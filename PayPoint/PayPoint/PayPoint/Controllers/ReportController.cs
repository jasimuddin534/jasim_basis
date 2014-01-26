using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PayPoint.Models;

namespace PayPoint.Controllers
{
    public class ReportController : Controller
    {
        private PayPointContext db = new PayPointContext();
        //
        // GET: /Report/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ProductReport()
        {
            ViewBag.products1 = "";
            ViewBag.products = db.Products.ToList();
            ViewBag.orders = "";
            ViewBag.users = (from product in db.Products
                             select product.CreatedBy).Distinct();
            
            return View();
        }
        [HttpPost]
        public ActionResult ProductReport(string salesman, DateTime fromdate, DateTime todate)
        {
            //string[] fdates = fromdate.Split('-');
            //int fdate = Convert.ToInt32(fdates[2]);
            //int fmonth = Convert.ToInt32(fdates[1]);
            //int fyear = Convert.ToInt32(fdates[0]);

            //DateTime dt = DateTime.Now;

            //var fdt = dt.Day;
          
            var orders = (from order1 in db.Orders
                          where
                              order1.CreatedTime.Value.Day <= fromdate.Day && order1.CreatedTime.Value.Month 
                              <= fromdate.Month && order1.CreatedTime.Value.Year<=fromdate.Year &&
                              order1.CreatedTime.Value.Day >= todate.Day && order1.CreatedTime.Value.Month >= todate.Month
                              && order1.CreatedTime.Value.Year >= todate.Year
                              select order1).ToList();

            ViewBag.orders = orders;

           foreach (var order in orders)
            {
                var barcode = order.BarCode;
                ViewBag.products1 = (from product in db.Products
                                     where product.BarCode == barcode
                                    select product).Single();
            }
            


            //ViewBag.users = db.UserProfiles.ToList();

            //var userobj = db.UserProfiles.Find(id);
            //ViewBag.user = userobj.UserName;

            //var username = userobj.UserName;

            //var allroles = Roles.GetAllRoles();

            //if (username != null && allroles.Length > 0)
            //{
            //    foreach (string rolename in allroles)
            //    {
            //        if (Roles.GetRolesForUser(username).Contains(rolename))
            //        {
            //            Roles.RemoveUserFromRole(username, rolename);
            //        }
            //    }

            //    if (!Roles.GetRolesForUser(username).Contains(role))
            //    {
            //        Roles.AddUserToRole(username, role);
            //    }

            //}

           ViewBag.products = db.Products.ToList();
  
           ViewBag.users = (from product in db.Products
                            select product.CreatedBy).Distinct();
            return View();

        }

    }
}

