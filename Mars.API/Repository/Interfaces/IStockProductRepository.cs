using Mars.API.Models.Products;

namespace Mars.API.Repository.Interfaces
{
    public interface IStockProductRepository
    {
        Task<IEnumerable<ProductDetail>> GetAllStockProductsAsync(CancellationToken ct = default);
    }
}
