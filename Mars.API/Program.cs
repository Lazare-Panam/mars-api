using Azure.Communication.Email;
using Azure.Identity;
using Azure.Messaging.ServiceBus;
using FluentValidation;
using Mars.API.MessageQueues;
using Mars.API.Models.Auth;
using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using Mars.API.Repository.NoSQL;
using Mars.API.Repository.SQL;
using Mars.API.Services.Auth;
using Mars.API.Services.Interfaces;
using Mars.API.Services.Notification;
using Mars.API.Services.Products;
using Mars.API.Services.SeriesProducts;
using Mars.API.Services.User;
using Mars.API.Services.Search;
using Mars.API.Settings;
using Meilisearch;
using Microsoft.ApplicationInsights.AspNetCore.Extensions;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.ApplicationInsights;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.JsonWebTokens;
using Microsoft.IdentityModel.Tokens;
using MongoDB.Driver;
using Polly;
using Polly.Retry;
using Serilog;
using System.Text;
using System.Threading.RateLimiting;
Log.Logger = new LoggerConfiguration().WriteTo.Console().CreateBootstrapLogger();

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSerilog((services, lc) => lc
        .ReadFrom.Configuration(builder.Configuration)
        .ReadFrom.Services(services));
builder.Services.AddApplicationInsightsTelemetry();
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddDbContext<ApplicationDBContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddOptionsWithValidateOnStart<MongoDbSettings>().Bind(builder.Configuration.GetSection(nameof(MongoDbSettings)))
    .Validate(settings =>
        !string.IsNullOrWhiteSpace(settings.ConnectionString) &&
        !string.IsNullOrWhiteSpace(settings.DatabaseName),
        "MongoDbSettings: ConnectionString and DatabaseName must be set.");

builder.Services.AddOptionsWithValidateOnStart<JwtSettings>().Bind(builder.Configuration.GetSection(nameof(JwtSettings)))
    .Validate(settings =>
        !string.IsNullOrWhiteSpace(settings.Key) &&
        !string.IsNullOrWhiteSpace(settings.Issuer) &&
        !string.IsNullOrWhiteSpace(settings.Audience),
        "JwtSettings: Key, Issuer, and Audience must be set.");

var jwtSettings = builder.Configuration.GetSection("JwtSettings");
var key = Encoding.UTF8.GetBytes(jwtSettings["Key"]!);
if(key.Length<32)
{
    throw new InvalidOperationException("JWT Key must be at least 32 bytes long for security reasons.");
}


builder.Services.AddAuthorization();
builder.Services.AddSingleton<IMongoClient>(sp =>
{
    var settings = sp.GetRequiredService<IOptions<MongoDbSettings>>().Value;
    return new MongoClient(settings.ConnectionString);
});
builder.Services.AddSingleton<IMongoDatabase>(sp =>
{
    var settings = sp.GetRequiredService<IOptions<MongoDbSettings>>().Value;
    return sp.GetRequiredService<IMongoClient>().GetDatabase(settings.DatabaseName);
});
builder.Services.AddOptions<EmailSettings>().Bind(builder.Configuration.GetSection(nameof(EmailSettings)));
var emailConnectionString = builder.Configuration["EmailSettings:ConnectionString"];
builder.Services.AddValidatorsFromAssemblyContaining<Program>();
builder.Services.AddSingleton(new EmailClient(emailConnectionString));
builder.Services.AddScoped<INoSQLRepository<ProductCatalog>, ProductCatalogRepository>();
builder.Services.AddScoped<INoSQLRepository<ProductDetail>, ProductDetailRepository>();
builder.Services.AddScoped<IProductVariantRepository, ProductVariantRepository>();
builder.Services.AddScoped<IEmailService, EmailService>();
builder.Services.AddScoped<IEmailTemplateService, EmailTemplateService>();
builder.Services.AddScoped<INotificationService, NotificationService>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<IStockProductRepository, StockProductRepository>();
builder.Services.AddScoped<IRfqService, RfqService>();
builder.Services.AddScoped<ICreditApplicationService, CreditApplicationService>();
builder.Services.AddScoped<IStockListService, StockListService>();
builder.Services.AddOptions<TurnstileSettings>().Bind(builder.Configuration.GetSection(nameof(TurnstileSettings)));
builder.Services.AddHttpClient<ITurnstileService, TurnstileService>();

// Meilisearch: bind settings, register the client as a singleton (stateless, wraps one
// HttpClient — reuse process-wide), and the search service as scoped (it depends on the
// scoped ApplicationDBContext, so singleton would be a captive dependency).
builder.Services.AddOptions<MeilisearchSettings>().Bind(builder.Configuration.GetSection(nameof(MeilisearchSettings)));
builder.Services.AddSingleton(sp =>
{
    var s = sp.GetRequiredService<IOptions<MeilisearchSettings>>().Value;
    return new MeilisearchClient(s.Host, s.ApiKey);
});
builder.Services.AddScoped<ISearchService, SearchService>();

builder.Services.AddRateLimiter(options =>
{
    // Blocked callers get 429 Too Many Requests (not the default 503).
    options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;

    // Named policy applied ONLY to the enquiry endpoint via [EnableRateLimiting("enquiry")].
    // Partition per client IP: each IP gets its own 5-per-minute bucket.
    options.AddPolicy("enquiry", httpContext =>
        RateLimitPartition.GetFixedWindowLimiter(
            partitionKey: httpContext.Connection.RemoteIpAddress?.ToString() ?? "unknown",
            factory: _ => new FixedWindowRateLimiterOptions
            {
                AutoReplenishment = true,
                PermitLimit = 5,
                QueueLimit = 0,
                Window = TimeSpan.FromMinutes(1)
            }));

    // Public search endpoint: a looser 30-per-minute-per-IP bucket, applied via
    // [EnableRateLimiting("search")] on SearchController's GET.
    options.AddPolicy("search", httpContext =>
        RateLimitPartition.GetFixedWindowLimiter(
            partitionKey: httpContext.Connection.RemoteIpAddress?.ToString() ?? "unknown",
            factory: _ => new FixedWindowRateLimiterOptions
            {
                AutoReplenishment = true,
                PermitLimit = 30,
                QueueLimit = 0,
                Window = TimeSpan.FromMinutes(1)
            }));
});
builder.Services.AddExceptionHandler<GlobalExceptionHandler>();
builder.Services.AddResiliencePipeline("azureServiceBus", builder =>
{
    builder.AddRetry(new RetryStrategyOptions 
    {
        MaxRetryAttempts = 3,
        BackoffType = DelayBackoffType.Exponential,
        UseJitter = true
    }).AddTimeout(TimeSpan.FromSeconds(10));
});

builder.Services.AddIdentity<ApplicationUser, IdentityRole>().AddEntityFrameworkStores<ApplicationDBContext>().AddDefaultTokenProviders();
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.MapInboundClaims = false;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = jwtSettings["Issuer"],
        ValidAudience = jwtSettings["Audience"],
        IssuerSigningKey = new SymmetricSecurityKey(key),
        ClockSkew = TimeSpan.Zero,
        NameClaimType = JwtRegisteredClaimNames.Name,
        RoleClaimType = "role"
    };
    options.Events = new JwtBearerEvents
    {
        OnMessageReceived = context =>
        {
            var header = context.Request.Headers.Authorization.ToString();
            if (string.IsNullOrEmpty(header))
            {
                Log.Information("No JWT Authorization header attached");
            }
            else 
            {
                Log.Information("JWT Authorization header attached");
            }
            return Task.CompletedTask;
        },
        OnAuthenticationFailed = context =>
        {
            Log.Error(context.Exception, "JWT Authentication failed");
            return Task.CompletedTask;
        },
        OnTokenValidated = context =>
        {
            Log.Information("JWT Token claims attached");
            return Task.CompletedTask;
        }
    };
});

builder.Services.AddProblemDetails(options =>
{
    options.CustomizeProblemDetails = ctx =>
    {
        ctx.ProblemDetails.Extensions["traceId"] = ctx.HttpContext.TraceIdentifier;
        ctx.ProblemDetails.Extensions["timestamp"] = DateTime.UtcNow;
        ctx.ProblemDetails.Instance = $"{ctx.HttpContext.Request.Method} {ctx.HttpContext.Request.Path}";
    };
});
var policyName = "MarsPolicy";
var allowedOrigins = builder.Configuration.GetSection("Cors:AllowedOrigins").Get<string[]>();
if(allowedOrigins is null || allowedOrigins.Length == 0)
{
    throw new InvalidOperationException("AllowedOrigins configuration is missing or empty.");
}
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: policyName, policy =>
    {
        policy.WithOrigins(allowedOrigins)
              .WithMethods("GET", "POST", "PUT", "DELETE")
               .AllowAnyHeader()
               .AllowCredentials();
    });
});
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromDays(7);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
    options.Cookie.SameSite = SameSiteMode.None;
    options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
});
builder.Services.AddOptions<MeilisearchSettings>().Bind(builder.Configuration.GetSection(nameof(MeilisearchSettings)));
builder.Services.AddSingleton(sp =>
{
    var s = sp.GetRequiredService<IOptions<MeilisearchSettings>>().Value;
    return new MeilisearchClient(s.Host, s.ApiKey);
});
builder.Services.AddScoped<ICartService, CartService>();
builder.Services.AddScoped<IProductService, ProductService>();
builder.Services.AddScoped<ISeriesProductService, SeriesProductService>();
builder.Services.Configure<ServiceBusSettings>(builder.Configuration.GetSection("ServiceBusSettings"));

builder.Services.AddSingleton(sp =>
{
    var settings = sp.GetRequiredService<IOptions<ServiceBusSettings>>().Value;
    return new ServiceBusClient(settings.ConnectionString);
});

builder.Services.AddSingleton<IEnquiryPublisher, EnquiryPublisher>();
builder.Services.AddHostedService<EnquiryReceivedConsumer>();
var app = builder.Build();


using (var scope = app.Services.CreateScope())
{
    var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>();
    string[] roleNames = { "User", "Admin" }; // add whatever roles you need

    foreach (var roleName in roleNames)
    {
        if (!await roleManager.RoleExistsAsync(roleName))
        {
            await roleManager.CreateAsync(new IdentityRole(roleName));
        }
    }

    // Seed an initial admin from configuration (user-secrets / env), never hardcoded.
    // Idempotent: only created if an account with that email does not already exist.
    var userManager = scope.ServiceProvider.GetRequiredService<UserManager<ApplicationUser>>();
    var adminEmail = builder.Configuration["AdminSeed:Email"];
    var adminPassword = builder.Configuration["AdminSeed:Password"];

    if (!string.IsNullOrWhiteSpace(adminEmail) && !string.IsNullOrWhiteSpace(adminPassword)
        && await userManager.FindByEmailAsync(adminEmail) is null)
    {
        var admin = new ApplicationUser
        {
            UserName = adminEmail,          // login is by email in this app
            Email = adminEmail,
            EmailConfirmed = true,
            FirstName = "Site",
            LastName = "Admin",
            CompanyName = "Mars Valvenok",
            JobTitle = "Administrator",
            Country = "GB",
        };

        var created = await userManager.CreateAsync(admin, adminPassword);
        if (created.Succeeded)
        {
            await userManager.AddToRoleAsync(admin, Roles.Admin);
            Log.Information("Seeded admin user {UserId}", admin.Id);
        }
        else
        {
            Log.Error("Failed to seed admin user: {ErrorCodes}",
                string.Join("; ", created.Errors.Select(e => e.Code)));
        }
    }
}
app.UseSwagger();
app.UseSwaggerUI();
app.UseCors("MarsPolicy");
app.UseRateLimiter();
app.UseExceptionHandler();
app.UseAuthentication();
app.UseAuthorization();
app.UseSession();
app.UseHttpsRedirection();
app.UseStatusCodePages();
app.MapControllers();

app.Run();