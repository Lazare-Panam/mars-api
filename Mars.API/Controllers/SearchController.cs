using Mars.API.Models.Search;
using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.RateLimiting;

namespace Mars.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class SearchController : ControllerBase
    {
        private const int MaxQueryLength = 100;

        private readonly ISearchService _searchService;
        private readonly ILogger<SearchController> _logger;

        public SearchController(ISearchService searchService, ILogger<SearchController> logger)
        {
            _searchService = searchService;
            _logger = logger;
        }

        // GET api/Search?q=cryogenic&limit=8  -> grouped series + product hits (public, rate-limited).
        [HttpGet]
        [EnableRateLimiting("search")]
        public async Task<IActionResult> Search([FromQuery] string? q, [FromQuery] int limit = 8, CancellationToken ct = default)
        {
            if (string.IsNullOrWhiteSpace(q))
                return Ok(new SearchResultsDto());

            // Bound the input before it reaches the search engine.
            if (q.Length > MaxQueryLength)
                q = q[..MaxQueryLength];

            var results = await _searchService.SearchAsync(q, limit, ct);
            return Ok(results);
        }
    }
}
