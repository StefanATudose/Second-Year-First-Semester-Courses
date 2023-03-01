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

        ///[Authorize(Roles ="RegisteredUser,Admin")]
        [HttpPost]
        public IActionResult KickFromGroup(int id, string idMem)
        {
            //if(User.IsInRole("Admin")) //sau e moderator
            /*
                delete from UserGroup where User_ID = id_mem and Group_ID = id_grup
             */
            var victim = (from item in db.UserGroups
                         where item.Group_ID == id && item.User_ID == idMem
                         select item).First();
            db.UserGroups.Remove(victim);
            db.SaveChanges();
            return Redirect("/Groups/ShowMem/" + id.ToString());
        }

        //[Authorize(Roles ="RegisteredUser,Admin")]
        [HttpPost]
        public IActionResult AddToGroup(int id, string idMem)
        {
            //if(User.IsInRole("Admin")) //sau e moderator
            /*
               In momentul de fata, putem adauga acelasi membru de mai multe ori in acelasi grup, ceea ce nu e ok
            */
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
        public IActionResult AddToPending(int id, string idMem)  ///Aceeasi belea. Putem adauga in pending acelasi user de mai multe ori
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
        public IActionResult ToggleModerator(int id, string idMem) //Avem nevoie de verificare sa fie Admin sau moderator
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
