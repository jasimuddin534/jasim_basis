using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;

namespace C3App.Accounts
{
    public partial class AccountList : System.Web.UI.Page
    {
        private AccountBL accountBl=new AccountBL();

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void searchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = searchTextBox.Text;
            accountBl.SearchAccount(search);
       
        }


         protected void searchButton_Click(object sender, EventArgs e)
        {
            string search = searchTextBox.Text;
            accountBl.SearchAccount(search);
        }
    }
}