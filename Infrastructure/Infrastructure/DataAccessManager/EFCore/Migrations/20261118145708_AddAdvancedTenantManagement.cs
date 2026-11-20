using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace IOMS.Infrastructure.DataAccessManager.EFCore.Migrations
{
    /// <inheritdoc />
    public partial class AddAdvancedTenantManagement : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "ContactEmail",
                table: "Company",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ContactPerson",
                table: "Company",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "ContactPhone",
                table: "Company",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "LogoUrl",
                table: "Company",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MaxUsers",
                table: "Company",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "MaxWarehouses",
                table: "Company",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Plan",
                table: "Company",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Settings",
                table: "Company",
                type: "nvarchar(4000)",
                maxLength: 4000,
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "Status",
                table: "Company",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<string>(
                name: "Subdomain",
                table: "Company",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "SubscriptionExpiresAt",
                table: "Company",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TimeZone",
                table: "Company",
                type: "nvarchar(255)",
                maxLength: 255,
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "TrialExpiresAt",
                table: "Company",
                type: "datetime2",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_Company_EmailAddress",
                table: "Company",
                column: "EmailAddress");

            migrationBuilder.CreateIndex(
                name: "IX_Company_Status",
                table: "Company",
                column: "Status");

            migrationBuilder.CreateIndex(
                name: "IX_Company_Subdomain",
                table: "Company",
                column: "Subdomain",
                unique: true,
                filter: "[Subdomain] IS NOT NULL");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropIndex(
                name: "IX_Company_EmailAddress",
                table: "Company");

            migrationBuilder.DropIndex(
                name: "IX_Company_Status",
                table: "Company");

            migrationBuilder.DropIndex(
                name: "IX_Company_Subdomain",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "ContactEmail",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "ContactPerson",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "ContactPhone",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "LogoUrl",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "MaxUsers",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "MaxWarehouses",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "Plan",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "Settings",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "Status",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "Subdomain",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "SubscriptionExpiresAt",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "TimeZone",
                table: "Company");

            migrationBuilder.DropColumn(
                name: "TrialExpiresAt",
                table: "Company");
        }
    }
}
