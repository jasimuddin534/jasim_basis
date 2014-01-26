using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using PayPoint.Models;
using WebMatrix.WebData;

namespace PayPoint.Controllers
{
    
    public class HomeController : Controller
    {
        private UsersContext db = new UsersContext();
        public ActionResult Index(string returnUrl)
        {
          ViewBag.ReturnUrl = returnUrl;
          return View();
        }
       [Authorize(Roles = "Administrator")]
        public ActionResult Users(string returnUrl)
        {
            ViewBag.users = db.UserProfiles.ToList();
            ViewBag.ReturnUrl = returnUrl;

            if (Request.QueryString["uname"] != null)
            {
                string username = Request.QueryString["uname"].ToString();

                var rolenames = Roles.GetRolesForUser(username);
                var rname = "";
                foreach (var name in rolenames)
                {
                    rname += name + ",";
                }

                rname = rname.Substring(0, rname.Length - 1);

                Roles.RemoveUserFromRole(username,rname);

                System.Web.Security.Membership.DeleteUser(username);
                return RedirectToAction("Users", "Home");
            }

            return View();
        }

        [Authorize(Roles = "Administrator")]
        public ActionResult CreateUser(string returnUrl)
        {
       
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        [Authorize(Roles = "Administrator")]
        public ActionResult EditUser(int id = 0)
        {
            var userobj = db.UserProfiles.Find(id);
            ViewBag.user = userobj.UserName;

            var rolenames = Roles.GetRolesForUser(ViewBag.user);
            var rname = "";
            foreach (var name in rolenames)
            {
                rname += name + ",";
            }

            rname = rname.Substring(0, rname.Length - 1);

            ViewBag.role = rname;
            
            ViewBag.users = db.UserProfiles.ToList();
            return View();
        }

        [Authorize(Roles = "Administrator")]
        [HttpPost]
        public ActionResult EditUser(string role, int id = 0)
        {
            ViewBag.users = db.UserProfiles.ToList();

            var userobj = db.UserProfiles.Find(id);
            ViewBag.user = userobj.UserName;

            var username = userobj.UserName;

            var allroles = Roles.GetAllRoles();

            if (username != null && allroles.Length > 0)
            {
                foreach (string rolename in allroles)
                {
                    if (Roles.GetRolesForUser(username).Contains(rolename))
                    {
                        Roles.RemoveUserFromRole(username, rolename);
                    }
                }

                if (!Roles.GetRolesForUser(username).Contains(role))
                    {
                        Roles.AddUserToRole(username, role);
                    }
                
            }


            return RedirectToAction("Users", "Home");

        }




    }
}