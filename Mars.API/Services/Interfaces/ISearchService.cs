using Mars.API.Models.Search;

namespace Mars.API.Services.Interfaces
{
    public interface ISearchService
    {
        /// <summary>Full-text search across the series + products indexes; returns grouped hits.</summary>
        Task<SearchResultsDto> SearchAsync(string query, int limit, CancellationToken ct);
    }
}
