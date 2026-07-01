using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using Mars.API.Services.Interfaces;

namespace Mars.API.Services.Products
{
    public class ProductCatalogService : IProductCatalogService
    {
        private readonly IProductCatalogRepository _repository;
        /// <summary>
        /// Initializes a new instance of the <see cref="ProductCatalogService"/> class.
        /// </summary>
        /// <param name="repository">The product catalog repository.</param>
        public ProductCatalogService(IProductCatalogRepository repository)
        {
            _repository = repository;
        }
        /// <summary>
        /// Gets a product catalog by its identifier.
        /// </summary>
        /// <param name="id">The catalog identifier.</param>
        /// <returns>The matching product catalog, or <c>null</c> if no catalog is found.</returns>
        public async Task<ProductCatalog?> GetCatalogByIdAsync(string id)
        {
            return await _repository.GetByIdAsync(id);
        }
    }
}
