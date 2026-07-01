namespace Mars.API.Repository.Interfaces
{   
    public interface INoSQLRepository<T>
    {
        Task<T?> GetByIdAsync(string id);
    }
}
