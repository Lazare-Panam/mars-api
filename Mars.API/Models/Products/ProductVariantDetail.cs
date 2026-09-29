namespace Mars.API.Models.Products
{
    /// <summary>
    /// A single variant together with the series it belongs to, returned by
    /// <c>GET api/product/{id}/variants/{variantId}</c> for the variant detail page.
    /// </summary>
    public class ProductVariantDetail
    {
        public string SeriesId { get; set; } = string.Empty;
        public string SeriesName { get; set; } = string.Empty;
        public string SeriesThumbnailImage { get; set; } = string.Empty;
        public ProductVariant Variant { get; set; } = new();
    }
}
