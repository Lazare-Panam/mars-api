using Azure.Identity;
using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using Mars.API.Repository.NoSQL;
using Mars.API.Services.Interfaces;
using Mars.API.Services.Products;
using Mars.API.Settings;
using Microsoft.ApplicationInsights.AspNetCore.Extensions;
using Microsoft.Extensions.Logging.ApplicationInsights;
using Microsoft.Extensions.Options;
using MongoDB.Driver;
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
builder.Services.Configure<MongoDbSettings>(builder.Configuration.GetSection(nameof(MongoDbSettings)));
builder.Services.AddOptionsWithValidateOnStart<MongoDbSettings>()
    .Bind(builder.Configuration.GetSection(nameof(MongoDbSettings)))
    .Validate(settings =>
        !string.IsNullOrWhiteSpace(settings.ConnectionString) &&
        !string.IsNullOrWhiteSpace(settings.DatabaseName),
        "MongoDbSettings: ConnectionString and DatabaseName must be set.");
builder.Services.AddSingleton<IMongoDatabase>(sp =>
{
    var settings = sp.GetRequiredService<IOptions<MongoDbSettings>>().Value;
    return new MongoClient(settings.ConnectionString).GetDatabase(settings.DatabaseName);
});
builder.Services.AddScoped<INoSQLRepository<ProductCatalog>, ProductCatalogRepository>();
builder.Services.AddScoped<INoSQLRepository<ProductDetail>, ProductDetailRepository>();
builder.Services.AddScoped<INoSQLRepository<ProductSeriesVariants>, ProductVariantRepository>();
builder.Services.AddProblemDetails();
builder.Services.AddExceptionHandler<GlobalExceptionHandler>();

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
              .WithMethods("GET")
               .AllowAnyHeader();
    });
});
builder.Services.AddScoped<IProductService, ProductService>();
var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.UseHttpsRedirection();
app.UseCors("MarsPolicy");
app.UseAuthorization();
app.MapControllers();

app.Run();