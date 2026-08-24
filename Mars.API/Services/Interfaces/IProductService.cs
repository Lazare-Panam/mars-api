using Mars.API.Models.Products;

namespace Mars.API.Services.Interfaces
{
    public interface IProductService
    {
        /// <summary>
        /// Retrieves a product catalog by its id.
        /// </summary>
        /// <param name="id">The catalog id.</param>
        /// <param name="ct">Cancellation token.</param>
        /// <returns>The matching <see cref="ProductCatalog"/>, or <c>null</c> if <paramref name="id"/> is empty/whitespace or no catalog is found.</returns>
        Task<ProductCatalog?> GetCatalogByIdAsync(string id, CancellationToken ct = default);

        /// <summary>
        /// Retrieves the detail record for a product by its id.
        /// </summary>
        /// <param name="id">The product id.</param>
        /// <param name="ct">Cancellation token.</param>
        /// <returns>The matching <see cref="ProductDetail"/>, or <c>null</c> if <paramref name="id"/> is empty/whitespace or no detail is found.</returns>
        Task<ProductDetail?> GetProductDetailAsync(string id, CancellationToken ct = default);

        /// <summary>
        /// Retrieves the series variants for a product by id, applying pricing visibility rules
        /// based on the caller's authentication status.
        /// </summary>
        /// <param name="id">The product/series id.</param>
        /// <param name="isAuthenticated">Whether the current caller is authenticated; controls how much pricing is included.</param>
        /// <param name="ct">Cancellation token.</param>
        /// <returns>The matching <see cref="ProductSeriesVariants"/>, or <c>null</c> if <paramref name="id"/> is empty/whitespace or no variants are found.</returns>
        Task<ProductSeriesVariants?> GetProductVariantsAsync(string id, bool isAuthenticated, CancellationToken ct = default);
        /// <summary>
        /// 
        /// Retrieves all stock products.
        /// </summary>
        /// <param name="ct">Cancellation token.</param>
        /// <returns>The full set of stock <see cref="ProductDetail"/> records.</returns>
        Task<IEnumerable<ProductDetail>> GetStockProductsAsync(CancellationToken ct = default);
    }
}
