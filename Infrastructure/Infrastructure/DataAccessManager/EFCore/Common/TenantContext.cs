namespace Infrastructure.DataAccessManager.EFCore.Common;

public static class TenantContext
{
    private static readonly AsyncLocal<string?> _currentTenantId = new();

    public static string? CurrentTenantId
    {
        get => _currentTenantId.Value;
        set => _currentTenantId.Value = value;
    }
}
