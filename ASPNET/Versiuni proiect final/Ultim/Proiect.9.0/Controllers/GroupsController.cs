using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Proiect.Models;
using Proiect.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using Microsoft.EntityFrameworkCore.Storage;

namespace Proiect.Controllers
{
    public class GroupsController : Controller
    {

        private readonly ApplicationDbContext db;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        public GroupsController(ApplicationDbContext context, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            db = context;
            _userManager = userManager;
            _roleManager = roleManager;
        }


        public ICollection<SelectListItem> GetCategs(){
            var selectList = new List<SelectListItem>();
            var categs = from cat in db.Categories
                         select cat;
            foreach(var catt in categs)
            {
                selectList.Add(new SelectListItem {
                    Value = catt.Categ_ID.ToString(),
                    Text = catt.Categ_Name.ToString() });
            }
            return selectList;
        }

        public IActionResult NonMembersList(int id)
        {

            var allUsers = from appUsr in db.ApplicationUsers
                           select appUsr;
            var allMems = from usr in db.UserGroups
                          where usr.Group_ID == id
                          select usr.User_ID;
            var allMemsPending = from usr in db.PendingUserGroups
                                 where usr.Group_ID == id
                                 select usr.User_ID;
            List <ApplicationUser> nonMems = new List<ApplicationUser>();

            foreach(var currUser in allUsers)
            {
                bool notIn = true;
                foreach (var mem in allMems)
                {
                    if (currUser.Id == mem)
                    {
                        notIn = false;
                        break;
                    }
                }
                foreach (var mem in allMemsPending)
                    if (currUser.Id == mem)
                    {
                        notIn = false;
                        break;
                    }
                if (notIn)
                    nonMems.Add(currUser);
            }
            ViewBag.nonMems = nonMems;
            ViewBag.grName = (from grr in db.Groups where grr.Group_ID == id select grr.Name).First();
            ViewBag.grId = id;
            return View();
        }



        public IActionResult ShowMem(int id)
        {
            Group numeGrup = db.Groups.Find(id);
            
            ViewBag.grup = numeGrup;
            var grMems = from grp in db.UserGroups.Include("User")
                         where grp.Group_ID == id
                         select new
                         {
                             UserName = grp.User.UserName,
                             idd = grp.User.Id,
                             isMod = grp.Moderator
                         };

            ViewBag.mems = grMems;

            var userId = _userManager.GetUserId(User);
            var userGroupEntry = (from grr in db.UserGroups
                                 where grr.Group_ID == id && grr.User_ID == userId
                                 select grr).FirstOrDefault();
            bool isMod;
            if (userGroupEntry == null)
                isMod = false;
            else if (userGroupEntry.Moderator == 1)
                isMod = false;
            else
                isMod = true;
            if (User.IsInRole("Admin") || isMod)
            {
                var grPending = from grp in db.PendingUserGroups.Include("User")
                                where grp.Group_ID == id
                                select new
                                {
                                    UserName = grp.User.UserName,
                                    idd = grp.User.Id
                                };

                ViewBag.pending = grPending;
            }
            return View();
        }


        //[Authorize(Roles = "RegisteredUser,Admin")]
        public IActionResult Index()
        {
            if (TempData.ContainsKey("message"))
            {
                ViewBag.message = TempData["message"].ToString();
            }

            var groups = from not_group in db.Groups
                             orderby not_group.Name             
                             select not_group;                   
            ViewBag.Groups = groups;
            return View();
        }
        

        //[Authorize(Roles = "RegisteredUser,Admin")]
        public IActionResult Show(int id)
        {
            Group group = db.Groups.Find(id);
            var userId = _userManager.GetUserId(User);
            ViewBag.userId = userId;
            var messages = from item in db.Messages.Include("User")
                           where item.Group_ID == id
                           select new
                           {
                               idd = item.Message_ID,
                               creator = item.User.UserName,
                               createdDate = item.CreatedDate,
                               text = item.Text
                           };
            ViewBag.messages = messages;

            var IsMod = (from item in db.UserGroups
                         where item.User_ID == userId && item.Group_ID == id
                         select item).FirstOrDefault();
            if (IsMod == null)
                ViewBag.mod = 0;
            else
                ViewBag.mod = IsMod.Moderator;
            return View(group);
        }

        [Authorize]
        public IActionResult New()
        {
            Group group = new Group();
            group.Categ = GetCategs();
            return View(group);
        }

        //[Authorize(Roles = "RegisteredUser,Admin")]
        [HttpPost]
        public IActionResult New(Group gr)
        {
            if (ModelState.IsValid)
            {
                gr.Gr_CreatedDate = DateTime.Now;
                db.Groups.Add(gr);
                db.SaveChanges();
                TempData["message"] = "Group successfully added";
                return RedirectToAction("Index");
            }

            else
            {
                TempData["message"] = "Group creation failed";
                gr.Categ = GetCategs();
                return View(gr);
            }
        }

        //[Authorize(Roles = "RegisteredUser,Admin")]  ///Aici trebuie verificare pentru RegisteredUser sa fie admin
        public IActionResult Edit(int id)
        {
            Group group = db.Groups.Find(id);
            return View(group);
        }

        //[Authorize(Roles = "RegisteredUser,Admin")]
        [HttpPost]
        public ActionResult Edit(int id, Group requestGroup) ///Aici din nou verificare ca RegisteredUser sa fie admin
        {
            Group group = db.Groups.Find(id);

            if (ModelState.IsValid)
            {

                group.Name = requestGroup.Name;
                group.Description = requestGroup.Description;
                db.SaveChanges();
                TempData["message"] = "Group successfully modified";
                return RedirectToAction("Index");
            }
            else
            {
                return View(requestGroup);
            }
        }

        //[Authorize(Roles = "RegisteredUser,Admin")] ///Aici trebuie verificate drepturile
        [HttpPost]
        public IActionResult Delete(int id)
        {
            Group group = db.Groups.Find(id);
            var dependedMessages = from item in db.Messages
                                   where item.Group_ID == id
                                   select item;
            foreach (var x in dependedMessages)
            {
                db.Messages.Remove(x);
            }
            db.Groups.Remove(group);
            
            
            TempData["message"] = "Group successfully removed";
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public IActionResult MyGroups()
        {
            var userId = _userManager.GetUserId(User);
            ViewBag.userId = userId;
            var myGroups = from item in db.UserGroups
                           where item.User_ID == userId
                           select item.Group_ID;
            Group currentGroup = new Group();
            List<Group> myGroupss = new List<Group>();
            foreach (var item in myGroups)
            {
                currentGroup = db.Groups.Find(item);
                myGroupss.Add(currentGroup);
            }
            ViewBag.myGroups = myGroupss;
            return View();
        }
        
    }
}
