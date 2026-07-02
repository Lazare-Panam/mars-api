using Mars.API.Models.Products;

namespace Mars.API.Repository.Interfaces
{
    public interface IProductDetailRepository 
    {
        Task<ProductDetail?> GetByProductIdAsync(string catalogId, string productId, CancellationToken ct = default);
    }
}
