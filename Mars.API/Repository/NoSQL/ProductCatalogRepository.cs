using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class ProductCatalogRepository : IProductCatalogRepository
    {
        private readonly IMongoCollection<ProductCatalog> _collection;
        private readonly string collectionName = "product_series";
        /// <summary>
        /// Initializes a repository for product catalog documents.
        /// </summary>
        public ProductCatalogRepository(IMongoDatabase database)
        {
            _collection = database.GetCollection<ProductCatalog>(collectionName);
        }
        /// <summary>
        /// Gets a product catalog by its identifier.
        /// </summary>
        /// <param name="id">The product catalog identifier.</param>
        /// <returns>The matching <see cref="ProductCatalog"/> if found, or <c>null</c> otherwise.</returns>
        public async Task<ProductCatalog?> GetByIdAsync(string id, CancellationToken ct)
        {
            return await _collection.Find(x=>x.Id==id).FirstOrDefaultAsync(ct);
        }
    }
}
