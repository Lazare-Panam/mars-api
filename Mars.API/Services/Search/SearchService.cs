using Mars.API.Models.Search;
using Mars.API.Services.Interfaces;
using Meilisearch;

namespace Mars.API.Services.Search
{
    // Thin read-only proxy over Meilisearch. Documents are loaded into Meili directly
    // (JSON upload in the dashboard), and index settings are configured there too — so
    // this service only queries.
    public class SearchService : ISearchService
    {
        // ONE index, products only (like Panam's single "panam-products"). "Series" is a
        // sidebar facet, not separate documents — so you upload once.
        private const string ProductsIndex = "products";

        private readonly MeilisearchClient _meili;
        private readonly ILogger<SearchService> _logger;

        public SearchService(MeilisearchClient meili, ILogger<SearchService> logger)
        {
            _meili = meili;
            _logger = logger;
        }

        public async Task<SearchResultsDto> SearchAsync(string query, int limit, CancellationToken ct)
        {
            if (string.IsNullOrWhiteSpace(query))
                return new SearchResultsDto();

            limit = Math.Clamp(limit, 1, 100);
            _logger.LogDebug("Search '{Query}' limit {Limit}", query, limit);

            var products = await SafeSearchAsync<ProductSearchDocument>(ProductsIndex, query, limit);
            return new SearchResultsDto { Products = products };
        }

        // Runs a search, returning [] if the index doesn't exist yet or Meili errors,
        // so one unavailable index never breaks the other half of the results.
        private async Task<List<T>> SafeSearchAsync<T>(string index, string query, int limit)
        {
            try
            {
                // MatchingStrategy "all": a hit must contain EVERY typed word, not just one.
                // Stops "series 10" (where "series" is in every doc) returning unrelated series.
                var result = await _meili.Index(index).SearchAsync<T>(query,
                    new SearchQuery { Limit = limit, MatchingStrategy = "all" });
                return result.Hits.ToList();
            }
            catch (MeilisearchApiError ex)
            {
                _logger.LogWarning(ex, "Search on index '{Index}' unavailable ({Code}); returning no hits", index, ex.Code);
                return [];
            }
        }
    }
}
