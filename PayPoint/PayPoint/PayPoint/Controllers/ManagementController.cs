using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PayPoint.Models;
using System.Data.Objects;

namespace PayPoint.Controllers
{
    public class ManagementController : Controller
    {
        private PayPointContext db = new PayPointContext();
        //
        // GET: /Management/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Managements()
        {
            DateTime dateFrom = Convert.ToDateTime("2013-08-01");
            DateTime dateTo = Convert.ToDateTime("2013-08-01");

            ViewBag.products = db.Products.Where(i => EntityFunctions.TruncateTime(i.StockSold) >= dateFrom && EntityFunctions.TruncateTime(i.StockSold) <= dateTo).ToList();


            //ViewBag.products = (from p in db.Products
            //                    where EntityFunctions.TruncateTime(p.StockSold) >= startDate && EntityFunctions.TruncateTime(p.StockSold) <= endDate
            //                                 select p).ToList();

            return View();
        }

    }
}
