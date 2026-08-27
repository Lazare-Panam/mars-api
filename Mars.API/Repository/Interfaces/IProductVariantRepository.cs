using Mars.API.Models.Products;

namespace Mars.API.Repository.Interfaces
{
    public interface IProductVariantRepository
    {
        Task<ProductSeriesVariants?> GetByIdAsync(string id, CancellationToken ct);
        Task<decimal?> GetPriceAsync(string seriesId, string variantId, CancellationToken ct = default);
        Task<Dictionary<(string SeriesId, string VariantId), decimal?>> GetPricesAsync(IEnumerable<(string SeriesId, string VariantId)> items, CancellationToken ct = default);
    }
}
