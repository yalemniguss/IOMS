using Domain.Entities;
using Domain.Enums;
using Infrastructure.DataAccessManager.EFCore.Common;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using static Domain.Common.Constants;

namespace Infrastructure.DataAccessManager.EFCore.Configurations;

public class CompanyConfiguration : BaseEntityConfiguration<Company>
{
    public override void Configure(EntityTypeBuilder<Company> builder)
    {
        base.Configure(builder);

        builder.Property(x => x.Name).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.Description).HasMaxLength(DescriptionConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.Subdomain).HasMaxLength(CodeConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.Currency).HasMaxLength(CodeConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.Street).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.City).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.State).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.ZipCode).HasMaxLength(CodeConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.Country).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.PhoneNumber).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.FaxNumber).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.EmailAddress).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.Website).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.LogoUrl).HasMaxLength(PathConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.TimeZone).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.ContactPerson).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.ContactPhone).HasMaxLength(NameConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.ContactEmail).HasMaxLength(EmailConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.Settings).HasMaxLength(DescriptionConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.Plan).HasMaxLength(CodeConsts.MaxLength).IsRequired(false);
        builder.Property(x => x.Status).IsRequired();
        builder.Property(x => x.TrialExpiresAt).IsRequired(false);
        builder.Property(x => x.SubscriptionExpiresAt).IsRequired(false);
        builder.Property(x => x.MaxUsers).IsRequired(false);
        builder.Property(x => x.MaxWarehouses).IsRequired(false);

        builder.HasIndex(e => e.Subdomain).IsUnique();
        builder.HasIndex(e => e.Status);
        builder.HasIndex(e => e.EmailAddress);
    }
}
