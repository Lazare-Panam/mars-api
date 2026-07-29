using Mars.API.Models.Auth;
using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Mars.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;
        private readonly ILogger<AuthController> _logger;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly SignInManager<ApplicationUser> _signInManager;
        public AuthController(IAuthService authService, ILogger<AuthController> logger, UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager)
        {
            _authService = authService;
            _logger = logger;
            _userManager = userManager;
            _signInManager = signInManager;
        }

        [HttpPost("register")]
        public async Task<IActionResult> RegisterUser(RegisterDTO registerDTO)
        {
            _logger.LogInformation("Register called for {Email}", registerDTO.Email);
            var existingUser = await _userManager.FindByEmailAsync(registerDTO.Email);

            if (existingUser != null)
            {
                return Problem(
                    statusCode: StatusCodes.Status409Conflict,
                    title: "Email is already registered.",
                    detail: "An account with this email address already exists. Try logging in instead.",
                    extensions: new Dictionary<string, object?> { ["code"] = "EMAIL_ALREADY_REGISTERED" }
                );
            }
            var user = new ApplicationUser
            {
                FirstName = registerDTO.FirstName,
                LastName = registerDTO.LastName,
                UserName = registerDTO.Email,
                Email = registerDTO.Email,
                PhoneNumber = registerDTO.PhoneNumber,
                CompanyName = registerDTO.CompanyName,
                Country = registerDTO.Country,
            };

            var result = await _userManager.CreateAsync(user, registerDTO.Password);
            if(!result.Succeeded)
            {
                return Problem(
                   statusCode: StatusCodes.Status400BadRequest,
                   title: "Registration failed.",
                   detail: "One or more account requirements were not met.",
                   extensions: new Dictionary<string, object?>
                   {
                       ["code"] = "REGISTRATION_FAILED",
                       ["errors"] = result.Errors.Select(e => e.Description)
                   }
               );
            }

            await _userManager.AddToRoleAsync(user, Roles.User);
            return Ok(new { message = "User registered successfully." });
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginDto dto)
        {
            var user = await _userManager.FindByEmailAsync(dto.Email);
            if (user == null)
            {
                return Problem(
                    statusCode: StatusCodes.Status401Unauthorized,
                    title: "Invalid email or password.",
                    extensions: new Dictionary<string, object?> { ["code"] = "INVALID_CREDENTIALS" }
                );
            }
            var result = await _signInManager.CheckPasswordSignInAsync(user, dto.Password, lockoutOnFailure: true);
            if (result.IsLockedOut)
            {
                return Problem(
                    statusCode: StatusCodes.Status401Unauthorized,
                    title: "Account locked. Try again later.",
                    extensions: new Dictionary<string, object?> { ["code"] = "ACCOUNT_LOCKED" }
                );
            }

            if (!result.Succeeded)
            {
                return Problem(
                    statusCode: StatusCodes.Status401Unauthorized,
                    title: "Invalid email or password.",
                    extensions: new Dictionary<string, object?> { ["code"] = "INVALID_CREDENTIALS" }
                );
            }
            var roles = await _userManager.GetRolesAsync(user);
            (string token, DateTime expiresAt) = _authService.CreateToken(user, roles);
            return Ok(new
            {
                token,
                expiration = expiresAt
            });
        }
    }
}
