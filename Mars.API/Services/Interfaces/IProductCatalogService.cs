using Mars.API.Models.Products;

namespace Mars.API.Services.Interfaces
{
    public interface IProductCatalogService
    {
        Task<ProductCatalog?> GetCatalogByIdAsync(string id);
    }
}
