using Microsoft.EntityFrameworkCore;

namespace Proiect_FINAL.Models
{
    public class AppDBContext : DbContext
    {
        public AppDBContext() : base()
        {
        }
        protected override void OnConfiguring
        (DbContextOptionsBuilder options)
        {
            options.UseSqlServer(
            @"Server=(localdb)\mssqllocaldb;Database=aspnet-53bc9b9d-9d6a-45d4-8429-2a2761773502;Trusted_Connection=True;MultipleActiveResultSets=true");
        }
        public DbSet<Group> Groups { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<User_Group> UserGroups { get; set; } 
        public DbSet <Message> Messages { get; set; }
        public DbSet <Category> Categories { get; set; }
    }
}
