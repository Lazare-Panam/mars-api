using Mars.API.Models.User;
using Mars.API.Services.Interfaces;

namespace Mars.API.Services.Notification
{
    public class MockService 
    {
        public Task<CreditLineApplication> CreateApplicationAsync(CreditLineApplication application)
        {
            throw new NotImplementedException();
        }
    }
}
