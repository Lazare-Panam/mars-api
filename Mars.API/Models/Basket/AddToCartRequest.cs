namespace Mars.API.Models.Basket
{
    public record AddToCartRequest(
        string SeriesId,
        string VariantId,
        string ProductDescription,
        int Quantity,
        string PictureUrl
    );

    public record UpdateQuantityRequest(int Quantity);
}
