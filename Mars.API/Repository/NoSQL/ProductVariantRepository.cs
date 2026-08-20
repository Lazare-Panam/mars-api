using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductVariantRepository : MongoRepositoryBase<ProductSeriesVariants>, IProductVariantRepository
    {
 
        public ProductVariantRepository(IMongoDatabase database, ILogger<ProductVariantRepository> logger) : base(database, logger, "product_variants")
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
    }
}
