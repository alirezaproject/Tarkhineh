using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class Mig_AddRefreshToken : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_FoodTypes_FoodTypes_FoodTypeId",
                table: "FoodTypes");

            migrationBuilder.DropIndex(
                name: "IX_FoodTypes_FoodTypeId",
                table: "FoodTypes");

            migrationBuilder.DropColumn(
                name: "FoodTypeId",
                table: "FoodTypes");

            migrationBuilder.AddColumn<string>(
                name: "RefreshToken",
                table: "Users",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "RefreshTokenExpiryTime",
                table: "Users",
                type: "datetime2",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "RefreshToken",
                table: "Users");

            migrationBuilder.DropColumn(
                name: "RefreshTokenExpiryTime",
                table: "Users");

            migrationBuilder.AddColumn<Guid>(
                name: "FoodTypeId",
                table: "FoodTypes",
                type: "uniqueidentifier",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_FoodTypes_FoodTypeId",
                table: "FoodTypes",
                column: "FoodTypeId");

            migrationBuilder.AddForeignKey(
                name: "FK_FoodTypes_FoodTypes_FoodTypeId",
                table: "FoodTypes",
                column: "FoodTypeId",
                principalTable: "FoodTypes",
                principalColumn: "Id");
        }
    }
}
