using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Proiect.Data;
using static System.Net.WebRequestMethods;

namespace Proiect.Models
{
    public static class SeedData
    {
        public static void Initialize(IServiceProvider serviceProvider)
        {
            using (var context = new ApplicationDbContext(
            serviceProvider.GetRequiredService
            <DbContextOptions<ApplicationDbContext>>()))
            {
                // Verificam daca in baza de date exista cel putin un rol
                // insemnand ca a fost rulat codul
                // De aceea facem return pentru a nu insera rolurile inca o data
                // Acesta metoda trebuie sa se execute o singura data
                if (context.Roles.Any())
                {
                    return; // baza de date contine deja roluri
                }
                // CREAREA ROLURILOR IN BD
                // daca nu contine roluri, acestea se vor crea
                context.Roles.AddRange(
                new IdentityRole { Id = "2c5e174e-3b0e-446f-86af-483d56fd7210", Name = "Admin", NormalizedName = "Admin".ToUpper() },
                new IdentityRole { Id = "2c5e174e-3b0e-446f-86af-483d56fd7211", Name = "RegisteredUser", NormalizedName = "RegisteredUser".ToUpper() }
                );
                // o noua instanta pe care o vom utiliza pentru crearea parolelor utilizatorilor
                // parolele sunt de tip hash
                var hasher = new PasswordHasher<ApplicationUser>();
                // CREAREA USERILOR IN BD
                // Am creat manual doar Admin-ul. Restul isi vor face cont
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "8e445865-a24d-4543-a6c6-9443d048cdb0", // primary key
                    UserName = "admin@yahoo.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "ADMIN@YAHOO.COM",
                    Email = "admin@yahoo.com",
                    NormalizedUserName = "admin@yahoo.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "Admin1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                // ASOCIEREA USER-ROLE
                // Ii dam Admin-ului rolul de Admin
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7210",
                    UserId = "8e445865-a24d-4543-a6c6-9443d048cdb0"
                }
                );
                context.SaveChanges();
            }
        }
        public static void AddUser(IServiceProvider serviceProvider)
        {
            using (var context = new ApplicationDbContext(
            serviceProvider.GetRequiredService
            <DbContextOptions<ApplicationDbContext>>()))
            {
                var hasher = new PasswordHasher<ApplicationUser>();
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "015e4c78-c6ef-470b-b968-9b1d180c0d7d", // primary key
                    UserName = "user@u1.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "user@u1.com".ToUpper(),
                    Email = "user@u1.com",
                    NormalizedUserName = "user@u1.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "User1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "26cdb628-06d2-4ce2-8740-7f59a8a7fbe2", // primary key
                    UserName = "user@u2.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "user@u2.com".ToUpper(),
                    Email = "user@u2.com",
                    NormalizedUserName = "user@u2.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "User1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "9c9ea3cd-48b5-466e-907a-8c68776890da", // primary key
                    UserName = "user@u3.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "user@u3.com".ToUpper(),
                    Email = "user@u3.com",
                    NormalizedUserName = "user@u3.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "User1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "9ade0a2f-8da6-4dc2-a3ba-1792c5a46bae", // primary key
                    UserName = "user@u4.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "user@u4.com".ToUpper(),
                    Email = "user@u4.com",
                    NormalizedUserName = "user@u4.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "User1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "e5865c42-4f2e-47b3-9946-83eb53a4e52c", // primary key
                    UserName = "user@u10.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "user@u10.com".ToUpper(),
                    Email = "user@u10.com",
                    NormalizedUserName = "user@u10.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "User1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "ca14f88a-91fa-4828-916b-4dc12375480a", // primary key
                    UserName = "user@u5.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "user@u5.com".ToUpper(),
                    Email = "user@u5.com",
                    NormalizedUserName = "user@u5.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "User1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "e20a9fd6-e0e6-441e-8f16-c17bc7dccdc0", // primary key
                    UserName = "user@u6.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "user@u6.com".ToUpper(),
                    Email = "user@u6.com",
                    NormalizedUserName = "user@u6.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "User1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "8f3d28c6-9871-41a6-9128-dd6f1e384a15", // primary key
                    UserName = "user@u7.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "user@u7.com".ToUpper(),
                    Email = "user@u7.com",
                    NormalizedUserName = "user@u7.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "User1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "f10af72c-d98c-4e26-8e1f-52627d7695f8", // primary key
                    UserName = "user@u8.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "user@u8.com".ToUpper(),
                    Email = "user@u8.com",
                    NormalizedUserName = "user@u8.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "User1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "bc3ad0b1-a411-4ddd-9162-be07b0636a44", // primary key
                    UserName = "user@u9.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "user@u9.com".ToUpper(),
                    Email = "user@u9.com",
                    NormalizedUserName = "user@u9.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "User1!"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );

                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7211",
                    UserId = "015e4c78-c6ef-470b-b968-9b1d180c0d7d"
                }
                );
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7211",
                    UserId = "26cdb628-06d2-4ce2-8740-7f59a8a7fbe2"
                }
                );
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7211",
                    UserId = "9c9ea3cd-48b5-466e-907a-8c68776890da"
                }
                );
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7211",
                    UserId = "9ade0a2f-8da6-4dc2-a3ba-1792c5a46bae"
                }
                );
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7211",
                    UserId = "e5865c42-4f2e-47b3-9946-83eb53a4e52c"
                }
                );
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7211",
                    UserId = "ca14f88a-91fa-4828-916b-4dc12375480a"
                }
                );
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7211",
                    UserId = "e20a9fd6-e0e6-441e-8f16-c17bc7dccdc0"
                }
                );
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7211",
                    UserId = "8f3d28c6-9871-41a6-9128-dd6f1e384a15"
                }
                );
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7211",
                    UserId = "f10af72c-d98c-4e26-8e1f-52627d7695f8"
                }
                );
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7211",
                    UserId = "bc3ad0b1-a411-4ddd-9162-be07b0636a44"
                }
                );


                /*
                context.Users.AddRange(
                new ApplicationUser
                {
                    Id = "dd7b1856-5ca4-44d7-841a-3ae3cb2169d7", // primary key
                    UserName = "stefan.tudose5@gmail.com",
                    EmailConfirmed = true,
                    NormalizedEmail = "STEFAN.TUDOSE5@GMAIL.COM",
                    Email = "stefan.tudose5@gmail.com",
                    NormalizedUserName = "stefan.tudose5@gmail.com".ToUpper(),
                    PasswordHash = hasher.HashPassword(null, "Tudose#1"),
                    LockoutEnabled = false,
                    SecurityStamp = Guid.NewGuid().ToString()
                }
                );
                // ASOCIEREA USER-ROLE
                // Ii dam Admin-ului rolul de Admin
                context.UserRoles.AddRange(
                new IdentityUserRole<string>
                {
                    RoleId = "2c5e174e-3b0e-446f-86af-483d56fd7210",
                    UserId = "dd7b1856-5ca4-44d7-841a-3ae3cb2169d7"
                }
                );*/
                context.SaveChanges();
            }
        }
    }
}
