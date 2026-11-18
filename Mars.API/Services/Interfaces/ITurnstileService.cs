namespace Mars.API.Services.Interfaces
{
    public interface ITurnstileService
    {
        /// <summary>
        /// Verifies a Cloudflare Turnstile token with Cloudflare's siteverify API.
        /// Returns true only if Cloudflare confirms the token is valid.
        /// </summary>
        /// <param name="token">The token the frontend widget produced (cf-turnstile-response).</param>
        /// <param name="remoteIp">The caller's IP, passed to Cloudflare for an extra check. Optional.</param>
        Task<bool> VerifyAsync(string? token, string? remoteIp, CancellationToken cancellationToken);
    }
}
