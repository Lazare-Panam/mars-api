using Mars.API.Models.User;

namespace Mars.API.Services.Interfaces
{
    public interface IStockListService
    {
        /// <summary>
        /// Records a stock-list notification request and sends the customer email
        /// (catalogue + stock-list links) plus the internal staff notification.
        /// Requests whose honeypot is filled are silently ignored.
        /// </summary>
        Task HandleStockListRequestAsync(StockListRequestDTO request, CancellationToken cancellationToken = default);
    }
}
