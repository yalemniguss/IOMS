namespace Application.Common.Services;

public class CurrentTenantService : ICurrentTenantService
{
    private string? _tenantId;

    public string? GetTenantId() => _tenantId;

    public void SetTenantId(string? tenantId) => _tenantId = tenantId;
}
