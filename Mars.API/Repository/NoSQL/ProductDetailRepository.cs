using Mars.API.Models.Products;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductDetailRepository : MongoRepositoryBase<ProductDetail>
    {
        private const string CollectionName = "product_details";

        public ProductDetailRepository(IMongoDatabase database, ILogger<ProductDetailRepository> logger) : base(database, logger, CollectionName)
        {
        }
    }
}
