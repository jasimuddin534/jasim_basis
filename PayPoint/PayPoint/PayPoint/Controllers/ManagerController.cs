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
    public class ManagerController : Controller
    {
        private PayPointContext db = new PayPointContext();
        //
        // GET: /Manager/

        public ActionResult Index()
        {
            return View();
        }

       
        public ActionResult Managers()
        {
            DateTime dateFrom = Convert.ToDateTime("2013-08-01");
            DateTime dateTo = Convert.ToDateTime("2013-08-03");

            ViewBag.orders = db.Orders.Where(i => EntityFunctions.TruncateTime(i.CreatedTime) >= dateFrom && EntityFunctions.TruncateTime(i.CreatedTime) <= dateTo).ToList();

            return View();
        }





         [HttpPost]
        public ActionResult Managers2(DateTime dateFrom, DateTime dateTo)
        {
            //DateTime dateFrom = Convert.ToDateTime("2013-08-01");
            //DateTime dateTo = Convert.ToDateTime("2013-08-03");

            var query = (from p in db.Products
                         from o in db.Orders
                         where p.BarCode == o.BarCode && EntityFunctions.TruncateTime(o.CreatedTime) >= dateFrom && EntityFunctions.TruncateTime(o.CreatedTime) <= dateTo
                         select new { o.OrderId, o.CreatedTime, o.OrderNumber, p.Category, p.Brand, p.Model, p.IMEI1, o.BarCode, o.CreatedBy, o.Price }).ToList();

            //var query = from p in db.Products
            //            from o in db.Orders
            //            where p.BarCode == o.BarCode && EntityFunctions.TruncateTime(o.CreatedTime) >= dateFrom && EntityFunctions.TruncateTime(o.CreatedTime) <= dateTo
            //            select new { o.OrderId, o.CreatedTime, o.OrderNumber, p.Category, p.Brand, p.Model, p.IMEI1, o.BarCode, o.CreatedBy, o.Price };

            ViewBag.orders1 = query;

            return View();


            //var  result = (from prduct in db.Products
            //              from order in db.Orders
            //              where prduct.BarCode == order.BarCode && EntityFunctions.TruncateTime(order.CreatedTime) >= dateFrom && EntityFunctions.TruncateTime(order.CreatedTime) <= dateTo
            //              select new
            //              {
            //                  slNo = order.OrderId,
            //                  orderDate = order.CreatedTime,
            //                  invoiceNo = order.OrderNumber,
            //                  productType = prduct.Category,
            //                  brand = prduct.Brand,
            //                  model = prduct.Model,
            //                  imie1 = prduct.IMEI1,
            //                  barcode = order.BarCode,
            //                  supplier = order.CreatedBy,
            //                  sellingPrice = order.Price

            //              }).ToList()
            //                      .Select(x =>
            //                          new Manager
            //                          {
            //                              slNo = x.slNo,
            //                  orderDate = Convert.ToDateTime(x.orderDate),
            //                  invoiceNo =x.invoiceNo,
            //                  productType = x.productType,
            //                  brand = x.brand,
            //                  model = x.model,
            //                  imie1 = x.imie1,
            //                  barcode = x.barcode,
            //                  supplier = x.supplier,
            //                  sellingPrice = x.sellingPrice
            //                          }).ToList();

            //ViewBag.orders = result.ToList();
            //return View();

        }


         [HttpPost]
        public ActionResult Managers3()
        {
            DateTime dateFrom = Convert.ToDateTime("2013-08-01");
            DateTime dateTo = Convert.ToDateTime("2013-08-03");

            ViewBag.orders3 = db.Orders.Where(i => EntityFunctions.TruncateTime(i.CreatedTime) >= dateFrom && EntityFunctions.TruncateTime(i.CreatedTime) <= dateTo).ToList();

            ViewBag.products3 = db.Products.Where(i => EntityFunctions.TruncateTime(i.StockSold) >= dateFrom && EntityFunctions.TruncateTime(i.StockSold) <= dateTo).ToList();



            return View();
        }

    }

    //public class Manager
    //{
    //    public int? slNo { get; set; }
    //    public DateTime orderDate { get; set; }
    //    public string invoiceNo { get; set; }
    //    public string productType { get; set; }
    //    public string brand { get; set; }
    //    public string model { get; set; }
    //    public string imie1 { get; set; }
    //    public string barcode { get; set;}
    //    public string supplier { get; set; }
    //    public decimal? sellingPrice { get; set;}
    //}
}
