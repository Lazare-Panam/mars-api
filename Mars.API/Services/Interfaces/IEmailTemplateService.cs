using Mars.API.Models.Basket;

namespace Mars.API.Services.Interfaces
{
    public interface IEmailTemplateService
    {
        /// <summary>
        /// Builds the HTML body for the receipt email sent back to the customer who submitted an enquiry.
        /// </summary>
        /// <returns>Rendered HTML with the enquiry details substituted into the template.</returns>
        string GetEnquiryReceiptHtml(string userName, string userCompany, string userEmail, string userCountry, string enquiryMessage);

        /// <summary>
        /// Builds the HTML body for the internal notification email alerting staff to a new enquiry.
        /// </summary>
        /// <returns>Rendered HTML with the enquiry details substituted into the template.</returns>
        string GetEnquiryInternalHtml(string userName, string userCompany, string userEmail, string userCountry, string enquiryMessage);

        /// <summary>
        /// Builds the HTML body for the welcome email sent to a newly registered user.
        /// </summary>
        /// <returns>Rendered HTML with the user's details substituted into the template.</returns>
        string GetRegistrationWelcomeHtml(string userName, string userEmail, string userCompany);

        /// <summary>
        /// Builds the HTML body for the internal notification email alerting staff to a new user registration.
        /// </summary>
        /// <returns>Rendered HTML with the registration details substituted into the template.</returns>
        string GetRegistrationInternalHtml(string userName, string userCompany, string userEmail, string userCountry, string userJobTitle, string registrationDate);

        /// <summary>
        /// Builds the HTML body for the receipt email sent back to the customer who submitted a quote request.
        /// </summary>
        /// <returns>Rendered HTML with the quote request details substituted into the template.</returns>
        string GetRfqReceiptHtml(string userName, string userCompany, string userEmail, string quoteRequestId, IEnumerable<QuoteRequestItem> items);

        /// <summary>
        /// Builds the HTML body for the internal notification email alerting staff to a new quote request.
        /// </summary>
        /// <returns>Rendered HTML with the quote request details substituted into the template.</returns>
        string GetRfqInternalHtml(string userName, string userCompany, string userEmail, string quoteRequestId, IEnumerable<QuoteRequestItem> items);
    }
}
