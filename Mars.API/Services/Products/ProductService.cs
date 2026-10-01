using System.Text.Json;
using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using Mars.API.Services.Interfaces;
using Microsoft.Extensions.Caching.Distributed;

namespace Mars.API.Services.Products
{
    public class ProductService : IProductService
    {
        private readonly INoSQLRepository<ProductCatalog> _catalogRepository;
        private readonly INoSQLRepository<ProductDetail> _detailRepository;
        private readonly IProductVariantRepository _variantRepository;
        private readonly IStockProductRepository _stockProductRepository;
        private readonly IDistributedCache _cache;
        private readonly ILogger<ProductService> _logger;

        // Variant data changes rarely, so a cached copy is served for up to 10 minutes.
        private static readonly DistributedCacheEntryOptions VariantsCacheOptions = new()
        {
            AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(10)
        };

        public ProductService(INoSQLRepository<ProductCatalog> catalogRepository, INoSQLRepository<ProductDetail> detailRepository, IProductVariantRepository variantRepository, IStockProductRepository stockProductRepository, IDistributedCache cache, ILogger<ProductService> logger)
        {
            _catalogRepository = catalogRepository;
            _detailRepository = detailRepository;
            _variantRepository = variantRepository;
            _stockProductRepository = stockProductRepository;
            _cache = cache;
            _logger = logger;
        }
        /// <summary>
        /// Retrieves a product catalog by its id.
        /// </summary>
        /// <param name="id">The catalog id.</param>
        /// <param name="ct">Cancellation token.</param>
        /// <returns>The matching <see cref="ProductCatalog"/>, or <c>null</c> if <paramref name="id"/> is empty/whitespace or no catalog is found.</returns>
        public async Task<ProductCatalog?> GetCatalogByIdAsync(string id, CancellationToken ct = default)
        {
            if(string.IsNullOrWhiteSpace(id))
            {
                _logger.LogWarning("GetCatalogByIdAsync called with null or empty id");
                return null;
            }
            var catalog = await _catalogRepository.GetByIdAsync(id, ct);
            if(catalog == null)
            {
                _logger.LogWarning("ProductCatalog not found for {Id}", id);
                return null;
            }
            return catalog;
        }

        /// <summary>
        /// Retrieves the detail record for a product by its id.
        /// </summary>
        /// <param name="id">The product id.</param>
        /// <param name="ct">Cancellation token.</param>
        /// <returns>The matching <see cref="ProductDetail"/>, or <c>null</c> if <paramref name="id"/> is empty/whitespace or no detail is found.</returns>
        public async Task<ProductDetail?> GetProductDetailAsync(string id, CancellationToken ct = default)
        {
            if(string.IsNullOrWhiteSpace(id))
            {
                _logger.LogWarning("GetProductDetailAsync called with null or empty id");
                return null;
            }
            var detail = await _detailRepository.GetByIdAsync(id, ct);
            if (detail is null)
            {
                _logger.LogWarning("ProductDetail not found for {Id}", id);
                return null;
            }
            return detail;
        }

        /// <summary>
        /// Retrieves the series variants for a product by id. Uses the cache-aside pattern:
        /// the cache is checked first, and on a miss the series is loaded from MongoDB and
        /// cached for <see cref="VariantsCacheOptions"/>.
        /// </summary>
        /// <param name="id">The product/series id.</param>
        /// <param name="ct">Cancellation token.</param>
        /// <returns>The matching <see cref="ProductSeriesVariants"/>, or <c>null</c> if <paramref name="id"/> is empty/whitespace or no variants are found.</returns>
        public async Task<ProductSeriesVariants?> GetProductVariantsAsync(string id, CancellationToken ct = default)
        {
            if (string.IsNullOrWhiteSpace(id))
            {
                _logger.LogWarning("GetProductVariantsAsync called with null or empty id/catalogId");
                return null;
            }

            var cacheKey = VariantsCacheKey(id);

            var cached = await TryGetFromCacheAsync<ProductSeriesVariants>(cacheKey, ct);
            if (cached is not null)
            {
                _logger.LogDebug("Variants cache hit for {Id}", id);
                return cached;
            }

            _logger.LogDebug("Variants cache miss for {Id}", id);

            var variants = await _variantRepository.GetByIdAsync(id, ct);
            if (variants is null)
            {
                _logger.LogWarning("ProductSeriesVariants not found for {Id}", id);
                return null;
            }

            await TrySetInCacheAsync(cacheKey, variants, VariantsCacheOptions, ct);
            return variants;
        }

        /// <summary>
        /// Retrieves a single variant of a product series, along with the series' name and thumbnail.
        /// </summary>
        /// <param name="id">The product/series id.</param>
        /// <param name="variantId">The variant id (e.g. <c>V20-20-1-4IN-W-O-LOCK</c>).</param>
        /// <param name="ct">Cancellation token.</param>
        /// <returns>The matching <see cref="ProductVariantDetail"/>, or <c>null</c> if either id is empty/whitespace or the series or variant is not found.</returns>
        public async Task<ProductVariantDetail?> GetProductVariantAsync(string id, string variantId, CancellationToken ct = default)
        {
            if (string.IsNullOrWhiteSpace(id) || string.IsNullOrWhiteSpace(variantId))
            {
                _logger.LogWarning("GetProductVariantAsync called with null or empty id/variantId");
                return null;
            }

            // Reuse the cached series instead of querying MongoDB again.
            var series = await GetProductVariantsAsync(id, ct);
            if (series is null)
            {
                return null;
            }

            var variant = series.Variants.FirstOrDefault(v => v.Id == variantId);
            if (variant is null)
            {
                _logger.LogWarning("Variant {VariantId} not found in series {Id}", variantId, id);
                return null;
            }

            return new ProductVariantDetail
            {
                SeriesId = series.Id,
                SeriesName = series.Name,
                SeriesThumbnailImage = series.ThumbnailImage,
                Variant = variant,
            };
        }

        /// <summary>
        /// Retrieves all stock products.
        /// </summary>
        /// <param name="ct">Cancellation token.</param>
        /// <returns>The full set of stock <see cref="ProductDetail"/> records.</returns>
        public async Task<IEnumerable<ProductDetail>> GetStockProductsAsync(CancellationToken ct = default)
        {
            return await _stockProductRepository.GetAllStockProductsAsync(ct);
        }

        private static string VariantsCacheKey(string id) => $"variants:{id}";

        // The cache is an optimisation, never a dependency: if Redis is down or the cached
        // value can't be read, log it and fall back to MongoDB instead of failing the request.
        private async Task<T?> TryGetFromCacheAsync<T>(string key, CancellationToken ct) where T : class
        {
            try
            {
                var json = await _cache.GetStringAsync(key, ct);
                return json is null ? null : JsonSerializer.Deserialize<T>(json);
            }
            catch (Exception ex) when (ex is not OperationCanceledException)
            {
                _logger.LogWarning(ex, "Cache read failed for {CacheKey}; falling back to the database", key);
                return null;
            }
        }

        private async Task TrySetInCacheAsync<T>(string key, T value, DistributedCacheEntryOptions options, CancellationToken ct)
        {
            try
            {
                await _cache.SetStringAsync(key, JsonSerializer.Serialize(value), options, ct);
            }
            catch (Exception ex) when (ex is not OperationCanceledException)
            {
                _logger.LogWarning(ex, "Cache write failed for {CacheKey}", key);
            }
        }
    }
}
