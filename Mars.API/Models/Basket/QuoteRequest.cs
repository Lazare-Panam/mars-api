using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace Mars.API.Models.Basket
{
    public class QuoteRequest
    {
        public string QuoteRequestId { get; set; } 
        public string UserId { get; set; }
        public List<QuoteRequestItem> Items { get; set; } = [];
        public DateTimeOffset CreatedAt { get; set; }
        public DateTimeOffset UpdatedAt { get; set; }
    }
}