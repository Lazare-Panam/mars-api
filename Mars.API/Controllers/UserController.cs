using Mars.API.MessageQueues;
using Mars.API.Models.Auth;
using Mars.API.Models.User;
using Mars.API.Repository.SQL;
using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Mars.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class UserController : ControllerBase
    {
        private readonly ApplicationDBContext _dbContext;
        private readonly IEnquiryPublisher _enquiryPublisher;
        private readonly ILogger<UserController> _logger;

        public UserController(ApplicationDBContext dbContext, IEnquiryPublisher enquiryPublisher, ILogger<UserController> logger)
        {
            _dbContext = dbContext;
            _enquiryPublisher = enquiryPublisher;
            _logger = logger;
        }

        [HttpPost("enquiry")]
        public async Task<IActionResult> UserEnquiry(EnquiryRequest enquiryRequest, CancellationToken cancellationToken)
        {
            _logger.LogInformation("Enquiry received for email {Email}", enquiryRequest.UserEmail);

            var enquiry = new Enquiry
            {
                Id = Guid.NewGuid(),
                UserName = enquiryRequest.UserName,
                UserEmail = enquiryRequest.UserEmail,
                UserCompany = enquiryRequest.UserCompany,
                UserCountry = enquiryRequest.UserCountry,
                Message = enquiryRequest.Message,
                CreatedAtUtc = DateTime.UtcNow
            };

            _dbContext.Enquiry.Add(enquiry);
            await _dbContext.SaveChangesAsync(cancellationToken);

            try
            {
                await _enquiryPublisher.PublishEnquiryRecievedAsync(enquiry.Id, cancellationToken);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to publish EnquiryReceived message for enquiry {EnquiryId}. Enquiry was saved but notification was not queued.", enquiry.Id);
            }

            return Ok(new { message = "Enquiry received", enquiryId = enquiry.Id });
        }
    }
}
