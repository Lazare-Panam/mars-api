using Mars.API.Models.Basket;
using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.JsonWebTokens;
using System.Security.Claims;
using static Microsoft.ApplicationInsights.MetricDimensionNames.TelemetryContext;

namespace Mars.API.Controllers
{
    [ApiController]
    [Route("api/basket")]
    public class BasketController(ICartService cartService) : ControllerBase
    {
        private string? GetUserId()
        {
           var userId = HttpContext.User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;
           return userId;
        }
        private const string SessionKeyName = "BasketSessionId";
        private string GetSessionId()
        {
            if (HttpContext.Session is null)
            {
                return Guid.NewGuid().ToString();
            }

            var existingId = HttpContext.Session.GetString(SessionKeyName);

            if (string.IsNullOrEmpty(existingId))
            {
                existingId = HttpContext.Session.Id;
                HttpContext.Session.SetString(SessionKeyName, existingId);
            }

            return existingId;
        }

        [HttpGet]
        public async Task<IActionResult> GetBasket()
        {
            var userId = GetUserId();
            var sessionId = GetSessionId();

            var basket = await cartService.GetBasketAsync(userId, sessionId);

            if (basket is null)
            {
                return Ok(new { items = Array.Empty<object>(), totalAmount = 0m });
            }

            return Ok(basket);
        }

        [HttpPost("items")]
        public async Task<IActionResult> AddToCart([FromBody] AddToCartRequest request)
        {
            if (request.Quantity < 1)
            {
                return BadRequest("Quantity must be at least 1.");
            }

            var userId = GetUserId();
            var sessionId = GetSessionId();
            var basket = await cartService.AddOrUpdate(userId, sessionId, request);
            return Ok(basket);
        }

        [HttpPut("items/{productId}")]
        public async Task<IActionResult> UpdateQuantity(string productId, [FromBody] UpdateQuantityRequest request)
        {
            var userId = GetUserId();
            var sessionId = GetSessionId();

            var basket = await cartService.UpdateItemQuantityAsync(userId, sessionId, productId, request.Quantity);

            if (basket is null)
            {
                return NotFound();
            }

            return Ok(basket);
        }

        [HttpDelete("items/{productId}")]
        public async Task<IActionResult> RemoveItem(string productId)
        {
            var userId = GetUserId();
            var sessionId = GetSessionId();

            var removed = await cartService.RemoveItemAsync(userId, sessionId, productId);
            return removed ? NoContent() : NotFound();
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteBasket()
        {
            var userId = GetUserId();
            var sessionId = GetSessionId();

            var deleted = await cartService.DeleteBasketAsync(userId, sessionId);
            return deleted ? NoContent() : NotFound();
        }
    }
}
