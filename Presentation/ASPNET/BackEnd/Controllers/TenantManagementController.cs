using Application.Common.Services;
using Application.Features.CompanyManager;
using ASPNET.BackEnd.Common.Base;
using ASPNET.BackEnd.Common.Models;
using Domain.Entities;
using Domain.Enums;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ASPNET.BackEnd.Controllers;

[Route("api/tenant")]
[Authorize]
public class TenantManagementController : BaseApiController
{
    private readonly CompanyManagementService _companyService;
    private readonly ICurrentTenantService _currentTenantService;

    public TenantManagementController(
        ISender sender,
        CompanyManagementService companyService,
        ICurrentTenantService currentTenantService
        ) : base(sender)
    {
        _companyService = companyService;
        _currentTenantService = currentTenantService;
    }

    [HttpGet("current")]
    public async Task<ActionResult<ApiSuccessResult<CompanyDto>>> GetCurrentTenant(CancellationToken cancellationToken)
    {
        var tenantId = _currentTenantService.GetTenantId();
        if (string.IsNullOrEmpty(tenantId))
        {
            return NotFound(new ApiSuccessResult<CompanyDto>
            {
                Code = StatusCodes.Status404NotFound,
                Message = "No tenant context found."
            });
        }

        var company = await _companyService.GetCompanyByIdAsync(tenantId, cancellationToken);
        if (company == null)
        {
            return NotFound(new ApiSuccessResult<CompanyDto>
            {
                Code = StatusCodes.Status404NotFound,
                Message = "Tenant not found."
            });
        }

        return Ok(new ApiSuccessResult<CompanyDto>
        {
            Code = StatusCodes.Status200OK,
            Message = "Current tenant retrieved successfully.",
            Content = MapToDto(company)
        });
    }

    [HttpGet("list")]
    public async Task<ActionResult<ApiSuccessResult<List<CompanyDto>>>> GetAllTenants(CancellationToken cancellationToken)
    {
        var companies = await _companyService.GetAllCompaniesAsync(cancellationToken);
        var dtos = companies.Select(MapToDto).ToList();

        return Ok(new ApiSuccessResult<List<CompanyDto>>
        {
            Code = StatusCodes.Status200OK,
            Message = "Tenants retrieved successfully.",
            Content = dtos
        });
    }

    [HttpGet("{id}")]
    public async Task<ActionResult<ApiSuccessResult<CompanyDto>>> GetTenantById(string id, CancellationToken cancellationToken)
    {
        var company = await _companyService.GetCompanyByIdAsync(id, cancellationToken);
        if (company == null)
        {
            return NotFound(new ApiSuccessResult<CompanyDto>
            {
                Code = StatusCodes.Status404NotFound,
                Message = "Tenant not found."
            });
        }

        return Ok(new ApiSuccessResult<CompanyDto>
        {
            Code = StatusCodes.Status200OK,
            Message = "Tenant retrieved successfully.",
            Content = MapToDto(company)
        });
    }

    [HttpPost]
    public async Task<ActionResult<ApiSuccessResult<CompanyDto>>> CreateTenant(
        CreateTenantRequest request,
        CancellationToken cancellationToken)
    {
        if (string.IsNullOrEmpty(request.Subdomain) || !await _companyService.IsSubdomainAvailableAsync(request.Subdomain, null, cancellationToken))
        {
            return BadRequest(new ApiSuccessResult<CompanyDto>
            {
                Code = StatusCodes.Status400BadRequest,
                Message = "Subdomain is already taken."
            });
        }

        var company = new Company
        {
            Name = request.Name,
            Description = request.Description,
            Subdomain = request.Subdomain?.ToLowerInvariant(),
            Currency = request.Currency,
            Street = request.Street,
            City = request.City,
            State = request.State,
            ZipCode = request.ZipCode,
            Country = request.Country,
            PhoneNumber = request.PhoneNumber,
            FaxNumber = request.FaxNumber,
            EmailAddress = request.EmailAddress,
            Website = request.Website,
            LogoUrl = request.LogoUrl,
            TimeZone = request.TimeZone,
            ContactPerson = request.ContactPerson,
            ContactPhone = request.ContactPhone,
            ContactEmail = request.ContactEmail,
            Settings = request.Settings,
            Status = TenantStatus.Registered,
            TrialExpiresAt = request.TrialExpiresAt,
            SubscriptionExpiresAt = request.SubscriptionExpiresAt,
            MaxUsers = request.MaxUsers,
            MaxWarehouses = request.MaxWarehouses,
            Plan = request.Plan
        };

        var created = await _companyService.CreateCompanyAsync(company, cancellationToken);

        return Ok(new ApiSuccessResult<CompanyDto>
        {
            Code = StatusCodes.Status201Created,
            Message = "Tenant created successfully.",
            Content = MapToDto(created)
        });
    }

    [HttpPut("{id}")]
    public async Task<ActionResult<ApiSuccessResult<CompanyDto>>> UpdateTenant(
        string id,
        UpdateTenantRequest request,
        CancellationToken cancellationToken)
    {
        if (!string.IsNullOrEmpty(request.Subdomain))
        {
            var isAvailable = await _companyService.IsSubdomainAvailableAsync(request.Subdomain, id, cancellationToken);
            if (!isAvailable)
            {
                return BadRequest(new ApiSuccessResult<CompanyDto>
                {
                    Code = StatusCodes.Status400BadRequest,
                    Message = "Subdomain is already taken."
                });
            }
        }

        var updated = await _companyService.UpdateCompanyAsync(
            id,
            request.Name,
            request.Description,
            request.Subdomain,
            request.Currency,
            request.Street,
            request.City,
            request.State,
            request.ZipCode,
            request.Country,
            request.PhoneNumber,
            request.FaxNumber,
            request.EmailAddress,
            request.Website,
            request.LogoUrl,
            request.TimeZone,
            request.ContactPerson,
            request.ContactPhone,
            request.ContactEmail,
            request.Settings,
            request.Status,
            request.TrialExpiresAt,
            request.SubscriptionExpiresAt,
            request.MaxUsers,
            request.MaxWarehouses,
            request.Plan,
            cancellationToken
        );

        if (updated == null)
        {
            return NotFound(new ApiSuccessResult<CompanyDto>
            {
                Code = StatusCodes.Status404NotFound,
                Message = "Tenant not found."
            });
        }

        return Ok(new ApiSuccessResult<CompanyDto>
        {
            Code = StatusCodes.Status200OK,
            Message = "Tenant updated successfully.",
            Content = MapToDto(updated)
        });
    }

    [HttpDelete("{id}")]
    public async Task<ActionResult<ApiSuccessResult<bool>>> DeleteTenant(string id, CancellationToken cancellationToken)
    {
        var result = await _companyService.DeleteCompanyAsync(id, cancellationToken);
        if (!result)
        {
            return NotFound(new ApiSuccessResult<bool>
            {
                Code = StatusCodes.Status404NotFound,
                Message = "Tenant not found."
            });
        }

        return Ok(new ApiSuccessResult<bool>
        {
            Code = StatusCodes.Status200OK,
            Message = "Tenant deleted successfully.",
            Content = true
        });
    }

    [HttpPost("{id}/suspend")]
    public async Task<ActionResult<ApiSuccessResult<bool>>> SuspendTenant(string id, CancellationToken cancellationToken)
    {
        var result = await _companyService.SuspendCompanyAsync(id, cancellationToken);
        if (!result)
        {
            return NotFound(new ApiSuccessResult<bool>
            {
                Code = StatusCodes.Status404NotFound,
                Message = "Tenant not found."
            });
        }

        return Ok(new ApiSuccessResult<bool>
        {
            Code = StatusCodes.Status200OK,
            Message = "Tenant suspended successfully.",
            Content = true
        });
    }

    [HttpPost("{id}/activate")]
    public async Task<ActionResult<ApiSuccessResult<bool>>> ActivateTenant(string id, CancellationToken cancellationToken)
    {
        var result = await _companyService.ActivateCompanyAsync(id, cancellationToken);
        if (!result)
        {
            return NotFound(new ApiSuccessResult<bool>
            {
                Code = StatusCodes.Status404NotFound,
                Message = "Tenant not found."
            });
        }

        return Ok(new ApiSuccessResult<bool>
        {
            Code = StatusCodes.Status200OK,
            Message = "Tenant activated successfully.",
            Content = true
        });
    }

    [HttpGet("check-subdomain")]
    public async Task<ActionResult<ApiSuccessResult<bool>>> CheckSubdomainAvailability(
        [FromQuery] string subdomain,
        [FromQuery] string? excludeId = null,
        CancellationToken cancellationToken = default)
    {
        var isAvailable = await _companyService.IsSubdomainAvailableAsync(subdomain, excludeId, cancellationToken);

        return Ok(new ApiSuccessResult<bool>
        {
            Code = StatusCodes.Status200OK,
            Message = isAvailable ? "Subdomain is available." : "Subdomain is already taken.",
            Content = isAvailable
        });
    }

    [HttpGet("resolve-by-url")]
    public async Task<ActionResult<ApiSuccessResult<CompanyDto>>> ResolveTenantByUrl(
        [FromQuery] string url,
        CancellationToken cancellationToken)
    {
        var subdomain = ExtractSubdomain(url);
        if (string.IsNullOrEmpty(subdomain))
        {
            return BadRequest(new ApiSuccessResult<CompanyDto>
            {
                Code = StatusCodes.Status400BadRequest,
                Message = "Invalid URL or no subdomain found."
            });
        }

        var company = await _companyService.GetCompanyBySubdomainAsync(subdomain, cancellationToken);
        if (company == null)
        {
            return NotFound(new ApiSuccessResult<CompanyDto>
            {
                Code = StatusCodes.Status404NotFound,
                Message = "No tenant found for this URL."
            });
        }

        return Ok(new ApiSuccessResult<CompanyDto>
        {
            Code = StatusCodes.Status200OK,
            Message = "Tenant resolved successfully.",
            Content = MapToDto(company)
        });
    }

    private static CompanyDto MapToDto(Company company)
    {
        return new CompanyDto
        {
            Id = company.Id,
            Name = company.Name,
            Description = company.Description,
            Subdomain = company.Subdomain,
            Currency = company.Currency,
            Street = company.Street,
            City = company.City,
            State = company.State,
            ZipCode = company.ZipCode,
            Country = company.Country,
            PhoneNumber = company.PhoneNumber,
            FaxNumber = company.FaxNumber,
            EmailAddress = company.EmailAddress,
            Website = company.Website,
            LogoUrl = company.LogoUrl,
            TimeZone = company.TimeZone,
            ContactPerson = company.ContactPerson,
            ContactPhone = company.ContactPhone,
            ContactEmail = company.ContactEmail,
            Settings = company.Settings,
            Status = company.Status,
            TrialExpiresAt = company.TrialExpiresAt,
            SubscriptionExpiresAt = company.SubscriptionExpiresAt,
            MaxUsers = company.MaxUsers,
            MaxWarehouses = company.MaxWarehouses,
            Plan = company.Plan,
            IsDeleted = company.IsDeleted,
            CreatedAtUtc = company.CreatedAtUtc,
            UpdatedAtUtc = company.UpdatedAtUtc
        };
    }

    private static string? ExtractSubdomain(string url)
    {
        if (string.IsNullOrEmpty(url)) return null;

        try
        {
            var uri = new Uri(url);
            var host = uri.Host;
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
        catch
        {
            return null;
        }
    }
}

public class CompanyDto
{
    public string? Id { get; set; }
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
    public TenantStatus Status { get; set; }
    public DateTime? TrialExpiresAt { get; set; }
    public DateTime? SubscriptionExpiresAt { get; set; }
    public int? MaxUsers { get; set; }
    public int? MaxWarehouses { get; set; }
    public string? Plan { get; set; }
    public bool IsDeleted { get; set; }
    public DateTime? CreatedAtUtc { get; set; }
    public DateTime? UpdatedAtUtc { get; set; }
}

public class CreateTenantRequest
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
    public DateTime? TrialExpiresAt { get; set; }
    public DateTime? SubscriptionExpiresAt { get; set; }
    public int? MaxUsers { get; set; }
    public int? MaxWarehouses { get; set; }
    public string? Plan { get; set; }
}

public class UpdateTenantRequest
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
    public TenantStatus? Status { get; set; }
    public DateTime? TrialExpiresAt { get; set; }
    public DateTime? SubscriptionExpiresAt { get; set; }
    public int? MaxUsers { get; set; }
    public int? MaxWarehouses { get; set; }
    public string? Plan { get; set; }
}
