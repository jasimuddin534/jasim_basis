using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using PayPoint.Models;
using WebMatrix.WebData;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.UI;

namespace PayPoint.Controllers
{
    public class ReportsController : Controller
    {
        private PayPointContext db = new PayPointContext();

        public ActionResult Index()
        {
          
            return View();
        }


       [Authorize(Roles = "Administrator,Manager")]
        public ActionResult Order()
        {
            DateTime dt = DateTime.Now;

            ViewBag.users = (from p in db.Products
                            select p.CreatedBy).Distinct();

            ViewBag.orders = "";

            
            ViewBag.prodtypes = null;
            ViewBag.prodbrands = null;
            ViewBag.prodmodels = null;

            ViewBag.from = "";
            ViewBag.to = "";
            ViewBag.select = "";

           
            return View();
        }

       [HttpPost]
       public ActionResult ExportData()
       {
          // string ss = "<table><td><td></table>";
           var orders = Session["item"];
           GridView gv = new GridView();
           gv.DataSource = orders;
           gv.DataBind();
           Response.ClearContent();
           Response.Buffer = true;
           Response.AddHeader("content-disposition", "attachment; filename=Orderlist.xls");
           Response.ContentType = "application/ms-excel";
           Response.Charset = "";
           StringWriter sw = new StringWriter();
           HtmlTextWriter htw = new HtmlTextWriter(sw);
           gv.RenderControl(htw);
           Response.Output.Write(sw.ToString());
           Response.Flush();
           Response.End();


           //Response.ClearContent();
           //Response.AddHeader("content-disposition", "attachment; filename=Orderlist.xls");
           //Response.ContentType = "application/ms-excel";
           //Response.Write(ss);
           //Response.End();

           return RedirectToAction("Reports");
       }
       public ActionResult ExportProductData()
       {
           // string ss = "<table><td><td></table>";
           var products = Session["Product"];
           GridView gv = new GridView();
           gv.DataSource = products;
           gv.DataBind();
           Response.ClearContent();
           Response.Buffer = true;
           Response.AddHeader("content-disposition", "attachment; filename=Orderlist.xls");
           Response.ContentType = "application/ms-excel";
           Response.Charset = "";
           StringWriter sw = new StringWriter();
           HtmlTextWriter htw = new HtmlTextWriter(sw);
           gv.RenderControl(htw);
           Response.Output.Write(sw.ToString());
           Response.Flush();
           Response.End();


           //Response.ClearContent();
           //Response.AddHeader("content-disposition", "attachment; filename=Orderlist.xls");
           //Response.ContentType = "application/ms-excel";
           //Response.Write(ss);
           //Response.End();

           return RedirectToAction("Reports");
       }
       public ActionResult ExportProductOutData()
       {
           // string ss = "<table><td><td></table>";
           var productsOut = Session["ProductOut"];
         
           GridView gv = new GridView();
           gv.DataSource = productsOut;
           gv.DataBind();
           Response.ClearContent();
           Response.Buffer = true;
           Response.AddHeader("content-disposition", "attachment; filename=Orderlist.xls");
           Response.ContentType = "application/ms-excel";
           Response.Charset = "";
           StringWriter sw = new StringWriter();
           HtmlTextWriter htw = new HtmlTextWriter(sw);
           gv.RenderControl(htw);
           Response.Output.Write(sw.ToString());
           Response.Flush();
           Response.End();


           //Response.ClearContent();
           //Response.AddHeader("content-disposition", "attachment; filename=Orderlist.xls");
           //Response.ContentType = "application/ms-excel";
           //Response.Write(ss);
           //Response.End();

           return RedirectToAction("Reports");
       }

      
        [HttpPost]
        public ActionResult Order(string salesman, string fromdate,  string todate)
        {
            List<Order> orders = null;
            DateTime dt = DateTime.Now;


            var fdates = fromdate.Split('-');
            var tdates = todate.Split('-');

      
            ViewBag.from = fromdate;
            
            ViewBag.to = todate ;
            
            ViewBag.select = salesman;

            ViewBag.users = (from p in db.Products
                            select p.CreatedBy).Distinct();

            if (fromdate != "" && todate != "")
            {
                int fyear = Convert.ToInt32(fdates[0]);
                int fday = Convert.ToInt32(fdates[2]);
                int fmonth = Convert.ToInt32(fdates[1]);

                int tyear = Convert.ToInt32(tdates[0]);
                int tday = Convert.ToInt32(tdates[2]);
                int tmonth = Convert.ToInt32(tdates[1]);


                if (salesman != "")
                {
                    ViewBag.orders = db.Orders.Where(x => x.CreatedTime.Value.Year == fyear
                                    && x.CreatedTime.Value.Month >= fmonth
                                    && x.CreatedTime.Value.Day >= fday
                                    && x.CreatedTime.Value.Year <= tyear
                                    && x.CreatedTime.Value.Month <= tmonth
                                    && x.CreatedTime.Value.Day <= tday
                                    && x.CreatedBy == salesman
                                    ).ToList();
                }
                else
                {
                    ViewBag.orders = db.Orders.Where(x => x.CreatedTime.Value.Year == fyear
                                   && x.CreatedTime.Value.Month >= fmonth
                                   && x.CreatedTime.Value.Day >= fday
                                   && x.CreatedTime.Value.Year <= tyear
                                   && x.CreatedTime.Value.Month <= tmonth
                                   && x.CreatedTime.Value.Day <= tday
                                   
                                   ).ToList();
               
                }

               
            }
            else if(fromdate =="" && todate == "" && salesman!="")
            {
                  ViewBag.orders = db.Orders.Where(x => x.CreatedBy==salesman).ToList();
                
            }
            else if (fromdate == "" && todate == "" && salesman == "")
            {
                ViewBag.orders = db.Orders.ToList();
            }
            else
            {
                ViewBag.orders = "";
                ViewBag.prodtypes = null;
                ViewBag.prodbrands = null;
                ViewBag.prodmodels = null;
            }


            var prodtype = "";
            var prodmodel = "";
            var prodbrand = "";

            Session["item"] = ViewBag.orders;

            foreach (var item in ViewBag.orders)
            {
                string barcode = item.BarCode;

                var products = db.Products.Where(x => x.BarCode == barcode).First();

                prodtype += products.Category + ",";
                prodmodel += products.Model + ",";
                prodbrand += products.Brand + ",";

            }


            if (prodtype != "")
            {
                prodtype = prodtype.Substring(0, prodtype.Length - 1);
                ViewBag.prodtypes = prodtype;
            }
            else
            {
                ViewBag.prodtypes = null;
            }

            if (prodmodel != "")
            {
                prodmodel = prodmodel.Substring(0, prodmodel.Length - 1);
                ViewBag.prodmodels = prodmodel;
            }
            else
            {
                ViewBag.prodmodels = null;
            }

            if (prodbrand != "")
            {
                prodbrand = prodbrand.Substring(0, prodbrand.Length - 1);
                ViewBag.prodbrands = prodbrand;
            }
            else
            {
                ViewBag.prodbrands = null;
            }


            return View();

        }

         [Authorize(Roles = "Salesman")]
        public ActionResult OrderSalesman()
        {
            

            ViewBag.orders = "";

            ViewBag.prodtypes = null;
            ViewBag.prodbrands = null;
            ViewBag.prodmodels = null;

            ViewBag.from = "";
            ViewBag.to = "";
            


            return View();
        }


        [HttpPost]
        public ActionResult OrderSalesman(string fromdate, string todate)
        {
            DateTime dt = DateTime.Now;

            string salesman = User.Identity.Name;

            var fdates = fromdate.Split('-');
            var tdates = todate.Split('-');


            ViewBag.from = fromdate;

            ViewBag.to = todate;

           

            if (fromdate != "" && todate != "")
            {
                int fyear = Convert.ToInt32(fdates[0]);
                int fday = Convert.ToInt32(fdates[2]);
                int fmonth = Convert.ToInt32(fdates[1]);

                int tyear = Convert.ToInt32(tdates[0]);
                int tday = Convert.ToInt32(tdates[2]);
                int tmonth = Convert.ToInt32(tdates[1]);


         
                ViewBag.orders = db.Orders.Where(x => x.CreatedTime.Value.Year == fyear
                                    && x.CreatedTime.Value.Month >= fmonth
                                    && x.CreatedTime.Value.Day >= fday
                                    && x.CreatedTime.Value.Year <= tyear
                                    && x.CreatedTime.Value.Month <= tmonth
                                    && x.CreatedTime.Value.Day <= tday
                                    && x.CreatedBy == salesman
                                    ).ToList();
                
            }
            else if (fromdate == "" && todate == "" && salesman != "")
            {
                ViewBag.orders = db.Orders.Where(x => x.CreatedBy == salesman).ToList();

            }
         
            else
            {
                ViewBag.orders = "";
                ViewBag.prodtypes = null;
                ViewBag.prodbrands = null;
                ViewBag.prodmodels = null;
            }

            var prodtype = "";
            var prodmodel = "";
            var prodbrand = "";


            foreach (var item in ViewBag.orders)
            {
                string barcode = item.BarCode;

                var products = db.Products.Where(x => x.BarCode == barcode).First();

                prodtype += products.Category + ",";
                prodmodel += products.Model + ",";
                prodbrand += products.Brand + ",";
                Session["item"] = item;

            }


            if (prodtype != "")
            {
                prodtype = prodtype.Substring(0, prodtype.Length - 1);
                ViewBag.prodtypes = prodtype;
            }
            else
            {
                ViewBag.prodtypes = null;
            }

            if (prodmodel != "")
            {
                prodmodel = prodmodel.Substring(0, prodmodel.Length - 1);
                ViewBag.prodmodels = prodmodel;
            }
            else
            {
                ViewBag.prodmodels = null;
            }

            if (prodbrand != "")
            {
                prodbrand = prodbrand.Substring(0, prodbrand.Length - 1);
                ViewBag.prodbrands = prodbrand;
            }
            else
            {
                ViewBag.prodbrands = null;
            }

            return View();

        }


         [Authorize(Roles = "Administrator,Stock Supervisor")]
        public ActionResult Product()
        {
            DateTime dt = DateTime.Now;

            ViewBag.categories = (from p in db.Products
                             select p.Category).Distinct();
            ViewBag.brands = (from p in db.Products
                                  select p.Brand).Distinct();

            ViewBag.cselect = "";

            ViewBag.bselect = "";

            ViewBag.products = "";

            ViewBag.from = "";
            ViewBag.to = "";
           


            return View();
        }


        [HttpPost]
        public ActionResult Product(string category,string brand, string fromdate, string todate)
        {
            DateTime dt = DateTime.Now;
            ViewBag.categories = (from p in db.Products
                                  select p.Category).Distinct();
            ViewBag.brands = (from p in db.Products
                              select p.Brand).Distinct();

            var fdates = fromdate.Split('-');
            var tdates = todate.Split('-');


            ViewBag.from = fromdate;

            ViewBag.to = todate;

            ViewBag.cselect = category;

            ViewBag.bselect = brand;



            if (fromdate != "" && todate != "")
            {
                int fyear = Convert.ToInt32(fdates[0]);
                int fday = Convert.ToInt32(fdates[2]);
                int fmonth = Convert.ToInt32(fdates[1]);

                int tyear = Convert.ToInt32(tdates[0]);
                int tday = Convert.ToInt32(tdates[2]);
                int tmonth = Convert.ToInt32(tdates[1]);


                if (category != "" && brand == "")
                {
                    ViewBag.products = db.Products.Where(x => x.StockUpdate.Value.Year == fyear
                                         && x.StockUpdate.Value.Month >= fmonth
                                         && x.StockUpdate.Value.Day >= fday
                                         && x.StockUpdate.Value.Year <= tyear
                                         && x.StockUpdate.Value.Month <= tmonth
                                         && x.StockUpdate.Value.Day <= tday
                                         && x.Category == category
                                         ).ToList();
                }
                if (brand != "" && category=="")
                {
                    ViewBag.products = db.Products.Where(x => x.StockUpdate.Value.Year == fyear
                                        && x.StockUpdate.Value.Month >= fmonth
                                        && x.StockUpdate.Value.Day >= fday
                                        && x.StockUpdate.Value.Year <= tyear
                                        && x.StockUpdate.Value.Month <= tmonth
                                        && x.StockUpdate.Value.Day <= tday
                                        && x.Brand == brand
                                        ).ToList();
                }
                if (category == "" && brand == "")
                {
                    ViewBag.products = db.Products.Where(x => x.StockUpdate.Value.Year == fyear
                                        && x.StockUpdate.Value.Month >= fmonth
                                        && x.StockUpdate.Value.Day >= fday
                                        && x.StockUpdate.Value.Year <= tyear
                                        && x.StockUpdate.Value.Month <= tmonth
                                        && x.StockUpdate.Value.Day <= tday
                                        ).ToList();
                }
                if (category != "" && brand != "")
                {
                    ViewBag.products = db.Products.Where(x => x.StockUpdate.Value.Year == fyear
                                        && x.StockUpdate.Value.Month >= fmonth
                                        && x.StockUpdate.Value.Day >= fday
                                        && x.StockUpdate.Value.Year <= tyear
                                        && x.StockUpdate.Value.Month <= tmonth
                                        && x.StockUpdate.Value.Day <= tday
                                        && x.Category == category
                                        && x.Brand == brand
                                        ).ToList();
                }

                
                
            }
            else if(fromdate == "" && todate == "" && category!="" && brand=="")
            {
                ViewBag.products = db.Products.Where(x =>  x.Category == category).ToList();
               
            }
            else if (fromdate == "" && todate == "" && brand != "" && category=="")
            {
                ViewBag.products = db.Products.Where(x => x.Brand == brand).ToList();
            }
            else if (fromdate == "" && todate == "" && brand != "" && category!="")
            {
                ViewBag.products = db.Products.Where(x => x.Category == category && x.Brand==brand).ToList();
            }
            else if (fromdate == "" && todate == "" && brand == "" && category == "")
            {
                ViewBag.products = db.Products.ToList();
            }
            else
            {
                ViewBag.products = "";
            }

            Session["Product"] = ViewBag.products;
            return View();

        }
         [Authorize(Roles = "Administrator,Finance,Management")]
        public ActionResult ProductOut()
        {
            DateTime dt = DateTime.Now;

            ViewBag.categories = (from p in db.Products
                                  select p.Category).Distinct();
            ViewBag.brands = (from p in db.Products
                              select p.Brand).Distinct();

            ViewBag.cselect = "";

            ViewBag.bselect = "";

            ViewBag.products = "";
            ViewBag.orders = null;

            ViewBag.from = "";
            ViewBag.to = "";



            return View();
        }


        [HttpPost]
        public ActionResult ProductOut(string category, string brand, string fromdate, string todate)
        {
            DateTime dt = DateTime.Now;
            ViewBag.categories = (from p in db.Products
                                  select p.Category).Distinct();
            ViewBag.brands = (from p in db.Products
                              select p.Brand).Distinct();

            var fdates = fromdate.Split('-');
            var tdates = todate.Split('-');


            ViewBag.from = fromdate;

            ViewBag.to = todate;

            ViewBag.cselect = category;

            ViewBag.bselect = brand;



            if (fromdate != "" && todate != "")
            {
                int fyear = Convert.ToInt32(fdates[0]);
                int fday = Convert.ToInt32(fdates[2]);
                int fmonth = Convert.ToInt32(fdates[1]);

                int tyear = Convert.ToInt32(tdates[0]);
                int tday = Convert.ToInt32(tdates[2]);
                int tmonth = Convert.ToInt32(tdates[1]);


                if (category != "" && brand == "")
                {
                    ViewBag.products = db.Products.Where(x => x.StockSold.Value.Year == fyear
                                         && x.StockSold.Value.Month >= fmonth
                                         && x.StockSold.Value.Day >= fday
                                         && x.StockSold.Value.Year <= tyear
                                         && x.StockSold.Value.Month <= tmonth
                                         && x.StockSold.Value.Day <= tday
                                         && x.Category == category
                                         ).ToList();
                }
                if (brand != "" && category == "")
                {
                    ViewBag.products = db.Products.Where(x => x.StockSold.Value.Year == fyear
                                        && x.StockSold.Value.Month >= fmonth
                                        && x.StockSold.Value.Day >= fday
                                        && x.StockSold.Value.Year <= tyear
                                        && x.StockSold.Value.Month <= tmonth
                                        && x.StockSold.Value.Day <= tday
                                        && x.Brand == brand
                                        ).ToList();
                }
                if (category == "" && brand == "")
                {
                    ViewBag.products = db.Products.Where(x => x.StockSold.Value.Year == fyear
                                        && x.StockSold.Value.Month >= fmonth
                                        && x.StockSold.Value.Day >= fday
                                        && x.StockSold.Value.Year <= tyear
                                        && x.StockSold.Value.Month <= tmonth
                                        && x.StockSold.Value.Day <= tday
                                        ).ToList();
                }
                if (category != "" && brand != "")
                {
                    ViewBag.products = db.Products.Where(x => x.StockSold.Value.Year == fyear
                                        && x.StockSold.Value.Month >= fmonth
                                        && x.StockSold.Value.Day >= fday
                                        && x.StockSold.Value.Year <= tyear
                                        && x.StockSold.Value.Month <= tmonth
                                        && x.StockSold.Value.Day <= tday
                                        && x.Category == category
                                        && x.Brand == brand
                                        ).ToList();
                }



            }
            else if (fromdate == "" && todate == "" && category != "" && brand == "")
            {
                ViewBag.products = db.Products.Where(x => x.Category == category).ToList();

            }
            else if (fromdate == "" && todate == "" && brand != "" && category == "")
            {
                ViewBag.products = db.Products.Where(x => x.Brand == brand).ToList();
            }
            else if (fromdate == "" && todate == "" && brand != "" && category != "")
            {
                ViewBag.products = db.Products.Where(x => x.Category == category && x.Brand == brand).ToList();
            }
            else if (fromdate == "" && todate == "" && brand == "" && category == "")
            {
                ViewBag.products = db.Products.ToList();
            }
            else
            {
                ViewBag.products = "";
            }


            var ordernum = "";

            Session["ProductOut"] = ViewBag.products;
            foreach (var item in ViewBag.products)
            {
                string barcode = item.BarCode;
                string stockout = Convert.ToString(item.StockSold);
                if (stockout != null)
                {
                    var orders = db.Orders.Where(x => x.BarCode == barcode).First();
                    ordernum += orders.OrderNumber + ",";

                }
            }

           
            if (ordernum != "")
            {
                ordernum = ordernum.Substring(0, ordernum.Length - 1);
                ViewBag.orders = ordernum;
            }
            else
            {
                ViewBag.orders = null;
            }


           // Response.Write(ordernum);

            return View();

        }



    }
}
