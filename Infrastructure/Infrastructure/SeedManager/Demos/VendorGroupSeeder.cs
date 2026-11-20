using Application.Common.Repositories;
using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Demos;

public class VendorGroupSeeder
{
    private readonly ICommandRepository<VendorGroup> _groupRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly DataContext _context;

    public VendorGroupSeeder(
        ICommandRepository<VendorGroup> groupRepository,
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

        var vendorGroups = new List<VendorGroup>
        {
            new VendorGroup { Name = "Manufacture", CompanyId = companyId },
            new VendorGroup { Name = "Supplier", CompanyId = companyId },
            new VendorGroup { Name = "Service Provider", CompanyId = companyId },
            new VendorGroup { Name = "Distributor", CompanyId = companyId },
            new VendorGroup { Name = "Freelancer", CompanyId = companyId }
        };

        foreach (var group in vendorGroups)
        {
            await _groupRepository.CreateAsync(group);
        }

        await _unitOfWork.SaveAsync();
    }
}
