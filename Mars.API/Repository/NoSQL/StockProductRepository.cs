using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class StockProductRepository : IStockProductRepository
    {
        private readonly IMongoCollection<ProductDetail> _collection;
        private readonly ILogger<StockProductRepository> _logger;
        private const string CollectionName = "stock_products";
        public StockProductRepository(IMongoDatabase database, ILogger<StockProductRepository> logger)
        {
            _collection = database.GetCollection<ProductDetail>(CollectionName);
            _logger = logger;
        }
        public async Task<IEnumerable<ProductDetail>> GetAllStockProductsAsync(CancellationToken ct = default)
        {
            try
            {
                return await _collection
                    .Find(FilterDefinition<ProductDetail>.Empty)
                    .ToListAsync(ct);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to fetch stock products from {Collection}", CollectionName);
                throw;
            }
        }
    }
}
