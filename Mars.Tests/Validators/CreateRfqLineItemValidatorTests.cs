using FluentValidation.TestHelper;
using Mars.API.Models.Basket;
using Mars.API.Models.ModelValidators;
using System;
using System.Collections.Generic;
using System.Text;

namespace Mars.Tests.Validators
{

    public class CreateRfqLineItemValidatorTests
    {
        private readonly CreateRfqLineItemValidator _validator = new();

        private static CreateRfqLineItem ValidItem() => new()
        {
            SeriesId = "series-1",
            ProductId = "product-1",
            ProductDescription = "desc",
            Quantity = 1,
            PictureUrl = "https://example.com/pic.png"
        };

        [Fact]
        public void SeriesId_Empty_HasValidationError()
        {
            var item = ValidItem();
            item.SeriesId = "";
            var result = _validator.TestValidate(item);

            result.ShouldHaveValidationErrorFor(x => x.SeriesId);
        }

        [Fact]
        public void ProductId_Empty_HasValidationError()
        {
            var item = ValidItem();
            item.ProductId = "";

            var result = _validator.TestValidate(item);

            result.ShouldHaveValidationErrorFor(x => x.ProductId);
        }

        [Fact]
        public void ProductDescription_ExceedsMaxLength_HasValidationError()
        {
            var item = ValidItem();
            item.ProductDescription = new string('a', 501);

            var result = _validator.TestValidate(item);

            result.ShouldHaveValidationErrorFor(x => x.ProductDescription);
        }

        [Fact]
        public void Quantity_Zero_HasValidationError()
        {
            var item = ValidItem();
            item.Quantity = 0;

            var result = _validator.TestValidate(item);

            result.ShouldHaveValidationErrorFor(x => x.Quantity);
        }

        [Fact]
        public void PictureUrl_Empty_HasValidationError()
        {
            var item = ValidItem();
            item.PictureUrl = "";

            var result = _validator.TestValidate(item);

            result.ShouldHaveValidationErrorFor(x => x.PictureUrl);
        }

        [Fact]
        public void ValidItem_HasNoValidationErrors()
        {
            var result = _validator.TestValidate(ValidItem());

            result.ShouldNotHaveAnyValidationErrors();
        }
    }
}
