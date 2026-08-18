using Mars.API.Models.Products;

namespace Mars.API.Services.Interfaces
{
    public interface IProductService
    {
        Task<ProductCatalog?> GetCatalogByIdAsync(string id, CancellationToken ct = default);
        Task<ProductDetail?> GetProductDetailAsync(string id, CancellationToken ct = default);
        Task<ProductSeriesVariants?> GetProductVariantsAsync(string id, bool isAuthenticated, CancellationToken ct = default);
        Task<IEnumerable<ProductDetail>> GetStockProductsAsync(CancellationToken ct = default);
    }
}
