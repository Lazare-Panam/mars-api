using Mars.API.Models.Products;

namespace Mars.API.Repository.Interfaces
{
    public interface IProductVariantRepository
    {
        Task<ProductSeriesVariants?> GetBySeriesIdAsync(string id, CancellationToken ct = default);
    }
}
