using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using Mars.API.Services.Interfaces;

namespace Mars.API.Services.Products
{
    public class ProductCatalogService : IProductCatalogService
    {
        private readonly IProductCatalogRepository _repository;
        public ProductCatalogService(IProductCatalogRepository repository)
        {
            _repository = repository;
        }
        public async Task<ProductCatalog?> GetCatalogByIdAsync(string id)
        {
            return await _repository.GetByIdAsync(id);
        }
    }
}
