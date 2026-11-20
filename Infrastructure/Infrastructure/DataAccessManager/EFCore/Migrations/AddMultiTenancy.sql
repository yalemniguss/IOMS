IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [AspNetRoles] (
        [Id] nvarchar(450) NOT NULL,
        [Name] nvarchar(256) NULL,
        [NormalizedName] nvarchar(256) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [Company] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [Currency] nvarchar(50) NULL,
        [Street] nvarchar(255) NULL,
        [City] nvarchar(255) NULL,
        [State] nvarchar(255) NULL,
        [ZipCode] nvarchar(50) NULL,
        [Country] nvarchar(255) NULL,
        [PhoneNumber] nvarchar(255) NULL,
        [FaxNumber] nvarchar(255) NULL,
        [EmailAddress] nvarchar(255) NULL,
        [Website] nvarchar(255) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        CONSTRAINT [PK_Company] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [Todo] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        CONSTRAINT [PK_Todo] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [Token] (
        [Id] nvarchar(50) NOT NULL,
        [UserId] nvarchar(450) NULL,
        [RefreshToken] nvarchar(255) NULL,
        [ExpiryDate] datetimeoffset NOT NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        CONSTRAINT [PK_Token] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [AspNetRoleClaims] (
        [Id] int NOT NULL IDENTITY,
        [RoleId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [AspNetUsers] (
        [Id] nvarchar(450) NOT NULL,
        [FirstName] nvarchar(255) NULL,
        [LastName] nvarchar(255) NULL,
        [CompanyName] nvarchar(max) NULL,
        [CompanyId] nvarchar(50) NULL,
        [ProfilePictureName] nvarchar(255) NULL,
        [IsBlocked] bit NULL,
        [IsDeleted] bit NULL,
        [CreatedAt] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAt] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [UserName] nvarchar(256) NULL,
        [NormalizedUserName] nvarchar(256) NULL,
        [Email] nvarchar(256) NULL,
        [NormalizedEmail] nvarchar(256) NULL,
        [EmailConfirmed] bit NOT NULL,
        [PasswordHash] nvarchar(max) NULL,
        [SecurityStamp] nvarchar(max) NULL,
        [ConcurrencyStamp] nvarchar(max) NULL,
        [PhoneNumber] nvarchar(max) NULL,
        [PhoneNumberConfirmed] bit NOT NULL,
        [TwoFactorEnabled] bit NOT NULL,
        [LockoutEnd] datetimeoffset NULL,
        [LockoutEnabled] bit NOT NULL,
        [AccessFailedCount] int NOT NULL,
        CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetUsers_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [CustomerCategory] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_CustomerCategory] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_CustomerCategory_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [CustomerGroup] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_CustomerGroup] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_CustomerGroup_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [FileDocument] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [OriginalName] nvarchar(255) NULL,
        [GeneratedName] nvarchar(255) NULL,
        [Extension] nvarchar(50) NULL,
        [FileSize] bigint NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_FileDocument] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_FileDocument_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [FileImage] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [OriginalName] nvarchar(255) NULL,
        [GeneratedName] nvarchar(255) NULL,
        [Extension] nvarchar(50) NULL,
        [FileSize] bigint NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_FileImage] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_FileImage_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [NegativeAdjustment] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(255) NULL,
        [AdjustmentDate] datetime2 NULL,
        [Status] int NULL,
        [Description] nvarchar(4000) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_NegativeAdjustment] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_NegativeAdjustment_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [NumberSequence] (
        [Id] nvarchar(50) NOT NULL,
        [EntityName] nvarchar(255) NULL,
        [Prefix] nvarchar(50) NULL,
        [Suffix] nvarchar(50) NULL,
        [LastUsedCount] int NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_NumberSequence] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_NumberSequence_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [PositiveAdjustment] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(255) NULL,
        [AdjustmentDate] datetime2 NULL,
        [Status] int NULL,
        [Description] nvarchar(4000) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_PositiveAdjustment] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_PositiveAdjustment_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [ProductGroup] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_ProductGroup] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_ProductGroup_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [Tax] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Percentage] float NULL,
        [Description] nvarchar(4000) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Tax] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Tax_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [UnitMeasure] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_UnitMeasure] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_UnitMeasure_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [VendorCategory] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_VendorCategory] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_VendorCategory_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [VendorGroup] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_VendorGroup] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_VendorGroup_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [Warehouse] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [SystemWarehouse] bit NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Warehouse] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Warehouse_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [TodoItem] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [TodoId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        CONSTRAINT [PK_TodoItem] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_TodoItem_Todo_TodoId] FOREIGN KEY ([TodoId]) REFERENCES [Todo] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [AspNetUserClaims] (
        [Id] int NOT NULL IDENTITY,
        [UserId] nvarchar(450) NOT NULL,
        [ClaimType] nvarchar(max) NULL,
        [ClaimValue] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [AspNetUserLogins] (
        [LoginProvider] nvarchar(128) NOT NULL,
        [ProviderKey] nvarchar(128) NOT NULL,
        [ProviderDisplayName] nvarchar(max) NULL,
        [UserId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
        CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [AspNetUserRoles] (
        [UserId] nvarchar(450) NOT NULL,
        [RoleId] nvarchar(450) NOT NULL,
        CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
        CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [AspNetUserTokens] (
        [UserId] nvarchar(450) NOT NULL,
        [LoginProvider] nvarchar(128) NOT NULL,
        [Name] nvarchar(128) NOT NULL,
        [Value] nvarchar(max) NULL,
        CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
        CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [Customer] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Number] nvarchar(50) NULL,
        [Description] nvarchar(4000) NULL,
        [Street] nvarchar(255) NULL,
        [City] nvarchar(255) NULL,
        [State] nvarchar(255) NULL,
        [ZipCode] nvarchar(255) NULL,
        [Country] nvarchar(255) NULL,
        [PhoneNumber] nvarchar(255) NULL,
        [FaxNumber] nvarchar(255) NULL,
        [EmailAddress] nvarchar(255) NULL,
        [Website] nvarchar(255) NULL,
        [WhatsApp] nvarchar(255) NULL,
        [LinkedIn] nvarchar(255) NULL,
        [Facebook] nvarchar(255) NULL,
        [Instagram] nvarchar(255) NULL,
        [TwitterX] nvarchar(255) NULL,
        [TikTok] nvarchar(255) NULL,
        [CustomerGroupId] nvarchar(50) NULL,
        [CustomerCategoryId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Customer] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Customer_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Customer_CustomerCategory_CustomerCategoryId] FOREIGN KEY ([CustomerCategoryId]) REFERENCES [CustomerCategory] ([Id]),
        CONSTRAINT [FK_Customer_CustomerGroup_CustomerGroupId] FOREIGN KEY ([CustomerGroupId]) REFERENCES [CustomerGroup] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [Product] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Number] nvarchar(50) NULL,
        [Description] nvarchar(4000) NULL,
        [UnitPrice] float NULL,
        [Physical] bit NULL,
        [UnitMeasureId] nvarchar(50) NULL,
        [ProductGroupId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Product] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Product_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Product_ProductGroup_ProductGroupId] FOREIGN KEY ([ProductGroupId]) REFERENCES [ProductGroup] ([Id]),
        CONSTRAINT [FK_Product_UnitMeasure_UnitMeasureId] FOREIGN KEY ([UnitMeasureId]) REFERENCES [UnitMeasure] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [Vendor] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Number] nvarchar(50) NULL,
        [Description] nvarchar(4000) NULL,
        [Street] nvarchar(255) NULL,
        [City] nvarchar(255) NULL,
        [State] nvarchar(255) NULL,
        [ZipCode] nvarchar(255) NULL,
        [Country] nvarchar(255) NULL,
        [PhoneNumber] nvarchar(255) NULL,
        [FaxNumber] nvarchar(255) NULL,
        [EmailAddress] nvarchar(255) NULL,
        [Website] nvarchar(255) NULL,
        [WhatsApp] nvarchar(255) NULL,
        [LinkedIn] nvarchar(255) NULL,
        [Facebook] nvarchar(255) NULL,
        [Instagram] nvarchar(255) NULL,
        [TwitterX] nvarchar(255) NULL,
        [TikTok] nvarchar(255) NULL,
        [VendorGroupId] nvarchar(50) NULL,
        [VendorCategoryId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Vendor] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Vendor_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Vendor_VendorCategory_VendorCategoryId] FOREIGN KEY ([VendorCategoryId]) REFERENCES [VendorCategory] ([Id]),
        CONSTRAINT [FK_Vendor_VendorGroup_VendorGroupId] FOREIGN KEY ([VendorGroupId]) REFERENCES [VendorGroup] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [Scrapping] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(50) NULL,
        [ScrappingDate] datetime2 NULL,
        [Status] int NULL,
        [Description] nvarchar(4000) NULL,
        [WarehouseId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_Scrapping] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Scrapping_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Scrapping_Warehouse_WarehouseId] FOREIGN KEY ([WarehouseId]) REFERENCES [Warehouse] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [StockCount] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(50) NULL,
        [CountDate] datetime2 NULL,
        [Status] int NULL,
        [Description] nvarchar(4000) NULL,
        [WarehouseId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_StockCount] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_StockCount_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_StockCount_Warehouse_WarehouseId] FOREIGN KEY ([WarehouseId]) REFERENCES [Warehouse] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [TransferOut] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(50) NULL,
        [TransferReleaseDate] datetime2 NULL,
        [Status] int NULL,
        [Description] nvarchar(4000) NULL,
        [WarehouseFromId] nvarchar(50) NULL,
        [WarehouseToId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_TransferOut] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_TransferOut_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_TransferOut_Warehouse_WarehouseFromId] FOREIGN KEY ([WarehouseFromId]) REFERENCES [Warehouse] ([Id]),
        CONSTRAINT [FK_TransferOut_Warehouse_WarehouseToId] FOREIGN KEY ([WarehouseToId]) REFERENCES [Warehouse] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [CustomerContact] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Number] nvarchar(50) NULL,
        [JobTitle] nvarchar(255) NULL,
        [PhoneNumber] nvarchar(255) NULL,
        [EmailAddress] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [CustomerId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_CustomerContact] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_CustomerContact_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_CustomerContact_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [SalesOrder] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(50) NULL,
        [OrderDate] datetime2 NULL,
        [OrderStatus] int NULL,
        [Description] nvarchar(4000) NULL,
        [CustomerId] nvarchar(50) NULL,
        [TaxId] nvarchar(50) NULL,
        [BeforeTaxAmount] float NULL,
        [TaxAmount] float NULL,
        [AfterTaxAmount] float NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_SalesOrder] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_SalesOrder_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_SalesOrder_Customer_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customer] ([Id]),
        CONSTRAINT [FK_SalesOrder_Tax_TaxId] FOREIGN KEY ([TaxId]) REFERENCES [Tax] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [InventoryTransaction] (
        [Id] nvarchar(50) NOT NULL,
        [ModuleId] nvarchar(50) NULL,
        [ModuleName] nvarchar(255) NULL,
        [ModuleCode] nvarchar(50) NULL,
        [ModuleNumber] nvarchar(max) NULL,
        [MovementDate] datetime2 NULL,
        [Status] int NULL,
        [Number] nvarchar(50) NULL,
        [WarehouseId] nvarchar(50) NULL,
        [ProductId] nvarchar(50) NULL,
        [Movement] float NULL,
        [TransType] int NULL,
        [Stock] float NULL,
        [WarehouseFromId] nvarchar(50) NULL,
        [WarehouseToId] nvarchar(50) NULL,
        [QtySCSys] float NULL,
        [QtySCCount] float NULL,
        [QtySCDelta] float NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_InventoryTransaction] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryTransaction_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_InventoryTransaction_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id]),
        CONSTRAINT [FK_InventoryTransaction_Warehouse_WarehouseFromId] FOREIGN KEY ([WarehouseFromId]) REFERENCES [Warehouse] ([Id]),
        CONSTRAINT [FK_InventoryTransaction_Warehouse_WarehouseId] FOREIGN KEY ([WarehouseId]) REFERENCES [Warehouse] ([Id]),
        CONSTRAINT [FK_InventoryTransaction_Warehouse_WarehouseToId] FOREIGN KEY ([WarehouseToId]) REFERENCES [Warehouse] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [PurchaseOrder] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(50) NULL,
        [OrderDate] datetime2 NULL,
        [OrderStatus] int NULL,
        [Description] nvarchar(4000) NULL,
        [VendorId] nvarchar(50) NULL,
        [TaxId] nvarchar(50) NULL,
        [BeforeTaxAmount] float NULL,
        [TaxAmount] float NULL,
        [AfterTaxAmount] float NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_PurchaseOrder] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_PurchaseOrder_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_PurchaseOrder_Tax_TaxId] FOREIGN KEY ([TaxId]) REFERENCES [Tax] ([Id]),
        CONSTRAINT [FK_PurchaseOrder_Vendor_VendorId] FOREIGN KEY ([VendorId]) REFERENCES [Vendor] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [VendorContact] (
        [Id] nvarchar(50) NOT NULL,
        [Name] nvarchar(255) NULL,
        [Number] nvarchar(50) NULL,
        [JobTitle] nvarchar(255) NULL,
        [PhoneNumber] nvarchar(255) NULL,
        [EmailAddress] nvarchar(255) NULL,
        [Description] nvarchar(4000) NULL,
        [VendorId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_VendorContact] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_VendorContact_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_VendorContact_Vendor_VendorId] FOREIGN KEY ([VendorId]) REFERENCES [Vendor] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [TransferIn] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(50) NULL,
        [TransferReceiveDate] datetime2 NULL,
        [Status] int NULL,
        [Description] nvarchar(4000) NULL,
        [TransferOutId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_TransferIn] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_TransferIn_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_TransferIn_TransferOut_TransferOutId] FOREIGN KEY ([TransferOutId]) REFERENCES [TransferOut] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [DeliveryOrder] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(50) NULL,
        [DeliveryDate] datetime2 NULL,
        [Status] int NULL,
        [Description] nvarchar(4000) NULL,
        [SalesOrderId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_DeliveryOrder] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_DeliveryOrder_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_DeliveryOrder_SalesOrder_SalesOrderId] FOREIGN KEY ([SalesOrderId]) REFERENCES [SalesOrder] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [SalesOrderItem] (
        [Id] nvarchar(50) NOT NULL,
        [SalesOrderId] nvarchar(50) NULL,
        [ProductId] nvarchar(50) NULL,
        [Summary] nvarchar(4000) NULL,
        [UnitPrice] float NULL,
        [Quantity] float NULL,
        [Total] float NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_SalesOrderItem] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_SalesOrderItem_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_SalesOrderItem_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id]),
        CONSTRAINT [FK_SalesOrderItem_SalesOrder_SalesOrderId] FOREIGN KEY ([SalesOrderId]) REFERENCES [SalesOrder] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [GoodsReceive] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(50) NULL,
        [ReceiveDate] datetime2 NULL,
        [Status] int NULL,
        [Description] nvarchar(4000) NULL,
        [PurchaseOrderId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_GoodsReceive] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_GoodsReceive_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_GoodsReceive_PurchaseOrder_PurchaseOrderId] FOREIGN KEY ([PurchaseOrderId]) REFERENCES [PurchaseOrder] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [PurchaseOrderItem] (
        [Id] nvarchar(50) NOT NULL,
        [PurchaseOrderId] nvarchar(50) NULL,
        [ProductId] nvarchar(50) NULL,
        [Summary] nvarchar(4000) NULL,
        [UnitPrice] float NULL,
        [Quantity] float NULL,
        [Total] float NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_PurchaseOrderItem] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_PurchaseOrderItem_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_PurchaseOrderItem_Product_ProductId] FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id]),
        CONSTRAINT [FK_PurchaseOrderItem_PurchaseOrder_PurchaseOrderId] FOREIGN KEY ([PurchaseOrderId]) REFERENCES [PurchaseOrder] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [SalesReturn] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(50) NULL,
        [ReturnDate] datetime2 NULL,
        [Status] int NULL,
        [Description] nvarchar(4000) NULL,
        [DeliveryOrderId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_SalesReturn] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_SalesReturn_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_SalesReturn_DeliveryOrder_DeliveryOrderId] FOREIGN KEY ([DeliveryOrderId]) REFERENCES [DeliveryOrder] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE TABLE [PurchaseReturn] (
        [Id] nvarchar(50) NOT NULL,
        [Number] nvarchar(50) NULL,
        [ReturnDate] datetime2 NULL,
        [Status] int NULL,
        [Description] nvarchar(4000) NULL,
        [GoodsReceiveId] nvarchar(50) NULL,
        [IsDeleted] bit NOT NULL DEFAULT CAST(0 AS bit),
        [CreatedAtUtc] datetime2 NULL,
        [CreatedById] nvarchar(450) NULL,
        [UpdatedAtUtc] datetime2 NULL,
        [UpdatedById] nvarchar(450) NULL,
        [CompanyId] nvarchar(50) NOT NULL,
        CONSTRAINT [PK_PurchaseReturn] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_PurchaseReturn_Company_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Company] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_PurchaseReturn_GoodsReceive_GoodsReceiveId] FOREIGN KEY ([GoodsReceiveId]) REFERENCES [GoodsReceive] ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_AspNetUsers_CompanyId] ON [AspNetUsers] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_AspNetUsers_Email] ON [AspNetUsers] ([Email]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_AspNetUsers_FirstName] ON [AspNetUsers] ([FirstName]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_AspNetUsers_LastName] ON [AspNetUsers] ([LastName]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_AspNetUsers_UserName] ON [AspNetUsers] ([UserName]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    EXEC(N'CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL');
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Customer_CompanyId] ON [Customer] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Customer_CustomerCategoryId] ON [Customer] ([CustomerCategoryId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Customer_CustomerGroupId] ON [Customer] ([CustomerGroupId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Customer_Name] ON [Customer] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Customer_Number] ON [Customer] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_CustomerCategory_CompanyId] ON [CustomerCategory] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_CustomerCategory_Name] ON [CustomerCategory] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_CustomerContact_CompanyId] ON [CustomerContact] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_CustomerContact_CustomerId] ON [CustomerContact] ([CustomerId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_CustomerContact_Name] ON [CustomerContact] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_CustomerContact_Number] ON [CustomerContact] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_CustomerGroup_CompanyId] ON [CustomerGroup] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_CustomerGroup_Name] ON [CustomerGroup] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_DeliveryOrder_CompanyId] ON [DeliveryOrder] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_DeliveryOrder_Number] ON [DeliveryOrder] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_DeliveryOrder_SalesOrderId] ON [DeliveryOrder] ([SalesOrderId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_FileDocument_CompanyId] ON [FileDocument] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_FileDocument_GeneratedName] ON [FileDocument] ([GeneratedName]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_FileDocument_OriginalName] ON [FileDocument] ([OriginalName]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_FileImage_CompanyId] ON [FileImage] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_FileImage_GeneratedName] ON [FileImage] ([GeneratedName]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_FileImage_OriginalName] ON [FileImage] ([OriginalName]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_GoodsReceive_CompanyId] ON [GoodsReceive] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_GoodsReceive_Number] ON [GoodsReceive] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_GoodsReceive_PurchaseOrderId] ON [GoodsReceive] ([PurchaseOrderId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_InventoryTransaction_CompanyId] ON [InventoryTransaction] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_InventoryTransaction_ModuleCode] ON [InventoryTransaction] ([ModuleCode]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_InventoryTransaction_ModuleName] ON [InventoryTransaction] ([ModuleName]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_InventoryTransaction_Number] ON [InventoryTransaction] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_InventoryTransaction_ProductId] ON [InventoryTransaction] ([ProductId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_InventoryTransaction_WarehouseFromId] ON [InventoryTransaction] ([WarehouseFromId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_InventoryTransaction_WarehouseId] ON [InventoryTransaction] ([WarehouseId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_InventoryTransaction_WarehouseToId] ON [InventoryTransaction] ([WarehouseToId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_NegativeAdjustment_CompanyId] ON [NegativeAdjustment] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_NegativeAdjustment_Number] ON [NegativeAdjustment] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_NumberSequence_CompanyId] ON [NumberSequence] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_NumberSequence_EntityName] ON [NumberSequence] ([EntityName]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PositiveAdjustment_CompanyId] ON [PositiveAdjustment] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PositiveAdjustment_Number] ON [PositiveAdjustment] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Product_CompanyId] ON [Product] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Product_Name] ON [Product] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Product_Number] ON [Product] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Product_ProductGroupId] ON [Product] ([ProductGroupId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Product_UnitMeasureId] ON [Product] ([UnitMeasureId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_ProductGroup_CompanyId] ON [ProductGroup] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_ProductGroup_Name] ON [ProductGroup] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PurchaseOrder_CompanyId] ON [PurchaseOrder] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PurchaseOrder_Number] ON [PurchaseOrder] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PurchaseOrder_TaxId] ON [PurchaseOrder] ([TaxId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PurchaseOrder_VendorId] ON [PurchaseOrder] ([VendorId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PurchaseOrderItem_CompanyId] ON [PurchaseOrderItem] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PurchaseOrderItem_ProductId] ON [PurchaseOrderItem] ([ProductId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PurchaseOrderItem_PurchaseOrderId] ON [PurchaseOrderItem] ([PurchaseOrderId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PurchaseReturn_CompanyId] ON [PurchaseReturn] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PurchaseReturn_GoodsReceiveId] ON [PurchaseReturn] ([GoodsReceiveId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_PurchaseReturn_Number] ON [PurchaseReturn] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_SalesOrder_CompanyId] ON [SalesOrder] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_SalesOrder_CustomerId] ON [SalesOrder] ([CustomerId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_SalesOrder_Number] ON [SalesOrder] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_SalesOrder_TaxId] ON [SalesOrder] ([TaxId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_SalesOrderItem_CompanyId] ON [SalesOrderItem] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_SalesOrderItem_ProductId] ON [SalesOrderItem] ([ProductId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_SalesOrderItem_SalesOrderId] ON [SalesOrderItem] ([SalesOrderId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_SalesReturn_CompanyId] ON [SalesReturn] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_SalesReturn_DeliveryOrderId] ON [SalesReturn] ([DeliveryOrderId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_SalesReturn_Number] ON [SalesReturn] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Scrapping_CompanyId] ON [Scrapping] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Scrapping_Number] ON [Scrapping] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Scrapping_WarehouseId] ON [Scrapping] ([WarehouseId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_StockCount_CompanyId] ON [StockCount] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_StockCount_Number] ON [StockCount] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_StockCount_WarehouseId] ON [StockCount] ([WarehouseId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Tax_CompanyId] ON [Tax] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Tax_Name] ON [Tax] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Todo_Name] ON [Todo] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_TodoItem_Name] ON [TodoItem] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_TodoItem_TodoId] ON [TodoItem] ([TodoId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_TransferIn_CompanyId] ON [TransferIn] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_TransferIn_Number] ON [TransferIn] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_TransferIn_TransferOutId] ON [TransferIn] ([TransferOutId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_TransferOut_CompanyId] ON [TransferOut] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_TransferOut_Number] ON [TransferOut] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_TransferOut_WarehouseFromId] ON [TransferOut] ([WarehouseFromId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_TransferOut_WarehouseToId] ON [TransferOut] ([WarehouseToId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_UnitMeasure_CompanyId] ON [UnitMeasure] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_UnitMeasure_Name] ON [UnitMeasure] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Vendor_CompanyId] ON [Vendor] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Vendor_Name] ON [Vendor] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Vendor_Number] ON [Vendor] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Vendor_VendorCategoryId] ON [Vendor] ([VendorCategoryId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Vendor_VendorGroupId] ON [Vendor] ([VendorGroupId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_VendorCategory_CompanyId] ON [VendorCategory] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_VendorCategory_Name] ON [VendorCategory] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_VendorContact_CompanyId] ON [VendorContact] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_VendorContact_Name] ON [VendorContact] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_VendorContact_Number] ON [VendorContact] ([Number]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_VendorContact_VendorId] ON [VendorContact] ([VendorId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_VendorGroup_CompanyId] ON [VendorGroup] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_VendorGroup_Name] ON [VendorGroup] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Warehouse_CompanyId] ON [Warehouse] ([CompanyId]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    CREATE INDEX [IX_Warehouse_Name] ON [Warehouse] ([Name]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20261118112334_AddMultiTenancy'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261118112334_AddMultiTenancy', N'10.0.14');
END;

COMMIT;
GO

