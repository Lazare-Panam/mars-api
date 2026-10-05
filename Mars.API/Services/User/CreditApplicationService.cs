using Mars.API.Models.User;
using Mars.API.Repository.SQL;
using Mars.API.Services.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace Mars.API.Services.User
{
    public class CreditApplicationService : ICreditApplicationService
    {
        private readonly ILogger<CreditApplicationService> _logger;
        private readonly ApplicationDBContext _dbContext;
        private readonly INotificationService _notificationService;
        public CreditApplicationService(ILogger<CreditApplicationService> logger, ApplicationDBContext dbContext, INotificationService notificationService)
        {
            _logger = logger;
            _dbContext = dbContext;
            _notificationService = notificationService;
        }
        public async Task<CreditLineApplication> CreateApplicationAsync(CreditLineApplication application)
        {
            application.SubmittedAtUtc = DateTimeOffset.UtcNow;
            application.Status = ApplicationStatus.Pending;

            _dbContext.CreditLineApplications.Add(application);
            await _dbContext.SaveChangesAsync();

            await _notificationService.HandleNewCreditApplicationAsync(application.ContactName, application.Email, application.CompanyName, application.CreditLimitRequested, application.Currency, application.SubmittedAtUtc);
            _logger.LogInformation("New credit line application created with ID {ApplicationId}", application.ApplicationId);
            return application;
        }
        public async Task<List<CreditLineApplication>> GetAllApplicationsAsync()
        {
            return await _dbContext.CreditLineApplications.OrderByDescending(x => x.SubmittedAtUtc).ToListAsync();
        }
        public async Task<CreditLineApplication?> GetApplicationByIdAsync(int applicationId)
        {
            return await _dbContext.CreditLineApplications.FirstOrDefaultAsync(x => x.ApplicationId == applicationId);
        }
    }
}
