using Application.Common.Repositories;
using Domain.Entities;
using Domain.Enums;
using Microsoft.EntityFrameworkCore;

namespace Application.Features.CompanyManager;

public class CompanyManagementService
{
    private readonly ICommandRepository<Company> _repository;
    private readonly IUnitOfWork _unitOfWork;

    public CompanyManagementService(
        ICommandRepository<Company> repository,
        IUnitOfWork unitOfWork
        )
    {
        _repository = repository;
        _unitOfWork = unitOfWork;
    }

    public async Task<Company> CreateCompanyAsync(Company company, CancellationToken cancellationToken = default)
    {
        company.Status = TenantStatus.Registered;
        company.CreatedAtUtc = DateTime.UtcNow;
        company.IsDeleted = false;

        _repository.Create(company);
        await _unitOfWork.SaveAsync(cancellationToken);

        return company;
    }

    public async Task<Company?> UpdateCompanyAsync(
        string id,
        string? name,
        string? description,
        string? subdomain,
        string? currency,
        string? street,
        string? city,
        string? state,
        string? zipCode,
        string? country,
        string? phoneNumber,
        string? faxNumber,
        string? emailAddress,
        string? website,
        string? logoUrl,
        string? timeZone,
        string? contactPerson,
        string? contactPhone,
        string? contactEmail,
        string? settings,
        TenantStatus? status,
        DateTime? trialExpiresAt,
        DateTime? subscriptionExpiresAt,
        int? maxUsers,
        int? maxWarehouses,
        string? plan,
        CancellationToken cancellationToken = default)
    {
        var company = _repository.Get(id);
        if (company == null || company.IsDeleted) return null;

        company.Name = name ?? company.Name;
        company.Description = description ?? company.Description;
        company.Subdomain = subdomain ?? company.Subdomain;
        company.Currency = currency ?? company.Currency;
        company.Street = street ?? company.Street;
        company.City = city ?? company.City;
        company.State = state ?? company.State;
        company.ZipCode = zipCode ?? company.ZipCode;
        company.Country = country ?? company.Country;
        company.PhoneNumber = phoneNumber ?? company.PhoneNumber;
        company.FaxNumber = faxNumber ?? company.FaxNumber;
        company.EmailAddress = emailAddress ?? company.EmailAddress;
        company.Website = website ?? company.Website;
        company.LogoUrl = logoUrl ?? company.LogoUrl;
        company.TimeZone = timeZone ?? company.TimeZone;
        company.ContactPerson = contactPerson ?? company.ContactPerson;
        company.ContactPhone = contactPhone ?? company.ContactPhone;
        company.ContactEmail = contactEmail ?? company.ContactEmail;
        company.Settings = settings ?? company.Settings;
        company.Status = status ?? company.Status;
        company.TrialExpiresAt = trialExpiresAt ?? company.TrialExpiresAt;
        company.SubscriptionExpiresAt = subscriptionExpiresAt ?? company.SubscriptionExpiresAt;
        company.MaxUsers = maxUsers ?? company.MaxUsers;
        company.MaxWarehouses = maxWarehouses ?? company.MaxWarehouses;
        company.Plan = plan ?? company.Plan;
        company.UpdatedAtUtc = DateTime.UtcNow;

        _repository.Update(company);
        await _unitOfWork.SaveAsync(cancellationToken);

        return company;
    }

    public async Task<bool> DeleteCompanyAsync(string id, CancellationToken cancellationToken = default)
    {
        var company = _repository.Get(id);
        if (company == null) return false;

        company.IsDeleted = true;
        company.UpdatedAtUtc = DateTime.UtcNow;

        _repository.Update(company);
        await _unitOfWork.SaveAsync(cancellationToken);

        return true;
    }

    public async Task<bool> SuspendCompanyAsync(string id, CancellationToken cancellationToken = default)
    {
        return await UpdateCompanyStatusAsync(id, TenantStatus.Suspended, cancellationToken);
    }

    public async Task<bool> ActivateCompanyAsync(string id, CancellationToken cancellationToken = default)
    {
        return await UpdateCompanyStatusAsync(id, TenantStatus.Registered, cancellationToken);
    }

    public async Task<bool> UpdateCompanyStatusAsync(string id, TenantStatus status, CancellationToken cancellationToken = default)
    {
        var company = _repository.Get(id);
        if (company == null) return false;

        company.Status = status;
        company.UpdatedAtUtc = DateTime.UtcNow;

        _repository.Update(company);
        await _unitOfWork.SaveAsync(cancellationToken);

        return true;
    }

    public async Task<Company?> GetCompanyBySubdomainAsync(string subdomain, CancellationToken cancellationToken = default)
    {
        return await _repository.GetQuery()
            .Where(x => x.Subdomain == subdomain && !x.IsDeleted)
            .FirstOrDefaultAsync(cancellationToken);
    }

    public async Task<Company?> GetCompanyByIdAsync(string companyId, CancellationToken cancellationToken = default)
    {
        return await _repository.GetQuery()
            .Where(x => x.Id == companyId && !x.IsDeleted)
            .FirstOrDefaultAsync(cancellationToken);
    }

    public async Task<List<Company>> GetAllCompaniesAsync(CancellationToken cancellationToken = default)
    {
        return await _repository.GetQuery()
            .Where(x => !x.IsDeleted)
            .OrderBy(x => x.Name)
            .ToListAsync(cancellationToken);
    }

    public async Task<bool> IsSubdomainAvailableAsync(string subdomain, string? excludeCompanyId = null, CancellationToken cancellationToken = default)
    {
        var query = _repository.GetQuery().Where(x => x.Subdomain == subdomain);
        if (!string.IsNullOrEmpty(excludeCompanyId))
        {
            query = query.Where(x => x.Id != excludeCompanyId);
        }
        return !await query.AnyAsync(cancellationToken);
    }
}
