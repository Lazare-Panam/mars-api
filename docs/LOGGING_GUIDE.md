# Logging Guide — Mars API

How logging works in this API: where logs are written, what a log call produces, where it
ends up, and how to check it. For the PR review checklist (what reviewers look for), see
[LOGGING_REVIEW_CHECKLIST.md](LOGGING_REVIEW_CHECKLIST.md).

---

## 1. The pipeline: from `_logger.Log…` to App Insights

```
Your class                       e.g. CartService, AuthController
  _logger.LogInformation("Added {ItemCount} item(s) to basket {BasketId}", 3, id)
        │  ILogger<CartService>   (Microsoft.Extensions.Logging — the interface)
        ▼
Serilog                          (the only logging engine; registered in Program.cs: AddSerilog)
  1. level check   — below MinimumLevel? dropped immediately, stored nowhere
  2. enrich        — adds context fields (RequestPath, RequestId, SourceContext, …)
  3. write to sinks
        ▼
Sinks                            (configured in appsettings*.json → Serilog.WriteTo)
  ApplicationInsights  → Azure, table `traces`   (production + local, Information and above)
  Console              → your terminal           (local only)
```

**We write logs with Serilog — through `ILogger<T>`.** Classes inject `ILogger<T>` and
never reference Serilog; Serilog is plugged in behind that interface in `Program.cs`. This
is the setup Serilog recommends for ASP.NET Core:
- classes stay independent of the logging library (swap or test without touching them),
- ASP.NET Core and EF Core also log through `ILogger`, so their logs go through the same
  Serilog pipeline and obey the same level overrides.

Rules:
- In classes: inject `ILogger<YourClass>`. Don't `using Serilog;` in classes.
- Serilog appears only in `Program.cs` (setup) and `appsettings*.json` (configuration).
- Static `Serilog.Log.*` is only for code that runs before the app is built (the bootstrap
  logger on the first line of `Program.cs`).

### What a log call returns

Nothing. `LogInformation(...)` returns `void`, never throws, and has no effect on the HTTP
response. The client never sees logs. If the level is switched off, the call does almost
nothing (a level check) — but its **arguments are still evaluated**, so don't do expensive
work (e.g. serialising objects) inside a log call.

---

## 2. What one log line becomes (real example from production)

Code (`ProductController`):
```csharp
_logger.LogInformation("GetProductVariants called for {Id}", id);
```

Stored in App Insights, table `traces`:

| Field | Value | Where it came from |
|---|---|---|
| `message` | `GetProductVariants called for economical-three-piece-ball-valve` | the template with values filled in |
| `severityLevel` | `1` | the level (see table below) |
| `customDimensions.Id` | `economical-three-piece-ball-valve` | **your `{Id}` placeholder** — a searchable field |
| `customDimensions.MessageTemplate` | `GetProductVariants called for {Id}` | the template itself — group identical events with it |
| `customDimensions.SourceContext` | `Mars.API.Controllers.ProductController` | the `T` in `ILogger<T>` (the "category") |
| `customDimensions.RequestPath` | `/api/product/economical-three-piece-ball-valve/variants` | added by ASP.NET Core automatically |
| `customDimensions.RequestId`, `ConnectionId` | `0HNP2TP2J53LC:00000001` | added by ASP.NET Core automatically |
| `customDimensions.ActionName` | `Mars.API.Controllers.ProductController.GetProductVariants` | added by ASP.NET Core automatically |
| `customDimensions.EventId` | e.g. `{"Id":1101,"Name":"LoginFailed"}` | only when you pass an `EventId` (section 5) |
| `operation_Id` | a GUID | App Insights: the same id on every log, request, dependency and exception of one HTTP request |
| `cloud_RoleInstance` | `mars-api--0000028-…` (Azure) or `Mac` (a local run) | which machine/container wrote it |
| `timestamp` | UTC time | added automatically — never log the time yourself |

Level → `severityLevel` in App Insights:

| .NET level | Serilog level | `severityLevel` |
|---|---|---|
| Trace | Verbose | 0 |
| Debug | Debug | 0 |
| Information | Information | 1 |
| Warning | Warning | 2 |
| Error | Error | 3 |
| Critical | Fatal | 4 |

An `Error`/`Critical` log **with an exception argument** (`LogError(ex, …)`) is stored in the
`exceptions` table (with the stack trace), not in `traces`.

---

## 3. Where logs are written in this codebase

| Layer | Files | What they log |
|---|---|---|
| Controllers | `Controllers/*Controller.cs` | Outcome of a request: success (Information), rejected input / not found (Information), security events (Warning) |
| Services | `Services/User/CartService.cs`, `RfqService.cs`, `CreditApplicationService.cs`, `Services/Products/ProductService.cs` | Business events (basket saved, quote created), lookup detail (Debug) |
| Notifications | `Services/Notification/NotificationService.cs`, `EmailService.cs`, `EmailTemplateService.cs` | Email failures (Error, with exception), routine sending detail (Debug) |
| Repositories | `Repository/NoSQL/*.cs` | Database failures with which entity/id failed |
| Message queue | `MessageQueues/EnquiryPublisher.cs`, `EnquiryRecieved.cs` | Message published (Debug), malformed / dead-lettered messages (Error), email outcome per enquiry (Warning) |
| Startup / auth pipeline | `Program.cs` | Admin seeding, JWT events (static `Log.*` — see section 8) |
| Framework | ASP.NET Core, EF Core (not our code) | Only Warning and above (see overrides in section 6) |

Where in a method to log:
- **At the outcome**, not at the start: "User {UserId} logged in", not "Login called".
  App Insights already records every request (`requests` table), so "X called" logs only
  repeat it — keep those at Debug if at all.
- **Where an exception is handled** (the `catch` that decides what happens next).
- **At every branch that returns an error to the client** (400/401/404/409) — one line,
  so you can explain any rejected request later.

---

## 4. How to write a log line

```csharp
_logger.LogWarning(LogEvents.LoginFailed, "Login failed for user {UserId}: invalid password", user.Id);
//      ^level     ^EventId (optional)      ^message template with {Named} placeholders  ^values, in order
```

1. **Message template, never interpolation.** `"... {UserId} ..."` + argument. Never
   `$"... {user.Id} ..."` — the value would only be text, not a searchable field.
2. **Placeholders are `{PascalCase}` and mean the same everywhere:** `{UserId}`, `{BasketId}`,
   `{ProductId}`, `{EnquiryId}`, `{QuoteRequestId}`, `{ApplicationId}`, `{Path}`, `{Endpoint}`.
   Same name = you can filter one field across all logs.
3. **Arguments bind by position**, not by name. Check the order matches the placeholders.
4. **Always `{Name}`; don't use `{@Name}`.** `@` makes Serilog save *every* property of an
   object (for a user or request object that means emails, names, hashes…). Ids, numbers,
   text, dates and lists all work with plain `{Name}`. If you need several values from an
   object, log them as separate placeholders:
   `"Added {ProductId} x {Quantity}", item.ProductId, item.Quantity`.
5. **Exceptions go first:** `LogError(ex, "Failed to send receipt for {QuoteRequestId}", id)`.
   Don't put `ex.Message` in the text.
6. **The message must make sense on its own:** what happened + the ids involved.
   `"Failed"` tells nobody anything.
7. **Never log** (OWASP): passwords, tokens / `Authorization` header, keys, connection
   strings, emails, names, phone numbers, company names, whole request/user objects.
   Log ids instead. For validation failures log the **field names**, never the values.
8. **No logging in loops** at Information or above — log one summary at the end.

---

## 5. Choosing the level

Ask: *if this appears in production, does someone need to act, and how soon?*

| Level | Means | Mars examples |
|---|---|---|
| **Debug** | Detail for investigating; off in production | `GetCatalog called for {Id}`, `ProductSeriesVariants not found for {Id}`, `Loaded email template`, `Attempting to send email`, cache hit/miss |
| **Information** | A normal event worth a record | `User {UserId} logged in`, `Enquiry {EnquiryId} received`, `Added {ItemCount} item(s) to basket`, `Variants not found for {Id}` (a normal 404), `… rejected: invalid {Fields}` (validation) |
| **Warning** | Unexpected or security-relevant, but handled | `Login failed …`, `account is locked out`, `Registration rejected …`, `Registration emails not all sent …`, `Receipt email not sent for enquiry {EnquiryId}` |
| **Error** | This operation failed | `LogError(ex, "Failed to send enquiry receipt")`, malformed queue message dead-lettered, failed to publish enquiry message |
| **Critical** | The app can't work | Can't start: database unreachable, signing key missing |

Deciding the borderline cases:
- **Information vs Debug:** would you want this line a week later in production? No → Debug.
- **Warning vs Error:** did the user still get a correct answer? Wrong password → correct 401
  → Warning. Email failed, no receipt → Error.
- **Client mistakes are not errors:** 400/404 are Information (Warning if security-relevant).
  Error means *our* system failed — otherwise error alerts fill up with other people's typos.

### EventIds (security events)

Defined in `Mars.API/Logging/LogEvents.cs`. Pass as the first argument so the event can be
filtered or alerted on without matching message text.

| Id | Name | Logged when |
|---|---|---|
| 1000 | UserRegistered | registration succeeded |
| 1001 | RegistrationRejected | email already registered / Identity rejected it |
| 1100 | LoginSucceeded | login succeeded |
| 1101 | LoginFailed | unknown email or wrong password |
| 1102 | AccountLockedOut | too many failed attempts |
| 1103 | LoggedOut | logout |
| 1200 | TokenRejected | (reserved — token logging not changed yet) |
| 1201 | TokenExpired | (reserved — token logging not changed yet) |
| 1300 | ValidationFailed | a request failed validation (register, login, basket, enquiry) |

Add new ones in the matching range; never reuse a number.

---

## 6. Configuration: which logs are kept, where they go

Settings load in layers; later layers override earlier ones:
1. `appsettings.json` — committed; production defaults; **no secrets**
2. `appsettings.Development.json` — local only (gitignored); loaded when `ASPNETCORE_ENVIRONMENT=Development`
3. user secrets (Development only)
4. environment variables — in Azure, the Container App settings (`__` = one level down,
   e.g. `Serilog__MinimumLevel__Default`)

Objects merge key by key; **arrays merge by position** (`WriteTo[0]` in one file merges into
`WriteTo[0]` in the other — keep sinks in the same order in both files).

| | Production (`appsettings.json` + Azure env vars) | Local (`appsettings.Development.json`) |
|---|---|---|
| `MinimumLevel.Default` | `Information` | `Debug` |
| Sinks | ApplicationInsights | ApplicationInsights (`restrictedToMinimumLevel: Information`) + Console |
| Debug logs | dropped | console only — never sent to Azure |

Overrides (both environments) — quiet the framework, keep our own code at the default:

| Override | Level | Effect |
|---|---|---|
| `Microsoft` | Warning | ASP.NET Core / EF Core only report problems |
| `Microsoft.AspNetCore.Hosting.Diagnostics` | Error | no per-request "Request starting/finished" lines (App Insights `requests` already has them) |
| `Microsoft.Hosting.Lifetime` | Information | keep "Application started / shutting down" |
| `Microsoft.EntityFrameworkCore.Database.Command` | Warning | no SQL text in logs |

### Turning on Debug in production (temporarily, for one class)

Debug lines must already be in the deployed code; this only switches them on. Logs before
the switch are gone — Debug is for the *next* occurrence.

```bash
az containerapp update -n mars-api -g rg-panam-dev \
  --set-env-vars "Serilog__MinimumLevel__Override__Mars.API.Services.User.CartService=Debug"
# reproduce, read the logs, then switch off:
az containerapp update -n mars-api -g rg-panam-dev \
  --remove-env-vars "Serilog__MinimumLevel__Override__Mars.API.Services.User.CartService"
```
Each change creates a new revision (restart, no rebuild). Switch it off the same day — Debug
volume costs App Insights storage.

---

## 7. How to check logs

**Locally:** run the API (`dotnet run --project Mars.API`) and watch the terminal:
```
[13:16:33 DBG] GetProductVariants called for no-such-series
[13:16:33 INF] Variants not found for no-such-series
[13:16:33 WRN] Login failed: user not found
```

**In Azure:** portal → `mars-api-insights` → **Logs** → turn the *Agent* toggle off → **KQL mode**.

```kusto
// Latest log lines from production
traces
| where timestamp > ago(24h) and cloud_RoleInstance startswith "mars-api"
| project timestamp, severityLevel, message, customDimensions
| order by timestamp desc

// Warnings and errors only
traces
| where timestamp > ago(7d) and severityLevel >= 2
| order by timestamp desc

// One event type, by EventId
traces
| where tostring(customDimensions.EventId) has "LoginFailed"
| summarize count() by bin(timestamp, 1h)

// Everything one user did (works where {UserId} was logged)
traces
| where customDimensions.UserId == "<user-id>"
| order by timestamp asc

// Everything that happened in one request (copy operation_Id from any row)
union traces, requests, dependencies, exceptions
| where operation_Id == "<operation-id>"
| order by timestamp asc

// The same event, grouped (MessageTemplate is identical for every occurrence)
traces
| where timestamp > ago(7d)
| summarize Count = count() by tostring(customDimensions.MessageTemplate), severityLevel
| order by Count desc
```

Other App Insights pages: **Failures** (exceptions and failed requests, grouped),
**Performance** (slow endpoints), **Transaction search** (one request end to end),
**Live metrics** (right now).

Tables you'll use: `traces` (our logs), `requests` (every HTTP request — automatic),
`exceptions`, `dependencies` (SQL/Mongo/HTTP calls — automatic). The frontend also sends
`pageViews`, `browserTimings` and browser `exceptions` to the same resource
(`client_Type == "Browser"`).

---

## 8. Known gaps in the setup (not fixed yet)

Recorded so they're known; each is a separate, deliberate change.

- **JWT events in `Program.cs`** use static `Log.*` (no `SourceContext`), log
  "No JWT Authorization header attached" at Information on every request, and log every
  rejected/expired token as Error. EventIds 1200/1201 are reserved for when this is changed.
- **Enrichers** `WithMachineName`, `WithProcessId`, `WithThreadId` in `appsettings.json`
  do nothing — their packages aren't installed. (`cloud_RoleInstance` already identifies the machine.)
- **`Microsoft.Extensions.Logging.ApplicationInsights`** package + `using` in `Program.cs`:
  a second route to App Insights that `AddSerilog` bypasses. Unused; Serilog's sink does the job.
- **No startup safety net:** a crash during startup isn't logged as Fatal and flushed
  (`try { … } catch (Exception ex) { Log.Fatal(ex, …); } finally { Log.CloseAndFlush(); }`).
- **`UserId` only on lines that include it.** Adding it to every log line in a logged-in
  request (via `LogContext`) would make "everything one user did" work for all logs.
- **Local runs send Information+ to production App Insights** (`cloud_RoleInstance == "Mac"`).
- **Some exceptions are logged twice** — logged then rethrown, and logged again by the caller
  or the global exception handler.
- **MongoDB (and Redis) calls aren't tracked automatically.** SQL, Service Bus, email and
  `HttpClient` calls appear in `dependencies` with timing and failures; Mongo doesn't, so the
  repository logs are the only record. (Option: the Mongo driver's OpenTelemetry instrumentation.)

### Frontend telemetry (mars-frontend, same App Insights resource)

Set up in `src/lib/appInsights.ts` and `src/Common/AppInsightsProvider.tsx`.

- **Third-party calls recorded as dependencies.** Fetch/Ajax tracking records every browser
  call, including trackers: LinkedIn (~6.9k/week, nearly all "failed" — ad blockers), Google
  Analytics (~4k), Clarity (~7k), HubSpot forms. Noise that counts toward the data allowance.
  Fix: a telemetry initializer that drops `RemoteDependencyData` whose target isn't our API /
  site, and `correlationHeaderExcludedDomains` for third-party hosts.
- **Page views counted twice.** `enableAutoRouteTracking: true` already tracks route changes,
  and `AppInsightsProvider` also calls `trackPageView` on every pathname change. Keep one.
- **Local development sends to production.** The connection string is hard-coded, so
  `localhost:3000` reports to the live resource (~2.9k rows/week). Read it from an env var and
  leave it unset locally.

---

## Sources

- Microsoft — [Logging in .NET and ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/logging/)
- Microsoft — [`LogLevel`](https://learn.microsoft.com/en-us/dotnet/api/microsoft.extensions.logging.loglevel)
- Serilog — [Writing log events](https://github.com/serilog/serilog/wiki/Writing-Log-Events),
  [Structured data](https://github.com/serilog/serilog/wiki/Structured-Data),
  [Serilog.AspNetCore](https://github.com/serilog/serilog-aspnetcore)
- OWASP — [Logging Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html)
- Microsoft — [Kusto Query Language (KQL) overview](https://learn.microsoft.com/en-us/kusto/query/)
