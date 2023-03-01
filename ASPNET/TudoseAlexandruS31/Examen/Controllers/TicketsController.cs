using Examen.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace Examen.Controllers
{
    public class TicketsController : Controller
    {
        private readonly AppDBContext db = new AppDBContext();

        public ICollection<SelectListItem> GetMovies()
        {
            var selectList = new List<SelectListItem>();
            var movies = from cat in db.Movies
                         select cat;
            foreach (var catt in movies)
            {
                selectList.Add(new SelectListItem
                {
                    Value = catt.Id.ToString(),
                    Text = catt.DenFilm.ToString()
                });
            }
            return selectList;
        }

        public IActionResult AddMovies()
        {
            Movie mov = new Movie();
            mov.DenFilm = "Orange Clockwork";
            db.Movies.Add(mov);


            Movie mov1 = new Movie();
            mov1.DenFilm = "Halloween";
            db.Movies.Add(mov1);


            Movie mov2 = new Movie();
            mov2.DenFilm = "Star Wars";
            db.Movies.Add(mov2);


            Movie mov3 = new Movie();
            mov3.DenFilm = "Avatar";
            db.Movies.Add(mov3);


            Movie mov4 = new Movie();
            mov4.DenFilm = "The Shining";
            db.Movies.Add(mov4);
            db.SaveChanges();

            return RedirectToAction("Index");
            
        }

        public IActionResult Index()
        {
            var showAddMovies = (from item in db.Movies
                                select item).FirstOrDefault();
            if (showAddMovies == null)
            {
                ViewBag.showAddMovies = 1;
            }
            else
            {
                ViewBag.showAddMovies = 0;
            }

            var tickets = from item in db.Tickets.Include("Movie")
                          select new {
                              Id = item.Id,
                              TitluBilet = item.TitluBilet,
                              Pret = item.Pret,
                              Data = item.Data,
                              TitluFilm = item.Movie.DenFilm
                            };
            ViewBag.tickets = tickets;
            return View();
        }

        public IActionResult Show(int id)
        {
            var ticket = (from item in db.Tickets.Include("Movie")
                         select new
                         {
                             Id = item.Id,
                             TitluBilet = item.TitluBilet,
                             Pret = item.Pret,
                             Data = item.Data,
                             TitluFilm = item.Movie.DenFilm
                         }).First();
            ViewBag.ticket = ticket;
            ViewBag.id = ticket.Id;
            return View();
        }

        public IActionResult New()
        {
            Ticket tick = new Ticket();
            tick.Filme = GetMovies();
            return View(tick);
        }

        [HttpPost]
        public IActionResult New (Ticket tickk)
        {
            if (ModelState.IsValid)
            {
                db.Add(tickk);
                db.SaveChanges();
                TempData["message"] = "Ticketul a fost adaugat cu succes";
                return RedirectToAction("Index");
            }
            else
            {
                TempData["message"] = "Ticketul n-a fost adaugat";
                tickk.Filme = GetMovies();
                return View(tickk);
            }
        }

        public IActionResult Edit (int id)
        {
            Ticket tick = db.Tickets.Find(id);
            tick.Filme = GetMovies();
            return View(tick);
        }
        [HttpPost]
        public IActionResult Edit (int id, Ticket reqTick)
        {
            var tick = db.Tickets.Find(id);
            if (ModelState.IsValid)
            {
                tick.TitluBilet = reqTick.TitluBilet;
                tick.Pret = reqTick.Pret;
                tick.Data = reqTick.Data;
                tick.MovieId = reqTick.MovieId;
                TempData["message"] = "Biletul a fost modificat cu succes!";
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            else
            {
                TempData["message"] = "Modificarea biletului a esuat";
                reqTick.Filme = GetMovies();
                return View(reqTick);
            }
        }

        [HttpPost]
        public IActionResult Delete(int id)
        {
            var tick = db.Tickets.Find(id);
            db.Remove(tick);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        
        public IActionResult searchTick()
        {
            return View();
        }


        public IActionResult searchTick(string id)      //nu mai am timp sa adaug alta ruta
        {
            ViewBag.post = 1;
            var tickets = from item in db.Tickets.Include("Movie")
                          where (
                            item.Movie.DenFilm.Contains(id)
                          )
                          select new
                          {
                              id = item.Id,
                              titluBilet = item.TitluBilet,
                              pret = item.Pret,
                              denFilm = item.Movie.DenFilm
                          };
            int sum = 0;
            foreach (var item in tickets)
            {
                sum = (int)(sum + item.pret);
            }
            ViewBag.tickets = tickets;
            ViewBag.valoare = sum;
            return View();
        }
    }
}
