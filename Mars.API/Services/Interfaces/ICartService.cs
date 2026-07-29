using Mars.API.Models.Basket;

namespace Mars.API.Services.Interfaces
{
    public interface ICartService
    {
        // ICartService
        Task<CustomerBasket?> GetBasketAsync(string? userId, string sessionId);
        Task<CustomerBasket> AddOrUpdate(string? userId, string sessionId, AddToCartRequest item);
        Task<CustomerBasket?> UpdateItemQuantityAsync(string? userId, string sessionId, string productId, int quantity);
        Task<bool> RemoveItemAsync(string? userId, string sessionId, string productId);
        Task<bool> DeleteBasketAsync(string? userId, string sessionId);
    }
}
