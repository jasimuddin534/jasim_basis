using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;

namespace C3App.Opportunities
{
    public partial class OpportunityDetails : System.Web.UI.Page
    {
        OpportunityBL opportunityBl=new OpportunityBL();

        private DropDownList accountDropDownList;
        private DropDownList opportunityTypeDropDownList1;
        private DropDownList leadSourceDropDownList2;
        private DropDownList teamsDropDownList3;
        private DropDownList assignedToDropDownList4;
        private DropDownList currencyDropDownList5;
        private DropDownList salesStageDropDownList6;
        private DropDownList CampaignNameDropDownList7;
        private Int32 OpportunityID;
        private Int32 companyID;
        private Int32 userID;
        protected void Page_Load(object sender, EventArgs e)
        {
            companyID = 7;

            OpportunityID = Convert.ToInt32(Request.QueryString["OpportunityID"]);
            if (OpportunityID == 0)
            {
                opportunityDetailsView.ChangeMode(DetailsViewMode.Insert);
                opportunityDetailsView.AutoGenerateInsertButton = true;
            }
            else
            {
                
                updateButton.Visible = true;
                deleteButton.Visible = true;
            }

        }

        
        protected void accountDropDownList_Init(object sender, EventArgs e)
        {
            accountDropDownList = sender as DropDownList;
        }
        protected void opportunityTypeDropDownList_Init(object sender, EventArgs e)
        {
            opportunityTypeDropDownList1 = sender as DropDownList;
        }
        protected void leadSourceDropDownList_Init(object sender, EventArgs e)
        {
            leadSourceDropDownList2 = sender as DropDownList;
        }
        protected void teamsDropDownList_Init(object sender, EventArgs e)
        {
            teamsDropDownList3 = sender as DropDownList;
        }
        protected void assignedToDropDownList_Init(object sender, EventArgs e)
        {
            assignedToDropDownList4 = sender as DropDownList;
        }
        protected void currencyDropDownList_Init(object sender, EventArgs e)
        {
            currencyDropDownList5 = sender as DropDownList;
        }
        protected void salesStageDropDownList_Init(object sender, EventArgs e)
        {
            salesStageDropDownList6 = sender as DropDownList;
        }
        protected void CampaignNameDropDownList_Init(object sender, EventArgs e)
        {
            CampaignNameDropDownList7 = sender as DropDownList;
        }
      

        protected void opportunityDetailsDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["AccountID"] = accountDropDownList.SelectedValue;
            e.Values["OpportunityTypeID"] = opportunityTypeDropDownList1.SelectedValue;
            e.Values["LeadSourceID"] = leadSourceDropDownList2.SelectedValue;
            e.Values["TeamID"] = teamsDropDownList3.SelectedValue;
            e.Values["AssignedUserID"] = assignedToDropDownList4.SelectedValue;
            e.Values["CurrencyID"] = currencyDropDownList5.SelectedValue;
            e.Values["SalesStageID"] = salesStageDropDownList6.SelectedValue;
            e.Values["CampaignID"] = CampaignNameDropDownList7.SelectedValue;
            e.Values["CompanyID"] = companyID;
        }

        protected void updateButton_Click(object sender, EventArgs e)
        {
            opportunityDetailsView.ChangeMode(DetailsViewMode.Edit);
            opportunityDetailsView.AutoGenerateEditButton = true;
            deleteButton.Visible = false;
            updateButton.Visible = false;
        }

        protected void deleteButton_Click(object sender, EventArgs e)
        {
            opportunityBl.DeleteById(OpportunityID);
            Response.Redirect("OpportunityList.aspx");

        }

        protected void opportunityDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            e.NewValues["AccountID"] = accountDropDownList.SelectedValue;
            e.NewValues["OpportunityTypeID"] = opportunityTypeDropDownList1.SelectedValue;
            e.NewValues["LeadSourceID"] = leadSourceDropDownList2.SelectedValue;
            e.NewValues["TeamID"] = teamsDropDownList3.SelectedValue;
            e.NewValues["AssignedUserID"] = assignedToDropDownList4.SelectedValue;
            e.NewValues["CurrencyID"] = currencyDropDownList5.SelectedValue;
            e.NewValues["SalesStageID"] = salesStageDropDownList6.SelectedValue;
            e.NewValues["CampaignID"] = CampaignNameDropDownList7.SelectedValue;
        }



        protected void opportunityDetailsView_ItemCommand(Object sender, 
                                                                   DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Response.Redirect("OpportunityList.aspx");
            }
        }

       

    }
}