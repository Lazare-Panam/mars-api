using FluentValidation.TestHelper;
using Mars.API.Models.Basket;
using Mars.API.Models.ModelValidators;
using System;
using System.Collections.Generic;
using System.Text;

namespace Mars.Tests.Validators
{
    public class AddToCartRequestValidatorTests
    {
        private readonly AddToCartRequestValidator _validator = new();

        private static readonly AddToCartRequest ValidRequest =
            new("series-1", "variant-1", "desc", 1, "https://example.com/pic.png");

        [Fact]
        public void Quantity_Zero_HasValidationError()
        {
            var request = ValidRequest with { Quantity = 0 };

            var result = _validator.TestValidate(request);

            result.ShouldHaveValidationErrorFor(x => x.Quantity);
        }

        [Fact]
        public void Quantity_Positive_HasNoValidationError()
        {
            var result = _validator.TestValidate(ValidRequest);

            result.ShouldNotHaveValidationErrorFor(x => x.Quantity);
        }
        [Fact]
        public void SeriesId_Empty_HasValidationError()
        {
            var request = ValidRequest with { SeriesId = "" };
            var result = _validator.TestValidate(request);
            result.ShouldHaveValidationErrorFor(x => x.SeriesId);
        }

        [Fact]
        public void VariantId_Empty_HasValidationError()
        {
            var request = ValidRequest with { VariantId = "" };
            var result = _validator.TestValidate(request);
            result.ShouldHaveValidationErrorFor(x => x.VariantId);
        }

        [Fact]
        public void ProductDescription_ExceedsMaxLength_HasValidationError()
        {
            var request = ValidRequest with { ProductDescription = new string('a', 501) };
            var result = _validator.TestValidate(request);
            result.ShouldHaveValidationErrorFor(x => x.ProductDescription);
        }

        [Fact]
        public void PictureUrl_NotAbsoluteUrl_HasValidationError()
        {
            var request = ValidRequest with { PictureUrl = "not-a-url" };
            var result = _validator.TestValidate(request);
            result.ShouldHaveValidationErrorFor(x => x.PictureUrl);
        }
    }
}
