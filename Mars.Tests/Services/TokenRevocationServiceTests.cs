using Mars.API.Services.Auth;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Options;

namespace Mars.Tests.Services
{
    public class TokenRevocationServiceTests
    {
        private readonly TokenRevocationService _service =
            new(new MemoryDistributedCache(Options.Create(new MemoryDistributedCacheOptions())));

        [Fact]
        public async Task IsRevoked_TokenNotLoggedOut_IsFalse()
        {
            Assert.False(await _service.IsRevokedAsync("token-1"));
        }

        [Fact]
        public async Task IsRevoked_AfterLogout_IsTrue()
        {
            await _service.RevokeAsync("token-1", DateTimeOffset.UtcNow.AddMinutes(30));

            Assert.True(await _service.IsRevokedAsync("token-1"));
        }

        [Fact]
        public async Task Revoke_OnlyAffectsThatToken()
        {
            await _service.RevokeAsync("token-1", DateTimeOffset.UtcNow.AddMinutes(30));

            Assert.False(await _service.IsRevokedAsync("token-2"));
        }

        [Fact]
        public async Task Revoke_AlreadyExpiredToken_IsNotStored()
        {
            await _service.RevokeAsync("token-1", DateTimeOffset.UtcNow.AddMinutes(-1));

            Assert.False(await _service.IsRevokedAsync("token-1"));
        }
    }
}
