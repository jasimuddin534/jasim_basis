using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace C3App
{
    public partial class DefaultMeeting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
        }

        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditUserID"] = e.CommandArgument.ToString();
            //miniDetails.Update();
        }
    }
}