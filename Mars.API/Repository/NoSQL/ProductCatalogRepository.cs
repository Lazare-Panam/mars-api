using Mars.API.Models.Products;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductCatalogRepository : MongoRepositoryBase<ProductCatalog>
    {
        private const string CollectionName = "product_series";

        public ProductCatalogRepository(IMongoDatabase database, ILogger<ProductCatalogRepository> logger) : base(database, logger, CollectionName)
        { 
        }
    }
}
