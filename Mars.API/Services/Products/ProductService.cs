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
        /// <summary>
        /// Initializes a new instance of the <see cref="ProductService"/> class.
        /// </summary>
        /// <param name="repository">The product catalog repository.</param>
        /// <param name="detailRepository">The product detail repository.</param>
        /// <param name="variantRepository">The product variant repository.</param>
        public ProductService(IProductCatalogRepository catalogRepository, IProductDetailRepository detailRepository, IProductVariantRepository variantRepository)
        {
            _catalogRepository = catalogRepository  ;
            _detailRepository = detailRepository;
            _variantRepository = variantRepository;
        }
        /// <summary>
        /// Gets a product catalog by its identifier.
        /// </summary>
        /// <param name="id">The catalog identifier.</param>
        /// <returns>The matching product catalog, or <c>null</c> if no catalog is found.</returns>
        public async Task<ProductCatalog?> GetCatalogByIdAsync(string id, CancellationToken ct = default)
        {
            return await _catalogRepository.GetByIdAsync(id, ct);
        }
        public async Task<ProductDetail?> GetProductDetailAsync(string catalogId, string productId, CancellationToken ct = default)
        {
            return await _detailRepository.GetByProductIdAsync(catalogId, productId, ct);
        }
        public async Task<ProductSeriesVariants?> GetProductVariantsAsync(string catalogId, string seriesId, CancellationToken ct = default)
        {
            return await _variantRepository.GetBySeriesIdAsync(catalogId, seriesId, ct);
        }
    }
}
