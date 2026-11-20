using Application.Common.Repositories;
using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Demos;

public class CustomerCategorySeeder
{
    private readonly ICommandRepository<CustomerCategory> _categoryRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly DataContext _context;

    public CustomerCategorySeeder(
        ICommandRepository<CustomerCategory> categoryRepository,
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

        var customerCategories = new List<CustomerCategory>
        {
            new CustomerCategory { Name = "Enterprise", CompanyId = companyId },
            new CustomerCategory { Name = "Medium", CompanyId = companyId },
            new CustomerCategory { Name = "Small", CompanyId = companyId },
            new CustomerCategory { Name = "Startup", CompanyId = companyId },
            new CustomerCategory { Name = "Micro", CompanyId = companyId }
        };

        foreach (var category in customerCategories)
        {
            await _categoryRepository.CreateAsync(category);
        }

        await _unitOfWork.SaveAsync();
    }
}


