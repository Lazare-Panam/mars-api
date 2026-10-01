using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mars.API.Migrations
{
    /// <inheritdoc />
    public partial class CreditLineApplication : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "CreditLineApplications",
                columns: table => new
                {
                    ApplicationId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    RegistrationNumber = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    CompanyName = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    VatNumber = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    AddressLine1 = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    AddressLine2 = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    Website = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    Sector = table.Column<string>(type: "nvarchar(150)", maxLength: 150, nullable: false),
                    YearsInBusiness = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Employees = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true),
                    ContactName = table.Column<string>(type: "nvarchar(150)", maxLength: 150, nullable: false),
                    JobTitle = table.Column<string>(type: "nvarchar(150)", maxLength: 150, nullable: false),
                    Email = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: false),
                    Phone = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    CreditLimitRequested = table.Column<decimal>(type: "decimal(12,2)", precision: 12, scale: 2, nullable: false),
                    PaymentTerms = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Currency = table.Column<string>(type: "nvarchar(3)", maxLength: 3, nullable: false),
                    MonthlyOrderValue = table.Column<decimal>(type: "decimal(12,2)", precision: 12, scale: 2, nullable: false),
                    Products = table.Column<string>(type: "nvarchar(400)", maxLength: 400, nullable: true),
                    SignatoryName = table.Column<string>(type: "nvarchar(150)", maxLength: 150, nullable: false),
                    SignatoryTitle = table.Column<string>(type: "nvarchar(150)", maxLength: 150, nullable: false),
                    Signature = table.Column<string>(type: "nvarchar(150)", maxLength: 150, nullable: false),
                    DeclarationDate = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: false),
                    DeclarationAccepted = table.Column<bool>(type: "bit", nullable: false),
                    SubmittedAtUtc = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(20)", maxLength: 20, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CreditLineApplications", x => x.ApplicationId);
                });

            migrationBuilder.CreateIndex(
                name: "IX_CreditLineApplications_Status",
                table: "CreditLineApplications",
                column: "Status");

            migrationBuilder.CreateIndex(
                name: "IX_CreditLineApplications_SubmittedAtUtc",
                table: "CreditLineApplications",
                column: "SubmittedAtUtc");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "CreditLineApplications");
        }
    }
}
