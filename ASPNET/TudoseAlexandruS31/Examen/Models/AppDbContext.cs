using Microsoft.EntityFrameworkCore;

namespace Examen.Models
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
            @"Data Source=(localdb)\mssqllocaldb;Initial Catalog=examen;Integrated Security=True;MultipleActiveResultSets=True");
        }
        //public DbSet<Student> Students { get; set; }
        public DbSet <Ticket> Tickets { get; set; }
        public DbSet <Movie> Movies { get; set; }
    }
}
