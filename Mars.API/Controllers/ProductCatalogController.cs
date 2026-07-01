using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Mars.API.Controllers
{

    [ApiController]
    [Route("api/[controller]")]
    public class ProductCatalogController : ControllerBase
    {
        private readonly IProductCatalogService _productService;

        /// <summary>
        /// Initializes a new instance of the <see cref="ProductCatalogController"/> class.
        /// </summary>
        public ProductCatalogController(IProductCatalogService productService)
        {
            _productService = productService;
        }

        /// <summary>
        /// Gets a product catalog by its ID.
        /// </summary>
        /// <param name="id">The catalog ID.</param>
        /// <returns>The catalog when found; otherwise, a 404 Not Found result with the requested ID.</returns>
        [HttpGet("{id}")]
        public async Task<IActionResult> GetCatalog(string id)
        {
            var catalog = await _productService.GetCatalogByIdAsync(id);

            if (catalog is null)
                return NotFound($"No catalog found for ID: {id }");

            return Ok(catalog);
        }
    }
}
