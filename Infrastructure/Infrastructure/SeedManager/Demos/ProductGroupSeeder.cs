using Application.Common.Repositories;
using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Demos;

public class ProductGroupSeeder
{
    private readonly ICommandRepository<ProductGroup> _productGroupRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly DataContext _context;

    public ProductGroupSeeder(
        ICommandRepository<ProductGroup> productGroupRepository,
        IUnitOfWork unitOfWork,
        DataContext context
    )
    {
        _productGroupRepository = productGroupRepository;
        _unitOfWork = unitOfWork;
        _context = context;
    }

    public async Task GenerateDataAsync()
    {
        var defaultCompany = await _context.Company.FirstOrDefaultAsync();
        var companyId = defaultCompany?.Id ?? "";

        var productGroups = new List<ProductGroup>
        {
            new ProductGroup { Name = "Hardware", CompanyId = companyId },
            new ProductGroup { Name = "Networking", CompanyId = companyId },
            new ProductGroup { Name = "Storage", CompanyId = companyId },
            new ProductGroup { Name = "Device", CompanyId = companyId },
            new ProductGroup { Name = "Software", CompanyId = companyId },
            new ProductGroup { Name = "Service", CompanyId = companyId }
        };

        foreach (var productGroup in productGroups)
        {
            await _productGroupRepository.CreateAsync(productGroup);
        }

        await _unitOfWork.SaveAsync();
    }
}
