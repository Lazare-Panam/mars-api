using Mars.API.Models.User;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Mars.API.EntityConfigurations
{
    public class CreditLineApplicationConfiguration : IEntityTypeConfiguration<CreditLineApplication>
    {
        public void Configure(EntityTypeBuilder<CreditLineApplication> builder)
        {
            builder.ToTable("CreditLineApplications");
            builder.HasKey(e => e.ApplicationId);

            // 1. Company Details — lengths kept in step with CreditLineApplicationValidator.
            builder.Property(e => e.CompanyName).IsRequired().HasMaxLength(200);
            builder.Property(e => e.RegistrationNumber).IsRequired().HasMaxLength(50);
            builder.Property(e => e.VatNumber).HasMaxLength(50);
            builder.Property(e => e.AddressLine1).IsRequired().HasMaxLength(200);
            builder.Property(e => e.AddressLine2).HasMaxLength(200);
            builder.Property(e => e.Website).HasMaxLength(200);
            builder.Property(e => e.Sector).IsRequired().HasMaxLength(150);
            builder.Property(e => e.YearsInBusiness).IsRequired().HasMaxLength(50);
            builder.Property(e => e.Employees).HasMaxLength(50);

            // 2. Primary Contact
            builder.Property(e => e.ContactName).IsRequired().HasMaxLength(150);
            builder.Property(e => e.JobTitle).IsRequired().HasMaxLength(150);
            builder.Property(e => e.Email).IsRequired().HasMaxLength(200);
            builder.Property(e => e.Phone).IsRequired().HasMaxLength(50);

            // 3. Credit Request
            builder.Property(e => e.CreditLimitRequested).IsRequired().HasPrecision(12, 2);
            builder.Property(e => e.PaymentTerms).IsRequired().HasMaxLength(100);
            builder.Property(e => e.Currency).IsRequired().HasMaxLength(3);
            builder.Property(e => e.MonthlyOrderValue).IsRequired().HasPrecision(12, 2);
            builder.Property(e => e.Products).HasMaxLength(400);

            // 4. Declaration & Signature
            builder.Property(e => e.SignatoryName).IsRequired().HasMaxLength(150);
            builder.Property(e => e.SignatoryTitle).IsRequired().HasMaxLength(150);
            builder.Property(e => e.Signature).IsRequired().HasMaxLength(150);
            builder.Property(e => e.DeclarationDate).IsRequired();
            builder.Property(e => e.DeclarationAccepted).IsRequired();

            // Audit / workflow
            builder.Property(e => e.SubmittedAtUtc).IsRequired();
            // Stored as text so reordering the enum can never silently remap existing rows.
            builder.Property(e => e.Status)
                .IsRequired()
                .HasConversion<string>()
                .HasMaxLength(20);

            // Computed, getter-only — not a column.
            builder.Ignore(e => e.IsApproved);

            builder.HasIndex(e => e.Status);
            builder.HasIndex(e => e.SubmittedAtUtc);
        }
    }
}
