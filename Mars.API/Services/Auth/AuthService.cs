using Mars.API.Models.Auth;
using Mars.API.Services.Interfaces;
using Mars.API.Settings;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.Data;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.JsonWebTokens;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;

namespace Mars.API.Services.Auth
{
    public class AuthService : IAuthService
    {
        private readonly JwtSettings _settings;
        public AuthService(IOptions<JwtSettings> options)
        {
            _settings = options.Value;
        }
        /// <summary>
        /// Generates a signed JWT for an authenticated user.
        /// </summary>
        /// <param name="user">The user the token is issued for.</param>
        /// <param name="roles">The roles to embed as claims on the token.</param>
        /// <returns>The signed JWT string and its UTC expiry time.</returns>
        public (string Token, DateTime ExpiresAt) CreateToken(ApplicationUser user, IEnumerable<string> roles)
        {
            var expiresAt = DateTime.UtcNow.AddMinutes(_settings.ExpireMinutes);
            var claims = new List<Claim>
            {
                new(JwtRegisteredClaimNames.Sub, user.Id),
                new(JwtRegisteredClaimNames.Email, user.Email!),
                new(JwtRegisteredClaimNames.Name, $"{user.FirstName} {user.LastName}"),
                new(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
            };
            claims.AddRange(roles.Select(role => new Claim("role", role)));

            var signingKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_settings.Key));
            var credentials = new SigningCredentials(signingKey, SecurityAlgorithms.HmacSha256);

            var descriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(claims),
                Expires = expiresAt,
                Issuer = _settings.Issuer,
                Audience = _settings.Audience,
                SigningCredentials = credentials
            };

            var token = new JsonWebTokenHandler().CreateToken(descriptor);
            return (token, expiresAt);
        }
        
    }

}
