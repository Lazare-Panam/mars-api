using Mars.API.Repository.Interfaces;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Mars.API.Models.Products
{
    [BsonIgnoreExtraElements]
    public class ProductVariant : IHasId
    {
        [BsonElement("id")]
        public string Id { get; set; } = string.Empty;
        [BsonElement("thumbnailImage")]
        public string ThumbnailImage { get; set; } = string.Empty;

        [BsonElement("specs")]
        public Dictionary<string, string> Specs { get; set; } = [];
    }
}
