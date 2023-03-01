using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Proiect.Data;
using Proiect.Models;

namespace Proiect.Controllers
{
    public class CategoriesController : Controller
    {
        private readonly ApplicationDbContext db;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        public CategoriesController(ApplicationDbContext context, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            db = context;
            _userManager = userManager;
            _roleManager = roleManager;
        }


        [Authorize(Roles="Admin")]
        public IActionResult Index()
        {
            if (TempData.ContainsKey("message"))
            {
                ViewBag.message = TempData["message"].ToString();
            }

            var categories = from category in db.Categories
                             orderby category.Categ_Name
                             select category;
            ViewBag.Categories = categories;
            return View();
        }

        [Authorize(Roles="Admin")]
        public IActionResult Show(int id)
        {
            Category category = db.Categories.Find(id);
            return View(category);
        }

        [Authorize(Roles="Admin")]
        public IActionResult New()
        {
            return View();
        }

        [Authorize(Roles="Admin")]
        [HttpPost]
        public IActionResult New(Category cat)
        {
            if (ModelState.IsValid)
            {
                db.Categories.Add(cat);
                db.SaveChanges();
                TempData["message"] = "Category successfully added";
                return RedirectToAction("Index");
            }

            else
            {
                return View(cat);
            }
        }

        [Authorize(Roles="Admin")]
        public IActionResult Edit(int id)
        {
            Category category = db.Categories.Find(id);
            return View(category);
        }

        [Authorize(Roles="Admin")]
        [HttpPost]
        public ActionResult Edit(int id, Category requestCategory)
        {
            Category category = db.Categories.Find(id);

            if (ModelState.IsValid)
            {

                category.Categ_Name = requestCategory.Categ_Name;
                db.SaveChanges();
                TempData["message"] = "Category successfully modified";
                return RedirectToAction("Index");
            }
            else
            {
                return View(requestCategory);
            }
        }

        [Authorize(Roles="Admin")]
        [HttpPost]
        public IActionResult Delete(int id)
        {
            Category category = db.Categories.Find(id);
            var dependedGroups = from item in db.Groups
                                 where item.Categ_ID == id
                                 select item;
            foreach(var x in dependedGroups)
            {
                var dependedMessages = from item in db.Messages
                                       where item.Group_ID == x.Group_ID
                                       select item;
                foreach (var y in dependedMessages)
                {
                    db.Messages.Remove(y);
                }
                db.Groups.Remove(x);
            }


            db.Categories.Remove(category);
            TempData["message"] = "Category successfully removed";
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        
    }
}
