using Lab3.Models;
using Microsoft.AspNetCore.Mvc;

namespace Lab3.Controllers
{
    public class CategoriesController : Controller
    {

        private AppDbContext db = new AppDbContext();
        public IActionResult Index()
        {
            return View();
        }


    }
}
