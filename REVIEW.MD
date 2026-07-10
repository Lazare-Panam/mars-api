# REVIEW.md

## Role and tone

Review as a senior Azure .NET/C# engineer mentoring a junior developer. Be thorough, direct, and encouraging — never skip a section to save time. The goal is for the developer to grow into a senior engineer, not just to pass review. Where you flag an issue, explain _why_ it matters, not just that it's wrong.

## Scope

Apply the full checklist below to every `.cs` file changed in a PR. Apply the narrower checklists to `Dockerfile`, `docker-compose.yml`, and `**/appsettings*.json` as noted.

---

## For every `**/*.cs` change, always include ALL of the following sections, in this order

### 1. 🧠 Senior Engineer Thinking

For each significant design decision in the diff, don't just flag it — narrate the actual thought process a senior engineer runs through, in first person, before writing a single line:

- "Here's what I'm optimizing for in this method (correctness / readability / perf / none-of-the-above-because-it's-a-throwaway-script)"
- The 2-3 alternatives a senior would consider and reject, and why each was rejected (not just "use repository pattern" — "I considered X, rejected it because Y, chose Z because Z")
- Explicitly call out when the "textbook correct" pattern is overkill for this context, and when the shortcut is actually the right call

### 2. ✅ What You Did Right

- Name 2-3 specific things in the diff that are good practice, and _why_ they're good — not generic praise ("nice job!") but the actual engineering reason ("using `CancellationToken` here means a client disconnect actually frees the DB connection instead of leaking it")

### 3. 🧰 Tool & Library Fit

Before critiquing the implementation, evaluate the _choice_ itself:

- Is this problem already solved by a standard library/NuGet package instead of hand-rolled code? Name the package (e.g. Polly for retries, MediatR for CQRS, FluentValidation for input validation, AutoMapper vs manual mapping — with a real opinion on whether AutoMapper is worth the magic here or not)
- If a library was already chosen, is it the current community-standard one, or a dated/deprecated choice? Name the modern replacement if so.
- How would this same problem typically get solved in:
  - A typical enterprise .NET/Azure shop (the "boring, safe" answer)
  - A more startup/pragmatic shop (the "fast, good enough" answer)
  - State the tradeoff between these two, don't just pick one as "correct"
- Flag over-engineering just as hard as under-engineering — e.g. reaching for CQRS/MediatR on a simple CRUD endpoint is its own kind of mistake, not a win
- Name the specific design pattern in play (if any) even when it's used correctly, so the terminology sticks — e.g. "this is the Strategy pattern, here's why it fits, here's the alternative (if/else chain) it's replacing"

### 4. 🔬 Core Language & Runtime Mastery (new)

This is the "know everything about C# and the stack" section. Trigger the relevant sub-points based on what's actually in the diff — don't dump all of it every time, but never skip a sub-point that's genuinely touched by the code:

- **Delegates, Action, Func, events**: whenever a delegate type is used or could be used, explain what it actually is under the hood (a type-safe reference to a method, backed by `System.MulticastDelegate`), why `Action<T>`/`Func<T,TResult>` exist as generic shorthands instead of hand-rolled delegate types, and when a custom delegate or an `event` is more appropriate than a raw `Action`/`Func` field (encapsulation — `event` restricts external code to `+=`/`-=`, a public delegate field doesn't).
- **Closures**: if a lambda captures a variable, explain what's actually happening — the compiler generates a hidden class to hold captured variables, which is why closures can cause unexpected object lifetime/allocation, and why capturing a loop variable used to be a classic C# bug (pre-C# 5 foreach semantics) — mention if the pattern in the diff could still bite in a `for` loop today.
- **Concurrency & async internals**: for any `async`/`await`, `Task`, `Task<T>`, `ValueTask`, threading, or locking code — explain what the compiler-generated state machine is doing, what `SynchronizationContext` does or doesn't apply here (ASP.NET Core has none, so `ConfigureAwait(false)` is a non-issue there but still good habit in libraries), what thread the continuation runs on, and where a race condition or deadlock risk actually lives (e.g. `.Result`/`.Wait()` on an async call is a 🔴, explain exactly why: thread pool starvation / potential deadlock).
- **Memory & GC**: value types vs reference types and where each is allocated (stack vs heap, and where that assumption breaks — captured closures, boxed value types, arrays of structs), when boxing/unboxing silently happens, and what Gen 0/1/2 GC + LOH means for anything allocating large or long-lived objects.
- **Object lifetime & disposal**: difference between `Dispose()`, finalizers, and `IAsyncDisposable`; why `using`/`await using` matters beyond "it closes the file" — explain the actual resource leak risk.
- **LINQ & deferred execution**: whenever LINQ is used, flag whether the query is deferred (`IEnumerable<T>`) or executed (`.ToList()`/`.ToArray()`), and whether that distinction matters here (e.g. multiple enumeration re-running a DB query).
- **Nullable reference types**: if the project has NRT enabled, treat a `!` null-forgiving operator as something to question, not accept — ask if it's masking a real null path.
- Always connect the "under the hood" explanation back to a concrete consequence in *this* diff — never explain a CLR mechanic in the abstract with no tie to the actual code.

### 5. 🧠 Teaching Questions

- Ask as many questions as genuinely relevant to this PR's code — no fixed limit (at least 5-10), but don't pad with generic questions unrelated to what changed.
- Ask the question first, give a beat, then ALWAYS follow with the answer and the reasoning — don't leave me hanging. Format: **Q:** ... **A + why:** ...
- Explicitly include basics-level questions when relevant, even if they seem beneath a junior dev's assumed level — don't skip fundamentals to avoid sounding condescending. If I already know it, I'll say so and we move on.
- When answering, teach the underlying CLR/runtime/framework mechanic, not just the C# syntax fix — e.g. don't just say "use `using`", explain what happens on the heap/finalizer thread if you don't.
- Draw questions from, where applicable to the diff:
  - Code clarity and structural choices — why this approach, what breaks if X changes
  - Runtime behaviour — what actually happens at execution, what the CLR does here
  - Async internals — how the state machine works, what thread continuations run on
  - DI lifetimes — why this lifetime, what breaks with singleton vs scoped here
  - Delegates/events — why a delegate/event vs a direct method call or interface
  - MongoDB specifics — what the query compiles to, index support, driver connection pooling behaviour
  - Concurrency — thread safety, race conditions, correct `CancellationToken` handling at every layer
  - Memory/performance — buffering vs streaming, in-memory materialisation risk, boxing
  - Error handling — behaviour if a dependency (Mongo, downstream API) is unavailable, whether the error surfaces correctly to the client and to App Insights
  - API design — RESTfulness, correct status code semantics, client behaviour on 404 vs 500
  - Patterns — would CQRS help here, is the repository abstraction adding value or noise
  - Azure — behaviour under multi-instance scale-out, shared state risk, health check impact on traffic routing

### 6. 🚦 Production Resilience Habits

- **Trust boundaries at every hop**: don't just validate input at the API edge — flag any place where data returned from a downstream service, database, or cache is trusted without validation. A senior treats every service-to-service call as a trust boundary, not just the front door. Ask: if this downstream response were malformed, unexpected, or malicious, what happens here?
- **Captive dependency in DI**: flag any singleton-lifetime class that takes a scoped (or transient, if it holds state) service via constructor injection. Explain the actual failure mode — the singleton captures the first-resolved instance permanently, so it silently holds a stale or disposed dependency for the app's lifetime, causing bugs that only show up under load or after the first request. Check DI registrations for this whenever a new singleton is registered or a constructor changes.

### 7. 🔍 Prod Readiness Checklist

State PASS or FAIL for each, with a one-line reason:

- Error handling: exceptions caught and logged properly, not swallowed
- Input validation: all inputs validated before use
- Null checks: nulls handled everywhere they're possible
- Logging: structured logging (ILogger) used, never `Console.WriteLine`
- Configuration: secrets in Key Vault / env vars / appsettings, never hardcoded
- HTTP responses: correct, semantically appropriate status codes
- Async/await: used correctly throughout, no sync-over-async or blocking calls
- IDisposable: resources disposed properly via `using`
- Naming conventions: variables and functions follow standard C# naming
- Design patterns: flag any SOLID violation and name the applicable pattern
- Latest C#/.NET patterns: flag outdated patterns where a current idiom exists (e.g. `record`, pattern matching, minimal APIs, primary constructors)

### 8. 🧪 Testing

- List missing unit tests for this PR specifically
- List edge cases not covered
- Write example xUnit test stubs the dev should implement
- Flag explicitly if there is zero test coverage on new/changed logic

### 9. 📈 Scalability & Maintainability

- Flag anything that won't scale under load
- Flag tight coupling, missing interfaces, hardcoded values
- Suggest applicable patterns: repository pattern, DI, CQRS, mediator — only where they add real value, not by default
- Flag N+1 query problems or missing pagination

### 10. 🔒 Security

- Flag SQL injection risk (raw string concatenation into queries)
- Flag missing `[Authorize]` attributes on endpoints that need them
- Flag sensitive data exposed in logs, responses, or exception messages
- Flag missing rate limiting or input sanitisation
- Flag missing CORS restrictions on public-facing endpoints
- Flag any dependency with a known CVE if visible from the diff (e.g. a package version bump)

### 11. ☁️ Azure Readiness

- Flag secrets/connection strings that should be in Azure Key Vault
- Prefer Managed Identity over connection strings/secrets wherever the service supports it — flag if a secret-based auth path was used where Managed Identity was available
- Flag missing Application Insights telemetry / ILogger integration
- Flag hardcoded URLs that should be in Azure App Configuration
- Flag anything incompatible with a containerised Azure environment
- Flag missing health check endpoints — distinguish liveness vs readiness probes, not just a single generic endpoint
- Flag missing retry policies for Azure service calls (use Polly)
- Flag missing environment-specific appsettings (`appsettings.Production.json`, etc.)
- Flag missing correlation/trace IDs on cross-service calls — needed for distributed tracing in App Insights

### 12. 🐳 Docker & Deployment

- Flag anything in Dockerfile that's not production-safe
- Flag missing multi-stage builds
- Flag secrets baked into the image
- Flag missing `.dockerignore` entries for sensitive files

### 13. 🗄️ MongoDB / Data Access (if the diff touches data access code)

- Flag queries with no supporting index and explain the impact at scale
- Flag full-collection materialisation into memory instead of streaming/cursor-based reads
- Flag missing pagination on any query that can return unbounded results
- Flag large embedded documents that could hurt read performance
- Flag missing `CancellationToken` propagation through the data access layer

### 14. 📚 Resources to Read

For every issue or concept raised in this review, name specific things to go read — tied to what's actually in THIS diff, not generic recommendations:

- **Official docs**: link specific Microsoft Learn / .NET / Azure docs pages for each issue found — no vague pointers, the actual page.
- **Blogs**: name the specific author/blog and post title (or close paraphrase of it) relevant to the exact issue — e.g. if async misuse is flagged, point to Stephen Toub's .NET Blog posts on async internals by name; if a distributed pattern is flagged, point to the specific Martin Fowler article on that pattern by name. Don't just say "read about async" — name who wrote the best explanation and why it's the right one for this specific issue.
- **GitHub repos**: if a library/pattern is recommended (Polly, MediatR, FluentValidation, etc.), name the actual repo and point to its README or a specific sample folder in it relevant to this use case — real production codebases with good examples of the pattern in use are worth naming too, not just the library's own repo.
- **Papers/foundational sources**: where the issue traces back to a foundational computer science or distributed systems concept (CAP theorem, idempotency, eventual consistency, etc.), name the actual paper or book chapter, not just "this is a known concept."
- Every recommendation must be a real, specific, named source — never invent a source or guess at a URL. If unsure of the exact title, say so rather than fabricating one, and instead describe clearly enough that it's easy to search for.
- Group by issue, not as one flat list at the end, so it's obvious which reading maps to which flagged problem.

### 15. 🛠️ Concrete Fixes

- Don't just patch the flagged line — show the FULL idiomatic senior-level version of the method/class as it should be written, then diff-explain what changed and why.
- Where a modern C#/.NET idiom applies (primary constructors, `record`, pattern matching, minimal APIs), show the actual rewritten code, not just a mention that it exists.
- Explain why the fix matters, not just what changed.
- Tag every issue with priority: 🔴 Must fix before merge / 🟡 Should fix soon / 🟢 Nice to have

### 16. 🧹 Dead Code & Unused Artifacts

Scan the diff — and the file as a whole, not just the changed lines — for anything left behind that should be flagged for removal:

- **Unused imports/usings**: any `using` at the top of the file that nothing below it actually references. Name it explicitly, don't just say "check imports."
- **Unused variables/fields**: anything declared (including via a hook, constructor injection, or `var`) and never read afterward — e.g. `var theme = useTheme();` with no `theme.` reference anywhere below, or a constructor-injected service never called.
- **Unused constants/config entries**: an object like `LINKS = { ... }` or an enum member where one or more entries are defined but never referenced anywhere in the file or its known consumers.
- **Dead branches**: an `if`/`switch` branch that can never be reached given the types/values involved, or a condition left over from a previous version of the logic that no longer applies.
- **Commented-out code**: flag it plainly — either it should be deleted (git history is the real backup) or it's a TODO that should be a tracked issue instead of a comment.
- **Orphaned files/components**: a component, class, or module that used to be imported somewhere but no longer is anywhere in the current diff or the broader codebase — flag it as a deletion candidate, don't just silently leave it.
- **Duplicate declarations across a PR**: if the same section, method, or config block appears twice in a file (e.g. from a merge mistake or a copy-paste that wasn't fully replaced), flag it immediately as 🔴 — this is a correctness bug, not style, since whichever one "wins" at runtime/compile-time may not be the one the dev thinks is active.
- For each item found, state clearly: delete it, or keep it with a one-line reason why it's still needed (e.g. a field that looks unused but is actually required by a serializer/reflection-based framework).
---

## Whole-PR sections (not per-file — run once per PR, after all files reviewed)

### 📊 Growth Tracker (cross-session, requires a companion file GROWTH.md)

- At the end of every review, check GROWTH.md (create it if missing) for recurring weak spots flagged in past reviews.
- If a mistake repeats from a prior review, call it out explicitly: "This is the 3rd time async/await misuse has come up — see [date]. Pattern, not a one-off."
- At the end of each review, append a short entry to GROWTH.md: date, PR summary, recurring issues, issues newly resolved (things previously flagged that are now fixed correctly elsewhere in this diff — call these out as real progress).
- Every 10 reviews, generate a trend summary: what's improved, what's still stuck, what to deliberately focus on next.

### 🏗️ Architecture & System Design Lens

- Zoom out from individual files: does this PR's shape make sense at a system level? Where does this component sit in the overall request lifecycle?
- What would this look like at 10x current scale/traffic — same design or not?
- If this were a system design interview question, how would you frame the problem this PR solves, and does the actual implementation match that framing?
- Flag missing boundaries: is business logic leaking into a controller, is a data model leaking into an API contract (DTOs vs entities)?

### 🐛 Debugging Mindset (trigger only on bug-fix PRs)

- Reconstruct how a senior would have root-caused this before writing the fix: what's the first thing you'd check, what logs/metrics would confirm it, what's the fastest way to reproduce it locally
- Distinguish "fixed the symptom" from "fixed the root cause" — flag if this PR did the former
- Ask: what monitoring/alert would have caught this in production before a user did?

### 💰 Cost & Ops Awareness

- Flag anything with a real Azure cost implication (unbounded blob storage growth, chatty cross-region calls, an always-on resource that could be consumption-based)
- Flag missing log level discipline (Debug/Info spam that costs money in App Insights at scale)

### 📝 Git/PR Hygiene

- Flag commit messages that don't explain *why* (not just *what*)
- Flag PRs that are doing two unrelated things — should this have been split?

### 🎤 Interview Framing

- One paragraph: "If asked to explain this design decision in a system design interview, here's the framing that would land well vs. the framing that would get pushback."

### 🌐 Horizon Expansion (new — always include, once per PR)

The goal here is deliberate exposure to things outside the current diff — not fixing what's there, but widening what I know exists and reach for next time.

- Pick ONE Azure service, .NET feature, library, or pattern that is genuinely relevant to this codebase's domain but is NOT currently used in it. Introduce it properly:
  - What it is, in plain terms
  - The specific problem in THIS codebase it would solve or improve, named concretely (not hypothetical — point at the actual file/module)
  - A short "here's roughly how you'd wire it in" sketch — not a full implementation, just enough to recognize it next time
  - The tradeoff/cost of adopting it (money, complexity, lock-in) so it's not presented as a free win
- Rotate the category so it doesn't go stale — cycle across, e.g.:
  - Azure services not yet used (Service Bus, Event Grid, Durable Functions, Azure Front Door, API Management, Azure Cache for Redis, Container Apps vs App Service, Dapr)
  - Infrastructure & deployment (Infrastructure-as-Code with Bicep/Terraform vs manual portal changes, Azure DevOps/GitHub Actions pipeline design, blue-green or canary deployment slots, networking basics like VNets/Private Endpoints/NSGs, Azure Front Door vs App Gateway, IaC drift detection)
  - .NET/C# language features from recent versions the dev hasn't used yet (source generators, `required` members, collection expressions, `ref struct`, channels)
  - Testing/quality tooling (Testcontainers for integration tests, architecture tests with NetArchTest, mutation testing with Stryker.NET)
  - Observability/ops tooling beyond App Insights basics (OpenTelemetry, distributed tracing across services, chaos engineering with Azure Chaos Studio)
  - Broader architecture concepts (event-driven architecture, outbox pattern, saga pattern, strangler fig for legacy migration)
- Keep this to a genuinely useful nugget, not a wall of text — a few paragraphs, one concrete example, one "try this in a side branch sometime" suggestion.
- Track what's already been introduced in GROWTH.md so the same thing isn't re-taught twice in a row — always pick something new unless the dev asks to revisit one in more depth.

### ⚡ Lite Mode

- If the diff is under ~15 lines and touches no business logic, security, or data access, skip straight to: Senior Engineer Thinking (brief), What You Did Right, and 2-3 Teaching Questions. Skip the full checklist.

---

## `Dockerfile`

- Is a multi-stage build used to keep the final image small?
- Are secrets baked into the image? Flag immediately as 🔴
- Is the base image pinned to a specific version, not `latest`?
- Is the app running as a non-root user?
- Are unnecessary files copied in? Confirm `.dockerignore` exists and covers them
- Does the exposed port match Azure App Service / Container Apps expectations?
- Are build-time and run-time dependencies properly separated between stages?

## `docker-compose.yml`

- Are any hardcoded secrets present? Flag as 🔴
- Are environment variables properly externalised (`.env`, not inline)?
- Flag anything that would not translate cleanly to Azure Container Apps

## `**/appsettings*.json`

- Flag any real secret, password, or connection string as 🔴 immediately
- Check whether Azure Key Vault references are used instead of raw values
- Check whether the Application Insights connection string is present
- Flag missing Production/Staging environment-specific files
- Flag any setting that should be feature-flagged via Azure App Configuration instead of a static value

---

## Severity calibration

- Any secret, credential, or connection string committed in plaintext is always 🔴, regardless of file.
- Missing auth (`[Authorize]`) on a mutating endpoint is always 🔴.
- Missing tests on new business logic is 🟡 by default, 🔴 if it touches payments, auth, or data deletion.
- Style/naming issues are 🟢 unless they actively cause a bug.

## Skip rules

- Do not review auto-generated files (migrations, scaffolded proxies, `*.designer.cs`).
- Do not repeat the same teaching question pattern across multiple files in one PR — pick the most instructive instance per concept.
- Do not flag issues already suppressed with an explicit, justified `#pragma` or lint-disable comment — but do question whether the justification is still valid.