using Domain.Common;
using Domain.Enums;

namespace Domain.Entities;

public class SalesReturn : TenantBaseEntity
{
    public string? Number { get; set; }
    public DateTime? ReturnDate { get; set; }
    public SalesReturnStatus? Status { get; set; }
    public string? Description { get; set; }
    public string? DeliveryOrderId { get; set; }
    public DeliveryOrder? DeliveryOrder { get; set; }

    public Company? Company { get; set; }
}