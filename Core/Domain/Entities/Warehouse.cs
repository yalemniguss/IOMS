using Domain.Common;

namespace Domain.Entities;

public class Warehouse : TenantBaseEntity
{
    public string? Name { get; set; }
    public string? Description { get; set; }
    public bool? SystemWarehouse { get; set; } = false;

    public Company? Company { get; set; }
}
