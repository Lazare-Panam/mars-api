using FluentValidation.TestHelper;
using Mars.API.Models.Basket;
using Mars.API.Models.ModelValidators;

namespace Mars.Tests.Validators
{
    public class MergeBasketRequestValidatorTests
    {
        private readonly MergeBasketRequestValidator _validator = new();

        private static AddToCartRequest Item() =>
            new("series-1", "variant-1", "desc", 1, "https://example.com/pic.png");

        [Fact]
        public void Items_WithinLimit_HasNoErrors()
        {
            _validator.TestValidate(new MergeBasketRequest([Item()])).ShouldNotHaveAnyValidationErrors();
        }

        [Fact]
        public void Items_Empty_IsAllowed()
        {
            _validator.TestValidate(new MergeBasketRequest([])).ShouldNotHaveAnyValidationErrors();
        }

        [Fact]
        public void Items_Null_HasValidationError()
        {
            _validator.TestValidate(new MergeBasketRequest(null!)).ShouldHaveValidationErrorFor(x => x.Items);
        }

        [Fact]
        public void Items_OverLimit_HasValidationError()
        {
            var items = Enumerable.Range(0, MergeBasketRequestValidator.MaxItems + 1).Select(_ => Item()).ToList();

            _validator.TestValidate(new MergeBasketRequest(items)).ShouldHaveValidationErrorFor(x => x.Items);
        }
    }
}
