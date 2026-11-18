using System.ComponentModel.DataAnnotations;

namespace Mars.API.Models.User
{
    public class EnquiryRequest
    {
        public string UserName { get; set; } = string.Empty;
        public string UserEmail { get; set; } = string.Empty;
        public string UserCompany { get; set; } = string.Empty;
        public string? UserCountry { get; set; }
        public string Message { get; set; } = string.Empty;

        /// <summary>Cloudflare Turnstile token from the frontend widget (cf-turnstile-response).</summary>
        public string? CaptchaToken { get; set; }
    }
}
