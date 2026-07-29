# GROWTH.md

Cross-review tracker, maintained per `REVIEW.md`'s Growth Tracker section. Each review appends one entry below: date, PR summary, recurring issues (with the review date they first came up), and issues newly resolved since the prior entry. Read this file at the start of a review before writing a new entry.

---

## 2026-07-09 — PR #4: feat:added-backend-grid-routes (initial + detailed prod review)

**PR summary:** Adds `GET api/product/{id}/variants`, changes `GET api/product/{id}/products/{productId}` to `GET api/product/{id}/detail`, adds a `ProductType` enum, wires up Application Insights telemetry/logging, adds try/catch + `ILogger` logging across the Mongo repositories.

**Issues flagged (baseline — nothing to compare against yet, first review of this repo):**
- CORS policy hardcoded to `http://localhost:3000` with no environment branching — will reject the real prod frontend origin. 🔴
- `GetProductDetailAsync`/`ProductDetailRepository.GetByIdAsync` dropped catalog-scoping (`CatalogId` filter removed) when the route collapsed from `{id}/products/{productId}` to `{id}/detail` — correctness risk unless `Id` is confirmed globally unique across catalogs. 🔴
- Application Insights connection string + Azure subscription ID committed in plaintext (`appsettings.json`, `Mars.API.csproj`). 🔴
- No confirmed index on `Id` in `product_series` / `product_details` / `product_variants` — every lookup is a potential collection scan. 🔴
- No global exception handling / `ProblemDetails` middleware. 🟡
- No health check endpoint. 🟡
- No `[Authorize]`/rate limiting on any endpoint — public reads, intent undocumented. 🟡
- `Azure.Identity` package added to `.csproj` but never used anywhere (no `DefaultAzureCredential`). 🟢
- `ProductCatalogRepository`, `ProductDetailRepository`, `ProductVariantRepository` structurally duplicated; existing `INoSQLRepository<T>` generic interface unused by any of them. 🟢
- `ProductCatalogRepository.CollectionName` is `readonly`, the other two repos use `const` — inconsistent. 🟢
- Zero test coverage on the entire controller/service/repository layer touched by this PR. 🟡
- Breaking route change shipped with no API versioning. 🟡

---

## 2026-07-10 — PR #4: feat:added-backend-grid-routes (update + full whole-PR review)

**PR summary:** Follow-up commit attempting to fix CORS (config-driven origins, methods restricted to `GET`) and adding Mongo settings startup validation via `AddOptionsWithValidateOnStart<MongoDbSettings>()`.

**Recurring issues (repeat from 2026-07-09):**
- **CORS — still broken, 2nd occurrence, now a subtler form.** Round 1: hardcoded to `localhost:3000`. This round: switched to `builder.Configuration.GetSection("AllowedOrigins")`, but the actual appsettings key is `Cors:AllowedOrigins` — the section resolves empty, `.Get<string[]>()` returns `null`, and the code falls back to the same hardcoded `localhost:3000` value it was meant to replace. Same production impact as round 1, just hidden behind code that looks fixed on a skim. **Pattern, not a one-off — config wiring that looks right but isn't fully connected end-to-end.**
- Plaintext App Insights secrets + subscription ID — still unresolved.
- No confirmed index on `Id` fields — still unresolved.
- Zero test coverage — still unresolved. (Note: this round's CORS bug and the round-1 catalog-scoping bug are exactly the kind of regressions a test suite would have caught mechanically instead of requiring a manual re-review each time.)
- No global exception handling, no health check endpoint, no auth/rate-limiting decision, unused `Azure.Identity` package — all still open, unchanged.

**Issues newly resolved (real progress):**
- **Mongo settings startup validation added** (`AddOptionsWithValidateOnStart<MongoDbSettings>()`) — not previously flagged as missing, but a genuinely good fail-fast addition: the app now refuses to start with a missing connection string/database name instead of failing lazily on first request.
- **CORS methods narrowed** from `AllowAnyMethod()` to `.WithMethods("GET")` — real tightening, correctly scoped to the fact every endpoint on this controller is read-only.
- **Repository interface unification — partial.** `IProductCatalogRepository` now implements the existing `INoSQLRepository<T>` generic interface (previously flagged as unused). Only 1 of 3 repositories converted so far — `IProductDetailRepository` and `IProductVariantRepository` still hand-roll their own identical signatures.

**Open blockers carried into next review:**
- CORS config path mismatch (🔴) — the one to check first next time; verify `Cors:AllowedOrigins` is actually read, not just present in appsettings.
- `ProductDetail` catalog-scope removal, uniqueness still unconfirmed (🔴)
- Plaintext secrets (🔴)
- Missing indexes (🔴)
- Test coverage (🟡) — flagged 2 reviews running now

---

## 2026-07-29 — PR #4: feat:added-backend-grid-routes (full-scope review — auth, basket, email, App Insights added)

**PR summary:** Major expansion since the last review — adds full JWT auth (register/login), a SQL Server/EF Core-backed basket (guest + authenticated, via a new `ApplicationDBContext`), user-enquiry submission with email notifications (Azure Communication Services), and a `GlobalExceptionHandler`/`ProblemDetails` layer. 60 files changed, +3,804/−107.

**Recurring issues (repeat from 2026-07-09/07-10):**
- **CORS — 3rd occurrence, now a 3rd distinct failure mode.** Round 1: hardcoded to `localhost:3000`. Round 2: config-key mismatch. Round 3 (this one): the config key is now read correctly and fails fast if missing, but the *value* is still only ever `http://localhost:3000` — no `appsettings.Production.json` exists anywhere in the repo, so the real frontend origin is still rejected outside dev. **Pattern confirmed across 3 reviews: config that looks fixed on a skim but isn't fully connected end-to-end** — and this round adds a **second, independent instance of the exact same pattern**: `JwtSettings.ExpiryMinutes` never binds because `appsettings.Development.json` has the key `ExpireMinutes`, not `ExpiryMinutes` — every issued JWT expires with `ExpiryMinutes == 0`, i.e. instantly. 🔴
- `ProductDetail` catalog-scoping — **worse, not just still-open.** Round 1 dropped the Mongo query filter. This round deletes the `catalogId` parameter from `IProductDetailRepository`/`IProductService`'s signatures entirely, turning what was a query-level fix into a breaking API/interface change. Still 🔴, now more expensive to fix than when first flagged.
- Plaintext App Insights connection string + Azure subscription ID — still unresolved, confirmed as net-new `+` lines in this PR's own diff (3rd occurrence).
- No confirmed index on `Id` — still unresolved, and now spreads to a third Mongo collection (`product_variants`, new in this PR).
- No `[Authorize]`/rate limiting — still open, though real underlying progress: a full JWT pipeline now exists, it's just applied to zero endpoints.
- Unused `Azure.Identity` package — still unused, now with an additional dead `using Azure.Identity;` in `Program.cs`.
- Zero test coverage — still unresolved, 3rd review running. This round's price-tampering, JWT-expiry, and catalog-scoping bugs are exactly the class of regression a test suite would catch mechanically.

**New issues found this round:**
- 🔴 **Price tampering** — `BasketController.AddToCart`/`CartService.AddOrUpdate` persist client-supplied `UnitPrice` with zero server-side validation against the catalog. Highest-severity finding in this PR; confirmed independently by 3 separate review passes (controllers, services, DTOs).
- 🔴 **`GlobalExceptionHandler` registered but never wired in** — `AddExceptionHandler<T>()` without a matching `app.UseExceptionHandler()` means the new exception-handling layer this PR adds has zero runtime effect; every unhandled exception still produces a bare 500.
- 🔴 **`RegisterDTO` fields silently dropped** — `CompanyName`/`JobTitle`/`Country`/`PhoneNumber` collected at registration, never copied onto `ApplicationUser`.
- 🔴 **Duplicate-basket race condition** — no DB-level unique constraint on `CustomerBasket.UserId`/`SessionId`; the existing composite index is dead weight (led by the already-unique PK).
- 🔴 **Swagger now exposed unconditionally**, including in whatever environment is deployed as production — the previous `IsDevelopment()` gate was removed.
- 🟡 **HTML injection into email templates** — user-submitted enquiry fields substituted into HTML emails via unencoded `string.Replace`.
- 🟡 **Enquiries never persisted** — only exist as two email side-effects; a total email-send failure loses the lead silently while still returning 200.
- 🟡 **`RefreshToken` fully half-wired** — entity + migration exist, nothing issues/validates/revokes one anywhere.

**Issues newly resolved (real progress):**
- **Repository interface unification — now complete.** Both `IProductCatalogRepository` and `IProductDetailRepository` (bespoke marker interfaces) are deleted; all three Mongo repositories implement the shared `INoSQLRepository<T>` directly. This was flagged partial on 2026-07-10 (1 of 3) — now fully done. Real, clean progress, though it's what caused the catalog-scoping regression to worsen (see above) — a cautionary tale about doing a structural cleanup and a behavior change in the same edit.
- **Async/await hygiene is consistently clean across the entire new surface** — no `.Result`/`.Wait()` found anywhere in 45 reviewed files; `CancellationToken` correctly threaded through the entire Product read path (controller → service → repository → Mongo driver).
- **Mongo model NRT discipline is clean** across `ProductCatalog`/`ProductDetail`/`ProductItem`/`ProductSeriesVariants`/`ProductVariant` — notably better than the SQL-side basket entities, worth calling out as the standard to bring the EF Core models up to.

**Open blockers carried into next review:**
- Price tampering on basket add/update (🔴) — the one to check first next time; verify a server-side catalog lookup replaced the client-supplied price.
- JWT `ExpiryMinutes`/`ExpireMinutes` config-key mismatch (🔴) — verify tokens actually carry a real expiry.
- `app.UseExceptionHandler()` wiring (🔴) — verify unhandled exceptions actually produce `ProblemDetails`, not a bare 500.
- `ProductDetail` catalog-scoping (🔴) — now a 3rd-review-old regression, verify a `catalogId` parameter has been restored.
- Duplicate-basket race condition (🔴) — verify a unique index exists on `UserId`/`SessionId`.
- Plaintext secrets (🔴), missing indexes (🔴), no `[Authorize]` anywhere (🔴), no `appsettings.Production.json` (🔴) — all still open, 3rd review running.
- Test coverage (🔴 upgraded from 🟡 — this round's regressions are exactly what tests would have caught) — flagged 3 reviews running now.
