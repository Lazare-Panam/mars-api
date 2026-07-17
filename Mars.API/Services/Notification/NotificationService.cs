using Mars.API.Models.User;
using Mars.API.Repository.Interfaces;
using Mars.API.Services.Interfaces;
using Mars.API.Settings;
using Microsoft.Extensions.Options;

namespace Mars.API.Services.Notification
{
    public class NotificationService : INotificationService
    {
        private readonly IEmailTemplateService _templateService;
        private readonly IEmailService _emailService;
        private readonly EmailSettings _emailSettings;
        private readonly ILogger<NotificationService> _logger;
        public NotificationService(IEmailTemplateService templateService, IEmailService emailService, IOptions<EmailSettings> options, ILogger<NotificationService> logger)
        {
            _templateService = templateService;
            _emailService = emailService;
            _emailSettings = options.Value;
            _logger = logger;
        }
        public async Task<NotificationResult> HandleNewEnquiryAsync(string userName, string userEmail, string userCompany, string userCountry, string message)
        {
            var result = new NotificationResult();
            try
            {
                await SendEnquiryReceiptAsync(userName, userEmail, userCompany, userCountry, message);
                result.ReceiptSent = true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to send enquiry receipt to {Email}", userEmail);
            }

            try
            {
                await SendEnquiryInternalNotificationAsync(userName, userEmail, userCompany, userCountry, message);
                result.InternalNotificationSent = true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to send internal enquiry notification for {Company}", userCompany);
            }
            return result;
        }
        private async Task SendEnquiryReceiptAsync(string userName, string userEmail, string userCompany, string userCountry, string message)
        {
            var body = _templateService.GetEnquiryReceiptHtml(userName, userCompany, userEmail, userCountry, message);
            await _emailService.SendEmailAsync(userEmail, "We've received your enquiry", body);
        }
        private async Task SendEnquiryInternalNotificationAsync(string userName, string userEmail, string userCompany, string userCountry, string message)
        {
            var body = _templateService.GetEnquiryInternalHtml(userName, userCompany, userEmail, userCountry, message);
            await _emailService.SendEmailAsync("marketing@panamvalve.com", $"URGENT: New Technical Enquiry from {userCompany}", body);
        }
    }
}
