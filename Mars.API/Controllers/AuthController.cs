using FluentValidation;
using Mars.API.Logging;
using Mars.API.Models.Auth;
using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.JsonWebTokens;
using System.ComponentModel.DataAnnotations;

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
        private readonly INotificationService _notificationService;
        public AuthController(IAuthService authService, ILogger<AuthController> logger, UserManager<ApplicationUser> userManager, SignInManager<ApplicationUser> signInManager, INotificationService notificationService)
        {
            _authService = authService;
            _logger = logger;
            _userManager = userManager;
            _signInManager = signInManager;
            _notificationService = notificationService;
        }

        [HttpPost("register")]
        public async Task<IActionResult> RegisterUser(RegisterDTO registerDTO, IValidator<RegisterDTO> validator)
        {
            var validationResult = await validator.ValidateAsync(registerDTO);
            /*TODO:Rishik Consider using FluentValidation's automatic model validation feature instead of manually validating in the controller. This can be done by adding the FluentValidation.AspNetCore package and configuring it in Startup.cs or Program.cs. This way, you can remove the manual validation code and let FluentValidation handle it automatically, returning a 400 Bad Request response with validation errors if the model is invalid.*/  
            if (!validationResult.IsValid)
            {
                foreach (var error in validationResult.Errors)
                {
                    ModelState.AddModelError(error.PropertyName, error.ErrorMessage);
                }
                // Field names only, never the submitted values.
                _logger.LogInformation(LogEvents.ValidationFailed, "{Endpoint} rejected: invalid {Fields}",
                    HttpContext.Request.Path.Value, validationResult.Errors.Select(e => e.PropertyName).Distinct());
                return ValidationProblem(ModelState);
            }
            var existingUser = await _userManager.FindByEmailAsync(registerDTO.Email);
            if (existingUser != null)
            {
                _logger.LogWarning(LogEvents.RegistrationRejected, "Registration rejected: email is already registered to user {UserId}", existingUser.Id);
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
                // Error codes, not descriptions: descriptions can contain the username (the email).
                _logger.LogWarning(LogEvents.RegistrationRejected, "Registration rejected: {ErrorCodes}", result.Errors.Select(e => e.Code));
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
            _logger.LogInformation(LogEvents.UserRegistered, "User {UserId} registered successfully", user.Id);
            var notification = await _notificationService.HandleNewUserRegisteredAsync(
                userName: $"{user.FirstName} {user.LastName}",
                userEmail: user.Email,
                userCompany: user.CompanyName,
                userCountry: user.Country,
                userJobTitle: registerDTO.JobTitle,
                registrationDate: DateTime.UtcNow.ToString("dd MMM yyyy")
            );
            // NotificationService already logged the error for any email that failed; this records the outcome per user.
            if (notification.ReceiptSent && notification.InternalNotificationSent)
            {
                _logger.LogInformation("Registration emails sent for user {UserId}", user.Id);
            }
            else
            {
                _logger.LogWarning("Registration emails not all sent for user {UserId}: welcome {WelcomeSent}, internal {InternalSent}",
                    user.Id, notification.ReceiptSent, notification.InternalNotificationSent);
            }
            return Ok(new { message = "User registered successfully." });
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginDto dto, IValidator<LoginDto> validator)
        {
            var validationResult = await validator.ValidateAsync(dto);
            if (!validationResult.IsValid)
            {
                foreach (var error in validationResult.Errors)
                {
                    ModelState.AddModelError(error.PropertyName, error.ErrorMessage);
                }
                // Field names only, never the submitted values.
                _logger.LogInformation(LogEvents.ValidationFailed, "{Endpoint} rejected: invalid {Fields}",
                    HttpContext.Request.Path.Value, validationResult.Errors.Select(e => e.PropertyName).Distinct());
                return ValidationProblem(ModelState);
            }

            var user = await _userManager.FindByEmailAsync(dto.Email);
            if (user == null)
            {
                // No identifier: the attempted email may not belong to anyone (or be a typo of someone else's).
                _logger.LogWarning(LogEvents.LoginFailed, "Login failed: user not found");
                return Problem(
                    statusCode: StatusCodes.Status401Unauthorized,
                    title: "Invalid email or password.",
                    extensions: new Dictionary<string, object?> { ["code"] = "INVALID_CREDENTIALS" }
                );
            }
            var result = await _signInManager.CheckPasswordSignInAsync(user, dto.Password, lockoutOnFailure: true);
            if (result.IsLockedOut)
            {
                _logger.LogWarning(LogEvents.AccountLockedOut, "Login failed for user {UserId}: account is locked out", user.Id);
                return Problem(
                    statusCode: StatusCodes.Status401Unauthorized,
                    title: "Account locked. Try again later.",
                    extensions: new Dictionary<string, object?> { ["code"] = "ACCOUNT_LOCKED" }
                );
            }

            if (!result.Succeeded)
            {
                _logger.LogWarning(LogEvents.LoginFailed, "Login failed for user {UserId}: invalid password", user.Id);
                return Problem(
                    statusCode: StatusCodes.Status401Unauthorized,
                    title: "Invalid email or password.",
                    extensions: new Dictionary<string, object?> { ["code"] = "INVALID_CREDENTIALS" }
                );
            }
            var roles = await _userManager.GetRolesAsync(user);
            (string token, DateTime expiresAt) = _authService.CreateToken(user, roles);
            _logger.LogInformation(LogEvents.LoginSucceeded, "User {UserId} logged in successfully", user.Id);
            return Ok(new
            {
                token,
                expiration = expiresAt
            });
        }

        /// <summary>
        /// Logs out the current user. With stateless JWTs there is nothing to invalidate
        /// server-side, so the client is responsible for discarding its token; this endpoint
        /// only records the event. (Once refresh tokens exist, revoke the refresh token here.)
        /// </summary>
        [HttpPost("logout")]
        [Authorize]
        public IActionResult Logout()
        {
            var userId = User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;
            _logger.LogInformation(LogEvents.LoggedOut, "User {UserId} logged out", userId);
            return Ok(new { message = "Logged out. Please discard your token." });
        }
    }
}
