using FluentValidation;
using Mars.API.Models.User;

namespace Mars.API.Models.ModelValidators
{
    /// <summary>
    /// Validates the public stock-list notification request. Lengths mirror the
    /// EF configuration for <see cref="StockListRequest"/> (Name/Email 100, Phone 20).
    /// </summary>
    public class StockListRequestDTOValidator : AbstractValidator<StockListRequestDTO>
    {
        public StockListRequestDTOValidator()
        {
            RuleFor(x => x.Name).NotEmpty().MaximumLength(100);
            RuleFor(x => x.Email).NotEmpty().EmailAddress().MaximumLength(100);
            RuleFor(x => x.Phone)
                .NotEmpty()
                .MaximumLength(20)
                .Matches(@"^[+]?[\d\s()-]{7,20}$").WithMessage("Invalid phone number format.");
        }
    }
}
