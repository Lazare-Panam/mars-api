using Mars.API.Models.Basket;

namespace Mars.API.Services.Interfaces
{
    public interface ICartService
    {
        /// <summary>
        /// Retrieves the basket for an authenticated user, or an anonymous session if <paramref name="userId"/> is null.
        /// </summary>
        /// <param name="userId">The authenticated user's id, or <c>null</c> for an anonymous/session-based basket.</param>
        /// <param name="sessionId">The anonymous session id, used when <paramref name="userId"/> is <c>null</c>.</param>
        /// <returns>The matching basket including its items, or <c>null</c> if none exists.</returns>
        Task<CustomerBasket?> GetBasketAsync(string? userId, string sessionId);

        /// <summary>
        /// Adds an item to the user's/session's basket, incrementing quantity if it already exists.
        /// Creates a new basket first if one doesn't exist yet.
        /// </summary>
        /// <param name="userId">The authenticated user's id, or <c>null</c> for an anonymous/session-based basket.</param>
        /// <param name="sessionId">The anonymous session id, used when <paramref name="userId"/> is <c>null</c>.</param>
        /// <param name="item">The variant, quantity, and display details to add to the basket.</param>
        /// <returns>The updated basket.</returns>
        Task<CustomerBasket> AddOrUpdate(string? userId, string sessionId, AddToCartRequest item);

        /// <summary>
        /// Updates the quantity of an existing basket item, or removes it entirely if <paramref name="quantity"/> is zero or less.
        /// </summary>
        /// <param name="userId">The authenticated user's id, or <c>null</c> for an anonymous/session-based basket.</param>
        /// <param name="sessionId">The anonymous session id, used when <paramref name="userId"/> is <c>null</c>.</param>
        /// <param name="productId">The variant id of the item to update.</param>
        /// <param name="quantity">The new quantity; a value of zero or less removes the item.</param>
        /// <returns>The updated basket, or <c>null</c> if no basket or matching item was found.</returns>
        Task<CustomerBasket?> UpdateItemQuantityAsync(string? userId, string sessionId, string productId, int quantity);

        /// <summary>
        /// Removes a single item from the basket.
        /// </summary>
        /// <param name="userId">The authenticated user's id, or <c>null</c> for an anonymous/session-based basket.</param>
        /// <param name="sessionId">The anonymous session id, used when <paramref name="userId"/> is <c>null</c>.</param>
        /// <param name="productId">The variant id of the item to remove.</param>
        /// <returns><c>true</c> if the item was removed; <c>false</c> if no basket or matching item was found.</returns>
        Task<bool> RemoveItemAsync(string? userId, string sessionId, string productId);

        /// <summary>
        /// Deletes the entire basket, cascading to its items.
        /// </summary>
        /// <param name="userId">The authenticated user's id, or <c>null</c> for an anonymous/session-based basket.</param>
        /// <param name="sessionId">The anonymous session id, used when <paramref name="userId"/> is <c>null</c>.</param>
        /// <returns><c>true</c> if a basket was found and deleted; <c>false</c> otherwise.</returns>
        Task<bool> DeleteBasketAsync(string? userId, string sessionId);
    }
}
