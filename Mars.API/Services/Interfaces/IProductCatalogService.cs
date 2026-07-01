using Mars.API.Models.Products;

namespace Mars.API.Services.Interfaces
{
    public interface IProductCatalogService
    {
        /// <summary>
/// Gets a product catalog by its identifier.
/// </summary>
/// <param name="id">The catalog identifier.</param>
/// <returns>The matching product catalog, or null if no catalog is found.</returns>
Task<ProductCatalog?> GetCatalogByIdAsync(string id);
    }
}
