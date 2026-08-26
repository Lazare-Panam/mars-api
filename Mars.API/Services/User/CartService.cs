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
        /// <summary>
        /// Retrieves the basket for an authenticated user, or an anonymous session if <paramref name="userId"/> is null.
        /// </summary>
        /// <param name="userId">The authenticated user's id, or <c>null</c> for an anonymous/session-based basket.</param>
        /// <param name="sessionId">The anonymous session id, used when <paramref name="userId"/> is <c>null</c>.</param>
        /// <returns>The matching basket including its items, or <c>null</c> if none exists.</returns>
        public async Task<CustomerBasket?> GetBasketAsync(string? userId, string sessionId)
        {
            return !string.IsNullOrEmpty(userId)
                ? await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.UserId == userId)
                : await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.SessionId == sessionId);
        }

        /// <summary>
        /// Adds an item to the user's/session's basket, incrementing quantity if it already exists.
        /// Creates a new basket first if one doesn't exist yet.
        /// </summary>
        /// <param name="userId">The authenticated user's id, or <c>null</c> for an anonymous/session-based basket.</param>
        /// <param name="sessionId">The anonymous session id, used when <paramref name="userId"/> is <c>null</c>.</param>
        /// <param name="addToCartRequest">The variant, quantity, and display details to add to the basket.</param>
        /// <returns>The updated basket.</returns>
        public async Task<CustomerBasket> AddOrUpdate(string? userId, string sessionId, AddToCartRequest addToCartRequest)
        {

            CustomerBasket? basket;
            decimal? price = await _productVariantRepository.GetPriceAsync(addToCartRequest.SeriesId, addToCartRequest.VariantId);
            var item = new BasketItem
            {
                SeriesId = addToCartRequest.SeriesId,
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
                _logger.LogInformation("No existing basket found for UserId {@UserId} or SessionId {@SessionId}; creating new basket", userId ?? "anonymous", sessionId);
            }
            var existingItem = basket.Items.FirstOrDefault(i => i.ProductId == item.ProductId);
            if (existingItem is not null)
            {
                _logger.LogInformation("Item {@ProductId} already in basket {@BasketId}; incrementing quantity from {@OldQuantity} to {@NewQuantity}", item.ProductId, basket.CustomerBasketId, existingItem.Quantity, existingItem.Quantity + item.Quantity);
                existingItem.Quantity += item.Quantity;
                existingItem.UnitPrice = item.UnitPrice;
            }
            else
            {
                _logger.LogInformation("Item {@ProductId} not in basket {@BasketId}; adding as new item with quantity {@Quantity}", item.ProductId, basket.CustomerBasketId, item.Quantity);
                item.CustomerBasketId = basket.CustomerBasketId;
                basket.Items.Add(item);
            }

            basket.UpdatedAt = DateTimeOffset.UtcNow;
            await _context.SaveChangesAsync();
            _logger.LogInformation("Basket {@BasketId} updated for user {@UserId}, product {@VariantId}",basket.CustomerBasketId, userId, item.ProductId);
            return basket;
        }
        /// <summary>
        /// Updates the quantity of an existing basket item, or removes it entirely if <paramref name="quantity"/> is zero or less.
        /// </summary>
        /// <param name="userId">The authenticated user's id, or <c>null</c> for an anonymous/session-based basket.</param>
        /// <param name="sessionId">The anonymous session id, used when <paramref name="userId"/> is <c>null</c>.</param>
        /// <param name="productId">The variant id of the item to update.</param>
        /// <param name="quantity">The new quantity; a value of zero or less removes the item.</param>
        /// <returns>The updated basket, or <c>null</c> if no basket or matching item was found.</returns>
        public async Task<CustomerBasket?> UpdateItemQuantityAsync(string? userId, string sessionId, string productId, int quantity)
        {
            var basket = !string.IsNullOrEmpty(userId)
                ? await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.UserId == userId)
                : await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.SessionId == sessionId);

            if (basket is null)
            {
                _logger.LogInformation("No basket found for UserId {@UserId} or SessionId {@SessionId}", userId ?? "anonymous", sessionId);
                return null;
            } 

            var item = basket.Items.FirstOrDefault(i => i.ProductId == productId);
            if (item is null)
            { 
                _logger.LogInformation("No matching item found for UserId {@UserId} or SessionId {@SessionId}", userId ?? "anonymous", sessionId);
                return null;
            }

            if (quantity <= 0)
            {
                basket.Items.Remove(item);
                _logger.LogInformation("Removing item {@ProductId} from basket {@BasketId} for user {@UserId}", productId, basket.CustomerBasketId, userId ?? "anonymous");
                _context.BasketItems.Remove(item);
            }
            else
            {
                _logger.LogInformation("Updating item {@ProductId} quantity to {@Quantity} in basket {@BasketId} for user {@UserId}", productId, quantity, basket.CustomerBasketId, userId ?? "anonymous");
                item.Quantity = quantity;
            }

            basket.UpdatedAt = DateTimeOffset.UtcNow;
            await _context.SaveChangesAsync();
            _logger.LogInformation("Basket {@BasketId} updated for user {@UserId}", basket.CustomerBasketId, userId ?? "anonymous");
            return basket;
        }

        /// <summary>
        /// Removes a single item from the basket.
        /// </summary>
        /// <param name="userId">The authenticated user's id, or <c>null</c> for an anonymous/session-based basket.</param>
        /// <param name="sessionId">The anonymous session id, used when <paramref name="userId"/> is <c>null</c>.</param>
        /// <param name="productId">The variant id of the item to remove.</param>
        /// <returns><c>true</c> if the item was removed; <c>false</c> if no basket or matching item was found.</returns>
        public async Task<bool> RemoveItemAsync(string? userId, string sessionId, string productId)
        {
            var basket = !string.IsNullOrEmpty(userId)
                ? await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.UserId == userId)
                : await _context.CustomerBaskets.Include(b => b.Items).FirstOrDefaultAsync(b => b.SessionId == sessionId);

            var item = basket?.Items.FirstOrDefault(i => i.ProductId == productId);
            if (basket is null || item is null)
            {
                _logger.LogInformation("No basket or matching item found for UserId {@UserId} or SessionId {@SessionId}", userId ?? "anonymous", sessionId);
                return false;
            }
            _logger.LogInformation("Basket found for UserId {@UserId} or SessionId {@SessionId}", userId ?? "anonymous", sessionId);
            basket.Items.Remove(item);
            _context.BasketItems.Remove(item);
            basket.UpdatedAt = DateTimeOffset.UtcNow;
            await _context.SaveChangesAsync();
            _logger.LogInformation("Removed item {@ProductId} from basket {@BasketId} for user {@UserId}", productId, basket.CustomerBasketId, userId ?? "anonymous");
            return true;
        }

        /// <summary>
        /// Deletes the entire basket, cascading to its items.
        /// </summary>
        /// <param name="userId">The authenticated user's id, or <c>null</c> for an anonymous/session-based basket.</param>
        /// <param name="sessionId">The anonymous session id, used when <paramref name="userId"/> is <c>null</c>.</param>
        /// <returns><c>true</c> if a basket was found and deleted; <c>false</c> otherwise.</returns>
        public async Task<bool> DeleteBasketAsync(string? userId, string sessionId)
        {
            var basket = !string.IsNullOrEmpty(userId)
                ? await _context.CustomerBaskets.FirstOrDefaultAsync(b => b.UserId == userId)
                : await _context.CustomerBaskets.FirstOrDefaultAsync(b => b.SessionId == sessionId);
            if (basket is null)
            {
                _logger.LogInformation("No basket found for UserId {@UserId} or SessionId {@SessionId}", userId ?? "anonymous", sessionId);
                return false;
            }
            _context.CustomerBaskets.Remove(basket);
            await _context.SaveChangesAsync();
            _logger.LogInformation("Deleting basket {@BasketId} for user {@UserId}", basket.CustomerBasketId, userId ?? "anonymous");
            return true;
        }
    }
}
