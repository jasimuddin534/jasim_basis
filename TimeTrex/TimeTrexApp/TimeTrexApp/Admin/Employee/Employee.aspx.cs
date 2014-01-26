using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TimeTrexApp.BLL;

namespace TimeTrexApp.Employee
{
    public partial class Employee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string userName = Page.User.Identity.Name;
            bool admin = Roles.IsUserInRole(userName, "Admin");
            if (userName != "")
            {
                if (Roles.IsUserInRole(userName, "General"))
                {
                    Response.Redirect("~/Attendance/Attendance.aspx");
                }
                else if (admin == true)
                {
                    if (!IsPostBack)
                    {
                        BindEmployeeDetails();
                    }
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
            else
            {
                // need to delete all session // logout
                Response.Redirect("~/Account/Login.aspx");
            }


        }
        protected void BindEmployeeDetails()
        {
            object[] objp;
            int i = 0;

            objp = new object[2];
            objp.SetValue("", i++);
            objp.SetValue("", i++);

            EmployeeBL employeeBLL = new EmployeeBL();
            DataTable dt = new DataTable();
            dt = employeeBLL.EmployeeList(objp);
            EmployeeListGridView.DataSource = dt;
            EmployeeListGridView.DataBind();
 

        }
    }
}