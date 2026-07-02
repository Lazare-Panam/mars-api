using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Mars.API.Models.Products
{
    [BsonIgnoreExtraElements]
    public class ProductVariant
    {
        [BsonElement("id")]
        public string Id { get; set; } = string.Empty;

        [BsonElement("specs")]
        public Dictionary<string, string> Specs { get; set; } = [];
    }
}
