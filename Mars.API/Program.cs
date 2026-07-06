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
builder.Services.Configure<MongoDbSettings>(builder.Configuration.GetSection(nameof(MongoDbSettings))); builder.Services.AddSingleton<IMongoDatabase>(sp =>
{
    var settings = sp.GetRequiredService<IOptions<MongoDbSettings>>().Value;
    return new MongoClient(settings.ConnectionString).GetDatabase(settings.DatabaseName);
}); 
builder.Services.AddCors(options =>
{
    options.AddPolicy("MarsPolicy", policy =>
    {
        policy.WithOrigins("http://localhost:3000")
              .AllowAnyMethod()
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