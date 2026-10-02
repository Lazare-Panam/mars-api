using FluentValidation;
using Mars.API.Models.Auth;
using Mars.API.Models.Basket;
using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.JsonWebTokens;

namespace Mars.API.Controllers
{
    /// <summary>
    /// The signed-in user's basket. Guests keep their cart in the browser and merge it in
    /// with <c>POST /api/basket/merge</c> after logging in.
    /// </summary>
    [ApiController]// can route be specified in controller itslef? 
    [Route("api/basket")]
    [Authorize]
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

            // Always the same shape: a user without a basket gets an empty one (not saved).
            return Ok(basket ?? new CustomerBasket(userId) { CustomerBasketId = string.Empty });
        }

        [HttpPost("items")]
        public async Task<IActionResult> AddToCart([FromBody] AddToCartRequest request, [FromServices] IValidator<AddToCartRequest> validator)
        {
            var validationResult = await validator.ValidateAsync(request);
            if (!validationResult.IsValid)
            {
                return ValidationFailed(validationResult);
            }

            var basket = await _cartService.AddOrUpdate(GetUserId(), request);
            return Ok(basket);
        }

        /// <summary>
        /// Merges a guest's browser cart into the user's basket after login. Quantities of items
        /// already in the basket are added together; prices come from the catalogue. Invalid
        /// items are skipped so one bad item doesn't block the rest of the cart.
        /// </summary>
        [HttpPost("merge")]
        public async Task<IActionResult> MergeBasket([FromBody] MergeBasketRequest request, [FromServices] IValidator<MergeBasketRequest> validator, [FromServices] IValidator<AddToCartRequest> itemValidator)
        {
            var validationResult = await validator.ValidateAsync(request);
            if (!validationResult.IsValid)
            {
                return ValidationFailed(validationResult);
            }

            var userId = GetUserId();
            var validItems = new List<AddToCartRequest>();
            foreach (var item in request.Items)
            {
                if ((await itemValidator.ValidateAsync(item)).IsValid)
                {
                    validItems.Add(item);
                }
                else
                {
                    _logger.LogWarning("Skipping invalid item {VariantId} while merging guest cart for user {UserId}", item.VariantId, userId);
                }
            }

            if (validItems.Count == 0)
            {
                var basket = await _cartService.GetBasketAsync(userId);
                return Ok(basket ?? new CustomerBasket(userId) { CustomerBasketId = string.Empty });
            }

            return Ok(await _cartService.AddItemsAsync(userId, validItems));
        }

        [HttpPut("items/{productId}")]
        public async Task<IActionResult> UpdateQuantity(string productId, [FromBody] UpdateQuantityRequest request, IValidator<UpdateQuantityRequest> validator)
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

        [HttpPost("submit-for-quote")]
        public async Task<IActionResult> SubmitForQuote([FromServices] IValidator<CreateRfqRequest> validator)
        {
            var userId = GetUserId();
            var basket = await _cartService.GetBasketAsync(userId);
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
            var validationResult = await validator.ValidateAsync(request);
            if (!validationResult.IsValid)
            {
                return ValidationFailed(validationResult);
            }

            var rfq = await _rfqService.CreateRfq(userId, $"{user.FirstName} {user.LastName}", user.Email, user.CompanyName, request);
            await _cartService.DeleteBasketAsync(userId);
            _logger.LogInformation("Basket submitted for quote as {@QuoteRequestId} for userId: {@UserId}", rfq.QuoteRequestId, userId);
            return Ok(rfq);
        }

        [HttpDelete]
        public async Task<IActionResult> DeleteBasket()
        {
            var deleted = await _cartService.DeleteBasketAsync(GetUserId());
            return deleted ? NoContent() : NotFound();
        }
    }
}
