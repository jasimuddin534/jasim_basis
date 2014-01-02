using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace C3App.Users
{
    public partial class UserList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
             Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            //Response.Write("Company Id is: " + companyid );
          
        
        }
    }
}