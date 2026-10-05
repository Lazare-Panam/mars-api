using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using Mars.API.Services.Caching;
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

        // Product detail changes rarely, so a cached copy is served for up to 10 minutes.
        private static readonly TimeSpan DetailCacheTtl = TimeSpan.FromMinutes(10);

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
            var detail = await _cache.GetOrSetAsync<ProductDetail>(
                DetailCacheKey(id),
                () => _detailRepository.GetByIdAsync(id, ct),
                DetailCacheTtl);

            if (detail is null)
            {
                _logger.LogWarning("ProductDetail not found for {Id}", id);
            }

            return detail;
        }

        /// <summary>
        /// Retrieves the series variants for a product by id.
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

            var variants = await _variantRepository.GetByIdAsync(id, ct);
            if (variants is null)
            {
                _logger.LogWarning("ProductSeriesVariants not found for {Id}", id);
            }

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

        private static string DetailCacheKey(string id) => $"detail:{id}";
    }
}
