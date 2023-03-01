using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Proiect.Models;
using Proiect.Data;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace Proiect.Controllers
{
    public class AdministrationController : Controller
    {
        private readonly ApplicationDbContext db;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        public AdministrationController(ApplicationDbContext context, UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            db = context;
            _userManager = userManager;
            _roleManager = roleManager;
        }

        [Authorize]
        [HttpPost]
        public IActionResult KickFromGroup(int id, string idMem)
        {
            var victim = (from item in db.UserGroups
                         where item.Group_ID == id && item.User_ID == idMem
                         select item).First();
            db.UserGroups.Remove(victim);
            db.SaveChanges();
            return Redirect("/Groups/ShowMem/" + id.ToString());
        }

        [Authorize]
        [HttpPost]
        public IActionResult AddToGroup(int id, string idMem)
        {
            UserGroup nou = new UserGroup();
            nou.Group_ID = id;
            nou.User_ID = idMem;
            db.UserGroups.Add(nou);
            db.SaveChanges();
            var str = "/Groups/NonMembersList/" + id.ToString();
            return Redirect(str);       
        }

        [Authorize]
        [HttpPost]
        public IActionResult AddToPending(int id, string idMem) 
        {
            PendingUserGroup peg = new PendingUserGroup();
            peg.Group_ID = id;
            peg.User_ID = idMem;
            db.PendingUserGroups.Add(peg);
            db.SaveChanges();
            return Redirect("/Groups/Show/" + id.ToString());
        }

        //[Authorize(Roles ="RegisteredUser,Admin")]
        [HttpPost]
        public IActionResult ToggleModerator(int id, string idMem)
        {
            var schimb = (from item in db.UserGroups
                        where item.User_ID == idMem && item.Group_ID == id
                        select item).First();
            if (schimb.Moderator == 1)
            {
                schimb.Moderator = 0;
            }
            else
            {
                schimb.Moderator = 1;
            }
            db.SaveChanges();
            return Redirect("/Groups/ShowMem/" + id.ToString());
        }
        public IActionResult RefusePending(int id, string idMem)
        {
            var victim = (from item in db.PendingUserGroups
                          where item.User_ID == idMem && item.Group_ID == id
                          select item).First();
            db.PendingUserGroups.Remove(victim);
            db.SaveChanges();
            return Redirect("/Groups/ShowMem/" + id.ToString());
        }
        public IActionResult AdmitPending(int id, string idMem)
        {
            var victim = (from item in db.PendingUserGroups
                          where item.User_ID == idMem && item.Group_ID == id
                          select item).First();
            UserGroup nou = new UserGroup();
            db.PendingUserGroups.Remove(victim);
            nou.Group_ID = id;
            nou.User_ID = idMem;
            db.UserGroups.Add(nou);
            db.SaveChanges();
            return Redirect("/Groups/ShowMem/" + id.ToString());
        }

        
    }
}
