using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using MongoDB.Driver;

namespace Mars.API.Repository.NoSQL
{
    public class MongoRepositoryBase<T> : INoSQLRepository<T> where T : class, IHasId
    {   
        protected readonly IMongoCollection<T> _collection;
        private readonly ILogger<MongoRepositoryBase<T>> _logger;
        public MongoRepositoryBase(IMongoDatabase database, ILogger<MongoRepositoryBase<T>> logger, string collectionName)
        {
            _collection = database.GetCollection<T>(collectionName);
            _logger = logger;
        }
        public async Task<T?> GetByIdAsync(string id, CancellationToken ct = default)
        {
            try
            {
                ArgumentException.ThrowIfNullOrWhiteSpace(id);
                return await _collection.Find(x => x.Id == id).FirstOrDefaultAsync(ct);
            }
            catch (OperationCanceledException ex)
            {
                _logger.LogDebug(ex, "Operation Cancelled for {EntityType} {Id}", typeof(T).Name, id);
                throw;
            }
            catch (MongoException ex)
            {
                _logger.LogWarning(ex, "MongoDB error fetching {EntityType} {Id}", typeof(T).Name, id);
                throw;
            }
        }
    }
}
