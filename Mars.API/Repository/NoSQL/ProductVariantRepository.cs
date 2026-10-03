using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductVariantRepository : MongoRepositoryBase<ProductSeriesVariants>, IProductVariantRepository
    {
        private const string CollectionName = "product_variants";

        public ProductVariantRepository(
            IMongoDatabase database,
            ILogger<ProductVariantRepository> logger)
            : base(database, logger, CollectionName)
        {

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
        public async Task<Dictionary<(string SeriesId, string VariantId), decimal?>> GetPricesAsync(IEnumerable<(string SeriesId, string VariantId)> items, CancellationToken ct = default)
        {
            var itemsList= items.ToList();
            var distinctIds = itemsList.Select(i => i.SeriesId).Distinct().ToList();
           
            var builder = Builders<ProductSeriesVariants>.Filter;
            var filter = builder.In(x => x.Id, distinctIds);
            var products = await _collection.Find(filter).ToListAsync(ct);
            var prices = new Dictionary<(string SeriesId, string VariantId), decimal?>();


            foreach (var item in itemsList)
            {
                var product = products.FirstOrDefault(p => p.Id == item.SeriesId);
                if (product == null)
                {
                    prices[item] = null;
                    continue;
                }
                var variant = product.Variants.FirstOrDefault(v => v.Id == item.VariantId);
                if (variant == null)
                {
                    prices[item] = null;
                    continue;
                }
                if (variant.Specs.TryGetValue("Price", out var priceStr) && decimal.TryParse(priceStr, out var price))
                {
                    prices[item] = price;
                }
                else
                {
                    prices[item] = null;
                }
            }
            
            return prices;
        }
    }
}
