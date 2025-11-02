using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Mig_AddRelationForFoodTypeWithCategory : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<Guid>(
                name: "FoodTypeId",
                table: "Categories",
                type: "uniqueidentifier",
                nullable: false,
                defaultValue: new Guid("00000000-0000-0000-0000-000000000000"));

            migrationBuilder.CreateIndex(
                name: "IX_Categories_FoodTypeId",
                table: "Categories",
                column: "FoodTypeId");

            migrationBuilder.AddForeignKey(
                name: "FK_Categories_FoodTypes_FoodTypeId",
                table: "Categories",
                column: "FoodTypeId",
                principalTable: "FoodTypes",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Categories_FoodTypes_FoodTypeId",
                table: "Categories");

            migrationBuilder.DropIndex(
                name: "IX_Categories_FoodTypeId",
                table: "Categories");

            migrationBuilder.DropColumn(
                name: "FoodTypeId",
                table: "Categories");
        }
    }
}
