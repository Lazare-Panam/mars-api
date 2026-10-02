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
        /// Adds one item to the user's basket, increasing the quantity if it's already there.
        /// Creates the basket first if the user doesn't have one.
        /// </summary>
        /// <param name="userId">The signed-in user's id.</param>
        /// <param name="addToCartRequest">The variant, quantity, and display details to add.</param>
        /// <returns>The updated basket.</returns>
        Task<CustomerBasket> AddOrUpdate(string userId, AddToCartRequest addToCartRequest);

        /// <summary>
        /// Adds several items in one save (e.g. merging a guest cart at login). Quantities of items
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
