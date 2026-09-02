using FluentValidation;
using Mars.API.Models.Basket;
using System;
using System.Collections.Generic;
using System.Text;

namespace Mars.API.Models.ModelValidators
{
    public class UpdateQuantityRequestValidator : AbstractValidator<UpdateQuantityRequest>
    {
        public UpdateQuantityRequestValidator()
        {
            RuleFor(x => x.Quantity)
                .GreaterThanOrEqualTo(0).WithMessage("Quantity cannot be negative.")
                .LessThanOrEqualTo(10000).WithMessage("Quantity is unreasonably large.");
        }
    }
}
