using Application.Common.Repositories;
using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Demos;

public class UnitMeasureSeeder
{
    private readonly ICommandRepository<UnitMeasure> _unitMeasureRepository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly DataContext _context;

    public UnitMeasureSeeder(
        ICommandRepository<UnitMeasure> unitMeasureRepository,
        IUnitOfWork unitOfWork,
        DataContext context
    )
    {
        _unitMeasureRepository = unitMeasureRepository;
        _unitOfWork = unitOfWork;
        _context = context;
    }

    public async Task GenerateDataAsync()
    {
        var defaultCompany = await _context.Company.FirstOrDefaultAsync();
        var companyId = defaultCompany?.Id ?? "";

        var unitMeasures = new List<UnitMeasure>
        {
            new UnitMeasure { Name = "m", CompanyId = companyId },
            new UnitMeasure { Name = "kg", CompanyId = companyId },
            new UnitMeasure { Name = "hour", CompanyId = companyId },
            new UnitMeasure { Name = "unit", CompanyId = companyId },
            new UnitMeasure { Name = "pcs", CompanyId = companyId }
        };

        foreach (var unitMeasure in unitMeasures)
        {
            await _unitMeasureRepository.CreateAsync(unitMeasure);
        }

        await _unitOfWork.SaveAsync();
    }
}
