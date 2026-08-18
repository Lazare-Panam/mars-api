using Mars.API.Models.Basket;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Mars.API.EntityConfigurations
{
    public class BasketItemConfiguration : IEntityTypeConfiguration<BasketItem>
    {
        public void Configure(EntityTypeBuilder<BasketItem> builder)
        {
            builder.HasKey(bi => bi.Id);

            builder.Property(bi => bi.Id)
                .HasMaxLength(450)
                .IsRequired();

            builder.Property(bi => bi.ProductId)
                .HasMaxLength(100)
                .IsRequired();

            builder.Property(bi => bi.ProductDescription)
                .HasMaxLength(500)
                .IsRequired();

            builder.Property(bi => bi.UnitPrice)
                .HasColumnType("decimal(18,2)")
                .IsRequired();

            builder.Property(bi => bi.Quantity)
                .IsRequired();

            builder.Property(bi => bi.PictureUrl)
                .HasMaxLength(2048);

            builder.Property(bi => bi.CustomerBasketId)
                .HasMaxLength(450)
                .IsRequired();
        }
    }
}
