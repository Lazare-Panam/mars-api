using Microsoft.Extensions.Caching.Distributed;
using System.Text.Json;

namespace Mars.API.Services.Caching
{
    public static class DistributedCacheExtensions
    {
        private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web);

        public static async Task<T?> GetOrSetAsync<T>(this IDistributedCache cache, string key,Func<Task<T?>> fetchFromSource, TimeSpan ttl)
        {
            byte[]? cachedBytes = await cache.GetAsync(key);

            if (cachedBytes is not null)
            {
                return JsonSerializer.Deserialize<T>(cachedBytes, JsonOptions);
            }

            T? value = await fetchFromSource();

            if (value is null)
            {
                return default;
            }

            byte[] serializedValue = JsonSerializer.SerializeToUtf8Bytes(value, JsonOptions);

            var cacheOptions = new DistributedCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = ttl
            };

            await cache.SetAsync(key, serializedValue, cacheOptions);

            return value;
        }
    }
}
