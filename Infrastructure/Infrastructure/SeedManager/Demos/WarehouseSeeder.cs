using Application.Common.Repositories;
using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Demos
{
    public class WarehouseSeeder
    {
        private readonly ICommandRepository<Warehouse> _repository;
        private readonly IUnitOfWork _unitOfWork;
        private readonly DataContext _context;

        public WarehouseSeeder(
            ICommandRepository<Warehouse> repository,
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

            var warehouses = new List<Warehouse>
            {
                new Warehouse { Name = "New York", CompanyId = companyId },
                new Warehouse { Name = "San Francisco", CompanyId = companyId },
                new Warehouse { Name = "Chicago", CompanyId = companyId },
                new Warehouse { Name = "Los Angeles", CompanyId = companyId }
            };

            foreach (var warehouse in warehouses)
            {
                await _repository.CreateAsync(warehouse);
            }

            await _unitOfWork.SaveAsync();
        }
    }
}
