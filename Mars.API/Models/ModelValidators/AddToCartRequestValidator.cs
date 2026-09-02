using FluentValidation;
using Mars.API.Models.Basket;
namespace Mars.API.Models.ModelValidators
{
    public class AddToCartRequestValidator : AbstractValidator<AddToCartRequest>
    {
        public AddToCartRequestValidator() 
        {
            RuleFor(x => x.SeriesId).NotEmpty().WithMessage("SeriesId is required.");
            RuleFor(x => x.VariantId).NotEmpty().WithMessage("VariantId is required.");
            RuleFor(x => x.ProductDescription).NotEmpty().MaximumLength(500).WithMessage("ProductDescription is required and must not exceed 500 characters.");
            RuleFor(x => x.Quantity).GreaterThan(0).WithMessage("Quantity must be a positive number.");
            RuleFor(x => x.PictureUrl).NotEmpty().Must(url => Uri.TryCreate(url, UriKind.Absolute, out _)).WithMessage("PictureUrl must be a valid absolute URL.");
        }
    }
}
