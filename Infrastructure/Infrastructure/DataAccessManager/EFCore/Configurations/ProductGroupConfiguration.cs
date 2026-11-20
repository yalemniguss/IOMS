using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Common;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using static Domain.Common.Constants;

namespace Infrastructure.DataAccessManager.EFCore.Configurations;

public class ProductGroupConfiguration : BaseEntityConfiguration<ProductGroup>
{
    public override void Configure(EntityTypeBuilder<ProductGroup> builder)
    {
        base.Configure(builder);

        builder.Property(x => x.CompanyId).IsRequired();
        builder.HasIndex(x => x.CompanyId);
        builder.HasOne(x => x.Company)
               .WithMany()
               .HasForeignKey(x => x.CompanyId)
               .OnDelete(Microsoft.EntityFrameworkCore.DeleteBehavior.Restrict);

        builder.Property(x => x.Name).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.Description).HasMaxLength(DescriptionConsts.MaxLength).IsRequired(false);

        builder.HasIndex(e => e.Name);
    }
}

