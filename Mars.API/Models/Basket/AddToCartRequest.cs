namespace Mars.API.Models.Basket
{
    public record AddToCartRequest(
        string ProductId,
        string ProductDescription,
        decimal UnitPrice,
        int Quantity,
        string PictureUrl
    );

    public record UpdateQuantityRequest(int Quantity);
}
