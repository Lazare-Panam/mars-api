
using Mars.API.Services.Interfaces;
using System.Reflection;

namespace Mars.API.Services.Notification
{
    public class EmailTemplateService : IEmailTemplateService
    {
        private readonly ILogger<EmailTemplateService> _logger;
        public EmailTemplateService(ILogger<EmailTemplateService> logger)
        {
            _logger = logger;
        }
        /// <summary>
        /// Builds the HTML body for the receipt email sent back to the customer who submitted an enquiry.
        /// </summary>
        /// <returns>Rendered HTML with the enquiry details substituted into the template.</returns>
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
        /// <summary>
        /// Builds the HTML body for the internal notification email alerting staff to a new enquiry.
        /// </summary>
        /// <returns>Rendered HTML with the enquiry details substituted into the template.</returns>
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
        /// <summary>
        /// Replaces each <c>{{Token}}</c> placeholder in <paramref name="template"/> with its corresponding value.
        /// </summary>
        /// <param name="template">The raw HTML template containing placeholder tokens.</param>
        /// <param name="replacements">Placeholder-to-value map; a null value is substituted with an empty string.</param>
        /// <returns>The template with all placeholders substituted.</returns>
        private static string replaceTokens(string template, Dictionary<string, string> replacements)
        {
            var result = template;
            foreach (var item in replacements)
            {
                result = result.Replace(item.Key, item.Value ?? string.Empty);
            }
            return result;
        }
        /// <summary>
        /// Loads an HTML email template embedded as a resource under <c>EmailTemplates/</c>.
        /// </summary>
        /// <param name="fileName">The template's file name, e.g. <c>NewEnquiry.html</c>.</param>
        /// <returns>The raw HTML content of the template.</returns>
        /// <exception cref="FileNotFoundException">Thrown if no embedded resource matches <paramref name="fileName"/>.</exception>
        private string LoadTemplate(string fileName)
        {
            try 
            {
                var assembly = Assembly.GetExecutingAssembly();
                string resourcePath = $"{assembly.GetName().Name}.EmailTemplates.{fileName}";

                using Stream stream = assembly.GetManifestResourceStream(resourcePath);
                if (stream == null)
                {
                    throw new FileNotFoundException($"Resource not found: {resourcePath}");
                } 

                using StreamReader reader = new StreamReader(stream);
                _logger.LogInformation("Successfully loaded email template: {FileName}", fileName);
                return reader.ReadToEnd();
            }
            catch(FileNotFoundException ex)
            {
                _logger.LogError(ex, "Failed to load email template: {FileName}. Ensure the file is embedded as a resource.", fileName);
                throw;
            }
           
        }
        /// <summary>
        /// Builds the HTML body for the welcome email sent to a newly registered user.
        /// </summary>
        /// <returns>Rendered HTML with the user's details substituted into the template.</returns>
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

        /// <summary>
        /// Builds the HTML body for the internal notification email alerting staff to a new user registration.
        /// </summary>
        /// <returns>Rendered HTML with the registration details substituted into the template.</returns>
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
