using FluentValidation.TestHelper;
using Mars.API.Models.Auth;
using Mars.API.Models.ModelValidators;
using System;
using System.Collections.Generic;
using System.Text;

namespace Mars.Tests.Validators
{
    public class RegisterDTOValidatorTests
    {
        private readonly RegisterDTOValidator _validator = new();

        private static RegisterDTO ValidRegister() => new()
        {
            Email = "user@example.com",
            Password = "password123",
            FirstName = "John",
            LastName = "Smith",
            PhoneNumber = "+441234567890",
            CompanyName = "Acme Ltd",
            Country = "UK",
            JobTitle = "Engineer"
        };

        [Fact]
        public void Email_Invalid_HasValidationError()
        {
            var dto = ValidRegister();
            dto.Email = "not-an-email";
            var result = _validator.TestValidate(dto);
            result.ShouldHaveValidationErrorFor(x => x.Email);
        }

        [Fact]
        public void Password_Empty_HasValidationError()
        {
            var dto = ValidRegister();
            dto.Password = "";
            var result = _validator.TestValidate(dto);
            result.ShouldHaveValidationErrorFor(x => x.Password);
        }

        [Fact]
        public void FirstName_ExceedsMaxLength_HasValidationError()
        {
            var dto = ValidRegister();
            dto.FirstName = new string('a', 101);
            var result = _validator.TestValidate(dto);
            result.ShouldHaveValidationErrorFor(x => x.FirstName);
        }

        [Fact]
        public void LastName_Empty_HasValidationError()
        {
            var dto = ValidRegister();
            dto.LastName = "";
            var result = _validator.TestValidate(dto);
            result.ShouldHaveValidationErrorFor(x => x.LastName);
        }

        [Fact]
        public void PhoneNumber_InvalidFormat_HasValidationError()
        {
            var dto = ValidRegister();
            dto.PhoneNumber = "not-a-phone";
            var result = _validator.TestValidate(dto);
            result.ShouldHaveValidationErrorFor(x => x.PhoneNumber);
        }

        [Fact]
        public void CompanyName_Empty_HasValidationError()
        {
            var dto = ValidRegister();
            dto.CompanyName = "";
            var result = _validator.TestValidate(dto);
            result.ShouldHaveValidationErrorFor(x => x.CompanyName);
        }

        [Fact]
        public void Country_Empty_HasValidationError()
        {
            var dto = ValidRegister();
            dto.Country = "";
            var result = _validator.TestValidate(dto);
            result.ShouldHaveValidationErrorFor(x => x.Country);
        }

        [Fact]
        public void JobTitle_Empty_HasValidationError()
        {
            var dto = ValidRegister();
            dto.JobTitle = "";
            var result = _validator.TestValidate(dto);
            result.ShouldHaveValidationErrorFor(x => x.JobTitle);
        }

        [Fact]
        public void ValidRegister_HasNoValidationErrors()
        {
            var result = _validator.TestValidate(ValidRegister());
            result.ShouldNotHaveAnyValidationErrors();
        }
    }
}
