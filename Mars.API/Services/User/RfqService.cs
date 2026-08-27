
using Mars.API.Models.Basket;
using Mars.API.Repository.Interfaces;
using Mars.API.Repository.SQL;
using Mars.API.Services.Interfaces;
namespace Mars.API.Services.User
{
    public class RfqService : IRfqService
    {
        private readonly INotificationService _notificationService;
        private readonly IProductVariantRepository _productVariantRepository;
        private readonly ILogger<RfqService> _logger;
        private readonly ApplicationDBContext _context;

        public RfqService(INotificationService notificationService, IProductVariantRepository productVariantRepository, ILogger<RfqService> logger, ApplicationDBContext context)
        {
            _notificationService = notificationService;
            _productVariantRepository = productVariantRepository;
            _logger = logger;
            _context = context;
        }
        public async Task<QuoteRequest> CreateRfq(string userId, string userName, string userEmail, string userCompany, CreateRfqRequest request)
        {
            var items = new List<QuoteRequestItem>();
            foreach (var item in request.LineItems)
            {
                decimal? price = await _productVariantRepository.GetPriceAsync(item.SeriesId, item.ProductId);
                items.Add(new QuoteRequestItem
                {
                    ProductId = item.ProductId,
                    Quantity = item.Quantity,
                    ProductDescription = item.ProductDescription,
                    PictureUrl = item.PictureUrl,
                    UnitPrice = price
                });
            }

            var rfq = new QuoteRequest
            {
                QuoteRequestId = Guid.NewGuid().ToString(),
                UserId = userId,
                CreatedAt = DateTimeOffset.UtcNow,
                UpdatedAt = DateTimeOffset.UtcNow,
                Items = items
            };

            await _context.QuoteRequests.AddAsync(rfq);
            await _context.SaveChangesAsync();
            _logger.LogInformation("Quote request {@QuoteRequestId} created for user {@UserId} with {@ItemCount} item(s)", rfq.QuoteRequestId, userId, rfq.Items.Count);
            await _notificationService.HandleNewRfqSubmittedAsync(userName, userEmail, userCompany, rfq.QuoteRequestId, rfq.Items);
            return rfq;
        }
    }
}
