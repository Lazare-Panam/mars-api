namespace Mars.API.Repository.Interfaces
{   
    public interface INoSQLRepository<T>
    {
        /// <summary>
        /// Retrieves an entity by its identifier.
        /// </summary>
        /// <param name="id">The entity identifier.</param>
        /// <returns>The entity with the specified identifier, or null if no entity is found.</returns>
        Task<T?> GetByIdAsync(string id, CancellationToken ct);
    }
}
