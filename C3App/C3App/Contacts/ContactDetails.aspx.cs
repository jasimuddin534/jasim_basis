using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;

namespace C3App.Contacts
{
    public partial class ContactDetails : System.Web.UI.Page
    {
        private ContactBL contactbl = new ContactBL();
        private DropDownList AccountDropDownList;
        private DropDownList TeamDropDownList;
        private DropDownList ReportToDropDownList;
        private DropDownList AssaigendToDropDownList;
        private DropDownList LeadSourcesDropDownList;
        private DropDownList UserDropDownList;
        private Int64 ContactID;

        protected void Page_Load(object sender, EventArgs e)
        { 
            ContactID = Convert.ToInt64(Request.QueryString["ContactID"]);

            if (ContactID == 0)
            {
                ContactDetailsView.ChangeMode(DetailsViewMode.Insert);
                ContactDetailsView.AutoGenerateInsertButton = true;
            }
            else
            {
                updateButton.Visible = true;
                deleteButton.Visible = true;
            }
        }

        protected void ContactDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["AccountID"] = AccountDropDownList.SelectedValue;
            e.Values["TeamID"] = TeamDropDownList.SelectedValue;
            e.Values["ReportsTo"] = ReportToDropDownList.SelectedValue;
            e.Values["AssignedTo"] = AssaigendToDropDownList.SelectedValue;
            e.Values["LeadSourcesID"] = LeadSourcesDropDownList.SelectedValue;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] =7;
        }


        protected void AccountNameDropDownList_Init(object sender, EventArgs e)
        {
            AccountDropDownList = sender as DropDownList;
        }

        protected void TeamNameDropDownList_Init(object sender, EventArgs e)
        {
            TeamDropDownList = sender as DropDownList;
        }

        protected void ReportToDropDownList_Init(object sender, EventArgs e)
        {
            ReportToDropDownList = sender as DropDownList;
        }

        protected void AssaigendToDropDownList_Init(object sender, EventArgs e)
        {
            AssaigendToDropDownList = sender as DropDownList;
        }

        protected void LeadSourceDropDownList_Init(object sender, EventArgs e)
        {
            LeadSourcesDropDownList = sender as DropDownList;
        }

        protected void updateButton_Click(object sender, EventArgs e)
        {
            ContactDetailsView.ChangeMode(DetailsViewMode.Edit);
            ContactDetailsView.AutoGenerateEditButton = true;
            deleteButton.Visible = false;
            updateButton.Visible = false;
        }

        protected void deleteButton_Click(object sender, EventArgs e)
        {
            contactbl.GetContactByID(ContactID);
            Response.Redirect("ContactList.aspx");
        }

        protected void ContactDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            e.NewValues["AccountID"] = AccountDropDownList.SelectedValue;
            e.NewValues["TeamID"] = TeamDropDownList.SelectedValue;
            e.NewValues["AssignedTo"] = UserDropDownList.SelectedValue;
            e.NewValues["ModifiedTime"] = DateTime.Now;
            e.NewValues["CompanyID"] = 7;
        }

        protected void ContactDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Response.Redirect("ContactList.aspx");
            }
        }
    }
}