using Mars.API.Models.Basket;

namespace Mars.API.Services.Interfaces
{
    public interface IRfqService
    {
        /// <summary>
        /// Creates a quote request from the given line items and sends the customer receipt
        /// and internal staff notification emails.
        /// </summary>
        /// <param name="userId">The authenticated user's id. Quote requests require a signed-in user.</param>
        /// <param name="userName">The requesting user's display name, used in the notification emails.</param>
        /// <param name="userEmail">The requesting user's email, used as the receipt email's recipient.</param>
        /// <param name="userCompany">The requesting user's company, used in the notification emails.</param>
        /// <param name="request">The line items being requested for quote.</param>
        /// <returns>The created <see cref="QuoteRequest"/>, including its generated id.</returns>
        Task<QuoteRequest> CreateRfq(string userId, string userName, string userEmail, string userCompany, CreateRfqRequest request);
    }
}
