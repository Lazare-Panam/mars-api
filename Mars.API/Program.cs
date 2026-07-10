using Mars.API.Repository.Interfaces;
using Mars.API.Repository.NoSQL;
using Mars.API.Services.Interfaces;
using Mars.API.Services.Products;
using Mars.API.Settings;
using Microsoft.Extensions.Options;
using MongoDB.Driver;
using Azure.Identity;
using Microsoft.Extensions.Logging.ApplicationInsights;
using Microsoft.ApplicationInsights.AspNetCore.Extensions;
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
var policyName = "MarsPolicy";
var allowedOrigins = builder.Configuration.GetSection("AllowedOrigins").Get<string[]>() ?? new[] { "http://localhost:3000" };
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: policyName, policy =>
    {
        policy.WithOrigins(allowedOrigins)
              .WithMethods("GET")
               .AllowAnyHeader();
    });
});
builder.Services.AddScoped<IProductCatalogRepository, ProductCatalogRepository>();
builder.Services.AddScoped<IProductDetailRepository, ProductDetailRepository>();
builder.Services.AddScoped<IProductVariantRepository, ProductVariantRepository>();
builder.Services.AddScoped<IProductService, ProductService>();
var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("MarsPolicy");
app.UseAuthorization();
app.MapControllers();

app.Run();