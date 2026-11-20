namespace Application.Common.Services;

public interface ICurrentTenantService
{
    string? GetTenantId();
    void SetTenantId(string? tenantId);
}
