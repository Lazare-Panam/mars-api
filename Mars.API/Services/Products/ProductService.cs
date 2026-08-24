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

        private static void ApplyPricingVisibility(IList<ProductVariant>? variants, bool isAuthenticated)
        {
            if (variants is null || isAuthenticated) return;

            for (int i = 0; i < variants.Count; i++)
            {
                if (i >= FreePreviewCount)
                    variants[i].Specs?.Remove(PriceKey);
            }
        }

        public async Task<IEnumerable<ProductDetail>> GetStockProductsAsync(CancellationToken ct = default)
        {
            return await _stockProductRepository.GetAllStockProductsAsync(ct);
        }
    }
}
