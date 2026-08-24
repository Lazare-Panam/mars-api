using Mars.API.Models.Auth;

namespace Mars.API.Services.Interfaces
{
    public interface IAuthService
    {
        /// <summary>
        /// Generates a signed JWT for an authenticated user.
        /// </summary>
        /// <param name="user">The user the token is issued for.</param>
        /// <param name="roles">The roles to embed as claims on the token.</param>
        /// <returns>The signed JWT string and its UTC expiry time.</returns>
        (string Token, DateTime ExpiresAt) CreateToken(ApplicationUser user, IEnumerable<string> roles);
    }
}
