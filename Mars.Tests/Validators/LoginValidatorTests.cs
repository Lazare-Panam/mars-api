using FluentValidation.TestHelper;
using Mars.API.Models.Auth;
using Mars.API.Models.ModelValidators;
namespace Mars.Tests.Validators
{
    public class LoginValidatorTests
    {
        private readonly LoginValidator _validator = new();

        private static LoginDto ValidLogin() => new()
        {
            Email = "user@example.com",
            Password = "password123"
        };

        [Fact]
        public void Email_Empty_HasValidationError()
        {
            var login = ValidLogin();
            login.Email = "";

            var result = _validator.TestValidate(login);

            result.ShouldHaveValidationErrorFor(x => x.Email);
        }

        [Fact]
        public void Email_InvalidFormat_HasValidationError()
        {
            var login = ValidLogin();
            login.Email = "not-an-email";

            var result = _validator.TestValidate(login);

            result.ShouldHaveValidationErrorFor(x => x.Email);
        }

        [Fact]
        public void Password_Empty_HasValidationError()
        {
            var login = ValidLogin();
            login.Password = "";

            var result = _validator.TestValidate(login);

            result.ShouldHaveValidationErrorFor(x => x.Password);
        }

        [Fact]
        public void ValidLogin_HasNoValidationErrors()
        {
            var result = _validator.TestValidate(ValidLogin());

            result.ShouldNotHaveAnyValidationErrors();
        }
    }
}
