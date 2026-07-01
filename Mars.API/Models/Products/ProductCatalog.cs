using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Mars.API.Models.Products
{
    public class ProductCatalog
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public ObjectId MongoId { get; set; }

        [BsonElement("id")]
        public string? Id { get; set; }

        [BsonElement("bannerImage")]
        public string? BannerImage { get; set; }

        [BsonElement("bannerTitle")]
        public string? BannerTitle { get; set; }

        [BsonElement("bannerSubtitle")]
        public string? BannerSubtitle { get; set; }

        [BsonElement("products")]
        public List<ProductItem>? Products { get; set; }
    }
}
