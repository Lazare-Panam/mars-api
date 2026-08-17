using Mars.API.Services.Interfaces;
using System.Reflection;

namespace Mars.API.Services.Notification
{
    public class EmailTemplateService : IEmailTemplateService
    {
        public string GetEnquiryReceiptHtml(string userName, string userCompany, string userEmail, string userCountry, string enquiryMessage)
        {
            string htmlContent = LoadTemplate("NewEnquiry.html");
            var replacements = new Dictionary<string, string>
            {
                { "{{UserName}}", userName },
                { "{{UserCompany}}", userCompany },
                { "{{UserEmail}}", userEmail },
                { "{{UserCountry}}", userCountry ?? "Not Provided" },
                { "{{EnquiryMessage}}", enquiryMessage },
                
            };
            return replaceTokens(htmlContent, replacements);
        }
        public string GetEnquiryInternalHtml(string userName, string userCompany, string userEmail, string userCountry, string enquiryMessage)
        {
            string htmlContent = LoadTemplate("InternalNewEnquiry.html");
            var replacements = new Dictionary<string, string>
            {
                { "{{UserName}}", userName },
                { "{{UserCompany}}", userCompany },
                { "{{UserEmail}}", userEmail },
                { "{{UserCountry}}", userCountry ?? "Not Provided" },
                { "{{EnquiryMessage}}", enquiryMessage },
            };

            return replaceTokens(htmlContent, replacements);
        }
        private string replaceTokens(string template, Dictionary<string, string> replacements)
        {
            var result = template;
            foreach (var item in replacements)
            {
                result = result.Replace(item.Key, item.Value ?? string.Empty);
            }
            return result;
        }
        private string LoadTemplate(string fileName)
        {
            var assembly = Assembly.GetExecutingAssembly();
            string resourcePath = $"{assembly.GetName().Name}.EmailTemplates.{fileName}";

            using Stream stream = assembly.GetManifestResourceStream(resourcePath);
            if (stream == null) throw new FileNotFoundException($"Resource not found: {resourcePath}");

            using StreamReader reader = new StreamReader(stream);
            return reader.ReadToEnd();
        }
        public string GetRegistrationWelcomeHtml(string userName, string userEmail, string userCompany)
        {
            string htmlContent = LoadTemplate("NewRegistration.html");
            var replacements = new Dictionary<string, string>
            {
                { "{{UserName}}", userName },
                { "{{UserEmail}}", userEmail },
                { "{{UserCompany}}", userCompany ?? "Not Provided" },
            };
            return replaceTokens(htmlContent, replacements);
        }

        public string GetRegistrationInternalHtml(string userName, string userCompany, string userEmail, string userCountry, string userJobTitle, string registrationDate)
        {
            string htmlContent = LoadTemplate("NewRegistrationInternal.html");
            var replacements = new Dictionary<string, string>
            {
                { "{{UserName}}", userName },
                { "{{UserCompany}}", userCompany ?? "Not Provided" },
                { "{{UserEmail}}", userEmail },
                { "{{UserCountry}}", userCountry ?? "Not Provided" },
                { "{{UserJobTitle}}", userJobTitle ?? "Not Provided" },
                { "{{RegistrationDate}}", registrationDate },
            };
            return replaceTokens(htmlContent, replacements);
        }
    }
}
