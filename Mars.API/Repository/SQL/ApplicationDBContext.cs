using Mars.API.EntityConfigurations;
using Mars.API.Models.Auth;
using Mars.API.Models.Basket;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Mars.API.Repository.SQL
{
    public class ApplicationDBContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDBContext(DbContextOptions<ApplicationDBContext> options) : base(options)
        {
           
        }
        public DbSet<RefreshToken> RefreshTokens => Set<RefreshToken>();
        public DbSet<CustomerBasket> CustomerBaskets => Set<CustomerBasket>();
        public DbSet<BasketItem> BasketItems => Set<BasketItem>();
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.ApplyConfiguration(new CustomerBasketConfiguration());
            modelBuilder.ApplyConfiguration(new BasketItemConfiguration());
        }
    }
}
