using Microsoft.AspNetCore.Identity.Data;
using System.ComponentModel.DataAnnotations;

namespace Mars.API.Models.Auth
{
    public class RegisterDTO
    {
        public string Email { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string PhoneNumber { get; set; } = string.Empty;
        public string CompanyName { get; set; } = string.Empty;
        public string Country { get; set; } = string.Empty;
        public string JobTitle { get; set; } = string.Empty;
    }
}
