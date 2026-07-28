using Azure.Communication.Email;
using Azure.Identity;
using Mars.API.Models.Auth;
using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using Mars.API.Repository.NoSQL;
using Mars.API.Repository.SQL;
using Mars.API.Services.Auth;
using Mars.API.Services.Interfaces;
using Mars.API.Services.Notification;
using Mars.API.Services.Products;
using Mars.API.Settings;
using Microsoft.ApplicationInsights.AspNetCore.Extensions;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging.ApplicationInsights;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.JsonWebTokens;
using Microsoft.IdentityModel.Tokens;
using MongoDB.Driver;
using System.Text;
var builder = WebApplication.CreateBuilder(args);
builder.Services.AddApplicationInsightsTelemetry();
builder.Services.AddLogging(log => 
{
    log.AddApplicationInsights();
    log.AddFilter<ApplicationInsightsLoggerProvider>("", LogLevel.Information);
});
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

builder.Services.AddOptions<JwtSettings>().Bind(builder.Configuration.GetSection(nameof(JwtSettings)));
var jwtSettings = builder.Configuration.GetSection("JwtSettings");
var key = Encoding.UTF8.GetBytes(jwtSettings["Key"]!);
if(key.Length<32)
{
    throw new InvalidOperationException("JWT Key must be at least 32 bytes long for security reasons.");
}
builder.Services
.AddAuthentication(options =>
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
});

builder.Services.AddAuthorization();
builder.Services.AddSingleton<IMongoClient>(sp =>
{
    var settings = sp.GetRequiredService<IOptions<MongoDbSettings>>().Value;
    return new MongoClient(settings.ConnectionString);
});
builder.Services.AddScoped<IMongoDatabase>(sp =>
{
    var settings = sp.GetRequiredService<IOptions<MongoDbSettings>>().Value;
    return sp.GetRequiredService<IMongoClient>().GetDatabase(settings.DatabaseName);
});
builder.Services.AddOptions<EmailSettings>().Bind(builder.Configuration.GetSection(nameof(EmailSettings)));
var emailConnectionString = builder.Configuration["EmailSettings:ConnectionString"];
builder.Services.AddSingleton(new EmailClient(emailConnectionString));
builder.Services.AddScoped<INoSQLRepository<ProductCatalog>, ProductCatalogRepository>();
builder.Services.AddScoped<INoSQLRepository<ProductDetail>, ProductDetailRepository>();
builder.Services.AddScoped<INoSQLRepository<ProductSeriesVariants>, ProductVariantRepository>();
builder.Services.AddScoped<IEmailService, EmailService>();
builder.Services.AddScoped<IEmailTemplateService, EmailTemplateService>();
builder.Services.AddScoped<INotificationService, NotificationService>();
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddExceptionHandler<GlobalExceptionHandler>();
builder.Services.AddIdentity<ApplicationUser, IdentityRole>().AddEntityFrameworkStores<ApplicationDBContext>().AddDefaultTokenProviders();
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
               .AllowAnyHeader();
    });
});
builder.Services.AddScoped<IProductService, ProductService>();
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
}
app.UseSwagger();
app.UseSwaggerUI();
app.UseCors("MarsPolicy");
app.UseAuthentication();
app.UseAuthorization();
app.UseHttpsRedirection();
app.UseStatusCodePages();
app.MapControllers();

app.Run();