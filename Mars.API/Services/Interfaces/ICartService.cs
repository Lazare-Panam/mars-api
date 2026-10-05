using Mars.API.Models.Basket;

namespace Mars.API.Services.Interfaces
{
    public interface ICartService
    {
        /// <summary>
        /// Retrieves the signed-in user's basket including its items.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <returns>The basket, or <c>null</c> if the user has none yet.</returns>
        Task<CustomerBasket?> GetBasketAsync(string userId);

        /// <summary>
        /// Adds several items in one save (e.g. the cart page being saved). Quantities of items
        /// already in the basket are increased; prices come from the catalogue.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <param name="items">The items to add.</param>
        /// <returns>The updated basket.</returns>
        Task<CustomerBasket> AddItemsAsync(string userId, IReadOnlyCollection<AddToCartRequest> items);

        /// <summary>
        /// Updates an item's quantity, or removes it if <paramref name="quantity"/> is zero or less.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <param name="productId">The variant id of the item to update.</param>
        /// <param name="quantity">The new quantity; zero or less removes the item.</param>
        /// <returns>The updated basket, or <c>null</c> if the user has no basket or the item isn't in it.</returns>
        Task<CustomerBasket?> UpdateItemQuantityAsync(string userId, string productId, int quantity);

        /// <summary>
        /// Removes a single item from the user's basket.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <param name="productId">The variant id of the item to remove.</param>
        /// <returns><c>true</c> if the item was removed; <c>false</c> otherwise.</returns>
        Task<bool> RemoveItemAsync(string userId, string productId);

        /// <summary>
        /// Deletes the user's basket and its items.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <returns><c>true</c> if a basket was found and deleted; <c>false</c> otherwise.</returns>
        Task<bool> DeleteBasketAsync(string userId);
    }
}
