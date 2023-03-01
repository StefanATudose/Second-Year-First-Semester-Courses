using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Proiect.Models;
using Proiect.Data;
using Microsoft.AspNetCore.Identity;

namespace Proiect.Controllers
{
    public class GroupsController : Controller
    {
        private readonly ApplicationDbContext db;

        public GroupsController(ApplicationDbContext context)     ///S-ar putea ca definita asta a bazei sa nu fie suficienta
                                                                  ///pentru tipul de operatii pe care vrem sa le facem
        {
            db = context;
        }

        private readonly UserManager<ApplicationUser>? _userManager;
        private readonly RoleManager<IdentityRole>? _roleManager;
        public GroupsController(
        ApplicationDbContext context,
        UserManager<ApplicationUser> userManager,
        RoleManager<IdentityRole> roleManager
        )
        {
            db = context;
            _userManager = userManager;
            _roleManager = roleManager;
        }
        
        [Authorize(Roles = "RegisteredUser,Admin")]
        /*public IActionResult Index()
        {
            if (TempData.ContainsKey("message"))
            {
                ViewBag.message = TempData["message"].ToString();
            }

            var groups = from group in db.Groups
                             orderby group.Name
                             select group;
            ViewBag.Groups = groups;
            return View();
        }
        */

        [Authorize(Roles = "RegisteredUser,Admin")]
        public IActionResult Show(int id)
        {
            Group group = db.Groups.Find(id);
            return View(group);
        }

        [Authorize(Roles = "RegisteredUser,Admin")]
        public IActionResult New()
        {
            return View();
        }

        [Authorize(Roles = "RegisteredUser,Admin")]
        [HttpPost]
        public IActionResult New(Group gr)
        {
            if (ModelState.IsValid)
            {
                db.Groups.Add(gr);
                db.SaveChanges();
                TempData["message"] = "Group successfully added";
                return RedirectToAction("Index");
            }

            else
            {
                return View(gr);
            }
        }

        [Authorize(Roles = "RegisteredUser,Admin")]  ///Aici trebuie verificare pentru RegisteredUser sa fie admin
        public IActionResult Edit(int id)
        {
            Group group = db.Groups.Find(id);
            return View(group);
        }

        [Authorize(Roles = "RegisteredUser,Admin")]
        [HttpPost]
        public ActionResult Edit(int id, Group requestGroup) ///Aici din nou verificare ca RegisteredUser sa fie admin
        {
            Group group = db.Groups.Find(id);

            if (ModelState.IsValid)
            {

                group.Name = requestGroup.Name;
                db.SaveChanges();
                TempData["message"] = "Group successfully modified";
                return RedirectToAction("Index");
            }
            else
            {
                return View(requestGroup);
            }
        }

        [Authorize(Roles = "RegisteredUser,Admin")] ///Aici trebuie verificate drepturile
        [HttpPost]
        public IActionResult Delete(int id)
        {
            Group group = db.Groups.Find(id);
            db.Groups.Remove(group);
            TempData["message"] = "Group successfully removed";
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        
    }
}
