using Mars.API.Models.User;

namespace Mars.API.Services.Interfaces
{
    public interface INotificationService
    {
        Task<NotificationResult> HandleNewEnquiryAsync(string userName, string userEmail, string userCompany, string userCountry, string message);
    }
}
