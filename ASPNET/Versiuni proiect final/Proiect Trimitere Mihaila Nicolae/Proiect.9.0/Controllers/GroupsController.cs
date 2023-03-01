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
        [Authorize]
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
            ViewBag.userId = userId;
            var userGroupEntry = (from grr in db.UserGroups
                                 where grr.Group_ID == id && grr.User_ID == userId
                                 select grr).FirstOrDefault();
            bool isMod;
            if (userGroupEntry == null)
                isMod = false;
            else if (userGroupEntry.Moderator == 1)
                isMod = true;
            else
                isMod = false;
            ViewBag.isMod = isMod;
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

        public IActionResult Index()
        {
            if (TempData.ContainsKey("message"))
            {
                ViewBag.message = TempData["message"].ToString();
            }
            int _perPage = 3;

            var groups = from not_group in db.Groups
                             orderby not_group.Name             
                             select not_group;
            int totalItems = groups.Count();
            var currentPage = Convert.ToInt32(HttpContext.Request.Query["page"]);
            var offset = 0;
            if (!currentPage.Equals(0))
            {
                offset = (currentPage - 1) * _perPage;
            }
            var paginatedGroups = groups.Skip(offset).Take(_perPage);
            ViewBag.lastPage = Math.Ceiling((float)totalItems / (float)_perPage);
            ViewBag.Groups = paginatedGroups;
            return View();
        }
        

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
                               creatorId = item.User.Id,
                               createdDate = item.CreatedDate,
                               text = item.Text
                           };
            ViewBag.noMessages = messages.Count();
            ViewBag.messages = messages;

            var IsMod = (from item in db.UserGroups
                         where item.User_ID == userId && item.Group_ID == id
                         select item).FirstOrDefault();
            var isPend = (from item in db.PendingUserGroups
                         where item.User_ID == userId && item.Group_ID == id
                         select item).FirstOrDefault();
            if (isPend == null)
            {
                ViewBag.isPending = 0;
            }
            else
                ViewBag.isPending = 1;
            if (IsMod == null)
            {
                ViewBag.mod = 0;
                ViewBag.isMem = 0;
            }
            else
            {
                ViewBag.mod = IsMod.Moderator;
                ViewBag.isMem = 1;
            }
                



            return View(group);
        }

        [Authorize]
        public IActionResult New()
        {
            Group group = new Group();
            group.Categ = GetCategs();
            return View(group);
        }

        [Authorize]
        [HttpPost]
        public IActionResult New(Group gr)
        {
            if (ModelState.IsValid)
            {
                gr.Gr_CreatedDate = DateTime.Now;
                db.Groups.Add(gr);
                db.SaveChanges();
                UserGroup entry = new UserGroup();
                entry.Group_ID = gr.Group_ID;
                entry.User_ID = _userManager.GetUserId(User);
                entry.Moderator = 1;
                db.UserGroups.Add(entry);
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

        [Authorize] 
        public IActionResult Edit(int id)
        {
            var userId = _userManager.GetUserId(User);
            var entry = (from item in db.UserGroups
                         where item.User_ID == userId && item.Group_ID == id
                         select item).FirstOrDefault();
            bool isMod;
            if (entry == null)
                isMod = false;
            else if (entry.Moderator == 1)
                isMod = true;
            else
                isMod = false;
            if (User.IsInRole("Admin") || isMod)
            {
                Group group = db.Groups.Find(id);
                return View(group);
            }
            else
            {
                TempData["message"] = "Nu aveti permisiunea sa realizati aceasta operatie";
                return Redirect("/Groups/Show/" + id.ToString());
            }
            
        }

        [Authorize]
        [HttpPost]
        public ActionResult Edit(int id, Group requestGroup)
        {
            Group group = db.Groups.Find(id);

            var userId = _userManager.GetUserId(User);
            var entry = (from item in db.UserGroups
                         where item.User_ID == userId && item.Group_ID == id
                         select item).FirstOrDefault();
            bool isMod;
            if (entry == null)
                isMod = false;
            else if (entry.Moderator == 1)
                isMod = true;
            else
                isMod = false;
            if (User.IsInRole("Admin") || isMod)
            {

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
            else
            {
                TempData["message"] = "Nu aveti permisiunea sa realizati aceasta operatie";
                return Redirect("/Groups/Show/" + id.ToString());
            }
        }

        [Authorize]
        [HttpPost]
        public IActionResult Delete(int id)
        {
            var userId = _userManager.GetUserId(User);
            var entry = (from item in db.UserGroups
                         where item.User_ID == userId && item.Group_ID == id
                         select item).FirstOrDefault();
            bool isMod;
            if (entry == null)
                isMod = false;
            else if (entry.Moderator == 1)
                isMod = true;
            else
                isMod = false;
            if (User.IsInRole("Admin") || isMod)
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
            else
            {
                TempData["message"] = "Nu aveti permisiunea sa realizati aceasta operatie";
                return Redirect("/Groups/Show/" + id.ToString());
            }
        }
        [Authorize]
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
