using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using PregExamen.Models;
using System.ComponentModel.DataAnnotations;

namespace PregExamen.Controllers
{
    public class GiftcardsController : Controller
    {
        private AppDBContext db = new AppDBContext();

        [NonAction]
        public static ValidationResult ValidareData(DateTime? date)
        {
            if (date == null)
                return new ValidationResult("Please enter a date!");
            if (date < DateTime.Now)
                return new ValidationResult("Please enter a future date!");
            return ValidationResult.Success;
        }

        public ICollection<SelectListItem> GetBrands()
        {
            var selectList = new List<SelectListItem>();
            var brands = from cat in db.Brands
                         select cat;
            foreach (var item in brands)
            {
                selectList.Add(new SelectListItem
                {
                    Value = item.Id.ToString(),
                    Text = item.Nume.ToString()
                });
            }
            return selectList;
        }

        public IActionResult Index()
        {
            if (TempData.ContainsKey("message"))
            {
                ViewBag.message = TempData["message"].ToString();
            }
            var cards = from item in db.GiftCards
                        select item;
            ViewBag.cards = cards;
            return View();
        }

        public IActionResult Show(int id)
        {
            var card = db.GiftCards.Find(id);
            return View(card);
        }

        public IActionResult New()
        {
            GiftCard card = new GiftCard();
            card.Brands = GetBrands();
            return View(card);
        }

        [HttpPost]
        public IActionResult New(GiftCard card)
        {
            if (ModelState.IsValid)
            {
                db.GiftCards.Add(card);
                db.SaveChanges();
                TempData["message"] = "Group successfully added";
                return RedirectToActionPermanent("Index");
            }
            else
            {
                TempData["message"] = "Group successfully added";
                card.Brands = GetBrands();
                return View(card);
            }
        }

        public IActionResult Edit(int id)
        {
            GiftCard card = db.GiftCards.Find(id);
            card.Brands = GetBrands();
            return View(card);
        }

        [HttpPost]
        public IActionResult Edit(int id, GiftCard reqCard)
        {
            GiftCard card = db.GiftCards.Find(id);

            if (ModelState.IsValid)
            {
                card.Descriere = reqCard.Descriere;
                card.Denumire = reqCard.Denumire;
                card.DataExp = reqCard.DataExp;
                card.Procent = reqCard.Procent;
                card.BrandId = reqCard.BrandId;
                db.SaveChanges();
                TempData["message"] = "Card successfully edited";
                return RedirectToAction("Index");
            }
            else
            {
                TempData["message"] = "Card edit failed";
                card.Brands = GetBrands();
                return View(card);
            }
        }
        [HttpPost]
        public IActionResult Delete(int id)
        {
            GiftCard card = db.GiftCards.Find(id);
            db.GiftCards.Remove(card);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

    }
}
