using Mars.API.Models.User;

namespace Mars.API.Services.Interfaces
{
    public interface INotificationService
    {
        /// <summary>
        /// Sends the customer receipt and internal staff notification emails for a new enquiry.
        /// Each email is sent independently, so a failure sending one does not prevent the other.
        /// </summary>
        /// <returns>A <see cref="NotificationResult"/> indicating which of the two emails were sent successfully.</returns>
        Task<NotificationResult> HandleNewEnquiryAsync(string userName, string userEmail, string userCompany, string userCountry, string message);

        /// <summary>
        /// Sends the welcome email and internal staff notification email for a newly registered user.
        /// Each email is sent independently, so a failure sending one does not prevent the other.
        /// </summary>
        /// <returns>A <see cref="NotificationResult"/> indicating which of the two emails were sent successfully.</returns>
        Task<NotificationResult> HandleNewUserRegisteredAsync(string userName, string userEmail, string userCompany, string userCountry, string userJobTitle, string registrationDate);
    }
}
