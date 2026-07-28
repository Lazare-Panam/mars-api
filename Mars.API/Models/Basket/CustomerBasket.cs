using System.ComponentModel.DataAnnotations.Schema;

namespace Mars.API.Models.Basket
{
    public class CustomerBasket
    {
        public string CustomerBasketId { get; set; } = Guid.NewGuid().ToString();
        public string? UserId { get; set; }
        public string SessionId { get; set; }
        public List<BasketItem> Items { get; set; } = [];
        public DateTimeOffset CreatedAt { get; set; }
        public DateTimeOffset UpdatedAt { get; set; }

        [NotMapped]
        public decimal TotalPrice => Items.Sum(item => item.UnitPrice * item.Quantity);
        public CustomerBasket() { }
        public CustomerBasket(string userId )
        {
            UserId = userId;
        }
    }
}
