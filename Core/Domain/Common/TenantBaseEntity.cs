namespace Domain.Common;

public abstract class TenantBaseEntity : BaseEntity, ITenantEntity
{
    public string CompanyId { get; set; } = null!;
}
