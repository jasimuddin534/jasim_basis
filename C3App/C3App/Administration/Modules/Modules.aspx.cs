using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;

namespace C3App.Administration.Modules
{
    public partial class Modules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

           

            //Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            C3Entities context = new C3Entities();
            ACLRoleBL aclRoleBL = new ACLRoleBL();
            int roleid = aclRoleBL.InsertRole("csd", "csd");
            Response.Write("roleid is  " + roleid);

            //int moduleid = 0;
            //int functionid = 0;
            //int[] menus = { 0 };
            //int[] functions = { 0 };
            //int i = 0;
            //int j = 0;

            //var query = from t in context.CompanyModules
            //            where (t.CompanyID == companyid)
            //            orderby t.ModuleID ascending
            //            select t.ModuleID;

            //if (query.Count() > 0)
            //{
            //    menus = new int[query.Count()];
            //    foreach (var q in query)
            //    {
            //        moduleid = q;
            //        // Response.Write("module id is: " + q + "<hr>");
            //        menus[i] = q;
            //        i++;
            //    }

            //}

            //var query1 = from t in context.ACLFunctions
            //             orderby t.FunctionOrder ascending
            //             select t.FunctionID;

            //if (query1.Count() > 0)
            //{
            //    functions = new int[query1.Count()];
            //    foreach (var q1 in query1)
            //    {
            //        functionid = q1;
            //        // Response.Write("function id is: " + q1 + "<hr>");
            //        functions[j] = q1;
            //        j++;

            //    }
            //}


            //foreach (int x in menus)
            //{
            //    foreach (int y in functions)
            //    {
            //        Response.Write("menu id are: " + x + "function id" + y + "<hr>");

            //        var aclaction = new ACLAction { ModuleID = x, FunctionID = y, Access = true, RoleID=4, CreatedTime = DateTime.Now };
            //        context.ACLActions.Add(aclaction);
            //        context.SaveChanges();

            //    }
            //}




        }


    }
}  