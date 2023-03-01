using Microsoft.AspNetCore.Mvc;

namespace WebApplication1.Controllers
{
    public class ExamplesController : Controller
    {
        public string Concat(string a, string b)
        {
            string response = a + " " + b + " Merge";
            return response;
        }
        public string Produs (int a, int? b)
        {
            if (b == null)
                return "Introduceti ambele valori";
            return Convert.ToString(a * b);
        }
        public string Operatie(int? a, int? b, string? str)
        {
            string missing = "";
            if (a == null)
            {
                missing = missing + "1";
            }
            if (b == null)
            {
                missing = missing + "/2";
            }
            if (str == null)
            {
                missing = missing + "/3";
            }
            if (missing != "")
                return "Introduceti parametrul " + missing;
            switch (str)
            {
                case "div":
                    return Convert.ToString(a / b);
                case "ori":
                    return Convert.ToString(a * b);
                case "plus":
                    return Convert.ToString(a + b);
                case "minus":
                    return Convert.ToString(a - b);
                default:
                    return "Introduceti o operatie valida!";
            }
        }
        public IActionResult Index()
        {
            return View();
        }
        
    }
}
