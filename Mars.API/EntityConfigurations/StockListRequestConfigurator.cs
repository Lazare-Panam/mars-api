using Microsoft.EntityFrameworkCore;
using Mars.API.Models.User;
namespace Mars.API.EntityConfigurations
{
    public class StockListRequestConfigurator : IEntityTypeConfiguration<StockListRequest>
    {
        public void Configure(Microsoft.EntityFrameworkCore.Metadata.Builders.EntityTypeBuilder<StockListRequest> builder)
        {
            builder.HasKey(s => s.Id);
            builder.Property(s => s.Name).IsRequired().HasMaxLength(100);
            builder.Property(s => s.Email).IsRequired().HasMaxLength(100);
            builder.Property(s => s.Phone).IsRequired().HasMaxLength(20);
        }
    }
}
