using Application.Common.Repositories;
using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Demos;

public class CustomerGroupSeeder
{
    private readonly ICommandRepository<CustomerGroup> _groupRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly DataContext _context;

    public CustomerGroupSeeder(
        ICommandRepository<CustomerGroup> groupRepository,
        IUnitOfWork unitOfWork,
        DataContext context
    )
    {
        _groupRepository = groupRepository;
        _unitOfWork = unitOfWork;
        _context = context;
    }

    public async Task GenerateDataAsync()
    {
        var defaultCompany = await _context.Company.FirstOrDefaultAsync();
        var companyId = defaultCompany?.Id ?? "";

        var customerGroups = new List<CustomerGroup>
        {
            new CustomerGroup { Name = "Corporate", CompanyId = companyId },
            new CustomerGroup { Name = "Government", CompanyId = companyId },
            new CustomerGroup { Name = "Foundation", CompanyId = companyId },
            new CustomerGroup { Name = "Military", CompanyId = companyId },
            new CustomerGroup { Name = "Education", CompanyId = companyId },
            new CustomerGroup { Name = "Hospitality", CompanyId = companyId }
        };

        foreach (var group in customerGroups)
        {
            await _groupRepository.CreateAsync(group);
        }

        await _unitOfWork.SaveAsync();
    }
}


