using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Proiect.Data.Migrations
{
    public partial class Final : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Messages_AspNetUsers_User_ID",
                table: "Messages");

            migrationBuilder.DropForeignKey(
                name: "FK_Messages_Groups_Group_ID",
                table: "Messages");

            migrationBuilder.AlterColumn<string>(
                name: "User_ID",
                table: "Messages",
                type: "nvarchar(450)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)");

            migrationBuilder.AlterColumn<int>(
                name: "Group_ID",
                table: "Messages",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_Messages_AspNetUsers_User_ID",
                table: "Messages",
                column: "User_ID",
                principalTable: "AspNetUsers",
                principalColumn: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_Messages_Groups_Group_ID",
                table: "Messages",
                column: "Group_ID",
                principalTable: "Groups",
                principalColumn: "Group_ID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Messages_AspNetUsers_User_ID",
                table: "Messages");

            migrationBuilder.DropForeignKey(
                name: "FK_Messages_Groups_Group_ID",
                table: "Messages");

            migrationBuilder.AlterColumn<string>(
                name: "User_ID",
                table: "Messages",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldNullable: true);

            migrationBuilder.AlterColumn<int>(
                name: "Group_ID",
                table: "Messages",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Messages_AspNetUsers_User_ID",
                table: "Messages",
                column: "User_ID",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Messages_Groups_Group_ID",
                table: "Messages",
                column: "Group_ID",
                principalTable: "Groups",
                principalColumn: "Group_ID",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
