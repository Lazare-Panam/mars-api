using System.Text.Json.Serialization;

namespace Mars.API.Models.SeriesProducts
{
    public class CategoryFilter
    {
        public int CategoryId { get; set; }
        public int FilterId { get; set; }
        public int SortOrder { get; set; }
        [JsonIgnore]
        public Category Category { get; set; }
        [JsonIgnore]
        public Filter Filter { get; set; }
    }
}
