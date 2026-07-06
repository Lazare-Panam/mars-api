using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Mars.API.Controllers
{

    [ApiController]
    [Route("api/[controller]")]
    public class ProductController : ControllerBase
    {
        private readonly IProductService _productService;
        public ProductController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetCatalog(string id, CancellationToken ct)
        {
            var catalog = await _productService.GetCatalogByIdAsync(id,ct);

            if (catalog is null)
                return NotFound($"No catalog found for ID: {id }");

            return Ok(catalog);
        }
        [HttpGet("{id}/detail")]
        public async Task<IActionResult> GetProductDetail(string id, CancellationToken ct)
        {
            var detail = await _productService.GetProductDetailAsync(id, ct);

            if (detail is null)
                return NotFound($"No detail found for ID: {id}");

            return Ok(detail);
        }
        [HttpGet("{id}/variants")]
        public async Task<IActionResult> GetProductVariants(string id, CancellationToken ct)
        {
            var variants = await _productService.GetProductVariantsAsync(id, ct);

            if (variants is null)
                return NotFound($"No variants found for ID: {id}");

            return Ok(variants);
        }
    }
}
