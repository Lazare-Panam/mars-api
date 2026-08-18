using Mars.API.Models.Auth;
using Mars.API.Models.Basket;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Mars.API.EntityConfigurations
{
    public class CustomerBasketConfiguration : IEntityTypeConfiguration<CustomerBasket>
    {
        public void Configure(EntityTypeBuilder<CustomerBasket> builder)
        {
            builder.HasKey(cb => cb.CustomerBasketId);

            builder.Property(cb => cb.CustomerBasketId)
                .HasMaxLength(450)
                .IsRequired();

            builder.Property(cb => cb.UserId)
                .HasMaxLength(450)
                .IsRequired(false);

            builder.Property(cb => cb.SessionId)
                .HasMaxLength(450);

            builder.Property(cb => cb.CreatedAt)
                .IsRequired();

            builder.Property(cb => cb.UpdatedAt)
                .IsRequired();

            builder.HasIndex(cb => new { cb.CustomerBasketId, cb.UserId });

            builder.HasOne<ApplicationUser>()
                .WithMany()
                .HasForeignKey(cb => cb.UserId)
                .OnDelete(DeleteBehavior.SetNull);

            builder.HasMany(cb => cb.Items)
                .WithOne(bi => bi.CustomerBasket)
                .HasForeignKey(bi => bi.CustomerBasketId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
