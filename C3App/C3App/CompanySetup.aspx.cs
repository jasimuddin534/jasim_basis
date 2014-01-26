using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using C3App.BLL;
using C3App.DAL;
using C3App.App_Code;

namespace C3App
{
    public partial class CompanySetup : System.Web.UI.Page
    {
        private DropDownList companyTypesDropDownList;
        private DropDownList teamSetDropDownList;
        private DropDownList roleDropDownList;
        private DropDownList teamDropDownList;
        private DropDownList countryDropDownList;

        protected void Page_Load(object sender, EventArgs e)
        {
            UserBL userBL = new UserBL();
            long uid = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
            userBL.FirstLoginSetToZero(uid);
            Firstname.Text = "Logged in as " + Session["FirstName"]+ " " + Session["LastName"];

        }

  

        public void Page_Error(object sender, EventArgs e)
        {
            // Get last error from the server
            Exception exc = Server.GetLastError();

            //Development phase error messages
            Response.Write("<h2>Something wrong happend!</h2>");
            Response.Write("<b>Exception Type: </b>" + exc.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Exception: </b>" + exc.Message.ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception Type: </b>" + exc.InnerException.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception: </b>" + exc.InnerException.Message + "<br/><br/>");
            Response.Write("<b>Inner Source: </b>" + exc.InnerException.Source + "<br/><br/>");
            //Response.Write("<b>Stack Trace: </b>" + exc.StackTrace.ToString());

            //Log the exception and notify system operators
            ExceptionUtility.LogException(exc, "CompanySetupPage");
            ExceptionUtility.NotifySystemOps(exc, "CompanySetupPage");

            //Clear the error from the server
            Server.ClearError();
        }


        protected void CompanyObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            string value = "";
            value = Convert.ToString(e.ReturnValue);
            Session["NewCompany"] = value;
        }

        protected void CompanyDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            UserBL userBL = new UserBL();
        
            Int64 userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            
            if (Convert.ToInt32(companyTypesDropDownList.SelectedValue) == 0) { e.NewValues["CompanyTypeID"] = null; }
            else { e.NewValues["CompanyTypeID"] = companyTypesDropDownList.SelectedValue; }
            e.NewValues["ModifiedTime"] = DateTime.Now;
            e.NewValues["ModifiedBy"] = userid;
        }

        protected void CompanyDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
           
            long id = 0;
            string value = Convert.ToString(Session["NewCompany"]);
            if (value != "")
                id = int.Parse(value);


            if (id > 0)
            {
                Label1.Text = "Success !</br> <p>Company information has been updated successfully</p>";
                UpdatePanel1.Update();
            }
            else
            {
                Label1.Text = "Error !</br> <p>Company information did not save.</p>";
                UpdatePanel1.Update();
            }


        }

        protected void CompanyDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {

            if (e.CommandName == "Cancel")
            {
                Label1.Text = "Submission cancelled <br/> <p>Your changes have been discarded</p>";
                UpdatePanel1.Update();
            }
        }

        protected void CompanyTypesDropDownList_Init(object sender, EventArgs e)
        {
            companyTypesDropDownList = sender as DropDownList;
        }

        protected void TeamSetDropDownList_Init(object sender, EventArgs e)
        {
            teamSetDropDownList = sender as DropDownList;
       
        }

        protected void TeamsDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
       
            if (e.CommandName == "Cancel")
            {
                Label2.Text = "Submission cancelled <br/> <p>Your changes have been discarded</p>";
                UpdatePanel2.Update();
            }
        }

        protected void TeamsDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            TeamBL teamBL = new TeamBL();
            Int64 id = 0;
            string value = Convert.ToString(Session["NewTeam"]);
            if (value != "")
                id = int.Parse(value);


            if (id > 0)
            {
                Label2.Text = "Success !</br> <p>Team information has been saved successfully</p>";
                UpdatePanel2.Update();
                UsersDetailsView.DataBind();
                UpdatePanel3.Update();
            }
            else
            {
                Label2.Text = "Error !</br> <p>Team information did not save.</p>";
                UpdatePanel2.Update();
            }


        }

        protected void TeamsDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            Int64 userid = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
   
            e.Values["CreatedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["CompanyID"] = companyid;
            e.Values["TeamSetID"] = teamSetDropDownList.SelectedValue;
        }

        protected void TeamDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Insert failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;

            }
            else
            {
                string value = "";
                value = Convert.ToString(e.ReturnValue);
                Session["NewTeam"] = value;
            }
        }

        protected void UsersDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
          
            if (e.CommandName == "Cancel")
            {
                Label3.Text = "Submission cancelled <br/> <p>Your changes have been discarded</p>";
                UpdatePanel3.Update();
            }
        }

        protected void UsersDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            TextBox pe = (TextBox)UsersDetailsView.FindControl("txtPrimaryEmail");
            string pemail = pe.Text;
            UserBL userBL = new UserBL();
            bool emailaddress = false;
            emailaddress = userBL.IsEmailExists(pemail);

            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            Int64 userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

          
            e.Values["TeamID"] = teamDropDownList.SelectedValue;

            Int64 teamid = Convert.ToInt64(teamDropDownList.SelectedValue);
            e.Values["TeamSetID"] = userBL.GetTeamSetID(teamid);

            e.Values["CreatedBy"] = userid;
            e.Values["ModifiedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ActivationID"] = Guid.NewGuid();
            e.Values["CompanyID"] = companyid;

            if (Convert.ToInt32(roleDropDownList.SelectedValue) == 0) { e.Values["RoleID"] = null; e.Values["IsAdmin"] = null; }
            else
            {
                e.Values["RoleID"] = roleDropDownList.SelectedValue;
                int roleid = Convert.ToInt32(roleDropDownList.SelectedValue);
                string rolename = userBL.GetRoleName(roleid);
                if (rolename == "Administrator" || rolename == "Admin")
                {
                    e.Values["IsAdmin"] = true;
                }
                else
                {
                    e.Values["IsAdmin"] = false;
                }

            }
            e.Values["IsActive"] = true;
            e.Values["IsEmployee"] = true;
            e.Values["CountryID"] = countryDropDownList.SelectedValue;
            e.Values["PrimaryEmail"] = pe.Text;
        }

        protected void UsersDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {

            TextBox pe = (TextBox)UsersDetailsView.FindControl("txtPrimaryEmail");
            string pemail = pe.Text;
            UserBL userBL = new UserBL();
            bool emailaddress = true;
            emailaddress = userBL.IsEmailExists(pemail);

            long id = 0;
            string value = Convert.ToString(Session["NewUser"]);
            if (value != "")
            id = int.Parse(value);


            if (id > 0)
            {
                Label3.Text = "Success !</br> <p>User information has been saved successfully</p>";
                UpdatePanel3.Update();
            }
            else
            {
                if (emailaddress == false)
                {

                    Label3.Text = "Error !</br> <p>User information did not save.</p>";
                    UpdatePanel3.Update();

                }
                else
                {
                    Label3.Text = "Error !</br> <p>This Primary Email Address Already Exists.Please try another one.</p>";
                    UpdatePanel3.Update();
             
                }
               
            }
        }

        protected void UsersObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Insert failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "user";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;

            }
            else
            {
                string value = "";
                value = Convert.ToString(e.ReturnValue);
                Session["NewUser"] = value;
            }
        }


        protected void RoleDropDownList_Init(object sender, EventArgs e)
        {
            roleDropDownList = sender as DropDownList;
        }

        protected void TeamDropDownList_Init(object sender, EventArgs e)
        {
            teamDropDownList = sender as DropDownList;
        }

        protected void CountryDropDownList_Init(object sender, EventArgs e)
        {
            countryDropDownList = sender as DropDownList;
        }


        
    }
}