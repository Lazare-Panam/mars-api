using System.Text.Json.Serialization;

namespace Mars.API.Models.Search
{
    public class ProductAttribute
    {
        [JsonPropertyName("name")] public string Name { get; set; } = string.Empty;
        [JsonPropertyName("value")] public string Value { get; set; } = string.Empty;
    }
    public class ProductSearchDocument
    {
        [JsonPropertyName("id")] public string Id { get; set; } = string.Empty;         
        [JsonPropertyName("partNumber")] public string PartNumber { get; set; } = string.Empty;
        [JsonPropertyName("series")] public string? Series { get; set; }                  
        [JsonPropertyName("seriesName")] public string? SeriesName { get; set; }
        [JsonPropertyName("attributes")] public List<ProductAttribute>? Attributes { get; set; }
        [JsonPropertyName("specs")] public string? Specs { get; set; }                   
        [JsonPropertyName("image")] public string? Image { get; set; }
        [JsonPropertyName("href")] public string Href { get; set; } = string.Empty;       
    }

    public class SeriesSearchDocument
    {
        [JsonPropertyName("id")] public string Id { get; set; } = string.Empty;
        [JsonPropertyName("name")] public string Name { get; set; } = string.Empty;
        [JsonPropertyName("description")] public string? Description { get; set; }
        [JsonPropertyName("keyFeatures")] public string? KeyFeatures { get; set; }
        [JsonPropertyName("design")] public string? Design { get; set; }
        [JsonPropertyName("image")] public string? Image { get; set; }
        [JsonPropertyName("href")] public string Href { get; set; } = string.Empty;
    }
    public class SearchResultsDto
    {
        public IReadOnlyList<SeriesSearchDocument> Series { get; set; } = [];
        public IReadOnlyList<ProductSearchDocument> Products { get; set; } = [];
    }
}
