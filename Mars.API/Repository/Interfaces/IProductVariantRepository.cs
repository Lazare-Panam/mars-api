using Mars.API.Models.Products;

namespace Mars.API.Repository.Interfaces
{
    public interface IProductVariantRepository
    {
        Task<ProductSeriesVariants?> GetBySeriesIdAsync(string catalogId, string seriesId, CancellationToken ct = default);
    }
}
