using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mars.API.Migrations
{
    /// <inheritdoc />
    public partial class AddCategorySeriesInfo : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "Approvals",
                table: "Categories",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "BodyMaterial",
                table: "Categories",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "CertificatesJson",
                table: "Categories",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "DatasheetUrl",
                table: "Categories",
                type: "nvarchar(2048)",
                maxLength: 2048,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Description",
                table: "Categories",
                type: "nvarchar(2000)",
                maxLength: 2000,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "Design",
                table: "Categories",
                type: "nvarchar(200)",
                maxLength: 200,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "KeyFeatures",
                table: "Categories",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "SeatMaterial",
                table: "Categories",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "TemperatureRange",
                table: "Categories",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Approvals",
                table: "Categories");

            migrationBuilder.DropColumn(
                name: "BodyMaterial",
                table: "Categories");

            migrationBuilder.DropColumn(
                name: "CertificatesJson",
                table: "Categories");

            migrationBuilder.DropColumn(
                name: "DatasheetUrl",
                table: "Categories");

            migrationBuilder.DropColumn(
                name: "Description",
                table: "Categories");

            migrationBuilder.DropColumn(
                name: "Design",
                table: "Categories");

            migrationBuilder.DropColumn(
                name: "KeyFeatures",
                table: "Categories");

            migrationBuilder.DropColumn(
                name: "SeatMaterial",
                table: "Categories");

            migrationBuilder.DropColumn(
                name: "TemperatureRange",
                table: "Categories");
        }
    }
}
