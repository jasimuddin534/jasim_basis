using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;

namespace C3App.Opportunities
{
    public partial class OpportunityList : System.Web.UI.Page
    {
        private OpportunityBL opportunitiesBl = new OpportunityBL();
        private DropDownList opportunitiesDropDownList;
        private DropDownList opportunitiesDropDownList1;
        private DropDownList opportunitiesDropDownList2;
        private DropDownList opportunitiesDropDownList3;
        private DropDownList opportunitiesDropDownList4;
        private DropDownList opportunitiesDropDownList5;


        protected void Page_Load(object sender, EventArgs e)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            Response.Write("Company Id is: " + companyid);
        }

        protected void searchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = searchTextBox.Text;
            opportunitiesBl.SearchOpportunities(search);

        }

        protected void searchButton_Click(object sender, EventArgs e)
        {
            string search = searchTextBox.Text;
            opportunitiesBl.SearchOpportunities(search);
        }

      

       



    }
}