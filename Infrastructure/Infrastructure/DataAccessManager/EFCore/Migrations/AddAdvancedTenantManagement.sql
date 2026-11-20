SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;

-- Add new columns to Company table
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'Subdomain')
BEGIN
    ALTER TABLE [Company] ADD [Subdomain] nvarchar(50) NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'LogoUrl')
BEGIN
    ALTER TABLE [Company] ADD [LogoUrl] nvarchar(255) NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'TimeZone')
BEGIN
    ALTER TABLE [Company] ADD [TimeZone] nvarchar(255) NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'ContactPerson')
BEGIN
    ALTER TABLE [Company] ADD [ContactPerson] nvarchar(255) NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'ContactPhone')
BEGIN
    ALTER TABLE [Company] ADD [ContactPhone] nvarchar(255) NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'ContactEmail')
BEGIN
    ALTER TABLE [Company] ADD [ContactEmail] nvarchar(255) NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'Settings')
BEGIN
    ALTER TABLE [Company] ADD [Settings] nvarchar(4000) NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'Status')
BEGIN
    ALTER TABLE [Company] ADD [Status] int NOT NULL DEFAULT 1;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'TrialExpiresAt')
BEGIN
    ALTER TABLE [Company] ADD [TrialExpiresAt] datetime2 NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'SubscriptionExpiresAt')
BEGIN
    ALTER TABLE [Company] ADD [SubscriptionExpiresAt] datetime2 NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'MaxUsers')
BEGIN
    ALTER TABLE [Company] ADD [MaxUsers] int NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'MaxWarehouses')
BEGIN
    ALTER TABLE [Company] ADD [MaxWarehouses] int NULL;
END
GO

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'[Company]') AND name = N'Plan')
BEGIN
    ALTER TABLE [Company] ADD [Plan] nvarchar(50) NULL;
END
GO

-- Add unique index on Subdomain
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Company_Subdomain' AND object_id = OBJECT_ID(N'[Company]'))
BEGIN
    CREATE UNIQUE INDEX [IX_Company_Subdomain] ON [Company] ([Subdomain]) WHERE [Subdomain] IS NOT NULL;
END
GO

-- Add index on Status
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Company_Status' AND object_id = OBJECT_ID(N'[Company]'))
BEGIN
    CREATE INDEX [IX_Company_Status] ON [Company] ([Status]);
END
GO

-- Mark migration as applied
IF NOT EXISTS (SELECT * FROM [__EFMigrationsHistory] WHERE [MigrationId] = N'20261118145708_AddAdvancedTenantManagement')
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20261118145708_AddAdvancedTenantManagement', N'10.0.14');
    PRINT 'Migration marked as applied';
END ELSE
BEGIN
    PRINT 'Migration already applied';
END
GO
