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
