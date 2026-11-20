using Domain.Common;

namespace Domain.Entities;

public class CustomerCategory : TenantBaseEntity
{
    public string? Name { get; set; }
    public string? Description { get; set; }

    public Company? Company { get; set; }
}
