using MongoDB.Bson.Serialization.Attributes;

namespace Mars.API.Models.Products
{
    public class ProductItem
    {
        [BsonElement("id")]
        public string? Id { get; set; }

        [BsonElement("name")]
        public string? Name { get; set; }

        [BsonElement("description")]
        public string? Description { get; set; }

        [BsonElement("thumbnailImage")]
        public string? ThumbnailImage { get; set; }

        [BsonElement("specs")]
        public Dictionary<string, string>? Specs { get; set; }

        [BsonElement("features")]
        public List<string>? Features { get; set; }
    }
}
