using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace Mars.API.Models.Products
{
    [BsonIgnoreExtraElements]
    public class ProductSeriesVariants
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string? MongoId { get; set; }

        [BsonElement("seriesId")]
        public string SeriesId { get; set; } = string.Empty;

        [BsonElement("catalogId")]
        public string CatalogId { get; set; } = string.Empty;

        [BsonElement("name")]
        public string Name { get; set; } = string.Empty;

        [BsonElement("thumbnailImage")]
        public string ThumbnailImage { get; set; } = string.Empty;

        [BsonElement("variants")]
        public List<ProductVariant> Variants { get; set; } = [];
    }
}
