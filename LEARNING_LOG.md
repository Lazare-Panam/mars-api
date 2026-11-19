# Learning Log

## Confusion Log
<!-- - [ ] YYYY-MM-DD — <the exact question/moment of confusion> — <file/context> -->
- [ ] 2026-11-18 — Search backend internals still fuzzy (DI singleton vs scoped, async/await, and the two review points: the too-broad `catch` + the unused `CancellationToken`). Code works + ships fine; revisit the "why" later. — `Services/Search/SearchService.cs`, `Program.cs`
- [ ] 2026-11-18 — Deferred polish (do later, not bugs): (1) narrow the catch to `when (ex.Code == "index_not_found")` so a dead API key/outage surfaces instead of showing "no results"; (2) thread `CancellationToken ct` into `SafeSearchAsync` + the Meili call. — `Services/Search/SearchService.cs`

## Concepts To Learn Next
- [ ] 2026-11-18 — **Client-side vs server-side faceting (and Meili filterable attributes)** — the search sidebar computes facet groups + counts from the returned hits in `SearchClient.tsx` (robust, no dependency on Meili config). The scalable alternative is server-side: declare `filterableAttributes` in Meili, request `facets` in the search query, and send a `filter` back to re-query as the user ticks boxes — which works beyond the first page of results. Worth reading Meilisearch "faceted search" + "filtering" docs to know when to graduate from client-side to server-side. Directly tied to the Mars search service we just built.
- [ ] 2026-10-12 — **GitHub OIDC federated credentials for Azure (`azure/login` with OpenID Connect)** — your `deploy-api.yml` authenticates with a long-lived `AZURE_CREDENTIALS` service-principal secret stored in GitHub; the current best practice is passwordless, short-lived OIDC tokens. Directly relevant to hardening the ACR/Container Apps deploy pipeline we reviewed against the ACR module.
