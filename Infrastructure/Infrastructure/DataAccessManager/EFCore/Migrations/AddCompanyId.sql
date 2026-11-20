SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;

-- Step 1: Insert a default company if Company table is empty
IF NOT EXISTS (SELECT * FROM [Company])
BEGIN
    INSERT INTO [Company] ([Id], [Name], [Description], [Currency], [Street], [City], [State], [ZipCode], [Country], [PhoneNumber], [FaxNumber], [EmailAddress], [Website], [IsDeleted], [CreatedAtUtc], [CreatedById], [UpdatedAtUtc], [UpdatedById])
    VALUES (NEWID(), 'Default Company', 'Default company for existing data', 'USD', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, GETUTCDATE(), 'SYSTEM', NULL, NULL);
END

DECLARE @DefaultCompanyId nvarchar(50);
SELECT @DefaultCompanyId = [Id] FROM [Company] WHERE [Name] = 'Default Company';

-- Step 2: Add CompanyId as nullable to AspNetUsers
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[AspNetUsers]') AND name = N'CompanyId')
BEGIN
    ALTER TABLE [AspNetUsers] ADD [CompanyId] nvarchar(50) NULL;
END

-- Step 3: Add CompanyId as nullable to all tenant tables
DECLARE @sql NVARCHAR(MAX) = N'';
DECLARE @tableName NVARCHAR(128);

DECLARE table_cursor CURSOR FOR
SELECT t.name 
FROM sys.tables t
WHERE t.name IN ('Customer','Product','SalesOrder','SalesOrderItem','PurchaseOrder','PurchaseOrderItem',
                 'Warehouse','Vendor','UnitMeasure','ProductGroup','CustomerGroup','CustomerCategory',
                 'VendorGroup','VendorCategory','Tax','CustomerContact','VendorContact','NumberSequence',
                 'FileImage','FileDocument','DeliveryOrder','GoodsReceive','SalesReturn','PurchaseReturn',
                 'TransferIn','TransferOut','StockCount','NegativeAdjustment','PositiveAdjustment',
                 'Scrapping','InventoryTransaction')
  AND NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('[' + t.name + ']') AND name = 'CompanyId');

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @tableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @sql = @sql + N'ALTER TABLE [' + @tableName + N'] ADD [CompanyId] nvarchar(50) NULL;' + CHAR(13) + CHAR(10);
    FETCH NEXT FROM table_cursor INTO @tableName;
END

CLOSE table_cursor;
DEALLOCATE table_cursor;

EXEC sp_executesql @sql;

-- Step 4: Update all existing rows to point to default company
UPDATE [AspNetUsers] SET [CompanyId] = @DefaultCompanyId WHERE [CompanyId] IS NULL;

DECLARE @updateSql NVARCHAR(MAX) = N'';

DECLARE update_cursor CURSOR FOR
SELECT t.name 
FROM sys.tables t
WHERE t.name IN ('Customer','Product','SalesOrder','SalesOrderItem','PurchaseOrder','PurchaseOrderItem',
                 'Warehouse','Vendor','UnitMeasure','ProductGroup','CustomerGroup','CustomerCategory',
                 'VendorGroup','VendorCategory','Tax','CustomerContact','VendorContact','NumberSequence',
                 'FileImage','FileDocument','DeliveryOrder','GoodsReceive','SalesReturn','PurchaseReturn',
                 'TransferIn','TransferOut','StockCount','NegativeAdjustment','PositiveAdjustment',
                 'Scrapping','InventoryTransaction');

OPEN update_cursor;
FETCH NEXT FROM update_cursor INTO @tableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @updateSql = @updateSql + N'UPDATE [' + @tableName + N'] SET [CompanyId] = ''' + @DefaultCompanyId + N''' WHERE [CompanyId] IS NULL;' + CHAR(13) + CHAR(10);
    FETCH NEXT FROM update_cursor INTO @tableName;
END

CLOSE update_cursor;
DEALLOCATE update_cursor;

EXEC sp_executesql @updateSql;

-- Step 5: Alter columns to NOT NULL
DECLARE @alterSql NVARCHAR(MAX) = N'';

DECLARE alter_cursor CURSOR FOR
SELECT t.name 
FROM sys.tables t
WHERE t.name IN ('Customer','Product','SalesOrder','SalesOrderItem','PurchaseOrder','PurchaseOrderItem',
                 'Warehouse','Vendor','UnitMeasure','ProductGroup','CustomerGroup','CustomerCategory',
                 'VendorGroup','VendorCategory','Tax','CustomerContact','VendorContact','NumberSequence',
                 'FileImage','FileDocument','DeliveryOrder','GoodsReceive','SalesReturn','PurchaseReturn',
                 'TransferIn','TransferOut','StockCount','NegativeAdjustment','PositiveAdjustment',
                 'Scrapping','InventoryTransaction');

OPEN alter_cursor;
FETCH NEXT FROM alter_cursor INTO @tableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @alterSql = @alterSql + N'ALTER TABLE [' + @tableName + N'] ALTER COLUMN [CompanyId] nvarchar(50) NOT NULL;' + CHAR(13) + CHAR(10);
    FETCH NEXT FROM alter_cursor INTO @tableName;
END

CLOSE alter_cursor;
DEALLOCATE alter_cursor;

EXEC sp_executesql @alterSql;

-- Step 6: Add indexes
DECLARE @indexSql NVARCHAR(MAX) = N'';

DECLARE index_cursor CURSOR FOR
SELECT t.name 
FROM sys.tables t
WHERE t.name IN ('Customer','Product','SalesOrder','SalesOrderItem','PurchaseOrder','PurchaseOrderItem',
                 'Warehouse','Vendor','UnitMeasure','ProductGroup','CustomerGroup','CustomerCategory',
                 'VendorGroup','VendorCategory','Tax','CustomerContact','VendorContact','NumberSequence',
                 'FileImage','FileDocument','DeliveryOrder','GoodsReceive','SalesReturn','PurchaseReturn',
                 'TransferIn','TransferOut','StockCount','NegativeAdjustment','PositiveAdjustment',
                 'Scrapping','InventoryTransaction')
  AND NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID('[' + t.name + ']') AND name = 'IX_' + t.name + '_CompanyId');

OPEN index_cursor;
FETCH NEXT FROM index_cursor INTO @tableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @indexSql = @indexSql + N'CREATE INDEX [IX_' + @tableName + '_CompanyId] ON [' + @tableName + N'] ([CompanyId]);' + CHAR(13) + CHAR(10);
    FETCH NEXT FROM index_cursor INTO @tableName;
END

CLOSE index_cursor;
DEALLOCATE index_cursor;

EXEC sp_executesql @indexSql;

-- Step 7: Add foreign keys
DECLARE @fkSql NVARCHAR(MAX) = N'';

DECLARE fk_cursor CURSOR FOR
SELECT t.name 
FROM sys.tables t
WHERE t.name IN ('Customer','Product','SalesOrder','SalesOrderItem','PurchaseOrder','PurchaseOrderItem',
                 'Warehouse','Vendor','UnitMeasure','ProductGroup','CustomerGroup','CustomerCategory',
                 'VendorGroup','VendorCategory','Tax','CustomerContact','VendorContact','NumberSequence',
                 'FileImage','FileDocument','DeliveryOrder','GoodsReceive','SalesReturn','PurchaseReturn',
                 'TransferIn','TransferOut','StockCount','NegativeAdjustment','PositiveAdjustment',
                 'Scrapping','InventoryTransaction')
  AND NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_' + t.name + '_Company_CompanyId');

OPEN fk_cursor;
FETCH NEXT FROM fk_cursor INTO @tableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @fkSql = @fkSql + N'ALTER TABLE [' + @tableName + N'] ADD CONSTRAINT [FK_' + @tableName + '_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION;' + CHAR(13) + CHAR(10);
    FETCH NEXT FROM fk_cursor INTO @tableName;
END

CLOSE fk_cursor;
DEALLOCATE fk_cursor;

EXEC sp_executesql @fkSql;

-- Step 8: Mark migration as applied
IF NOT EXISTS (SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20261118112334_AddMultiTenancy')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20261118112334_AddMultiTenancy', N'10.0.14');
END
