using Infrastructure.DataAccessManager.EFCore.Common;
using Microsoft.AspNetCore.Http;

namespace ASPNET.BackEnd.Common.Middlewares;

public class TenantMiddleware
{
    private readonly RequestDelegate _next;

    public TenantMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        var currentTenantService = context.RequestServices.GetRequiredService<Application.Common.Services.ICurrentTenantService>();

        var companyIdClaim = context.User.FindFirst("CompanyId");
        if (companyIdClaim != null && !string.IsNullOrEmpty(companyIdClaim.Value))
        {
            var tenantId = companyIdClaim.Value;
            TenantContext.CurrentTenantId = tenantId;
            currentTenantService.SetTenantId(tenantId);
        }
        else
        {
            TenantContext.CurrentTenantId = null;
            currentTenantService.SetTenantId(null);
        }

        await _next(context);
    }
}
