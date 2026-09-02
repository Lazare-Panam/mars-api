using FluentValidation;
using Mars.API.Models.User;

namespace Mars.API.Models.ModelValidators
{
    public class EnquiryRequestValidator : AbstractValidator<EnquiryRequest>
    {
        public EnquiryRequestValidator()
        {
            RuleFor(x => x.UserName).NotEmpty().MaximumLength(200);
            RuleFor(x => x.UserEmail).NotEmpty().EmailAddress().MaximumLength(320);
            RuleFor(x => x.UserCompany).NotEmpty().MaximumLength(200);
            RuleFor(x => x.UserCountry).MaximumLength(100);
            RuleFor(x => x.Message).NotEmpty().MaximumLength(4000);
        }
    }
}
