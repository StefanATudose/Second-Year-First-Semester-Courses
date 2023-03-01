using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using ProiectFinall.Models;


namespace ProiectFinall.Controllers
{
    public class CrudController : Controller
    {
        private AppDBContext db = new AppDBContext();
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult ShowAll()
        {
            var groups = from Group in db.Groups
                           orderby Group.Name
                           select Group;
            ViewBag.Groups = groups;
            return View();
        }

        public IActionResult Show(int grId)
        {
            Group group = db.Groups.Find(grId);
            ViewBag.Group = group;
            return View();
        }

        public IActionResult Edit(int id)
        {
            Group group = db.Groups.Find(id);
            ViewBag.Group = group;
            return View();
        }

        [HttpPost]
        public ActionResult Edit(int id, Group chGr)
        {
            Group group = db.Groups.Find(id);
            try
            {
                group.Name = chGr.Name;
                group.Description = chGr.Description;
                db.SaveChanges();
                return RedirectToAction("ShowAll");
            }
            catch (Exception)
            {
                return RedirectToAction("Edit", group.Group_ID);
            }
        }

        public IActionResult New()
        {
            return View();
        }
        [HttpPost]
        public IActionResult New (Group gr)
        {
            try
            {
                gr.Gr_CreatedDate = DateTime.Now;
                db.Groups.Add(gr);
                db.SaveChanges();
                return RedirectToAction("ShowAll");
            }
            catch (Exception ex)
            {
                ViewBag.Exception = ex;
                return View();
            }
        }
        [HttpPost]
        public ActionResult Delete(int id)
        {
            Group group = db.Groups.Find(id);
            TempData["message"] = "The " + group.Name + " was succesfully deleted";
            db.Groups.Remove(group);
            db.SaveChanges();
            return RedirectToAction("ShowAll");
        }
    }
}
