using FluentValidation;
using Mars.API.Models.Basket;

namespace Mars.API.Models.ModelValidators
{
    public class MergeBasketRequestValidator : AbstractValidator<MergeBasketRequest>
    {
        public const int MaxItems = 100;

        // Individual items are checked with AddToCartRequestValidator in the controller,
        // so one bad item is skipped instead of rejecting the whole guest cart.
        public MergeBasketRequestValidator()
        {
            RuleFor(x => x.Items)
                .NotNull()
                .Must(items => items is null || items.Count <= MaxItems)
                .WithMessage($"A basket can be merged with at most {MaxItems} items.");
        }
    }
}
