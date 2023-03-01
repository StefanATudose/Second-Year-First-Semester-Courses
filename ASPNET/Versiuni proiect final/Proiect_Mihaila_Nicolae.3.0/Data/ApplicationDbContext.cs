using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using Proiect.Models;

namespace Proiect.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<ApplicationUser> ApplicationUsers { get; set; }
        public DbSet<Group> Groups { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Message> Messages { get; set; }
        public DbSet<UserGroup> UserGroups { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            // definire primary key compus
            modelBuilder.Entity<UserGroup>()
            .HasKey(m => new {m.User_ID, m.Group_ID});
            // definire relatii cu modelele User si Group (FK)
            modelBuilder.Entity<UserGroup>()
            .HasOne(m => m.User)
            .WithMany(m => m.UserGroups)
            .HasForeignKey(m => m.User_ID);
            modelBuilder.Entity<UserGroup>()
            .HasOne(m => m.Group)
            .WithMany(ab => ab.UserGroups)
            .HasForeignKey(ab => ab.Group_ID);
            modelBuilder.Entity<Message>()
             .HasOne(m => m.Group)
             .WithMany(m => m.Messages)
             .HasForeignKey(m => m.Group_ID);
            modelBuilder.Entity<Message>()
             .HasOne(m => m.User)
             .WithMany(m => m.Messages)
             .HasForeignKey(m => m.User_ID);
        }
    }
}
