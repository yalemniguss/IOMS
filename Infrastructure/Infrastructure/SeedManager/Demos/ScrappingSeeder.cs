using Application.Common.Repositories;
using Application.Features.InventoryTransactionManager;
using Application.Features.NumberSequenceManager;
using Domain.Entities;
using Domain.Enums;
using Infrastructure.DataAccessManager.EFCore.Contexts;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.SeedManager.Demos;

public class ScrappingSeeder
{
    private readonly ICommandRepository<Scrapping> _scrappingRepository;
    private readonly ICommandRepository<InventoryTransaction> _inventoryTransactionRepository;
    private readonly ICommandRepository<Product> _productRepository;
    private readonly ICommandRepository<Warehouse> _warehouseRepository;
    private readonly NumberSequenceService _numberSequenceService;
    private readonly InventoryTransactionService _inventoryTransactionService;
    private readonly IUnitOfWork _unitOfWork;
    private readonly DataContext _context;

    public ScrappingSeeder(
        ICommandRepository<Scrapping> scrappingRepository,
        ICommandRepository<InventoryTransaction> inventoryTransactionRepository,
        ICommandRepository<Product> productRepository,
        ICommandRepository<Warehouse> warehouseRepository,
        NumberSequenceService numberSequenceService,
        InventoryTransactionService inventoryTransactionService,
        IUnitOfWork unitOfWork,
        DataContext context
    )
    {
        _scrappingRepository = scrappingRepository;
        _inventoryTransactionRepository = inventoryTransactionRepository;
        _productRepository = productRepository;
        _warehouseRepository = warehouseRepository;
        _numberSequenceService = numberSequenceService;
        _inventoryTransactionService = inventoryTransactionService;
        _unitOfWork = unitOfWork;
        _context = context;
    }

    public async Task GenerateDataAsync()
    {
        var defaultCompany = await _context.Company.FirstOrDefaultAsync();
        var companyId = defaultCompany?.Id ?? "";

        var random = new Random();
        var scrappingStatusLength = Enum.GetNames(typeof(ScrappingStatus)).Length;

        var products = await _productRepository
            .GetQuery()
            .Where(x => x.Physical == true)
            .ToListAsync();

        var warehouses = await _warehouseRepository
            .GetQuery()
            .Where(x => x.SystemWarehouse == false)
            .Select(x => x.Id)
            .ToListAsync();

        var dateFinish = DateTime.Now;
        var dateStart = new DateTime(dateFinish.AddMonths(-12).Year, dateFinish.AddMonths(-12).Month, 1);

        for (DateTime date = dateStart; date < dateFinish; date = date.AddMonths(1))
        {
            DateTime[] transactionDates = GetRandomDays(date.Year, date.Month, 6);

            foreach (var transDate in transactionDates)
            {
                var scrapping = new Scrapping
                {
                    Number = _numberSequenceService.GenerateNumber(nameof(Scrapping), "", "SCRP"),
                    ScrappingDate = transDate,
                    Status = (ScrappingStatus)random.Next(0, scrappingStatusLength),
                    WarehouseId = GetRandomValue(warehouses, random),
                    CompanyId = companyId
                };
                await _scrappingRepository.CreateAsync(scrapping);

                int numberOfProducts = random.Next(3, 6);
                for (int i = 0; i < numberOfProducts; i++)
                {
                    var product = products[random.Next(products.Count)];

                    var inventoryTransaction = new InventoryTransaction
                    {
                        ModuleId = scrapping.Id,
                        ModuleName = nameof(Scrapping),
                        ModuleCode = "SCRP",
                        ModuleNumber = scrapping.Number,
                        MovementDate = scrapping.ScrappingDate!.Value,
                        Status = (InventoryTransactionStatus)scrapping.Status,
                        Number = _numberSequenceService.GenerateNumber(nameof(InventoryTransaction), "", "IVT"),
                        WarehouseId = scrapping.WarehouseId,
                        ProductId = product.Id,
                        Movement = random.Next(1, 10),
                        CompanyId = companyId
                    };

                    _inventoryTransactionService.CalculateInvenTrans(inventoryTransaction);
                    await _inventoryTransactionRepository.CreateAsync(inventoryTransaction);
                }
            }
        }

        await _unitOfWork.SaveAsync();
    }

    private static DateTime[] GetRandomDays(int year, int month, int count)
    {
        var random = new Random();
        var daysInMonth = DateTime.DaysInMonth(year, month);
        return Enumerable.Range(1, count)
            .Select(_ => new DateTime(year, month, random.Next(1, daysInMonth + 1)))
            .ToArray();
    }

    private static T? GetRandomValue<T>(IList<T>? list, Random random)
    {
        if (list == null || list.Count == 0) return default;
        return list[random.Next(list.Count)];
    }
}
