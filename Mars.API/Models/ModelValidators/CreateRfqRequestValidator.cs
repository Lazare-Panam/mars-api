using FluentValidation;
using Mars.API.Models.Basket;

namespace Mars.API.Models.ModelValidators
{
    public class CreateRfqRequestValidator : AbstractValidator<CreateRfqRequest>
    {
        public CreateRfqRequestValidator()
        {
            RuleFor(x => x.LineItems).NotEmpty().WithMessage("At least one line item is required.");
            RuleForEach(x => x.LineItems).SetValidator(new CreateRfqLineItemValidator());
        }
    }
    public class CreateRfqLineItemValidator : AbstractValidator<CreateRfqLineItem>
    {
        public CreateRfqLineItemValidator()
        {
            RuleFor(x => x.SeriesId).NotEmpty();
            RuleFor(x => x.ProductId).NotEmpty();
            RuleFor(x => x.ProductDescription).NotEmpty().MaximumLength(500);
            RuleFor(x => x.Quantity).GreaterThan(0);
            RuleFor(x => x.PictureUrl).NotEmpty().WithMessage("PictureUrl must be a valid absolute URL.");
        }
    }
}
