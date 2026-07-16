using Mars.API.Models.Auth;

namespace Mars.API.Services.Interfaces
{
    public interface IAuthService
    {
        (string Token, DateTime ExpiresAt) CreateToken(ApplicationUser user, IEnumerable<string> roles);
    }
}
