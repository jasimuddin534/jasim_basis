using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;

namespace C3App.Leads
{
    public partial class LeadDetails : System.Web.UI.Page
    {
        LeadBL leadBl=new LeadBL();
        private DropDownList leadSourceDropDownList;
        private DropDownList contactDropDownList1;
        private DropDownList accountDropDownList2;
        private DropDownList teamsDropDownList3;
        private DropDownList assignedToDropDownList4;
        private DropDownList leadStatusDropDownList5;

       // private Int32 companyID;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void leadSourceDropDownList_Init(object sender, EventArgs e)
        {
            leadSourceDropDownList = sender as DropDownList;
        }
        protected void contactDropDownList_Init(object sender, EventArgs e)
        {
            contactDropDownList1 = sender as DropDownList;
        }
        protected void accountDropDownList_Init(object sender, EventArgs e)
        {
            accountDropDownList2 = sender as DropDownList;
        }
     
        protected void teamsDropDownList_Init(object sender, EventArgs e)
        {
            teamsDropDownList3 = sender as DropDownList;
        }
        protected void assignedToDropDownList_Init(object sender, EventArgs e)
        {
            assignedToDropDownList4 = sender as DropDownList;
        }
        protected void leadStatusDropDownList_Init(object sender, EventArgs e)
        {
            leadStatusDropDownList5 = sender as DropDownList;
        }

        
        protected void leadDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["LeadSourceID"] = leadSourceDropDownList.SelectedValue;
            
            e.Values["FirstName"] = contactDropDownList1.SelectedItem;
            e.Values["AccountID"] = accountDropDownList2.SelectedValue;
            e.Values["TeamID"] = teamsDropDownList3.SelectedValue;
            e.Values["AssignedUserID"] = assignedToDropDownList4.SelectedValue;
            e.Values["LeadStatusID"] = leadStatusDropDownList5.SelectedValue;
        }
        protected void updateButton_Click(object sender, EventArgs e)
        {
            leadDetailsView.ChangeMode(DetailsViewMode.Edit);
            leadDetailsView.AutoGenerateEditButton = true;
            deleteButton.Visible = false;
            updateButton.Visible = false;
        }

        protected void deleteButton_Click(object sender, EventArgs e)
        {
           

        }

        protected void leadDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            e.NewValues["LeadSourceID"] = leadSourceDropDownList.SelectedValue;
            e.NewValues["FirstName"] = contactDropDownList1.SelectedValue;
            e.NewValues["AccountID"] = accountDropDownList2.SelectedValue;
            e.NewValues["TeamID"] = teamsDropDownList3.SelectedValue;
            e.NewValues["AssignedUserID"] = assignedToDropDownList4.SelectedValue;
            e.NewValues["LeadStatusID"] = leadStatusDropDownList5.SelectedValue;
        }

     
      
      
    }
}