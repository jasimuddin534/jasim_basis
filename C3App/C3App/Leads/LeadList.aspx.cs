using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;

namespace C3App.Leads
{
    public partial class LeadList : System.Web.UI.Page
    {

        LeadBL leadBl=new LeadBL();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void searchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = searchTextBox.Text;
            leadBl.SearchLeads(search);

        }

        protected void searchButton_Click(object sender, EventArgs e)
        {
            string search = searchTextBox.Text;
            leadBl.SearchLeads(search);
        }
    }
}