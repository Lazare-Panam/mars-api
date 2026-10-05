using Mars.API.Services.Interfaces;
using Microsoft.Extensions.Caching.Distributed;

namespace Mars.API.Services.Auth
{
    /// <summary>
    /// Stores revoked token ids in the distributed cache, each one only until its token expires.
    /// With Redis every API instance sees the same list; with the in-memory cache it's per instance.
    /// </summary>
    public class TokenRevocationService : ITokenRevocationService
    {
        private const string KeyPrefix = "revoked-token:";
        private readonly IDistributedCache _cache;

        public TokenRevocationService(IDistributedCache cache)
        {
            _cache = cache;
        }

        public async Task RevokeAsync(string tokenId, DateTimeOffset expiresAt, CancellationToken ct = default)
        {
            if (expiresAt <= DateTimeOffset.UtcNow)
            {
                return; // Already expired: it's rejected anyway.
            }

            await _cache.SetStringAsync(KeyPrefix + tokenId, "1",
                new DistributedCacheEntryOptions { AbsoluteExpiration = expiresAt }, ct);
        }

        public async Task<bool> IsRevokedAsync(string tokenId, CancellationToken ct = default)
        {
            return await _cache.GetStringAsync(KeyPrefix + tokenId, ct) is not null;
        }
    }
}
