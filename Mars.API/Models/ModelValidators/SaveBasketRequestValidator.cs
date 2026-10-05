using FluentValidation;
using Mars.API.Models.Basket;

namespace Mars.API.Models.ModelValidators
{
    public class SaveBasketRequestValidator : AbstractValidator<SaveBasketRequest>
    {
        public const int MaxItems = 100;

        public SaveBasketRequestValidator()
        {
            RuleFor(x => x.Items)
                .NotEmpty().WithMessage("There are no items to save.")
                .Must(items => items is null || items.Count <= MaxItems)
                .WithMessage($"At most {MaxItems} items can be saved at once.");

            RuleForEach(x => x.Items).SetValidator(new AddToCartRequestValidator());
        }
    }
}
