using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;

namespace C3App.Leads
{
    public partial class Leads1 : System.Web.UI.Page
    {
        LeadBL leadBL = new LeadBL();
        private DropDownList leadSourcesDropDownList;
        private DropDownList contactsDropDownList;
        private DropDownList accountsDropDownList;
        private DropDownList teamsDropDownList;
        private DropDownList assignedToUsersDropDownList;
        private DropDownList leadStatusesDropDownList;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!ClientScript.IsStartupScriptRegistered("alert"))
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "GoToTab(2);", true);
            }
        }
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
        }
        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            leadBL.SearchLeads(search);

        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            leadBL.SearchLeads(search);
        }
        protected void leadSourcesDropDownList_Init(object sender, EventArgs e)
        {
            leadSourcesDropDownList = sender as DropDownList;
        }
        protected void ContactsDropDownList_Init(object sender, EventArgs e)
        {
            contactsDropDownList = sender as DropDownList;
        }
        protected void AccountsDropDownList_Init(object sender, EventArgs e)
        {
            accountsDropDownList = sender as DropDownList;
        }

        protected void TeamsDropDownList_Init(object sender, EventArgs e)
        {
            teamsDropDownList = sender as DropDownList;
        }
        protected void AssignedToUsersDropDownList_Init(object sender, EventArgs e)
        {
            assignedToUsersDropDownList = sender as DropDownList;
        }
        protected void LeadStatusesDropDownList_Init(object sender, EventArgs e)
        {
            leadStatusesDropDownList = sender as DropDownList;
        }


        protected void LeadDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["LeadSourceID"] = leadSourcesDropDownList.SelectedValue;
            e.Values["FirstName"] = contactsDropDownList.SelectedItem;
            e.Values["AccountID"] = accountsDropDownList.SelectedValue;
            e.Values["TeamID"] = teamsDropDownList.SelectedValue;
            e.Values["AssignedUserID"] = assignedToUsersDropDownList.SelectedValue;
            e.Values["LeadStatusID"] = leadStatusesDropDownList.SelectedValue;
        }
        //protected void UpdateButton1_Click(object sender, EventArgs e)
        //{
        //    LeadsDetailsView.ChangeMode(DetailsViewMode.Edit);
        //    LeadsDetailsView.AutoGenerateEditButton = true;
        //    DeleteButton.Visible = false;
        //    UpdateButton.Visible = false;
        //}

        protected void deleteButton1_Click(object sender, EventArgs e)
        {


        }

        protected void LeadDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            e.NewValues["LeadSourceID"] = leadSourcesDropDownList.SelectedValue;
            e.NewValues["FirstName"] = contactsDropDownList.SelectedValue;
            e.NewValues["AccountID"] = accountsDropDownList.SelectedValue;
            e.NewValues["TeamID"] = teamsDropDownList.SelectedValue;
            e.NewValues["AssignedUserID"] = assignedToUsersDropDownList.SelectedValue;
            e.NewValues["LeadStatusID"] = leadStatusesDropDownList.SelectedValue;
        }
        protected void LeadInsertButton_Click(object sender, EventArgs e)
        {

            Button btn = sender as Button;
            string insert = btn.CommandArgument.ToString();
            Label1.Text = insert;
            Session["LeadID"] = 0;
            Label1.Text = Convert.ToString(Session["LeadID"]);
            LeadsDetailsView.ChangeMode(DetailsViewMode.Insert);
            LeadsDetailsView.AutoGenerateInsertButton = true;


        }

        protected void LeadEditButton_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            Session["LeadID"] = btn.CommandArgument.ToString();
            Label1.Text = Convert.ToString(Session["LeadID"]);
            LeadsDetailsView.ChangeMode(DetailsViewMode.Edit);
            LeadsDetailsView.AutoGenerateInsertButton = false;
            LeadsDetailsView.AutoGenerateEditButton = true;

        }

       
    }
}