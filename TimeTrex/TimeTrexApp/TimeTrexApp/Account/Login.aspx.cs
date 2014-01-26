using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TimeTrexApp.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            

            
        }

        protected void Login_LoggedIn(object sender, EventArgs e)
        {
            if (Roles.IsUserInRole(login.UserName, "Admin"))
            {
                Response.Redirect("~/Admin/Attendance/Attendance.aspx");
            }

            if (Roles.IsUserInRole(login.UserName, "General"))
            {
                Response.Redirect("~/Attendance/Attendance.aspx");
            }
        }
    }
}