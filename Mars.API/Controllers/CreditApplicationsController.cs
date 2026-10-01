using Mars.API.Models.Auth;
using Mars.API.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace Mars.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize(Roles = Roles.Admin)]
    public class CreditApplicationsController : ControllerBase
    {
        private readonly ICreditApplicationService _creditApplicationService;
        private readonly ILogger<CreditApplicationsController> _logger;

        public CreditApplicationsController(
            ICreditApplicationService creditApplicationService,
            ILogger<CreditApplicationsController> logger)
        {
            _creditApplicationService = creditApplicationService;
            _logger = logger;
        }

        [HttpGet]
        public async Task<IActionResult> GetAll()
        {
            var applications = await _creditApplicationService.GetAllApplicationsAsync();
            return Ok(applications);
        }

        [HttpGet("{id:int}")]
        public async Task<IActionResult> GetById(int id)
        {
            var application = await _creditApplicationService.GetApplicationByIdAsync(id);
            if (application is null)
            {
                _logger.LogInformation("Credit application {ApplicationId} not found", id);
                return NotFound(new { message = $"Credit application {id} not found." });
            }
            return Ok(application);
        }
    }
}
