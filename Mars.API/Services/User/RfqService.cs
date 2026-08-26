using Azure.Core;
using Mars.API.Models.Basket;
using Mars.API.Repository.Interfaces;
using Mars.API.Repository.NoSQL;
using Mars.API.Repository.SQL;
using Mars.API.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Mars.API.Services.User
{
    public class RfqService : IRfqService
    {
        private readonly INotificationService _notificationService;
        private readonly ILogger<RfqService> _logger;
        private readonly ApplicationDBContext _context;

        public RfqService(INotificationService notificationService, ILogger<RfqService> logger, ApplicationDBContext context)
        {
            _notificationService = notificationService;
            _logger = logger;
            _context = context;
        }
        public async Task<QuoteRequest> CreateRfq(string userId, string userName, string userEmail, string userCompany, CreateRfqRequest request)
        {
            var rfq = new QuoteRequest
            {
                QuoteRequestId = Guid.NewGuid().ToString(),
                UserId = userId,
                CreatedAt = DateTimeOffset.UtcNow,
                UpdatedAt = DateTimeOffset.UtcNow,
                Items = request.LineItems.Select(item => new QuoteRequestItem
                {
                    ProductId = item.ProductId,
                    Quantity = item.Quantity,
                    ProductDescription = item.ProductDescription,
                    PictureUrl = item.PictureUrl
                }).ToList()
            };

            await _context.QuoteRequests.AddAsync(rfq);
            await _context.SaveChangesAsync();
            _logger.LogInformation("Quote request {@QuoteRequestId} created for user {@UserId} with {@ItemCount} item(s)", rfq.QuoteRequestId, userId, rfq.Items.Count);
            await _notificationService.HandleNewRfqSubmittedAsync(userName, userEmail, userCompany, rfq.QuoteRequestId, rfq.Items);
            return rfq;
        }
    }
}
