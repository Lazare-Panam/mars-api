using Azure;
using Azure.Communication.Email;
using Mars.API.Repository.Interfaces;
using Mars.API.Settings;
using Microsoft.Extensions.Options;

namespace Mars.API.Services.Notification
{
    public class EmailService : IEmailService
    {
        private readonly EmailClient _emailClient;
        private readonly EmailSettings _emailSettings;
        private readonly ILogger<EmailService> _logger;
        public EmailService(IOptions<EmailSettings> options, EmailClient emailClient, ILogger<EmailService> logger)
        {
            _emailClient = emailClient;
            _logger = logger;
            _emailSettings = options.Value;
        }
        public async Task SendEmailAsync(string recipientEmail, string subject, string htmlBody)
        {
            ArgumentException.ThrowIfNullOrWhiteSpace(recipientEmail);
            ArgumentException.ThrowIfNullOrWhiteSpace(subject);
            ArgumentException.ThrowIfNullOrWhiteSpace(htmlBody);

            _logger.LogInformation("Attempting to send email to {Recipient} with subject: {Subject}", recipientEmail, subject);

            try
            {
                var response = await _emailClient.SendAsync(wait: WaitUntil.Completed, senderAddress: _emailSettings.SenderAddress, recipientAddress: recipientEmail, subject: subject, htmlContent: htmlBody);
                _logger.LogInformation("Email sent successfully to {Recipient}. Operation ID: {OperationId}", recipientEmail, response.Id);
            }
            catch (RequestFailedException ex)
            {
                _logger.LogError(ex, "Azure Communication Services failed to send email to {Recipient}. Error Code: {ErrorCode}", recipientEmail, ex.ErrorCode);
                throw;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Unexpected error occurred while sending email to {Recipient}", recipientEmail);
                throw;
            }
        }
    }
}
