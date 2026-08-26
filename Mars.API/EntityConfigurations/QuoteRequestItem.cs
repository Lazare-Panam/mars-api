using Mars.API.Models.Basket;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
namespace Mars.API.EntityConfigurations
{
    public class QuoteRequestItemConfiguration : IEntityTypeConfiguration<QuoteRequestItem>
    {
        public void Configure(EntityTypeBuilder<QuoteRequestItem> builder)
        {
            builder.HasKey(qri => qri.Id);

            builder.Property(qri => qri.Id)
                .HasMaxLength(450)
                .IsRequired();

            builder.Property(qri => qri.ProductId)
                .HasMaxLength(100)
                .IsRequired();

            builder.Property(qri => qri.ProductDescription)
                .HasMaxLength(500)
                .IsRequired();

            builder.Property(qri => qri.Quantity)
                .IsRequired();

            builder.Property(qri => qri.PictureUrl)
                .HasMaxLength(2048);

            builder.Property(qri => qri.QuoteRequestId)
                .HasMaxLength(450)
                .IsRequired();
        }
    }
}
