using Microsoft.EntityFrameworkCore;

namespace PregExamen.Models
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
            @"Data Source = (localdb)\mssqllocaldb; Initial Catalog = try2; Integrated Security = True; MultipleActiveResultSets = True");
        }
        public DbSet<GiftCard> GiftCards { get; set; }
        public DbSet<Brand> Brands { get; set; }
    }
}



