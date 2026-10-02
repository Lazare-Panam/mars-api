using Mars.API.Models.Basket;
using Mars.API.Services.User;

namespace Mars.Tests.Services
{
    public class BasketMergeTests
    {
        private const string SeriesId = "economical-two-piece-ball-valve";

        private static AddToCartRequest Item(string variantId, int quantity = 1) =>
            new(SeriesId, variantId, variantId, quantity, "https://example.com/valve.png");

        private static Dictionary<(string SeriesId, string VariantId), decimal?> Prices(params (string VariantId, decimal? Price)[] prices) =>
            prices.ToDictionary(p => (SeriesId, p.VariantId), p => p.Price);

        [Fact]
        public void Apply_NewItem_IsAddedWithCataloguePrice()
        {
            var basket = new CustomerBasket("user-1");

            BasketMerge.Apply(basket, [Item("V20-A", 2)], Prices(("V20-A", 11.55m)));

            var item = Assert.Single(basket.Items);
            Assert.Equal("V20-A", item.ProductId);
            Assert.Equal(SeriesId, item.SeriesId);
            Assert.Equal(2, item.Quantity);
            Assert.Equal(11.55m, item.UnitPrice);
            Assert.Equal(basket.CustomerBasketId, item.CustomerBasketId);
        }

        [Fact]
        public void Apply_ItemAlreadyInBasket_AddsQuantities()
        {
            var basket = new CustomerBasket("user-1");
            BasketMerge.Apply(basket, [Item("V20-A", 2)], Prices(("V20-A", 11.55m)));

            BasketMerge.Apply(basket, [Item("V20-A", 3)], Prices(("V20-A", 11.55m)));

            var item = Assert.Single(basket.Items);
            Assert.Equal(5, item.Quantity);
        }

        [Fact]
        public void Apply_GuestCart_IsMergedIntoExistingItems()
        {
            var basket = new CustomerBasket("user-1");
            BasketMerge.Apply(basket, [Item("V20-A", 1)], Prices(("V20-A", 11.55m)));

            // Guest cart: one item the user already has, one new item.
            BasketMerge.Apply(basket, [Item("V20-A", 4), Item("V20-B", 1)], Prices(("V20-A", 11.55m), ("V20-B", 13.71m)));

            Assert.Equal(2, basket.Items.Count);
            Assert.Equal(5, basket.Items.Single(i => i.ProductId == "V20-A").Quantity);
            Assert.Equal(1, basket.Items.Single(i => i.ProductId == "V20-B").Quantity);
        }

        [Fact]
        public void Apply_UnpricedOrUnknownVariant_IsStoredWithZeroPrice()
        {
            var basket = new CustomerBasket("user-1");

            BasketMerge.Apply(basket, [Item("UNPRICED"), Item("NOT-IN-PRICES")], Prices(("UNPRICED", null)));

            Assert.All(basket.Items, i => Assert.Equal(0m, i.UnitPrice));
        }

        [Fact]
        public void Apply_PriceIsRefreshedFromTheCatalogue()
        {
            var basket = new CustomerBasket("user-1");
            BasketMerge.Apply(basket, [Item("V20-A")], Prices(("V20-A", 11.55m)));

            BasketMerge.Apply(basket, [Item("V20-A")], Prices(("V20-A", 12.00m)));

            Assert.Equal(12.00m, Assert.Single(basket.Items).UnitPrice);
        }
    }
}
