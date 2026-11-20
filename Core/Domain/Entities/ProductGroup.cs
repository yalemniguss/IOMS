using Domain.Common;

namespace Domain.Entities;

public class ProductGroup : TenantBaseEntity
{
    public string? Name { get; set; }
    public string? Description { get; set; }

    public Company? Company { get; set; }
}
