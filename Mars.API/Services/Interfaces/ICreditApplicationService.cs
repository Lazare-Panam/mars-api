using Mars.API.Models.User;

namespace Mars.API.Services.Interfaces
{
    public interface ICreditApplicationService
    {
        Task<CreditLineApplication> CreateApplicationAsync(CreditLineApplication application);
        Task<List<CreditLineApplication>> GetAllApplicationsAsync();
        Task<CreditLineApplication?> GetApplicationByIdAsync(int applicationId);
    }
}
