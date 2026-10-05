# .NET Logging Review Checklist — Auth Endpoints (Register / Login / Logout)

A reviewer's reference for checking logging in a PR. Every rule below is tied to an
official source so you can verify it yourself, not take my word for it. Scoped to
`Microsoft.Extensions.Logging` + Application Insights (the provider already wired in
this repo). Ties into issue #38.

---

## How to use this file

Read the PR's `AuthController` (and anything it calls) with these questions open.
For each endpoint — **Register, Login, Logout** — walk the three columns:
**(A) Is the right thing logged? (B) At the right level? (C) Without leaking secrets?**

A clean logging change answers "yes" to all three for every branch (success,
expected failure, unexpected exception).

---

## 1. Message templates — structured, not interpolated

The single most common mistake. Microsoft's rule, verbatim:

> "The log message template can contain placeholders for provided arguments.
> **Use names for the placeholders, not numbers.**"
> — [Logging in .NET and ASP.NET Core § Log message template](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/logging/)

```csharp
// ❌ string interpolation — the value is NOT captured as a structured field,
//    App Insights only sees one baked string, you can't query/filter on it
_logger.LogInformation($"User {email} registered");

// ✅ named placeholder — "email" becomes a queryable field in App Insights
_logger.LogInformation("User {Email} registered", email);
```

Why it matters: "The arguments themselves are passed to the logging system, not just
the formatted message template. This enables logging providers to store the parameter
values as fields." (same doc, § Log message template → semantic/structured logging).

**Gotcha to check:** placeholder-to-argument mapping is **by position, not by name**:

> "The *order of the parameters*, not their placeholder names, determines which
> parameters are used to provide placeholder values."

So `LogInformation("{A} {B}", first, second)` binds `A=first`, `B=second` even if the
names look swapped. Check the argument order matches the intended fields.

**Review check:** no `$"..."` or `string.Format` / `+` concatenation inside any
`_logger.Log*` call. Placeholders are `{PascalCaseNames}`.

---

## 2. Right log level for each branch

Microsoft's level definitions (quoted from the doc's Log level table):

| Level | Use it for | Source quote |
|-------|-----------|--------------|
| `Trace` | Most detailed; **may contain sensitive data** | "disabled by default and should **not** be enabled in production" |
| `Debug` | Dev/debugging | "Use with caution in production due to the high volume" |
| `Information` | Normal flow worth keeping | "tracking the general flow of the app" |
| `Warning` | Abnormal but not fatal | "abnormal or unexpected events … errors or conditions that don't cause the app to fail" |
| `Error` | This operation failed | "a failure in the current operation or request, **not** an app-wide failure" |
| `Critical` | Needs immediate attention | "data loss or out of disk space" |

— [Logging in .NET § Log level](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/logging/)

**Applied to auth (map each to the PR):**

| Event | Expected level | Reasoning |
|-------|---------------|-----------|
| Register success | `Information` | normal flow |
| Register rejected (email already exists, weak password) | `Information` or `Warning` | an *expected* business outcome, not a server fault — **not** `Error` |
| Login success | `Information` | normal flow |
| Login failure (bad credentials) | `Warning` | expected but security-relevant; repeated ones signal brute force |
| Account lockout | `Warning` | abnormal, security-relevant |
| Logout | `Information` | normal flow |
| Unhandled exception (DB down, etc.) | `Error` | the operation genuinely failed |

**Common smell:** using `LogError` for a user typing the wrong password. That's a
`Warning` at most — it floods error dashboards and buries real failures.

---

## 3. What to log vs what must NEVER be logged (security)

This is the part that turns a logging PR into a security incident. OWASP's rules:

**Always log these auth events**
([OWASP Logging Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html)):
- Authentication **successes and failures** (repeated failures = brute-force / credential-stuffing signal)
- Logout
- Account **lockout**
- Authorization / access-control **failures**
- Input validation failures

**NEVER log these — verbatim from OWASP "data to exclude":**
- "Authentication passwords"
- "Session identification values" / session tokens
- "Access tokens" — ⚠️ this includes the **raw `Authorization` header and the JWT**
  (directly relevant to issue #38 finding #1)
- "Encryption keys and other primary secrets"
- "Database connection strings"
- "Sensitive personal data and some forms of personally identifiable information (PII)"
- Bank/payment card data

**Grey area — log an identifier, not the secret:**
- Log the **email or user id**, never the password (not even its length).
- Log "token validation failed" — never the token value or claims dump.
- Prefer a stable **user id** over email where you can, to limit PII spread.

**Review check:** grep the diff for anything that could carry a secret into a log —
`password`, `token`, `Authorization`, `Request.Headers`, `jwt`, `claims`, a whole
`request`/`user` object (`LogInformation("{@User}", user)` serializes *everything*).

---

## 4. Log injection / forgery (untrusted input in logs)

Register/Login take **user-controlled input** (email, username). If that input lands
in a log unescaped, an attacker can inject newlines to forge fake log lines.

OWASP: "Perform sanitization on all event data to prevent log injection attacks"
(CR, LF, delimiters). Note that **structured logging (rule #1) already mitigates this** —
when `{Email}` is a captured field rather than concatenated into the message string,
a newline in the value doesn't fabricate a new log record. One more reason interpolation
is a double failure (unqueryable *and* injectable).

**Review check:** any user-supplied string that reaches a log goes through a named
placeholder, never concatenation.

---

## 5. Context: who / what / when / where

OWASP: record "when, where, who and what" for each event. In ASP.NET Core most of
this is automatic if you use the framework correctly:

- **When** — timestamp added by the provider.
- **Where** — the log **category** = the type name. Inject `ILogger<AuthController>`
  (not a hand-built string, not a closed generic — see issue #38 finding #2).
- **Who** — include a user id / email **field** (rule #1), and ideally correlate via
  the request's trace id (App Insights adds this automatically).
- **What** — a clear message + an **`EventId`** so events are machine-filterable:
  e.g. `LogWarning(new EventId(1001, "LoginFailed"), "Login failed for {Email}", email)`.
  See [High-performance logging / EventId](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/logging/) —
  issue #38 flags missing `EventId`s as a nice-to-have.

---

## 6. Don't swallow exceptions — log the exception object

When logging inside a `catch`, pass the exception as the **first argument** so the
stack trace is captured as structured data, not flattened into text:

```csharp
// ❌ loses the stack trace
catch (Exception ex) { _logger.LogError("Register failed: " + ex.Message); }

// ✅ exception captured in full
catch (Exception ex) { _logger.LogError(ex, "Register failed for {Email}", email); }
```

`LogError(Exception, string, params object[])` is the overload to look for.

---

## Quick pass/fail checklist (copy into the PR review)

- [ ] Every `Log*` call uses `{Named}` placeholders — zero interpolation/concat
- [ ] Levels correct: expected failures = `Warning`, server faults = `Error`
- [ ] Register / Login / Logout each log success **and** failure branches
- [ ] Login failure + lockout are logged (brute-force visibility)
- [ ] No password, token, `Authorization` header, claims dump, or full object logged
- [ ] User input only enters logs via structured fields (no injection)
- [ ] `catch` blocks pass the exception object to `LogError(ex, ...)`
- [ ] Logger injected as `ILogger<AuthController>` (clean category)
- [ ] Security-relevant events carry an `EventId`

---

## Primary sources

- Microsoft Learn — [Logging in .NET and ASP.NET Core](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/logging/)
  (log levels, categories, message templates, structured logging, EventId)
- OWASP — [Logging Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html)
  (what to log, what to never log, log injection)
- OWASP — [Authentication Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html)
  (auth-specific logging + generic failure messages)
- Andrew Lock, *ASP.NET Core in Action* (3rd ed.), Ch. 26 "Logging" — the per-finding
  map in issue #38 points to exact subsections.
