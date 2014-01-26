using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace C3App
{
    public partial class _OrderDefault : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if(Session["PanelSet"].ToString() == "DetailsView")
            //{
            //    //GoToTab(2);
            //    UpdatePanel1.Attributes.Add("class", "tab active");
            //    this.DetailsPanel.Visible = true;
            //}
            
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