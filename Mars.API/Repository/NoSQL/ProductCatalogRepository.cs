using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductCatalogRepository : IProductCatalogRepository
    {
        private readonly IMongoCollection<ProductCatalog> _collection;
        private readonly string collectionName = "product_series";
        public ProductCatalogRepository(IMongoDatabase database)
        {
            _collection = database.GetCollection<ProductCatalog>(collectionName);
        }
        public async Task<ProductCatalog?> GetByIdAsync(string id)
        {
            return await _collection.Find(x=>x.Id==id).FirstOrDefaultAsync();
        }
    }
}
