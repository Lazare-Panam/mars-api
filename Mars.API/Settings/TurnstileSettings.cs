namespace Mars.API.Settings
{
    public class TurnstileSettings
    {
        /// <summary>Cloudflare Turnstile secret key. Set via user-secrets / environment, never in appsettings.</summary>
        public string SecretKey { get; set; } = string.Empty;

        /// <summary>Cloudflare's server-side verification endpoint. Overridable for testing.</summary>
        public string VerifyUrl { get; set; } = "https://challenges.cloudflare.com/turnstile/v0/siteverify";
    }
}
