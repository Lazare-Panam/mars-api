namespace Mars.API.Repository.Interfaces
{
    public interface IEmailService
    {
        Task SendEmailAsync(string recipientEmail, string subject, string htmlBody);
    }
}
