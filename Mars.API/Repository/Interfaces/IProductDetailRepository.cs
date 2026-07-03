using Mars.API.Models.Products;

namespace Mars.API.Repository.Interfaces
{
    public interface IProductDetailRepository 
    {
        Task<ProductDetail?> GetByIdAsync(string id, CancellationToken ct = default);
    }
}
