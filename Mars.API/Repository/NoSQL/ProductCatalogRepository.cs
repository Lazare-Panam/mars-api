using Mars.API.Models.Products;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductCatalogRepository : MongoRepositoryBase<ProductCatalog>
    {
        public ProductCatalogRepository(IMongoDatabase database, ILogger<ProductCatalogRepository> logger) : base(database, logger, "product_series")
        { 
        }
    }
}
