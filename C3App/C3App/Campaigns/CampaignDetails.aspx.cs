using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace C3App.Campaigns
{
    public partial class CampaignDetails : System.Web.UI.Page
    {
        private DropDownList CampaignDropDownList;
        private DropDownList CampaignTypeDropDownList;
        private DropDownList CurrencyDropDownList;
        private DropDownList AssignedUserDropDownList;
        private DropDownList TeamDropDownList;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CampaignDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["CampaignStatusID"] = CampaignDropDownList.SelectedValue;
            e.Values["CampaignTypeID"] = CampaignTypeDropDownList.SelectedValue;
            e.Values["CurrencyID"] = CurrencyDropDownList.SelectedValue;
            e.Values["AssignedUserID"] = AssignedUserDropDownList.SelectedValue;
            e.Values["TeamID"] = TeamDropDownList.SelectedValue;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] = 8;
        }

        

        protected void CampaignStatusDropDownList_Init(object sender, EventArgs e)
        {
            CampaignDropDownList = sender as DropDownList;
        }

        protected void CampaignTypeDropDownList_Init(object sender, EventArgs e)
        {
            CampaignTypeDropDownList = sender as DropDownList;
        }

        protected void CurrencyDropDownList_Init(object sender, EventArgs e)
        {
           CurrencyDropDownList = sender as DropDownList;
        }

        protected void AssignedUserDropDownList_Init(object sender, EventArgs e)
        {
            AssignedUserDropDownList = sender as DropDownList;
        }

        protected void TeamNameDropDownList_Init(object sender, EventArgs e)
        {
            TeamDropDownList = sender as DropDownList;
        }
    }
}