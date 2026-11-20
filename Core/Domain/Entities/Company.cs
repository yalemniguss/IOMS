using Domain.Common;
using Domain.Enums;

namespace Domain.Entities;

public class Company : BaseEntity
{
    public string? Name { get; set; }
    public string? Description { get; set; }
    public string? Subdomain { get; set; }
    public string? Currency { get; set; }
    public string? Street { get; set; }
    public string? City { get; set; }
    public string? State { get; set; }
    public string? ZipCode { get; set; }
    public string? Country { get; set; }
    public string? PhoneNumber { get; set; }
    public string? FaxNumber { get; set; }
    public string? EmailAddress { get; set; }
    public string? Website { get; set; }
    public string? LogoUrl { get; set; }
    public string? TimeZone { get; set; }
    public string? ContactPerson { get; set; }
    public string? ContactPhone { get; set; }
    public string? ContactEmail { get; set; }
    public string? Settings { get; set; }
    public TenantStatus Status { get; set; } = TenantStatus.Registered;
    public DateTime? TrialExpiresAt { get; set; }
    public DateTime? SubscriptionExpiresAt { get; set; }
    public int? MaxUsers { get; set; }
    public int? MaxWarehouses { get; set; }
    public string? Plan { get; set; }
}
