using Microsoft.AspNetCore.Mvc;

namespace Proiect.Controllers
{
    public class MessagesController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
