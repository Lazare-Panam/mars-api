using FluentValidation;
using Mars.API.Models.Basket;
using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.JsonWebTokens;

namespace Mars.API.Controllers
{
    /// <summary>
    /// The signed-in user's saved cart (shown under My Account). The cart page lives in the
    /// browser; "Save Cart" sends its items here with <c>POST /api/basket</c>.
    /// </summary>
    [ApiController]
    [Route("api/basket")]
    [Authorize]
    public class BasketController : ControllerBase
    {
        private readonly ILogger<BasketController> _logger;
        private readonly ICartService _cartService;
        public BasketController(ILogger<BasketController> logger, ICartService cartService)
        {
            _logger = logger;
            _cartService = cartService;
        }

        // [Authorize] guarantees a signed-in user; the id comes from the token's "sub" claim.
        private string GetUserId() => User.FindFirst(JwtRegisteredClaimNames.Sub)?.Value
            ?? throw new InvalidOperationException("Authenticated request without a sub claim.");

        private IActionResult ValidationFailed(FluentValidation.Results.ValidationResult result)
        {
            foreach (var error in result.Errors)
            {
                ModelState.AddModelError(error.PropertyName, error.ErrorMessage);
            }
            return ValidationProblem(ModelState);
        }

        [HttpGet]
        public async Task<IActionResult> GetBasket()
        {
            var userId = GetUserId();
            var basket = await _cartService.GetBasketAsync(userId);

            // Always the same shape: a user without a saved cart gets an empty one (not saved).
            return Ok(basket ?? new CustomerBasket(userId) { CustomerBasketId = string.Empty });
        }

        /// <summary>
        /// Saves items into the user's saved cart. Items already saved have their quantities
        /// increased; new items are added. Prices always come from the catalogue.
        /// </summary>
        [HttpPost]
        public async Task<IActionResult> SaveBasket([FromBody] SaveBasketRequest request, [FromServices] IValidator<SaveBasketRequest> validator)
        {
            var validationResult = await validator.ValidateAsync(request);
            if (!validationResult.IsValid)
            {
                return ValidationFailed(validationResult);
            }

            var basket = await _cartService.AddItemsAsync(GetUserId(), request.Items);
            return Ok(basket);
        }

        [HttpPut("items/{productId}")]
        public async Task<IActionResult> UpdateQuantity(string productId, [FromBody] UpdateQuantityRequest request, [FromServices] IValidator<UpdateQuantityRequest> validator)
        {
            var validationResult = await validator.ValidateAsync(request);
            if (!validationResult.IsValid)
            {
                return ValidationFailed(validationResult);
            }

            var basket = await _cartService.UpdateItemQuantityAsync(GetUserId(), productId, request.Quantity);
            return basket is null ? NotFound() : Ok(basket);
        }

        [HttpDelete("items/{productId}")]
        public async Task<IActionResult> RemoveItem(string productId)
        {
            var removed = await _cartService.RemoveItemAsync(GetUserId(), productId);
            return removed ? NoContent() : NotFound();
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteBasket()
        {
            var deleted = await _cartService.DeleteBasketAsync(GetUserId());
            return deleted ? NoContent() : NotFound();
        }
    }
}
