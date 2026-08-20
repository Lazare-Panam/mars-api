using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductDetailRepository : MongoRepositoryBase<ProductDetail>
    {
        public ProductDetailRepository(IMongoDatabase database, ILogger<ProductDetailRepository> logger) : base(database, logger, "product_details")
        {
        }
    }
}
