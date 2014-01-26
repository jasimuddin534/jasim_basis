using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;

namespace C3App.Accounts
{
    public partial class AccountDetails : System.Web.UI.Page
    {
        AccountBL accountBl=new AccountBL();
        private DropDownList usersDDL;
        private DropDownList industryDDL;
        private DropDownList accountTypeDDL;
        private DropDownList teamDDL;
        private DropDownList memberOfDDL;
        private Int32 accountId;
        private Int32 companyID;
        private Int32 userID;

        private C3Entities context;

        protected void Page_Load(object sender, EventArgs e)
        {
            companyID = 7;

            accountId = Convert.ToInt32(Request.QueryString["AccountId"]);
            if (accountId == 0)
            {
                accountsDetailsView.ChangeMode(DetailsViewMode.Insert);
                accountsDetailsView.AutoGenerateInsertButton = true;
            }
            else
            {

                updateButton.Visible = true;
                deleteButton.Visible = true;
            }

        }

       
        protected void usersDDL_Init(object sender, EventArgs e)
        {
            usersDDL = sender as DropDownList;
        }

        protected void industryDDL_Init(object sender, EventArgs e)
        {
            industryDDL = sender as DropDownList;
        }

        protected void teamDDL_Init(object sender, EventArgs e)
        {
            teamDDL = sender as DropDownList;
        }

        protected void accountTypeDDL_Init(object sender, EventArgs e)
        {
            accountTypeDDL = sender as DropDownList;
        }

        protected void memberOfDDL_Init(object sender, EventArgs e)
        {
            memberOfDDL = sender as DropDownList;
        }

        protected void accountsDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
           // Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);


            e.Values["AccountTypesID"] = accountTypeDDL.SelectedValue;
            e.Values["AssignedUserID"] = usersDDL.SelectedValue;
            e.Values["TeamID"] = teamDDL.SelectedValue;
            e.Values["IndustryID"] = industryDDL.SelectedValue;
            e.Values["ParentID"] = memberOfDDL.SelectedValue;
           // e.Values["CompanyID"] =Session[""]   .SelectedValue;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;

        }

        protected void updateButton_Click(object sender, EventArgs e)
        {
            accountsDetailsView.ChangeMode(DetailsViewMode.Edit);
            accountsDetailsView.AutoGenerateEditButton = true;
            deleteButton.Visible = false;
            updateButton.Visible = false;
        }

        protected void deleteButton_Click(object sender, EventArgs e)
        {
            accountBl.DeleteAccount(accountId);
            Response.Redirect("AccountList.aspx");

        }


        protected void accountsDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            // Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);


            e.NewValues["AccountTypesID"] = accountTypeDDL.SelectedValue;
            e.NewValues["AssignedUserID"] = usersDDL.SelectedValue;
            e.NewValues["TeamID"] = teamDDL.SelectedValue;
            e.NewValues["IndustryID"] = industryDDL.SelectedValue;
            e.NewValues["ParentID"] = memberOfDDL.SelectedValue;
            // e.Values["CompanyID"] =Session[""]   .SelectedValue;
            e.NewValues["ModifiedTime"] = DateTime.Now;

        }

        protected void accountsDetailsView_ItemCommand(Object sender,DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Response.Redirect("AccountList.aspx");
            }
        }

        


        
    }
}