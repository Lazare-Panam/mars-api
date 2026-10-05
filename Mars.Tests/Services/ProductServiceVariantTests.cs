using Mars.API.Models.Products;
using Mars.API.Repository.Interfaces;
using Mars.API.Services.Products;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Options;

namespace Mars.Tests.Services
{
    public class ProductServiceVariantTests
    {
        private const string SeriesId = "economical-two-piece-ball-valve";
        private const string VariantId = "V20-20-1-4IN-W-O-LOCK";

        private static ProductSeriesVariants Series() => new()
        {
            Id = SeriesId,
            Name = "Economical 2-Piece Ball Valve",
            ThumbnailImage = "https://example.com/series.png",
            Variants =
            [
                new ProductVariant
                {
                    Id = VariantId,
                    Specs = new Dictionary<string, string> { ["Size"] = "1/4 Inch", ["Price"] = "11.55" }
                },
                new ProductVariant
                {
                    Id = "V20-20-1-2IN-W-LOCK",
                    Specs = new Dictionary<string, string> { ["Size"] = "1/2 Inch" }
                }
            ]
        };

        private static ProductService CreateService(ProductSeriesVariants? series) =>
            CreateServiceWith(new FakeVariantRepository(series));

        private static ProductService CreateServiceWith(FakeVariantRepository repository) =>
            new(null!, null!, repository, null!, NewCache(), NullLogger<ProductService>.Instance);

        private static IDistributedCache NewCache() =>
            new MemoryDistributedCache(Options.Create(new MemoryDistributedCacheOptions()));

        [Fact]
        public async Task GetProductVariantAsync_ExistingVariant_ReturnsVariantWithSeriesInfo()
        {
            var service = CreateService(Series());

            var result = await service.GetProductVariantAsync(SeriesId, VariantId);

            Assert.NotNull(result);
            Assert.Equal(SeriesId, result.SeriesId);
            Assert.Equal("Economical 2-Piece Ball Valve", result.SeriesName);
            Assert.Equal("https://example.com/series.png", result.SeriesThumbnailImage);
            Assert.Equal(VariantId, result.Variant.Id);
            Assert.Equal("11.55", result.Variant.Specs["Price"]);
        }

        [Fact]
        public async Task GetProductVariantAsync_VariantWithoutPrice_ReturnsVariantWithoutPrice()
        {
            var service = CreateService(Series());

            var result = await service.GetProductVariantAsync(SeriesId, "V20-20-1-2IN-W-LOCK");

            Assert.NotNull(result);
            Assert.False(result.Variant.Specs.ContainsKey("Price"));
        }

        [Fact]
        public async Task GetProductVariantAsync_UnknownVariant_ReturnsNull()
        {
            var service = CreateService(Series());

            var result = await service.GetProductVariantAsync(SeriesId, "DOES-NOT-EXIST");

            Assert.Null(result);
        }

        [Fact]
        public async Task GetProductVariantAsync_UnknownSeries_ReturnsNull()
        {
            var service = CreateService(null);

            var result = await service.GetProductVariantAsync("unknown-series", VariantId);

            Assert.Null(result);
        }

        [Theory]
        [InlineData("", VariantId)]
        [InlineData(" ", VariantId)]
        [InlineData(SeriesId, "")]
        [InlineData(SeriesId, " ")]
        public async Task GetProductVariantAsync_EmptyIds_ReturnsNull(string id, string variantId)
        {
            var service = CreateService(Series());

            var result = await service.GetProductVariantAsync(id, variantId);

            Assert.Null(result);
        }

        private sealed class FakeVariantRepository(ProductSeriesVariants? series) : IProductVariantRepository
        {
            public int Calls { get; private set; }

            public Task<ProductSeriesVariants?> GetByIdAsync(string id, CancellationToken ct)
            {
                Calls++;
                return Task.FromResult(series is not null && series.Id == id ? series : null);
            }

            public Task<decimal?> GetPriceAsync(string seriesId, string variantId, CancellationToken ct = default) =>
                throw new NotImplementedException();

            public Task<Dictionary<(string SeriesId, string VariantId), decimal?>> GetPricesAsync(
                IEnumerable<(string SeriesId, string VariantId)> items, CancellationToken ct = default) =>
                throw new NotImplementedException();
        }
    }
}
