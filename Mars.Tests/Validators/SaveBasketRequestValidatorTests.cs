using FluentValidation.TestHelper;
using Mars.API.Models.Basket;
using Mars.API.Models.ModelValidators;

namespace Mars.Tests.Validators
{
    public class SaveBasketRequestValidatorTests
    {
        private readonly SaveBasketRequestValidator _validator = new();

        private static AddToCartRequest Item(int quantity = 1) =>
            new("series-1", "variant-1", "desc", quantity, "https://example.com/pic.png");

        [Fact]
        public void Items_WithinLimit_HasNoErrors()
        {
            _validator.TestValidate(new SaveBasketRequest([Item()])).ShouldNotHaveAnyValidationErrors();
        }

        [Fact]
        public void Items_Empty_HasValidationError()
        {
            _validator.TestValidate(new SaveBasketRequest([])).ShouldHaveValidationErrorFor(x => x.Items);
        }

        [Fact]
        public void Items_Null_HasValidationError()
        {
            _validator.TestValidate(new SaveBasketRequest(null!)).ShouldHaveValidationErrorFor(x => x.Items);
        }

        [Fact]
        public void Items_OverLimit_HasValidationError()
        {
            var items = Enumerable.Range(0, SaveBasketRequestValidator.MaxItems + 1).Select(_ => Item()).ToList();

            _validator.TestValidate(new SaveBasketRequest(items)).ShouldHaveValidationErrorFor(x => x.Items);
        }

        [Fact]
        public void Items_WithInvalidItem_HasValidationError()
        {
            _validator.TestValidate(new SaveBasketRequest([Item(), Item(quantity: 0)]))
                .ShouldHaveValidationErrorFor("Items[1].Quantity");
        }
    }
}
