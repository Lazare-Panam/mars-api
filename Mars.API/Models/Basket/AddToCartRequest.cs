namespace Mars.API.Models.Basket
{
    public record AddToCartRequest(
        string SeriesId,
        string VariantId,
        string ProductDescription,
        int Quantity,
        string PictureUrl
    );

    /// <summary>
    /// Changes one saved item's quantity. A quantity of 0 removes the item.
    /// </summary>
    public record UpdateQuantityRequest(int Quantity);

    /// <summary>
    /// The items from the user's cart page, saved into their saved cart. Items already saved
    /// have their quantities increased; new items are added.
    /// </summary>
    public record SaveBasketRequest(List<AddToCartRequest> Items);
}
