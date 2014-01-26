using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace C3App.Contacts
{
    public partial class ContactList : System.Web.UI.Page
    {
        private DropDownList AccountDropDownList;
        private DropDownList TeamDropDownList;
        private DropDownList UserDropDownList;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AccountNameDropDownList_Init(object sender, EventArgs e)
        {

            AccountDropDownList = sender as DropDownList;

        }

        protected void ContactsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            e.NewValues["AccountID"] = AccountDropDownList.SelectedValue;
            e.NewValues["TeamID"] = TeamDropDownList.SelectedValue;
            e.NewValues["AssignedTo"] = UserDropDownList.SelectedValue;
            e.NewValues["ModifiedTime"] = DateTime.Now;
            e.NewValues["CompanyID"] = 7;
        }

        protected void TeamNameDropDownList_Init(object sender, EventArgs e)
        {
            TeamDropDownList = sender as DropDownList;
        }

        protected void UserNameDropDownList_Init(object sender, EventArgs e)
        {
            UserDropDownList = sender as DropDownList;
        }

         }
}