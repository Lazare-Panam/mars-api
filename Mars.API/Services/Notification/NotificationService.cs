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
        /// <summary>
        /// Sends the customer receipt and internal staff notification emails for a new enquiry.
        /// Each email is sent independently, so a failure sending one does not prevent the other.
        /// </summary>
        /// <returns>A <see cref="NotificationResult"/> indicating which of the two emails were sent successfully.</returns>
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
        /// <summary>
        /// Sends the welcome email and internal staff notification email for a newly registered user.
        /// Each email is sent independently, so a failure sending one does not prevent the other.
        /// </summary>
        /// <returns>A <see cref="NotificationResult"/> indicating which of the two emails were sent successfully.</returns>
        public async Task<NotificationResult> HandleNewUserRegisteredAsync(string userName, string userEmail, string userCompany, string userCountry, string userJobTitle, string registrationDate)
        {
            var result = new NotificationResult();
            try
            {
                await SendRegistrationWelcomeAsync(userName, userEmail, userCompany);
                result.ReceiptSent = true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to send registration welcome email to {Email}", userEmail);
            }

            try
            {
                await SendRegistrationInternalNotificationAsync(userName, userEmail, userCompany, userCountry, userJobTitle, registrationDate);
                result.InternalNotificationSent = true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to send internal registration notification for {Company}", userCompany);
            }
            return result;
        }

        /// <summary>
        /// Renders and sends the welcome email to a newly registered user.
        /// </summary>
        private async Task SendRegistrationWelcomeAsync(string userName, string userEmail, string userCompany)
        {
            var body = _templateService.GetRegistrationWelcomeHtml(userName, userEmail, userCompany);
            await _emailService.SendEmailAsync(userEmail, "Welcome to UK Mars Valve", body);
        }

        /// <summary>
        /// Renders and sends the internal staff notification email for a new user registration,
        /// to the address configured in <see cref="EmailSettings.InternalAddressEmail"/>.
        /// </summary>
        private async Task SendRegistrationInternalNotificationAsync(string userName, string userEmail, string userCompany, string userCountry, string userJobTitle, string registrationDate)
        {
            var body = _templateService.GetRegistrationInternalHtml(userName, userCompany, userEmail, userCountry, userJobTitle, registrationDate);
            await _emailService.SendEmailAsync(_emailSettings.InternalAddressEmail, $"New User Registered: {userCompany}", body);
        }
        /// <summary>
        /// Renders and sends the receipt email back to the customer who submitted an enquiry.
        /// </summary>
        private async Task SendEnquiryReceiptAsync(string userName, string userEmail, string userCompany, string userCountry, string message)
        {
            var body = _templateService.GetEnquiryReceiptHtml(userName, userCompany, userEmail, userCountry, message);
            await _emailService.SendEmailAsync(userEmail, "We've received your enquiry", body);
        }
        /// <summary>
        /// Renders and sends the internal staff notification email for a new technical enquiry,
        /// to the address configured in <see cref="EmailSettings.InternalAddressEmail"/>.
        /// </summary>
        private async Task SendEnquiryInternalNotificationAsync(string userName, string userEmail, string userCompany, string userCountry, string message)
        {
            var body = _templateService.GetEnquiryInternalHtml(userName, userCompany, userEmail, userCountry, message);
            await _emailService.SendEmailAsync(_emailSettings.InternalAddressEmail, $"URGENT: New Technical Enquiry from {userCompany}", body);
        }
    }
}
