using FluentValidation.TestHelper;
using Mars.API.Models.Basket;
using Mars.API.Models.ModelValidators;
using System;
using System.Collections.Generic;
using System.Text;

namespace Mars.Tests.Validators
{
    public class CreateRfqRequestValidatorTests
    {
        private readonly CreateRfqRequestValidator _validator = new();

        private static CreateRfqLineItem ValidItem() => new()
        {
            SeriesId = "series-1",
            ProductId = "product-1",
            ProductDescription = "desc",
            Quantity = 1,
            PictureUrl = "https://example.com/pic.png"
        };

        [Fact]
        public void LineItems_Empty_HasValidationError()
        {
            var request = new CreateRfqRequest { LineItems = new List<CreateRfqLineItem>() };

            var result = _validator.TestValidate(request);

            result.ShouldHaveValidationErrorFor(x => x.LineItems);
        }

        [Fact]
        public void LineItems_ContainsInvalidItem_HasValidationErrorOnThatItem()
        {
            var invalidItem = ValidItem();
            invalidItem.Quantity = 0;
            var request = new CreateRfqRequest { LineItems = new List<CreateRfqLineItem> { invalidItem } };

            var result = _validator.TestValidate(request);

            result.ShouldHaveValidationErrorFor("LineItems[0].Quantity");
        }

        [Fact]
        public void LineItems_AllValid_HasNoValidationErrors()
        {
            var request = new CreateRfqRequest { LineItems = new List<CreateRfqLineItem> { ValidItem() } };

            var result = _validator.TestValidate(request);

            result.ShouldNotHaveAnyValidationErrors();
        }
    }
}
