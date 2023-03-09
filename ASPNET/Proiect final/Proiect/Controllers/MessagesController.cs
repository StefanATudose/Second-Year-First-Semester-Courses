using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using Proiect.Models;
using Proiect.Data;

namespace Proiect.Controllers
{
    public class MessagesController : Controller
    {
        private readonly ApplicationDbContext db;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        public MessagesController(ApplicationDbContext context, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            db = context;
            _userManager = userManager;
            _roleManager = roleManager;
        }

        public IActionResult New(int id, string idMem)
        {
            Message msg = new Message();
            msg.User_ID = idMem;
            msg.Group_ID = id;
            return View(msg);
        }

        [HttpPost]
        public IActionResult New(Message msg)
        {
            if (msg.User_ID == null)
                return Redirect("/Home/Index");
            if (ModelState.IsValid)
            {
                msg.CreatedDate = DateTime.Now;
                db.Messages.Add(msg);
                db.SaveChanges();
                TempData["message"] = "Message succesfully added";
                return Redirect("/Groups/Show/" + msg.Group_ID.ToString());
            }

            else
            {
                TempData["message"] = "Message creation failed";
                return View(msg);
            }
        }

        public IActionResult Edit(int id)
        {
            Message msg = db.Messages.Find(id);
            return View(msg);
        }

        //[Authorize(Roles = "RegisteredUser,Admin")]
        [HttpPost]
        public ActionResult Edit(int id, Message reqMsg)
        {
            Message msg = db.Messages.Find(id);

            if (ModelState.IsValid)
            {

                msg.Text = reqMsg.Text;
                db.SaveChanges();
                TempData["message"] = "Message successfully modified";
                return Redirect("/Groups/Show/" + msg.Group_ID.ToString());
            }
            else
            {
                return View(reqMsg);
            }
        }


        //[Authorize(Roles = "RegisteredUser,Admin")]
        public IActionResult Delete(int id)
        {
            Message mes = db.Messages.Find(id);

            //if (mes.User_ID == _userManager.GetUserId(User) || User.IsInRole("Admin")) /// sau user-ul e moderator. Trebuie adaugat
            //{
                db.Messages.Remove(mes);
                db.SaveChanges();
                return Redirect("/Groups/Show/" + mes.Group_ID);
            //}

            //else
            //{
                //TempData["message"] = "You do not have the right to delete this message";
                //return RedirectToAction("Index", "Articles");
            //}
        }
    }
}
