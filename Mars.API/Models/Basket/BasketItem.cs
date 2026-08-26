using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Mars.API.Models.Basket
{
    public class BasketItem : IValidatableObject
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string SeriesId { get; set; }
        public string ProductId { get; set; }
        public string ProductDescription { get; set; }
        public decimal UnitPrice { get; set; }
        public int Quantity { get; set; }
        public string PictureUrl { get; set; }
        public string CustomerBasketId { get; set; }
        [JsonIgnore]
        public CustomerBasket CustomerBasket { get; set; }
        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            var results = new List<ValidationResult>();
            if (Quantity < 0)
            {
                results.Add(new ValidationResult("Quantity must be at least 0.", new[] { nameof(Quantity) }));
            }
            return results;
        }
    }
}
