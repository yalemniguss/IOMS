using Infrastructure.DataAccessManager.EFCore.Common;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;

namespace ASPNET.BackEnd.Common.Middlewares;

public class TenantUrlResolutionMiddleware
{
    private readonly RequestDelegate _next;

    public TenantUrlResolutionMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context, DataContext dataContext)
    {
        var currentTenantService = context.RequestServices.GetRequiredService<Application.Common.Services.ICurrentTenantService>();

        var host = context.Request.Host.Host;
        var subdomain = ExtractSubdomain(host);

        if (!string.IsNullOrEmpty(subdomain))
        {
            var company = await dataContext.Company
                .AsNoTracking()
                .FirstOrDefaultAsync(x => x.Subdomain == subdomain && !x.IsDeleted);

            if (company != null)
            {
                TenantContext.CurrentTenantId = company.Id;
                currentTenantService.SetTenantId(company.Id);

                context.Items["CurrentCompany"] = company;
                context.Items["CurrentSubdomain"] = subdomain;
            }
            else
            {
                TenantContext.CurrentTenantId = null;
                currentTenantService.SetTenantId(null);
            }
        }

        await _next(context);
    }

    private static string? ExtractSubdomain(string host)
    {
        if (string.IsNullOrEmpty(host)) return null;

        var parts = host.Split('.');
        if (parts.Length <= 2) return null;

        var subdomain = parts[0];
        if (string.Equals(subdomain, "www", StringComparison.OrdinalIgnoreCase)
            || string.Equals(subdomain, "api", StringComparison.OrdinalIgnoreCase))
        {
            return null;
        }

        return subdomain.ToLowerInvariant();
    }
}