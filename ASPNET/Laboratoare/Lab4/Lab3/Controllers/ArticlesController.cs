using Lab3.Models;
using Microsoft.AspNetCore.Mvc;

namespace Lab3.Controllers
{
    public class ArticlesController : Controller
    {

        private AppDbContext db = new AppDbContext();
        public IActionResult Index()
        {
            var articles = from item in db.Articles
                           orderby item.Title
                           select item;
            ViewBag.Articles = articles;
            return View();
        }

        public ActionResult Show(int id)
        {
            Article student = db.Articles.Find(id);
            ViewBag.Article = student;
            return View();
        }

        public IActionResult New()
        {
            return View();
        }
        [HttpPost]
        public IActionResult New(Article s)
        {
            try
            {
                s.Date = DateTime.Now;
                db.Articles.Add(s);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                return View();
            }
        }

        public IActionResult Edit(int id)
        {
            Article student = db.Articles.Find(id);
            ViewBag.Student = student;
            return View();
        }
        [HttpPost]
        public ActionResult Edit(int id, Article requestArticle)
        {
            Article article = db.Articles.Find(id);
            try
            {
                article.Title = requestArticle.Title;
                article.Content = requestArticle.Content;
                article.Date = requestArticle.Date;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch (Exception)
            {
                return RedirectToAction("Edit", article.ArticleID);
            }
        }


        [HttpPost]
        public ActionResult Delete(int id)
        {
            Article article = db.Articles.Find(id);
            db.Articles.Remove(article);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
    }
}
