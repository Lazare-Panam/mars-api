using Mars.API.Models.Auth;
using Mars.API.Models.User;
using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Mars.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController:ControllerBase
    {
        private readonly INotificationService _notificationService;
        private readonly ILogger<UserController> _logger;
        public UserController(INotificationService notificationService, ILogger<UserController> logger)
        {
            _notificationService = notificationService;
            _logger = logger;
        }
        [HttpPost("enquiry")]
        public async Task<IActionResult> UserEnquiry(EnquiryRequest enquiryRequest)
        {
            _logger.LogInformation("Enquiry For email {Email}", enquiryRequest.UserEmail);
            var result = await _notificationService.HandleNewEnquiryAsync(enquiryRequest.UserName, enquiryRequest.UserEmail, enquiryRequest.UserCompany, enquiryRequest.UserCountry, enquiryRequest.Message);
            if (!result.InternalNotificationSent)
            {
                _logger.LogWarning("Internal notification failed for enquiry from {Company}", enquiryRequest.UserCompany);
            }

            return Ok(new
            {
                message = "Enquiry received",
                receiptSent = result.ReceiptSent
            });
        }
    }
}
