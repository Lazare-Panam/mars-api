using FluentValidation;
using Mars.API.Models.User;

namespace Mars.API.Models.ModelValidators
{
    public class CreditLineApplicationValidator : AbstractValidator<CreditLineApplication>
    {
        private static readonly string[] AllowedCurrencies = { "GBP", "USD", "EUR" };
        public CreditLineApplicationValidator()
        {
           
            RuleFor(x => x.CompanyName).NotEmpty().MaximumLength(200);
            RuleFor(x => x.RegistrationNumber).NotEmpty().MaximumLength(50);
            RuleFor(x => x.VatNumber).MaximumLength(50);          
            RuleFor(x => x.AddressLine1).NotEmpty().MaximumLength(200);
            RuleFor(x => x.AddressLine2).MaximumLength(200);      
            RuleFor(x => x.Website)
                .MaximumLength(200)
                .Matches(@"^https?://.+").WithMessage("Website must start with http:// or https://.")
                .When(x => !string.IsNullOrWhiteSpace(x.Website));
            RuleFor(x => x.Sector).NotEmpty().MaximumLength(150);
            RuleFor(x => x.YearsInBusiness).NotEmpty().MaximumLength(50);
            RuleFor(x => x.Employees).MaximumLength(50);         

         
            RuleFor(x => x.ContactName).NotEmpty().MaximumLength(150);
            RuleFor(x => x.JobTitle).NotEmpty().MaximumLength(150);
            RuleFor(x => x.Email).NotEmpty().EmailAddress().MaximumLength(200);
            RuleFor(x => x.Phone)
                .NotEmpty()
                .MaximumLength(50)
                .Matches(@"^[+]?[\d\s()-]{7,20}$").WithMessage("Invalid phone number format.");

            RuleFor(x => x.CreditLimitRequested)
                .GreaterThan(0)
                .LessThanOrEqualTo(10_000_000);  
            RuleFor(x => x.PaymentTerms).NotEmpty().MaximumLength(100);
            RuleFor(x => x.Currency)
                .NotEmpty()
                .Must(c => AllowedCurrencies.Contains(c))
                .WithMessage($"Currency must be one of: {string.Join(", ", AllowedCurrencies)}.");
            RuleFor(x => x.MonthlyOrderValue).GreaterThanOrEqualTo(0);
            RuleFor(x => x.Products).MaximumLength(400);          

            
            RuleFor(x => x.SignatoryName).NotEmpty().MaximumLength(150);
            RuleFor(x => x.SignatoryTitle).NotEmpty().MaximumLength(150);
            RuleFor(x => x.Signature).NotEmpty().MaximumLength(150);
            RuleFor(x => x.DeclarationDate)
                .NotEmpty().WithMessage("Declaration date is required.")
                .Must(d => d.Date <= DateTime.UtcNow.Date)
                .WithMessage("Declaration date cannot be in the future.");
            RuleFor(x => x.DeclarationAccepted)
                .Equal(true).WithMessage("You must accept the declaration to submit.");

           
            RuleFor(x => x.Status).IsInEnum();
        }
    }
}
