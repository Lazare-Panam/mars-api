using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Mars.API.Migrations
{
    /// <inheritdoc />
    public partial class AddSeriesIdAndQuoteRequestTables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "SeriesId",
                table: "BasketItems",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "QuoteRequests",
                columns: table => new
                {
                    QuoteRequestId = table.Column<string>(type: "nvarchar(450)", maxLength: 450, nullable: false),
                    UserId = table.Column<string>(type: "nvarchar(450)", maxLength: 450, nullable: true),
                    CreatedAt = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: false),
                    UpdatedAt = table.Column<DateTimeOffset>(type: "datetimeoffset", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_QuoteRequests", x => x.QuoteRequestId);
                    table.ForeignKey(
                        name: "FK_QuoteRequests_AspNetUsers_UserId",
                        column: x => x.UserId,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.SetNull);
                });

            migrationBuilder.CreateTable(
                name: "QuoteRequestItems",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", maxLength: 450, nullable: false),
                    ProductId = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    ProductDescription = table.Column<string>(type: "nvarchar(500)", maxLength: 500, nullable: false),
                    UnitPrice = table.Column<decimal>(type: "decimal(18,2)", nullable: true),
                    Quantity = table.Column<int>(type: "int", nullable: false),
                    PictureUrl = table.Column<string>(type: "nvarchar(2048)", maxLength: 2048, nullable: false),
                    QuoteRequestId = table.Column<string>(type: "nvarchar(450)", maxLength: 450, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_QuoteRequestItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_QuoteRequestItems_QuoteRequests_QuoteRequestId",
                        column: x => x.QuoteRequestId,
                        principalTable: "QuoteRequests",
                        principalColumn: "QuoteRequestId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_QuoteRequestItems_QuoteRequestId",
                table: "QuoteRequestItems",
                column: "QuoteRequestId");

            migrationBuilder.CreateIndex(
                name: "IX_QuoteRequests_QuoteRequestId_UserId",
                table: "QuoteRequests",
                columns: new[] { "QuoteRequestId", "UserId" });

            migrationBuilder.CreateIndex(
                name: "IX_QuoteRequests_UserId",
                table: "QuoteRequests",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "QuoteRequestItems");

            migrationBuilder.DropTable(
                name: "QuoteRequests");

            migrationBuilder.DropColumn(
                name: "SeriesId",
                table: "BasketItems");
        }
    }
}
