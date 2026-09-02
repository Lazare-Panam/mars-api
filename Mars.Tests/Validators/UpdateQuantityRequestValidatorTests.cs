using FluentValidation.TestHelper;
using Mars.API.Models.Basket;
using Mars.API.Models.ModelValidators;
using System;
using System.Collections.Generic;
using System.Text;

namespace Mars.Tests.Validators
{
    public class UpdateQuantityRequestValidatorTests
    {
        private readonly UpdateQuantityRequestValidator _validator = new();

        [Fact]
        public void Quantity_TooLarge_HasValidationError()
        {
            var result = _validator.TestValidate(new UpdateQuantityRequest(10001));
            result.ShouldHaveValidationErrorFor(x => x.Quantity);
        }

        [Fact]
        public void Quantity_Negative_HasValidationError()
        {
            var result = _validator.TestValidate(new UpdateQuantityRequest(-1));
            result.ShouldHaveValidationErrorFor(x => x.Quantity);
        }

        [Fact]
        public void Quantity_Zero_HasNoValidationError()
        {
            var result = _validator.TestValidate(new UpdateQuantityRequest(0));
            result.ShouldNotHaveValidationErrorFor(x => x.Quantity);
        }

        [Fact]
        public void Quantity_Positive_HasNoValidationError()
        {
            var result = _validator.TestValidate(new UpdateQuantityRequest(5));
            result.ShouldNotHaveValidationErrorFor(x => x.Quantity);
        }
    }
}
