using Mars.API.Models.User;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Mars.API.EntityConfigurations
{
    public class EnquiryConfiguration : IEntityTypeConfiguration<Enquiry>
    {
        public void Configure(EntityTypeBuilder<Enquiry> builder)
        {
            builder.ToTable("Enquiries");
            builder.HasKey(e => e.Id);

            builder.Property(e => e.UserName).IsRequired().HasMaxLength(200);
            builder.Property(e => e.UserEmail).IsRequired().HasMaxLength(320);
            builder.Property(e => e.UserCompany).IsRequired().HasMaxLength(200);
            builder.Property(e => e.UserCountry).HasMaxLength(100);
            builder.Property(e => e.Message).IsRequired().HasMaxLength(4000);
            builder.Property(e => e.CreatedAtUtc).IsRequired();

            builder.HasIndex(e => e.CreatedAtUtc);
        }
    }
}
