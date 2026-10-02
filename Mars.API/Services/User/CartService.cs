using Mars.API.Models.Basket;
using Mars.API.Repository.Interfaces;
using Mars.API.Repository.SQL;
using Mars.API.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Mars.API.Services.User
{
    /// <summary>
    /// The signed-in user's basket. There is one basket per user, found by user id;
    /// guests keep their cart in the browser until they log in and it is merged in.
    /// </summary>
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
        /// Retrieves the user's basket including its items.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <returns>The basket, or <c>null</c> if the user has none yet.</returns>
        public async Task<CustomerBasket?> GetBasketAsync(string userId)
        {
            return await _context.CustomerBaskets
                .Include(b => b.Items)
                .FirstOrDefaultAsync(b => b.UserId == userId);
        }

        /// <summary>
        /// Adds one item to the user's basket, increasing the quantity if it's already there.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <param name="addToCartRequest">The variant, quantity, and display details to add.</param>
        /// <returns>The updated basket.</returns>
        public Task<CustomerBasket> AddOrUpdate(string userId, AddToCartRequest addToCartRequest)
        {
            return AddItemsAsync(userId, [addToCartRequest]);
        }

        /// <summary>
        /// Adds several items to the user's basket in one save, e.g. a guest cart being merged at login.
        /// Items already in the basket have their quantities increased. Prices come from the catalogue.
        /// Creates the basket first if the user doesn't have one.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <param name="items">The items to add.</param>
        /// <returns>The updated basket.</returns>
        public async Task<CustomerBasket> AddItemsAsync(string userId, IReadOnlyCollection<AddToCartRequest> items)
        {
            var prices = await _productVariantRepository.GetPricesAsync(items.Select(i => (i.SeriesId, i.VariantId)));

            var basket = await GetBasketAsync(userId);
            if (basket is null)
            {
                basket = new CustomerBasket(userId) { CreatedAt = DateTimeOffset.UtcNow };
                _context.CustomerBaskets.Add(basket);
                _logger.LogInformation("Creating basket {BasketId} for user {UserId}", basket.CustomerBasketId, userId);
            }

            BasketMerge.Apply(basket, items, prices);
            await _context.SaveChangesAsync();
            _logger.LogInformation("Added {ItemCount} item(s) to basket {BasketId} for user {UserId}", items.Count, basket.CustomerBasketId, userId);
            return basket;
        }

        /// <summary>
        /// Updates the quantity of an item in the user's basket, or removes it if <paramref name="quantity"/> is zero or less.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <param name="productId">The variant id of the item to update.</param>
        /// <param name="quantity">The new quantity; zero or less removes the item.</param>
        /// <returns>The updated basket, or <c>null</c> if the user has no basket or the item isn't in it.</returns>
        public async Task<CustomerBasket?> UpdateItemQuantityAsync(string userId, string productId, int quantity)
        {
            var basket = await GetBasketAsync(userId);
            var item = basket?.Items.FirstOrDefault(i => i.ProductId == productId);
            if (basket is null || item is null)
            {
                _logger.LogInformation("No basket or item {ProductId} found for user {UserId}", productId, userId);
                return null;
            }

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
            _logger.LogInformation("Set item {ProductId} quantity to {Quantity} in basket {BasketId} for user {UserId}", productId, quantity, basket.CustomerBasketId, userId);
            return basket;
        }

        /// <summary>
        /// Removes a single item from the user's basket.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <param name="productId">The variant id of the item to remove.</param>
        /// <returns><c>true</c> if the item was removed; <c>false</c> if the user has no basket or the item isn't in it.</returns>
        public async Task<bool> RemoveItemAsync(string userId, string productId)
        {
            var basket = await GetBasketAsync(userId);
            var item = basket?.Items.FirstOrDefault(i => i.ProductId == productId);
            if (basket is null || item is null)
            {
                _logger.LogInformation("No basket or item {ProductId} found for user {UserId}", productId, userId);
                return false;
            }

            basket.Items.Remove(item);
            _context.BasketItems.Remove(item);
            basket.UpdatedAt = DateTimeOffset.UtcNow;
            await _context.SaveChangesAsync();
            _logger.LogInformation("Removed item {ProductId} from basket {BasketId} for user {UserId}", productId, basket.CustomerBasketId, userId);
            return true;
        }

        /// <summary>
        /// Deletes the user's basket, cascading to its items.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <returns><c>true</c> if a basket was found and deleted; <c>false</c> otherwise.</returns>
        public async Task<bool> DeleteBasketAsync(string userId)
        {
            var basket = await _context.CustomerBaskets.FirstOrDefaultAsync(b => b.UserId == userId);
            if (basket is null)
            {
                _logger.LogInformation("No basket found for user {UserId}", userId);
                return false;
            }

            _context.CustomerBaskets.Remove(basket);
            await _context.SaveChangesAsync();
            _logger.LogInformation("Deleted basket {BasketId} for user {UserId}", basket.CustomerBasketId, userId);
            return true;
        }
    }
}
