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

    /// <summary>
    /// A guest's browser cart, sent once after login to be merged into the user's basket.
    /// </summary>
    /*Todo Disha, remvoe the merge, why record? why not class , difference between record and class*/
    public record MergeBasketRequest(List<AddToCartRequest> Items);
}
