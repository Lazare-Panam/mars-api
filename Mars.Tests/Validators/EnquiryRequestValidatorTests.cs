using FluentValidation.TestHelper;
using Mars.API.Models.ModelValidators;
using Mars.API.Models.User;
using System;
using System.Collections.Generic;
using System.Text;

namespace Mars.Tests.Validators
{
    public class EnquiryRequestValidatorTests
    {
        private readonly EnquiryRequestValidator _validator = new();

        private static EnquiryRequest ValidEnquiry() => new()
        {
            UserName = "Jane Doe",
            UserEmail = "jane@example.com",
            UserCompany = "Acme Ltd",
            UserCountry = "UK",
            Message = "Hello, I have a question."
        };

        [Fact]
        public void UserName_Empty_HasValidationError()
        {
            var enquiry = ValidEnquiry();
            enquiry.UserName = "";
            var result = _validator.TestValidate(enquiry);
            result.ShouldHaveValidationErrorFor(x => x.UserName);
        }

        [Fact]
        public void UserEmail_InvalidFormat_HasValidationError()
        {
            var enquiry = ValidEnquiry();
            enquiry.UserEmail = "not-an-email";
            var result = _validator.TestValidate(enquiry);
            result.ShouldHaveValidationErrorFor(x => x.UserEmail);
        }

        [Fact]
        public void UserCompany_Empty_HasValidationError()
        {
            var enquiry = ValidEnquiry();
            enquiry.UserCompany = "";
            var result = _validator.TestValidate(enquiry);
            result.ShouldHaveValidationErrorFor(x => x.UserCompany);
        }

        [Fact]
        public void UserCountry_Null_HasNoValidationError()
        {
            var enquiry = ValidEnquiry();
            enquiry.UserCountry = null;
            var result = _validator.TestValidate(enquiry);
            result.ShouldNotHaveValidationErrorFor(x => x.UserCountry);
        }

        [Fact]
        public void UserCountry_ExceedsMaxLength_HasValidationError()
        {
            var enquiry = ValidEnquiry();
            enquiry.UserCountry = new string('a', 101);
            var result = _validator.TestValidate(enquiry);
            result.ShouldHaveValidationErrorFor(x => x.UserCountry);
        }

        [Fact]
        public void Message_Empty_HasValidationError()
        {
            var enquiry = ValidEnquiry();
            enquiry.Message = "";
            var result = _validator.TestValidate(enquiry);
            result.ShouldHaveValidationErrorFor(x => x.Message);
        }

        [Fact]
        public void ValidEnquiry_HasNoValidationErrors()
        {
            var result = _validator.TestValidate(ValidEnquiry());
            result.ShouldNotHaveAnyValidationErrors();
        }
    }
}
