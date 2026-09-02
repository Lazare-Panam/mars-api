using FluentValidation;
using Mars.API.Models.Auth;

namespace Mars.API.Models.ModelValidators
{
    public class RegisterDTOValidator : AbstractValidator<RegisterDTO>
    {
        public RegisterDTOValidator()
        {
            RuleFor(x => x.Email).NotEmpty().EmailAddress();
            RuleFor(x => x.Password).NotEmpty();
            RuleFor(x => x.FirstName).NotEmpty().MaximumLength(100);
            RuleFor(x => x.LastName).NotEmpty().MaximumLength(100);
            RuleFor(x => x.PhoneNumber).NotEmpty().MaximumLength(20)
                .Matches(@"^[+]?[\d\s()-]{7,20}$").WithMessage("Invalid phone number format.");
            RuleFor(x => x.CompanyName).NotEmpty().MaximumLength(100);
            RuleFor(x => x.Country).NotEmpty().MaximumLength(100);
            RuleFor(x => x.JobTitle).NotEmpty().MaximumLength(100);
        }
    }
}
