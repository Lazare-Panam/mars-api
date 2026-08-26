using Mars.API.EntityConfigurations;
using Mars.API.Models.Auth;
using Mars.API.Models.Basket;
using Mars.API.Models.User;
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
        public DbSet<Enquiry> Enquiry => Set<Enquiry>();
        public DbSet<QuoteRequest> QuoteRequests => Set<QuoteRequest>();
        public DbSet<QuoteRequestItem> QuoteRequestItems => Set<QuoteRequestItem>();    
        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);
            builder.ApplyConfiguration(new CustomerBasketConfiguration());
            builder.ApplyConfiguration(new BasketItemConfiguration());
            builder.ApplyConfiguration(new EnquiryConfiguration());
            builder.ApplyConfiguration(new QuoteRequestConfiguration());
            builder.ApplyConfiguration(new QuoteRequestItemConfiguration());
        }
    }
}
