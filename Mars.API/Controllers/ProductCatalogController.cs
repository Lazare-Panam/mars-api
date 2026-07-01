using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace Mars.API.Controllers
{

    [ApiController]
    [Route("api/[controller]")]
    public class ProductCatalogController : ControllerBase
    {
        private readonly IProductCatalogService _productService;

        public ProductCatalogController(IProductCatalogService productService)
        {
            _productService = productService;
        }

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
