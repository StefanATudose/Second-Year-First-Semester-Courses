using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Proiect.Data;
using Proiect.Models;

namespace Proiect.Controllers
{
    
    public class UserviewsController : Controller
    {
        private readonly ApplicationDbContext db;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        public UserviewsController(ApplicationDbContext context, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            db = context;
            _userManager = userManager;
            _roleManager = roleManager;
        }

        [Authorize(Roles ="RegisteredUser,Admin")]
        public IActionResult MyGroupsIndex()
        {
            /*   Nu stiu cum sa fac rost de cacaturile astea. Cred ca exista doar metoda db.Tabel.Find(id) in arhitectura asta
             *   trebuie regandita baza de date astfel incat sa avem ID propriu pentru toate tabelele
            var que = ;
            ViewBag.MyG = que;
            */
            ViewBag.MyG = null;  //Ca sa functioneze pana implementam cererea
            return View();
        }

        [Authorize(Roles = "RegisteredUser,Admin")]
        public IActionResult ModeratedGroupsIndex()
        {
            /*
            var que = ;
            ViewBag.ModG = que;
            */
            ViewBag.ModG = null;    //Ca sa functioneze pana implementam cererea
            return View();
        }
    }
}
