using Microsoft.EntityFrameworkCore;

namespace ProiectFinall.Models
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
            @"Data Source=(localdb)\mssqllocaldb;Initial Catalog=butoi;Integrated Security=True;MultipleActiveResultSets=True");
        }
        public DbSet<Group> Groups { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<User_Group> UserGroups { get; set; } 
        public DbSet <Message> Messages { get; set; }
        public DbSet <Category> Categories { get; set; }
    }
}
