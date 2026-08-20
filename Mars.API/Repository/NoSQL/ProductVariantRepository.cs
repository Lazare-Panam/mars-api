using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductVariantRepository : IProductVariantRepository
    {
        private readonly IMongoCollection<ProductSeriesVariants> _collection;
        private readonly ILogger<ProductVariantRepository> _logger;
        private const string CollectionName = "product_variants";
        public ProductVariantRepository(IMongoDatabase database, ILogger<ProductVariantRepository> logger)
        {
            _collection = database.GetCollection<ProductSeriesVariants>(CollectionName);
            _logger = logger;
        }
        public async Task<ProductSeriesVariants?> GetByIdAsync(string id, CancellationToken ct = default)
        {
            try
            {
                return await _collection.Find(x => x.Id == id).FirstOrDefaultAsync(ct);
            }
            catch (OperationCanceledException)
            {
                _logger.LogWarning("Request cancelled for ProductSeriesVariants {Id}", id);
                throw;
            }
            catch (MongoException ex)
            {
                _logger.LogError(ex, "MongoDB error fetching ProductSeriesVariants {Id}", id);
                throw;
            }
        }

        public async Task<decimal?> GetPriceAsync( string seriesId, string variantId, CancellationToken ct = default)
        {
            var product = await _collection.Find(x => x.Id == seriesId).FirstOrDefaultAsync(ct);
            if (product == null)
                return null;

            var variant = product.Variants.FirstOrDefault(v => v.Id == variantId);
            if (variant == null)
                return null;

            if(variant.Specs.TryGetValue("Price", out var priceStr) && decimal.TryParse(priceStr, out var price))
            {
                return price;
            }

            return null;
        }
    }
}
