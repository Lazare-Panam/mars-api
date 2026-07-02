using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductDetailRepository : IProductDetailRepository
    {
        private readonly IMongoCollection<ProductDetail> _collection;
        private readonly string collectionName = "product_details";

        public ProductDetailRepository(IMongoDatabase database)
        {
            _collection = database.GetCollection<ProductDetail>(collectionName);
        }
        public async Task<ProductDetail?> GetByProductIdAsync(string catalogId, string productId, CancellationToken ct = default)
        {
            return await _collection.Find(x => x.CatalogId == catalogId && x.Id == productId).FirstOrDefaultAsync(ct);
        }
    }
}
