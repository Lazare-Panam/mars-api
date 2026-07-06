using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using Mars.API.Services.Interfaces;

namespace Mars.API.Services.Products
{
    public class ProductService : IProductService
    {
        private readonly IProductCatalogRepository _catalogRepository;
        private readonly IProductDetailRepository _detailRepository;
        private readonly IProductVariantRepository _variantRepository;
        public ProductService(IProductCatalogRepository catalogRepository, IProductDetailRepository detailRepository, IProductVariantRepository variantRepository)
        {
            _catalogRepository = catalogRepository  ;
            _detailRepository = detailRepository;
            _variantRepository = variantRepository;
        }
        public async Task<ProductCatalog?> GetCatalogByIdAsync(string id, CancellationToken ct = default)
        {
            return await _catalogRepository.GetByIdAsync(id, ct);
        }
        public async Task<ProductDetail?> GetProductDetailAsync(string id, CancellationToken ct = default)
        {
            return await _detailRepository.GetByIdAsync(id, ct);
        }
        public async Task<ProductSeriesVariants?> GetProductVariantsAsync(string id, CancellationToken ct = default)
        {
            return await _variantRepository.GetBySeriesIdAsync(id, ct);
        }
    }
}
