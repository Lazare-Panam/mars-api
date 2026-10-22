using Mars.API.Models.SeriesProducts.Dtos;

namespace Mars.API.Services.Interfaces
{
    public interface ISeriesProductService
    {
        Task<IReadOnlyList<CategoryDto>> GetCategoriesAsync(CancellationToken ct);

        // Returns null if the category does not exist.
        Task<IReadOnlyList<CategoryFilterDto>?> GetCategoryFiltersAsync(int categoryId, CancellationToken ct);

        // Returns null if the category does not exist. Optional faceted filtering:
        // each (filterName -> value) pair must be matched (AND) by the product.
        Task<IReadOnlyList<CatalogProductDto>?> GetProductsAsync(int categoryId, IReadOnlyDictionary<string, string>? filters, CancellationToken ct);

        Task<CatalogProductDto?> GetProductByPartNumberAsync(string partNumber, CancellationToken ct);

        // Server-side configurator: given the current selection, returns the option
        // availability + the single resolved product (when the selection narrows to one),
        // so the client never downloads the whole product list. Null if category missing.
        Task<ConfiguratorStateDto?> GetConfiguratorStateAsync(int categoryId, IReadOnlyDictionary<string, string> selection, CancellationToken ct);
    }
}
