using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Mars.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductController : ControllerBase
    {
        private readonly IProductService _productService;
        private readonly ILogger<ProductController> _logger;

        public ProductController(IProductService productService, ILogger<ProductController> logger)
        {
            _productService = productService;
            _logger = logger;
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetCatalog(string id, CancellationToken ct)
        {
            _logger.LogInformation("GetCatalog called for {Id}", id);
            var catalog = await _productService.GetCatalogByIdAsync(id, ct);

            if (catalog is null)
            {
                _logger.LogWarning("Catalog not found for {Id}", id);
                return NotFound($"No catalog found for ID: {id}");
            }

            return Ok(catalog);
        }

        [HttpGet("{id}/detail")]
        public async Task<IActionResult> GetProductDetail(string id, CancellationToken ct)
        {
            _logger.LogInformation("GetProductDetail called for {Id}", id);
            var detail = await _productService.GetProductDetailAsync(id, ct);

            if (detail is null)
            {
                _logger.LogWarning("Product detail not found for {Id}", id);
                return NotFound($"No detail found for ID: {id}");
            }

            return Ok(detail);
        }

        [HttpGet("{id}/variants")]
        public async Task<IActionResult> GetProductVariants(string id, CancellationToken ct)
        {
            _logger.LogInformation("GetProductVariants called for {Id}", id);
            var isAuthenticated = User.Identity?.IsAuthenticated ?? false;
            var variants = await _productService.GetProductVariantsAsync(id, isAuthenticated, ct);

            if (variants is null)
            {
                _logger.LogWarning("Variants not found for {Id}", id);
                return NotFound($"No variants found for ID: {id}");
            }

            return Ok(variants);
        }
        [HttpGet("stock")]
        public async Task<IActionResult> GetStockProducts(CancellationToken ct)
        {
            _logger.LogInformation("GetStockProducts called");
            var stockProducts = await _productService.GetStockProductsAsync(ct);

            return Ok(stockProducts);
        }
    }
}