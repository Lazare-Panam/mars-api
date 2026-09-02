using FluentValidation;
using Mars.API.Models.Basket;
namespace Mars.API.Models.ModelValidators
{
    public class AddToCartRequestValidator : AbstractValidator<AddToCartRequest>
    {
        public AddToCartRequestValidator() 
        {
            RuleFor(x => x.Quantity).NotEmpty().GreaterThan(0).WithMessage("Please specify the quantity to be greater than 0");
        }
    }
}
