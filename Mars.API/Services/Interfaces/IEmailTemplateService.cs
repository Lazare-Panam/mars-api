namespace Mars.API.Services.Interfaces
{
    public interface IEmailTemplateService
    {
        string GetEnquiryReceiptHtml(string userName, string userCompany, string userEmail, string userCountry, string enquiryMessage);
        string GetEnquiryInternalHtml(string userName, string userCompany, string userEmail, string userCountry, string enquiryMessage);
    }
}
