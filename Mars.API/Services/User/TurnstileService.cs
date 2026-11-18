using System.Text.Json.Serialization;
using Mars.API.Services.Interfaces;
using Mars.API.Settings;
using Microsoft.Extensions.Options;

namespace Mars.API.Services.User
{
    public class TurnstileService : ITurnstileService
    {
        private readonly HttpClient _httpClient;
        private readonly TurnstileSettings _settings;
        private readonly ILogger<TurnstileService> _logger;

        public TurnstileService(HttpClient httpClient, IOptions<TurnstileSettings> settings, ILogger<TurnstileService> logger)
        {
            _httpClient = httpClient;
            _settings = settings.Value;
            _logger = logger;
        }

        public async Task<bool> VerifyAsync(string? token, string? remoteIp, CancellationToken cancellationToken)
        {
            // No token means the client never solved the challenge — reject outright, no network call.
            if (string.IsNullOrWhiteSpace(token))
            {
                return false;
            }

            var form = new List<KeyValuePair<string, string>>
            {
                new("secret", _settings.SecretKey),
                new("response", token)
            };
            if (!string.IsNullOrWhiteSpace(remoteIp))
            {
                form.Add(new("remoteip", remoteIp));
            }

            try
            {
                using var response = await _httpClient.PostAsync(
                    _settings.VerifyUrl, new FormUrlEncodedContent(form), cancellationToken);
                response.EnsureSuccessStatusCode();

                var result = await response.Content.ReadFromJsonAsync<TurnstileVerifyResponse>(cancellationToken);
                if (result is null || !result.Success)
                {
                    _logger.LogWarning("Turnstile verification failed. Error codes: {ErrorCodes}",
                        result?.ErrorCodes is { Length: > 0 } codes ? string.Join(",", codes) : "none");
                    return false;
                }

                return true;
            }
            catch (Exception ex)
            {
                // Fail closed: if we can't reach Cloudflare, treat the request as unverified.
                _logger.LogError(ex, "Turnstile verification call failed; rejecting the request.");
                return false;
            }
        }

        private sealed class TurnstileVerifyResponse
        {
            [JsonPropertyName("success")]
            public bool Success { get; set; }

            [JsonPropertyName("error-codes")]
            public string[]? ErrorCodes { get; set; }
        }
    }
}
