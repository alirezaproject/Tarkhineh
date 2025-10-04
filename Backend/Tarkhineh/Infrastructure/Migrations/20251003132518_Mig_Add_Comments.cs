using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Mig_Add_Comments : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "FoodTypeId",
                table: "FoodTypes",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.AddColumn<Guid>(
                name: "FoodTypeId",
                table: "Foods",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateTable(
                name: "Comments",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uniqueidentifier", nullable: false),
                    Text = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    BranchId = table.Column<Guid>(type: "uniqueidentifier", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Comments", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Comments_Branch_BranchId",
                        column: x => x.BranchId,
                        principalTable: "Branch",
                        principalColumn: "Id");
                });

            migrationBuilder.CreateIndex(
                name: "IX_FoodTypes_FoodTypeId",
                table: "FoodTypes",
                column: "FoodTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_Foods_FoodTypeId",
                table: "Foods",
                column: "FoodTypeId");

            migrationBuilder.CreateIndex(
                name: "IX_Comments_BranchId",
                table: "Comments",
                column: "BranchId");

            migrationBuilder.AddForeignKey(
                name: "FK_Foods_FoodTypes_FoodTypeId",
                table: "Foods",
                column: "FoodTypeId",
                principalTable: "FoodTypes",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_FoodTypes_FoodTypes_FoodTypeId",
                table: "FoodTypes",
                column: "FoodTypeId",
                principalTable: "FoodTypes",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Foods_FoodTypes_FoodTypeId",
                table: "Foods");

            migrationBuilder.DropForeignKey(
                name: "FK_FoodTypes_FoodTypes_FoodTypeId",
                table: "FoodTypes");

            migrationBuilder.DropTable(
                name: "Comments");

            migrationBuilder.DropIndex(
                name: "IX_FoodTypes_FoodTypeId",
                table: "FoodTypes");

            migrationBuilder.DropIndex(
                name: "IX_Foods_FoodTypeId",
                table: "Foods");

            migrationBuilder.DropColumn(
                name: "FoodTypeId",
                table: "FoodTypes");

            migrationBuilder.DropColumn(
                name: "FoodTypeId",
                table: "Foods");
        }
    }
}
