using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductVariantRepository : IProductVariantRepository
    {
        private readonly IMongoCollection<ProductSeriesVariants> _collection;

        public ProductVariantRepository(IMongoDatabase database)
        {
            _collection = database.GetCollection<ProductSeriesVariants>("product_variants");
        }

        public async Task<ProductSeriesVariants?> GetBySeriesIdAsync(string catalogId, string seriesId, CancellationToken ct = default)
        {
            return await _collection
                .Find(x => x.CatalogId == catalogId && x.SeriesId == seriesId)
                .FirstOrDefaultAsync(ct);
        }
    }
}
