using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using Mars.API.Services.Interfaces;

namespace Mars.API.Services.Products
{
    public class ProductService : IProductService
    {
        private const int FreePreviewCount = 4;
        private const string PriceKey = "Price";
        private readonly INoSQLRepository<ProductCatalog> _catalogRepository;
        private readonly INoSQLRepository<ProductDetail> _detailRepository;
        private readonly IProductVariantRepository _variantRepository;
        private readonly IStockProductRepository _stockProductRepository;
        private readonly ILogger<ProductService> _logger;
        public ProductService(INoSQLRepository<ProductCatalog> catalogRepository, INoSQLRepository<ProductDetail> detailRepository, IProductVariantRepository variantRepository, IStockProductRepository stockProductRepository, ILogger<ProductService> logger)
        {
            _catalogRepository = catalogRepository;
            _detailRepository = detailRepository;
            _variantRepository = variantRepository;
            _stockProductRepository = stockProductRepository;
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
        /// Retrieves the series variants for a product by id, applying pricing visibility rules
        /// based on the caller's authentication status (see <see cref="ApplyPricingVisibility"/>).
        /// </summary>
        /// <param name="id">The product/series id.</param>
        /// <param name="isAuthenticated">Whether the current caller is authenticated; controls how much pricing is included.</param>
        /// <param name="ct">Cancellation token.</param>
        /// <returns>The matching <see cref="ProductSeriesVariants"/>, or <c>null</c> if <paramref name="id"/> is empty/whitespace or no variants are found.</returns>
        public async Task<ProductSeriesVariants?> GetProductVariantsAsync(string id, bool isAuthenticated, CancellationToken ct = default)
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
                return null;
            }

            ApplyPricingVisibility(variants.Variants, isAuthenticated);
            return variants;
        }

        /// <summary>
        /// Logged-in users see full pricing on every variant.
        /// Anonymous users see pricing on the first N variants only (teaser preview);
        /// price is fully removed (not nulled) from every variant after that.
        /// </summary>
        private static void ApplyPricingVisibility(IList<ProductVariant>? variants, bool isAuthenticated)
        {
            if (variants is null || isAuthenticated) return;

            for (int i = 0; i < variants.Count; i++)
            {
                if (i >= FreePreviewCount)
                    variants[i].Specs?.Remove(PriceKey);
            }
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
    }
}
