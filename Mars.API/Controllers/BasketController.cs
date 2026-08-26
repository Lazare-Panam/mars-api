using Mars.API.Models.Auth;
using Mars.API.Models.Basket;
using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.JsonWebTokens;
using System.Security.Claims;

namespace Mars.API.Controllers
{
    [ApiController]
    [Route("api/basket")]
    public class BasketController : ControllerBase
    {
        private readonly ILogger<BasketController> _logger;
        private readonly ICartService _cartService;
        private readonly IRfqService _rfqService;
        private readonly UserManager<ApplicationUser> _userManager;
        public BasketController(ILogger<BasketController> logger, ICartService cartService, IRfqService rfqService, UserManager<ApplicationUser> userManager)
        {
            _logger = logger;
            _cartService = cartService;
            _rfqService = rfqService;
            _userManager = userManager;
        }
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

            var basket = await _cartService.GetBasketAsync(userId, sessionId);

            if (basket is null)
            {
                _logger.LogInformation("No basket found for userId: {@UserId}, sessionId: {@SessionId}", userId, sessionId);
                return Ok(new { items = Array.Empty<object>(), totalAmount = 0m });
            }
            _logger.LogInformation("Basket retrieved for userId: {@UserId}, sessionId: {@SessionId}", userId, sessionId);
            return Ok(basket);
        }

        [HttpPost("items")]
        public async Task<IActionResult> AddToCart([FromBody] AddToCartRequest request)
        {
            if (request.Quantity < 1)
            {
                _logger.LogInformation("Attempted to add item with invalid quantity: {@Quantity}", request.Quantity);
                return BadRequest("Quantity must be at least 1.");
            }

            var userId = GetUserId();
            var sessionId = GetSessionId();
            var basket = await _cartService.AddOrUpdate(userId, sessionId, request);
            _logger.LogInformation("Item added to basket for userId: {@UserId}, sessionId: {@SessionId}, productId: {@ProductId}, quantity: {@Quantity}", userId, sessionId, request.VariantId, request.Quantity);
            return Ok(basket);
        }

        [HttpPut("items/{productId}")]
        public async Task<IActionResult> UpdateQuantity(string productId, [FromBody] UpdateQuantityRequest request)
        {
            var userId = GetUserId();
            var sessionId = GetSessionId();

            var basket = await _cartService.UpdateItemQuantityAsync(userId, sessionId, productId, request.Quantity);
            if (basket is null)
            {
                _logger.LogInformation("Attempted to update quantity for non-existent item: {@ProductId} in basket for userId: {@UserId}, sessionId: {@SessionId}", productId, userId, sessionId);
                return NotFound();
            }
            _logger.LogInformation("Item quantity updated for userId: {@UserId}, sessionId: {@SessionId}, productId: {@ProductId}, newQuantity: {@NewQuantity}", userId, sessionId, productId, request.Quantity);
            return Ok(basket);
        }

        [HttpDelete("items/{productId}")]
        public async Task<IActionResult> RemoveItem(string productId)
        {
            var userId = GetUserId();
            var sessionId = GetSessionId();
            _logger.LogInformation("Attempting to remove item from basket for userId: {@UserId}, sessionId: {@SessionId}, productId: {@ProductId}", userId, sessionId, productId);
            var removed = await _cartService.RemoveItemAsync(userId, sessionId, productId);
            _logger.LogInformation("Item removal result for userId: {@UserId}, sessionId: {@SessionId}, productId: {@ProductId}: {@Removed}", userId, sessionId, productId, removed);
            return removed ? NoContent() : NotFound();
        }

        [HttpPost("submit-for-quote")]
        [Authorize]
        public async Task<IActionResult> SubmitForQuote()
        {
            var userId = GetUserId();
            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized();
            }

            var sessionId = GetSessionId();
            var basket = await _cartService.GetBasketAsync(userId, sessionId);
            if (basket is null || basket.Items.Count == 0)
            {
                _logger.LogInformation("Attempted to submit for quote with an empty or missing basket for userId: {@UserId}", userId);
                return BadRequest("Your basket is empty.");
            }

            var user = await _userManager.FindByIdAsync(userId);
            if (user is null)
            {
                return Unauthorized();
            }

            var request = new CreateRfqRequest
            {
                LineItems = basket.Items.Select(item => new CreateRfqLineItem
                {
                    SeriesId = item.SeriesId,
                    ProductId = item.ProductId,
                    ProductDescription = item.ProductDescription,
                    Quantity = item.Quantity,
                    PictureUrl = item.PictureUrl
                }).ToList()
            };

            var rfq = await _rfqService.CreateRfq(userId, $"{user.FirstName} {user.LastName}", user.Email, user.CompanyName, request);
            await _cartService.DeleteBasketAsync(userId, sessionId);
            _logger.LogInformation("Basket submitted for quote as {@QuoteRequestId} for userId: {@UserId}", rfq.QuoteRequestId, userId);
            return Ok(rfq);
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteBasket()
        {
            var userId = GetUserId();
            var sessionId = GetSessionId();
            _logger.LogInformation("Attempting to delete basket for userId: {@UserId}, sessionId: {@SessionId}", userId, sessionId);
            var deleted = await _cartService.DeleteBasketAsync(userId, sessionId);
            _logger.LogInformation("Basket deletion result for userId: {@UserId}, sessionId: {@SessionId}: {@Deleted}", userId, sessionId, deleted);
            return deleted ? NoContent() : NotFound();
        }
    }
}
