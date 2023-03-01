using Microsoft.EntityFrameworkCore;

namespace Lab3.Models
{
    public class AppDbContext : DbContext
    {
        public AppDbContext() : base()
        {
        }
        protected override void OnConfiguring
        (DbContextOptionsBuilder options)
        {
            options.UseSqlServer(
            @"Data Source=(localdb)\mssqllocaldb;Initial Catalog=pregEx;Integrated Security=True;MultipleActiveResultSets=True");
        }
        public DbSet<Article> Articles { get; set; }
        public DbSet<Categoy> Categories { get; set; }
    }
}
