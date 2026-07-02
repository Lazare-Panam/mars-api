using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Mars.API.Controllers
{

    [ApiController]
    [Route("api/[controller]")]
    public class ProductController : ControllerBase
    {
        private readonly IProductService _productService;

        /// <summary>
        /// Initializes a new instance of the <see cref="ProductController"/> class.
        /// </summary>
        public ProductController(IProductService productService)
        {
            _productService = productService;
        }

        /// <summary>
        /// Gets a product catalog by its ID.
        /// </summary>
        /// <param name="id">The catalog ID.</param>
        /// <returns>The catalog when found; otherwise, a 404 Not Found result with the requested ID.</returns>
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCatalog(string id, CancellationToken ct)
        {
            var catalog = await _productService.GetCatalogByIdAsync(id,ct);

            if (catalog is null)
                return NotFound($"No catalog found for ID: {id }");

            return Ok(catalog);
        }
        [HttpGet("{id}/products/{productId}")]
        public async Task<IActionResult> GetProductDetail(string id, string productId, CancellationToken ct)
        {
            var detail = await _productService.GetProductDetailAsync(id, productId, ct);

            if (detail is null)
                return NotFound($"No product found for ID: {productId} in catalog: {id}");

            return Ok(detail);
        }
        [HttpGet("{id}/products/{seriesId}/variants")]
        public async Task<IActionResult> GetProductVariants(string id, string seriesId, CancellationToken ct)
        {
            var variants = await _productService.GetProductVariantsAsync(id, seriesId, ct);

            if (variants is null)
                return NotFound($"No variants found for series: {seriesId}");

            return Ok(variants);
        }
    }
}
