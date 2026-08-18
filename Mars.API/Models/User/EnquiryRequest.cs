using System.ComponentModel.DataAnnotations;

namespace Mars.API.Models.User
{
    public class EnquiryRequest
    {
        [Required, MaxLength(200)]
        public string UserName { get; set; } = string.Empty;

        [Required, EmailAddress, MaxLength(320)]
        public string UserEmail { get; set; } = string.Empty;

        [Required, MaxLength(200)]
        public string UserCompany { get; set; } = string.Empty;

        [MaxLength(100)]
        public string? UserCountry { get; set; }

        [Required, MaxLength(4000)]
        public string Message { get; set; } = string.Empty;
    }
}
