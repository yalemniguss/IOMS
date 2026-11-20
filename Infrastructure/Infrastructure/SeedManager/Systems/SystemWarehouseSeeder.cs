using Application.Common.Repositories;
using Domain.Entities;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Systems
{
    public class SystemWarehouseSeeder
    {
        private readonly ICommandRepository<Warehouse> _repository;
        private readonly IUnitOfWork _unitOfWork;
        private readonly DataContext _context;

        public SystemWarehouseSeeder(
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
                new Warehouse { Name = "Customer", SystemWarehouse = true, CompanyId = companyId },
                new Warehouse { Name = "Vendor", SystemWarehouse = true, CompanyId = companyId },
                new Warehouse { Name = "Transfer", SystemWarehouse = true, CompanyId = companyId },
                new Warehouse { Name = "Adjustment", SystemWarehouse = true, CompanyId = companyId },
                new Warehouse { Name = "StockCount", SystemWarehouse = true, CompanyId = companyId },
                new Warehouse { Name = "Scrapping", SystemWarehouse = true, CompanyId = companyId }
            };

            foreach (var warehouse in warehouses)
            {
                await _repository.CreateAsync(warehouse);
            }

            await _unitOfWork.SaveAsync();
        }
    }
}
