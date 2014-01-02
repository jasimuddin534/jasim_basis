using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace C3App.Users
{
    public partial class UserDetails : System.Web.UI.Page
    {
        private DropDownList countryDropDownList;
        private DropDownList genderDropDownList;
        private DropDownList reportsToDropDownList;
        private DropDownList roleDropDownList;

        protected void Page_Init(object sender, EventArgs e)
        {

            //  UsersDetailsView.EnableDynamicData(typeof(User));

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Int64 userid = Convert.ToInt32(Request.QueryString["UserID"].ToString());

            UsersDetailsView.ChangeMode(DetailsViewMode.ReadOnly);
            if (userid == 0)
            {

                UsersDetailsView.ChangeMode(DetailsViewMode.Insert);
                UsersDetailsView.AutoGenerateInsertButton = true;
                UsersDetailsView.FindControl("PrimaryEmail").Visible = false;
                UsersDetailsView.FindControl("txtPrimaryEmail").Visible = true;

            }
            else if (userid > 0)
            {
                UsersDetailsView.FindControl("txtPrimaryEmail").Visible = false;
                UsersDetailsView.FindControl("PrimaryEmail").Visible = true;
            }




        }

        protected void CountryDropDownList_Init(object sender, EventArgs e)
        {

            countryDropDownList = sender as DropDownList;

        }

        protected void GenderDropDownList_Init(object sender, EventArgs e)
        {

            genderDropDownList = sender as DropDownList;

        }

        protected void ReportsToDropDownList_Init(object sender, EventArgs e)
        {

            reportsToDropDownList = sender as DropDownList;

        }

        protected void RoleDropDownList_Init(object sender, EventArgs e)
        {

            roleDropDownList = sender as DropDownList;

        }

        protected void UsersDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {

            Int64 userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            e.NewValues["Gender"] = genderDropDownList.SelectedValue;
            e.NewValues["ReportsTo"] = reportsToDropDownList.SelectedValue;
            e.NewValues["Country"] = countryDropDownList.SelectedValue;
            e.NewValues["RoleID"] = roleDropDownList.SelectedValue;
            e.NewValues["ModifiedBy"] = userid;
            e.NewValues["ModifiedTime"] = DateTime.Now;


        }

        protected void UsersDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {

            Response.Redirect("~/Users/UserList.aspx");

        }

        protected void UsersDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                //Response.Redirect("~/Users/Users.aspx");
                UsersDetailsView.ChangeMode(DetailsViewMode.Edit);

            }

            if (e.CommandName == "Update")
            {
                //Response.Redirect("~/Users/Users.aspx");
                UsersDetailsView.ChangeMode(DetailsViewMode.Edit);


            }

            if (e.CommandName == "Cancel")
            {
                Response.Redirect("~/Users/UserList.aspx");
            }



        }

        protected void UsersDetailsView_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            Response.Redirect("~/Users/UserList.aspx");
        }

        protected void UsersDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            Response.Redirect("~/Users/UserList.aspx");
        }

        protected void UsersDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {

            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            Int64 userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

            e.Values["Gender"] = genderDropDownList.SelectedValue;
            e.Values["ReportsTo"] = reportsToDropDownList.SelectedValue;
            e.Values["Country"] = countryDropDownList.SelectedValue;
            e.Values["RoleID"] = roleDropDownList.SelectedValue;
            e.Values["CreatedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ActivationID"] = Guid.NewGuid();
            e.Values["Password"] = "abc316";
            e.Values["CompanyID"] = companyid;

            TextBox pe = (TextBox)UsersDetailsView.FindControl("txtPrimaryEmail");

            e.Values["PrimaryEmail"] = pe.Text;

        }

        protected void txtPrimaryEmail_Init(object sender, EventArgs e)
        {
            Int64 userid = Convert.ToInt32(Request.QueryString["UserID"].ToString());
            if (userid == 0)
            {
                UsersDetailsView.FindControl("txtPrimaryEmail").Visible = true;
                UsersDetailsView.FindControl("PrimaryEmail").Visible = false;
            }
            else if (userid > 0)
            {
                UsersDetailsView.FindControl("txtPrimaryEmail").Visible = false;
                UsersDetailsView.FindControl("PrimaryEmail").Visible = true;
            }

        }

      
    
    }
}