using Mars.API.Models.Basket;

namespace Mars.API.Services.User
{
    /// <summary>
    /// Adds items to a basket: an item already in the basket has its quantity increased,
    /// a new item is appended. Prices always come from <paramref name="prices"/> (the catalogue),
    /// never from the request.
    /// </summary>
    public static class BasketItems
    {
        public static void Add(
            CustomerBasket basket,
            IEnumerable<AddToCartRequest> items,
            IReadOnlyDictionary<(string SeriesId, string VariantId), decimal?> prices)
        {
            foreach (var request in items)
            {
                // Unpriced ("contact for price") variants are stored with a price of 0.
                var price = prices.GetValueOrDefault((request.SeriesId, request.VariantId)) ?? 0m;
                var existing = basket.Items.FirstOrDefault(i => i.ProductId == request.VariantId);

                if (existing is not null)
                {
                    existing.Quantity += request.Quantity;
                    existing.UnitPrice = price;
                    continue;
                }

                basket.Items.Add(new BasketItem
                {
                    SeriesId = request.SeriesId,
                    ProductId = request.VariantId,
                    ProductDescription = request.ProductDescription,
                    UnitPrice = price,
                    Quantity = request.Quantity,
                    PictureUrl = request.PictureUrl,
                    CustomerBasketId = basket.CustomerBasketId,
                });
            }

            basket.UpdatedAt = DateTimeOffset.UtcNow;
        }
    }
}
