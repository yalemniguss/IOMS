using Application.Common.Repositories;
using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Systems;

public class CompanySeeder
{
    private readonly ICommandRepository<Company> _repository;
    private readonly IUnitOfWork _unitOfWork;
    private readonly DataContext _context;
    public CompanySeeder(
        ICommandRepository<Company> repository,
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
        var existing = await _context.Company.FirstOrDefaultAsync();
        if (existing != null) return;

        var entity = new Company
        {
            CreatedAtUtc = DateTime.UtcNow,
            IsDeleted = false,
            Name = "Acme Corp",
            Currency = "USD",
            Street = "123 Main St",
            City = "Metropolis",
            State = "New York",
            ZipCode = "10001",
            Country = "USA",
            PhoneNumber = "+1-212-555-1234",
            FaxNumber = "+1-212-555-5678",
            EmailAddress = "info@acmecorp.com",
            Website = "https://www.acmecorp.com"
        };

        await _repository.CreateAsync(entity);
        await _unitOfWork.SaveAsync();
    }

}
