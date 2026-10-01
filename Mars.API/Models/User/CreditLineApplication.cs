namespace Mars.API.Models.User
{
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;

  
        public enum ApplicationStatus
        {
            Pending = 0,
            Approved = 1,
            Declined = 2
        }
        public class CreditLineApplication
        {
            public int ApplicationId { get; set; }
            public string RegistrationNumber { get; set; }
            public string CompanyName { get; set; }
            public string? VatNumber { get; set; }
            public string AddressLine1 { get; set; }
            public string? AddressLine2 { get; set; }
            public string? Website { get; set; }
            public string Sector { get; set; }
            public string YearsInBusiness { get; set; }
            public string? Employees { get; set; }
            public string ContactName { get; set; }
            public string JobTitle { get; set; }
            public string Email { get; set; }
            public string Phone { get; set; }
            public decimal CreditLimitRequested { get; set; }
            public string PaymentTerms { get; set; }
            public string Currency { get; set; } = "GBP";
            public decimal MonthlyOrderValue { get; set; }
            public string? Products { get; set; }
            public string SignatoryName { get; set; }
            public string SignatoryTitle { get; set; }
            public string Signature { get; set; }
            public DateTimeOffset DeclarationDate { get; set; }
            public bool DeclarationAccepted { get; set; } = true;
            public DateTimeOffset SubmittedAtUtc { get; set; } = DateTime.UtcNow;
            public ApplicationStatus Status { get; set; } = ApplicationStatus.Pending;
            public bool IsApproved => Status == ApplicationStatus.Approved;
        }
    
}
