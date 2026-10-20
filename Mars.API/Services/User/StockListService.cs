using Mars.API.Models.User;
using Mars.API.Repository.SQL;
using Mars.API.Services.Interfaces;

namespace Mars.API.Services.User
{
    public class StockListService : IStockListService
    {
        private readonly ILogger<StockListService> _logger;
        private readonly ApplicationDBContext _dbContext;
        private readonly INotificationService _notificationService;

        public StockListService(ILogger<StockListService> logger, ApplicationDBContext dbContext, INotificationService notificationService)
        {
            _logger = logger;
            _dbContext = dbContext;
            _notificationService = notificationService;
        }

        public async Task HandleStockListRequestAsync(StockListRequestDTO request, CancellationToken cancellationToken = default)
        {
            var entity = new StockListRequest
            {
                Id = Guid.NewGuid(),
                Name = request.Name,
                Email = request.Email,
                Phone = request.Phone
            };

            _dbContext.StockListRequests.Add(entity);
            await _dbContext.SaveChangesAsync(cancellationToken);
            _logger.LogInformation("Stock-list request {RequestId} stored", entity.Id);

            await _notificationService.HandleStockListRequestAsync(entity.Name, entity.Email, entity.Phone, DateTimeOffset.UtcNow);
        }
    }
}
