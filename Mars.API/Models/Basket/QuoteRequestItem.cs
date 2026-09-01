using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Mars.API.Models.Basket
{
    public class QuoteRequestItem : IValidatableObject
    {
        public string Id { get; set; } = Guid.NewGuid().ToString();
        public string ProductId { get; set; }
        public string ProductDescription { get; set; }
        public decimal? UnitPrice { get; set; }
        public int Quantity { get; set; }
        public string PictureUrl { get; set; }
        public string QuoteRequestId { get; set; }
        [JsonIgnore]
        public QuoteRequest QuoteRequest { get; set; }
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
