using Application.Common.Repositories;
using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Demos;

public class TaxSeeder
{
    private readonly ICommandRepository<Tax> _repository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly DataContext _context;

    public TaxSeeder(
        ICommandRepository<Tax> repository,
        IUnitOfWork unitOfWork,
        DataContext context
    )
    {
        _repository = repository;
        _unitOfWork = unitOfWork;
        _context = context;
    }

    public async Task GenerateDataAsync()
    {
        var defaultCompany = await _context.Company.FirstOrDefaultAsync();
        var companyId = defaultCompany?.Id ?? "";

        var taxes = new List<Tax>
        {
            new Tax { Name = "NOTAX", Percentage = 0.0, CompanyId = companyId },
            new Tax { Name = "T10", Percentage = 10.0, CompanyId = companyId },
            new Tax { Name = "T15", Percentage = 15.0, CompanyId = companyId },
            new Tax { Name = "T20", Percentage = 20.0, CompanyId = companyId }
        };

        foreach (var tax in taxes)
        {
            await _repository.CreateAsync(tax);
        }

        await _unitOfWork.SaveAsync();
    }
}

