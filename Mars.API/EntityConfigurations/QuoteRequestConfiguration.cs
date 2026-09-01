using Mars.API.Models.Auth;
using Mars.API.Models.Basket;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;

namespace Mars.API.EntityConfigurations
{
    public class QuoteRequestConfiguration : IEntityTypeConfiguration<QuoteRequest>
    {
        public void Configure(EntityTypeBuilder<QuoteRequest> builder)
        {
            builder.HasKey(qr => qr.QuoteRequestId);

            builder.Property(qr => qr.QuoteRequestId)
                .HasMaxLength(450)
                .IsRequired();

            builder.Property(qr => qr.UserId)
                .HasMaxLength(450)
                .IsRequired(false);

            builder.Property(qr => qr.CreatedAt)
                .IsRequired();

            builder.Property(qr => qr.UpdatedAt)
                .IsRequired();

            builder.HasIndex(qr => new { qr.QuoteRequestId, qr.UserId });

            builder.HasOne<ApplicationUser>()
                .WithMany()
                .HasForeignKey(qr => qr.UserId)
                .OnDelete(DeleteBehavior.SetNull);

            builder.HasMany(qr => qr.Items)
                .WithOne(bi => bi.QuoteRequest)
                .HasForeignKey(bi => bi.QuoteRequestId)
                .OnDelete(DeleteBehavior.Cascade);
        }
    }
}
