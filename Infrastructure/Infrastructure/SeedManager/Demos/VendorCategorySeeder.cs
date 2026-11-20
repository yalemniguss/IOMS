using Application.Common.Repositories;
using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Demos;

public class VendorCategorySeeder
{
    private readonly ICommandRepository<VendorCategory> _categoryRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly DataContext _context;

    public VendorCategorySeeder(
        ICommandRepository<VendorCategory> categoryRepository,
        IUnitOfWork unitOfWork,
        DataContext context
    )
    {
        _categoryRepository = categoryRepository;
        _unitOfWork = unitOfWork;
        _context = context;
    }

    public async Task GenerateDataAsync()
    {
        var defaultCompany = await _context.Company.FirstOrDefaultAsync();
        var companyId = defaultCompany?.Id ?? "";

        var vendorCategories = new List<VendorCategory>
        {
            new VendorCategory { Name = "Large", CompanyId = companyId },
            new VendorCategory { Name = "Medium", CompanyId = companyId },
            new VendorCategory { Name = "Small", CompanyId = companyId },
            new VendorCategory { Name = "Specialty", CompanyId = companyId },
            new VendorCategory { Name = "Local", CompanyId = companyId },
            new VendorCategory { Name = "Global", CompanyId = companyId }
        };

        foreach (var category in vendorCategories)
        {
            await _categoryRepository.CreateAsync(category);
        }

        await _unitOfWork.SaveAsync();
    }
}
