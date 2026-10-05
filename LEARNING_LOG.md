# LEARNING_LOG.md

## Confusion Log
- [ ] 2026-10-05 — A null check on an injected `IDistributedCache` does NOT handle "Redis is down": the cache object is always non-null (DI/fallback registration), and a server outage surfaces as an exception thrown by `GetStringAsync`, not as a null field. Resilience = try/catch around the call, not a null check before it. — `RedisCacheService.GetDataAsync`
- [ ] 2026-10-02 — Extracting the cache helpers out of `ProductService` broke the build: deleting the private helpers without rewiring the call site, and the replacement (`GetOrSetAsync` extension) silently dropped the try/catch resilience and used sync `cache.Get` inside an async method. — `Services/Products/ProductService.cs`, `Services/Caching/DistributedCacheService.cs`
- [ ] 2026-10-01 — Difference between registering `IConnectionMultiplexer` directly vs `AddStackExchangeRedisCache` / `IDistributedCache` (two different layers, not alternatives). — `Program.cs`

## Concepts To Learn Next
- [ ] 2026-10-02 — **.NET 9 `HybridCache`** (`Microsoft.Extensions.Caching.Hybrid`) — the built-in `GetOrCreateAsync` with built-in stampede protection and a two-tier (in-memory + distributed) design. It does almost exactly what the hand-rolled `ICacheService` now does, but also prevents the cache-stampede case where many concurrent misses all hit Mongo at once. Worth reading before building more caching into other services (ties to issue #84). — Microsoft Learn: "HybridCache library in ASP.NET Core".
