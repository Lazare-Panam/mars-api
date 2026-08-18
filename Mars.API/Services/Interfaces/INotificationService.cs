using Mars.API.Models.User;

namespace Mars.API.Services.Interfaces
{
    public interface INotificationService
    {
        Task<NotificationResult> HandleNewEnquiryAsync(string userName, string userEmail, string userCompany, string userCountry, string message);
        Task<NotificationResult> HandleNewUserRegisteredAsync(string userName, string userEmail, string userCompany, string userCountry, string userJobTitle, string registrationDate);
    }
}
