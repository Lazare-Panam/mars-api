using Azure.Core;
using Mars.API.Models.Basket;
using Mars.API.Repository.Interfaces;
using Mars.API.Repository.NoSQL;
using Mars.API.Repository.SQL;
using Mars.API.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Mars.API.Services.User
{
    public class CartService : ICartService
    {
        private readonly ILogger<CartService> _logger;
        private readonly IProductVariantRepository _productVariantRepository;
        private readonly ApplicationDBContext _context;

        public CartService(ILogger<CartService> logger, ApplicationDBContext context, IProductVariantRepository productVariantRepository)
        {
            _logger = logger;
            _context = context;
            _productVariantRepository = productVariantRepository;
        }
        public async Task<CustomerBasket?> GetBasketAsync(string? userId, string sessionId)
        {
            return !string.IsNullOrEmpty(userId)
                ? await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.UserId == userId)
                : await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.SessionId == sessionId);
        }

        public async Task<CustomerBasket> AddOrUpdate(string? userId, string sessionId, AddToCartRequest addToCartRequest)
        {

            CustomerBasket? basket;
            decimal? price = await _productVariantRepository.GetPriceAsync(addToCartRequest.SeriesId, addToCartRequest.VariantId);
            var item = new BasketItem
            {
                ProductId = addToCartRequest.VariantId,
                ProductDescription = addToCartRequest.ProductDescription,
                UnitPrice = price??0m,
                Quantity = addToCartRequest.Quantity,
                PictureUrl = addToCartRequest.PictureUrl
            };

            if (!string.IsNullOrEmpty(userId))
            {
                basket = await _context.CustomerBaskets
                    .Include(b => b.Items)
                    .FirstOrDefaultAsync(b => b.UserId == userId);
            }
            else
            {
                basket = await _context.CustomerBaskets
                    .Include(b => b.Items)
                    .FirstOrDefaultAsync(b => b.SessionId == sessionId);
            }
            if (basket == null)
            {
                if(userId == null)
                    basket = new CustomerBasket { SessionId = sessionId };
                else 
                basket = new CustomerBasket(userId) { SessionId = sessionId };
                _context.CustomerBaskets.Add(basket);
            }
            var existingItem = basket.Items.FirstOrDefault(i => i.ProductId == item.ProductId);

            if (existingItem is not null)
            {
                existingItem.Quantity += item.Quantity;
                existingItem.UnitPrice = item.UnitPrice; 
            }
            else
            {
                item.CustomerBasketId = basket.CustomerBasketId;
                basket.Items.Add(item);
            }

            basket.UpdatedAt = DateTimeOffset.UtcNow;

            await _context.SaveChangesAsync();

            _logger.LogInformation("Basket {BasketId} updated for user {UserId}, product {VariantId}",basket.CustomerBasketId, userId, item.ProductId);

            return basket;
        }
        public async Task<CustomerBasket?> UpdateItemQuantityAsync(string? userId, string sessionId, string productId, int quantity)
        {
            var basket = !string.IsNullOrEmpty(userId)
                ? await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.UserId == userId)
                : await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.SessionId == sessionId);

            if (basket is null) return null;

            var item = basket.Items.FirstOrDefault(i => i.ProductId == productId);
            if (item is null) return null;

            if (quantity <= 0)
            {
                basket.Items.Remove(item);
                _context.BasketItems.Remove(item);
            }
            else
            {
                item.Quantity = quantity;
            }

            basket.UpdatedAt = DateTimeOffset.UtcNow;
            await _context.SaveChangesAsync();
            return basket;
        }

        public async Task<bool> RemoveItemAsync(string? userId, string sessionId, string productId)
        {
            var basket = !string.IsNullOrEmpty(userId)
                ? await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.UserId == userId)
                : await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.SessionId == sessionId);

            var item = basket?.Items.FirstOrDefault(i => i.ProductId == productId);
            if (basket is null || item is null) return false;

            basket.Items.Remove(item);
            _context.BasketItems.Remove(item);
            basket.UpdatedAt = DateTimeOffset.UtcNow;

            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> DeleteBasketAsync(string? userId, string sessionId)
        {
            var basket = !string.IsNullOrEmpty(userId)
                ? await _context.CustomerBaskets.FirstOrDefaultAsync(b => b.UserId == userId)
                : await _context.CustomerBaskets.FirstOrDefaultAsync(b => b.SessionId == sessionId);

            if (basket is null) return false;

            _context.CustomerBaskets.Remove(basket); // cascade deletes items
            await _context.SaveChangesAsync();
            return true;
        }
    }
}
