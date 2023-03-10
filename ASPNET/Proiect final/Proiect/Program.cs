using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Proiect.Data;
using Proiect.Models;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));
builder.Services.AddDatabaseDeveloperPageExceptionFilter();

//builder.Services.AddDefaultIdentity<IdentityUser>(options => options.SignIn.RequireConfirmedAccount = true)
    //.AddEntityFrameworkStores<ApplicationDbContext>();

///Pas 2 adaugare roluri - Are o definitie mai sus. Poate genereaza conflicte?
builder.Services.AddControllersWithViews();
builder.Services.AddDefaultIdentity<ApplicationUser>(options => options.SignIn.RequireConfirmedAccount = true)
.AddRoles<IdentityRole>().AddEntityFrameworkStores<ApplicationDbContext>();
///

var app = builder.Build();

///Pas 5 - crearea rolurilor si a adminului (sau nimic, daca nu e prima rulare)
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    SeedData.Initialize(services);
   // SeedData.AddUser(services);        ///test sa vad daca asa imi adauga admin; a se rula functia asta doar la primul run project
}

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseMigrationsEndPoint();
}
else
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}/{idMem?}");
app.MapRazorPages();

app.Run();
