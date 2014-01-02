using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using C3App.BLL;
using C3App.DAL;
using System.Text;
using C3App.App_Code;

namespace C3App.Users
{
    public partial class Users : PageBase
    {

        private DropDownList countryDropDownList;
        private DropDownList genderDropDownList;
        private DropDownList reportsToDropDownList;
        private DropDownList roleDropDownList;
        private DropDownList isActiveDropDownList;
        private DropDownList messengerTypeDropDownList;
     //   private DropDownList securityQuestionDropDownList;
        private DropDownList teamDropDownList;

        protected void Page_Init(object sender, EventArgs e)
        {
            // UsersDetailsView.EnableDynamicData(typeof(User));

        }

        protected void Page_Load(object sender, EventArgs e)
        {

                    if (Request.QueryString["ShowPanel"] != null)
                    {
                        if ((!IsPostBack))
                        {
                            Session.Remove("EditUserID");
                         
                        }
                    }

                    //if (Session["EditUserID"] != null)
                    //{

                        Int64 userid = Convert.ToInt64(Session["EditUserID"]);

                        if (userid == 0)
                        {

                            UsersDetailsView.ChangeMode(DetailsViewMode.Insert);
                            UsersDetailsView.FindControl("PrimaryEmail").Visible = false;
                            UsersDetailsView.FindControl("txtPrimaryEmail").Visible = true;
                            UsersDetailsView.FindControl("CreatePasswordTextBox").Visible = true;
                            UsersDetailsView.FindControl("PasswordTextBox").Visible = false;
                            UsersDetailsView.FindControl("ModalPopButton2").Visible = false;
                            UsersDetailsView.FindControl("PasswordRequiredFieldValidator").Visible = true;
                            
                            //ModalPopButton2.Visible = false;
                            EditLinkButton.Visible = false;
                            DeleteLinkButton.Visible = false;
                           
                            this.UsersGridView.DataBind();
                            this.UsersGridView.SelectedIndex = -1;
                            this.MiniUserFormView.DataBind();
                            this.MiniUserDetailsView.DataBind();
                            upListView.Update();
                            miniDetails.Update();

                        }
                        else if (userid > 0)
                        {
                            UserInsertButton.Text = "User Details";
                            UsersDetailsView.ChangeMode(DetailsViewMode.Edit);
                            // UsersDetailsView.AutoGenerateEditButton = true;
                            UsersDetailsView.FindControl("txtPrimaryEmail").Visible = false;
                            UsersDetailsView.FindControl("PrimaryEmail").Visible = true;
                            UsersDetailsView.FindControl("PrimaryEmailRegularExpressionValidator").Visible = false;
                            UsersDetailsView.FindControl("PrimaryEmailRequiredFieldValidator").Visible = false;

                            UsersDetailsView.FindControl("CreatePasswordTextBox").Visible = false;
                            UsersDetailsView.FindControl("PasswordRequiredFieldValidator").Visible = false;
                            UsersDetailsView.FindControl("PasswordTextBox").Visible = true;
                            UsersDetailsView.FindControl("ModalPopButton2").Visible = true;

                            //ModalPopButton2.Visible = true;
                            if(CheckEdit()!=false)
                            EditLinkButton.Visible = true;
                     
                            long loguser = Convert.ToInt64(Session["UserID"]);
                            long seluser = Convert.ToInt64(Session["EditUserID"]);

                            if (CheckDelete() != false && (loguser != seluser))
                            {
                                DeleteLinkButton.Visible = true;
                            }
                            else
                            {
                                DeleteLinkButton.Visible = false;
                            }
                        }
                    //}
                    //else
                    //{

                    //    UsersDetailsView.ChangeMode(DetailsViewMode.Insert);
                    //    UsersDetailsView.DataBind();
                    //    //UsersDetailsView.AutoGenerateInsertButton = true;
                    //}

            
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
            ExceptionUtility.LogException(exc, "UsersPage");
            ExceptionUtility.NotifySystemOps(exc, "UsersPage");

            //Clear the error from the server
            Server.ClearError();
        }

        protected void AddNullValueToDropDownList_DataBound(object sender, EventArgs e)
        {
            DropDownList dropdownlist = (DropDownList)sender;
            if (dropdownlist.SelectedValue == null)
            {
                dropdownlist.Items[0].Enabled = true;
            }
        }

        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            
            Session["EditUserID"] = e.CommandArgument.ToString();
            int gindex = Convert.ToInt32(UsersGridView.SelectedIndex);
            if (gindex > -1)
            {

                LinkButton nlbtn = UsersGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                nlbtn.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            lbtn.CssClass = "active";
            miniDetails.Update();
            //ModalPopButton2.Visible = true;
            if(CheckEdit()!=false)
            EditLinkButton.Visible = true;

            bool cc = CheckDelete();

            long loguser = Convert.ToInt64(Session["UserID"]);
            long seluser = Convert.ToInt64(Session["EditUserID"]);

            if (CheckDelete() != false && (loguser != seluser))
            {
                DeleteLinkButton.Visible = true;
            }
            else
            {
                DeleteLinkButton.Visible = false;
            }
        }



        protected void IsActiveDropDownList_Init(object sender, EventArgs e)
        {
            isActiveDropDownList = sender as DropDownList;
            UserBL userBL = new UserBL();
            string value = userBL.IsActive(Convert.ToInt64(Session["EditUserID"]));
            
            foreach (ListItem item in isActiveDropDownList.Items)
            {
                if ( item.Value == value)
                {
                    item.Selected = true;
                    break;
                }
            }
        }

        protected void CountryDropDownList_Init(object sender, EventArgs e)
        {

            countryDropDownList = sender as DropDownList;
        
        }

        protected void GenderDropDownList_Init(object sender, EventArgs e)
        {

            UserBL userBL = new UserBL();

            genderDropDownList = sender as DropDownList;
            string value = userBL.GetGender(Convert.ToInt64(Session["EditUserID"]));

            if (value == "Male")
            genderDropDownList.SelectedIndex = genderDropDownList.Items.IndexOf(genderDropDownList.Items.FindByText("Male"));
            else if (value == "Female")
            genderDropDownList.SelectedIndex = genderDropDownList.Items.IndexOf(genderDropDownList.Items.FindByText("Female"));
            else
            genderDropDownList.SelectedIndex = genderDropDownList.Items.IndexOf(genderDropDownList.Items.FindByText(""));

        }

        protected void MessengerTypeDropDownList_Init(object sender, EventArgs e)
        {

            UserBL userBL = new UserBL();
            messengerTypeDropDownList = sender as DropDownList;
            string value = userBL.GetMessengerType(Convert.ToInt64(Session["EditUserID"]));
            foreach (ListItem item in messengerTypeDropDownList.Items)
            {
                if (item.Text == value)
                {
                    item.Selected = true;
                    break;
                }
            }

        }

        //protected void SecurityQuestionDropDownList_Init(object sender, EventArgs e)
        //{
        //    UserBL userBL = new UserBL();
        //    securityQuestionDropDownList = sender as DropDownList;
        //    string value = userBL.GetsecurityQuestion(Convert.ToInt64(Session["EditUserID"]));
        //    foreach (ListItem item in securityQuestionDropDownList.Items)
        //    {
        //        if (item.Text == value)
        //        {
        //            item.Selected = true;
        //            break;
        //        }
        //    }
        //}

        protected void ReportsToDropDownList_Init(object sender, EventArgs e)
        {

            reportsToDropDownList = sender as DropDownList;

        }

        protected void RoleDropDownList_Init(object sender, EventArgs e)
        {

            roleDropDownList = sender as DropDownList;

        }

        protected void TeamDropDownList_Init(object sender, EventArgs e)
        {
            teamDropDownList = sender as DropDownList;

        }

        protected void UsersDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            string ID = UsersDetailsView.DataKey[0].ToString();
            Int64 userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            Int64 currentuserid = Int64.Parse(ID);
            UserBL userBL = new UserBL();
            long edituser = Convert.ToInt32(HttpContext.Current.Session["EditUserID"]);
            string password = null;
            string passwordsalt = null;
            var user = userBL.GetUsersByID(edituser);

            if (user.Count() > 0)
            {
                password = user.ElementAt(0).Password;
                passwordsalt = user.ElementAt(0).PasswordSalt;
            }


            e.NewValues["Password"] = password;
            e.NewValues["PasswordSalt"] = passwordsalt;
            e.NewValues["Gender"] = genderDropDownList.SelectedValue;
            e.NewValues["ModifiedBy"] = userid;
            e.NewValues["ModifiedTime"] = DateTime.Now;
            e.NewValues["IsActive"] = isActiveDropDownList.SelectedValue;
            e.NewValues["MessengerType"] = messengerTypeDropDownList.SelectedValue;
           // e.NewValues["SecurityQuestion"] = securityQuestionDropDownList.SelectedValue;
            e.NewValues["TeamID"] = teamDropDownList.SelectedValue;
            Int64 teamid = Convert.ToInt64(teamDropDownList.SelectedValue);
            e.NewValues["TeamSetID"] = userBL.GetTeamSetID(teamid);
           
            if (Convert.ToInt32(countryDropDownList.SelectedValue) == 0) { e.NewValues["CountryID"] = null; }
            else { e.NewValues["CountryID"] = countryDropDownList.SelectedValue; }

            if (Convert.ToInt32(roleDropDownList.SelectedValue) == 0) { e.NewValues["RoleID"] = null; e.NewValues["IsAdmin"] = null; }
            else 
            { 
                e.NewValues["RoleID"] = roleDropDownList.SelectedValue;
                int roleid = Convert.ToInt32(roleDropDownList.SelectedValue);
                string rolename = userBL.GetRoleName(roleid);
                if (rolename == "Administrator" || rolename == "Admin")
                {
                    e.NewValues["IsAdmin"] = true;
                }
                else
                {
                    e.NewValues["IsAdmin"] = false;
                }

            }
            
            if (Convert.ToInt32(reportsToDropDownList.SelectedValue) == 0) { e.NewValues["ReportsTo"] = null; }
            else { e.NewValues["ReportsTo"] = reportsToDropDownList.SelectedValue; }

      

        }

        protected void UsersDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {

            Int64 id = 0;

            string value = Convert.ToString(Session["UpdateUser"]);
            if (value != "")
            id = int.Parse(value);


            if (id > 0)
            {
                //Literal1.Text = "Success";
                //Label6.Text =  "User information has been saved successfully.";
                Literal1.Text = "Success !</br></br> <p>User information has been updated successfully</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                Session["EditUserID"] = 0;
                UsersDetailsView.DataBind();
            }
            else
            {
               // Literal1.Text = "Error";
                //Label6.Text = "User information did not save.";
                Literal1.Text = "Error !</br></br> <p>User information did not save.</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                Session["EditUserID"] = 0;
                UsersDetailsView.DataBind();
            }
        }

        protected void UsersDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                UsersDetailsView.ChangeMode(DetailsViewMode.Edit);
            }

            if (e.CommandName == "Update")
            {
                UsersDetailsView.ChangeMode(DetailsViewMode.Edit);
            }

            if (e.CommandName == "Cancel")
            {
                Session["EditUserID"] = 0;
                UsersDetailsView.DataBind();
                Literal1.Text = "Submission cancelled <br/> <p>Your changes have been discarded</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
            }

        }

        protected void UsersDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            this.UsersGridView.DataBind();
            this.MiniUserFormView.DataBind();
            this.MiniUserDetailsView.DataBind();
            upListView.Update();
            miniDetails.Update();


            TextBox pe = (TextBox)UsersDetailsView.FindControl("txtPrimaryEmail");
            string pemail = pe.Text;
            UserBL userBL = new UserBL();
            bool emailaddress = false;
            emailaddress = userBL.IsEmailExists(pemail);

            Int64 id = 0;
            string value = Convert.ToString(Session["NewUser"]);
            if(value !="")
            id = int.Parse(value);

           
                if (id > 0)
                {
                    //Literal1.Text = "Success";
                    //Label6.Text = "User information has been saved successfully.";
                    Literal1.Text = "Success !</br></br> <p>User information has been saved successfully</p>";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    Session["EditUserID"] = 0;
                    UsersDetailsView.DataBind();
                 
                }
                else
                {
                    if (emailaddress == true)
                    {
                        //Literal1.Text = "Error";
                        //Label6.Text = "User information did not save.";
                        Literal1.Text = "Error !</br></br> <p>User information did not save.</p>";
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                        Session["EditUserID"] = 0;
                        UsersDetailsView.DataBind();
                    
                    }
            
                }
    
        }


        public string Encryptdata(string filename)
        {
            string strmsg = string.Empty;
            byte[] encode = new byte[filename.Length];
            encode = Encoding.UTF8.GetBytes(filename);
            strmsg = Convert.ToBase64String(encode);
            return strmsg;
        }

        public string Decryptdata(string imagepath)
        {
            string image = "";
            if (imagepath != "")
            {
                string[] path = { "" };
                path = imagepath.Split('/');
                string baseurl = path[0];
                string filename = path[1];
                string[] withextention = { "" };
                withextention = filename.Split('.');
                string encryptpwd = withextention[0];
                string extention = withextention[1];
                string decryptpwd = string.Empty;
                UTF8Encoding encodepwd = new UTF8Encoding();
                Decoder Decode = encodepwd.GetDecoder();
                byte[] todecode_byte = Convert.FromBase64String(encryptpwd);
                int charCount = Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
                char[] decoded_char = new char[charCount];
                Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
                decryptpwd = new String(decoded_char);

                image = baseurl + "/" + decryptpwd + "." + extention;
            }
            else
            {
                image = "~/Users/Images/Chrysanthemum.jpg";
            }
            return image;
        }

        protected void UsersDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {

            TextBox pe = (TextBox)UsersDetailsView.FindControl("txtPrimaryEmail");
            string pemail = pe.Text;

            TextBox pa = (TextBox)UsersDetailsView.FindControl("CreatePasswordTextBox");
            string password = pa.Text;
            
            UserBL userBL = new UserBL();
            bool emailaddress = false;
            emailaddress = userBL.IsEmailExists(pemail);

            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            Int64 userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

                e.Values["Gender"] = genderDropDownList.SelectedValue;
                e.Values["IsActive"] = isActiveDropDownList.SelectedValue;
                //e.Values["MaritalStatus"] = maritalStatusDropDownList.SelectedValue;
                e.Values["MessengerType"] = messengerTypeDropDownList.SelectedValue;
               // e.Values["SecurityQuestion"] = securityQuestionDropDownList.SelectedValue;
                e.Values["TeamID"] = teamDropDownList.SelectedValue;

                Int64 teamid = Convert.ToInt64(teamDropDownList.SelectedValue);
                e.Values["TeamSetID"] = userBL.GetTeamSetID(teamid);

                e.Values["CreatedBy"] = userid;
                e.Values["ModifiedBy"] = userid;
                e.Values["ModifiedTime"] = DateTime.Now;
                e.Values["CreatedTime"] = DateTime.Now;
                e.Values["ActivationID"] = Guid.NewGuid();
                e.Values["Password"] = password;
                e.Values["CompanyID"] = companyid;

                if (Convert.ToInt32(countryDropDownList.SelectedValue) == 0) { e.Values["CountryID"] = null; }
                else { e.Values["CountryID"] = countryDropDownList.SelectedValue; }

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
                
                if (Convert.ToInt32(reportsToDropDownList.SelectedValue) == 0) { e.Values["ReportsTo"] = null; }
                else { e.Values["ReportsTo"] = reportsToDropDownList.SelectedValue; }
                e.Values["PrimaryEmail"] = pe.Text;
         

        }

        protected void txtPrimaryEmail_Init(object sender, EventArgs e)
        {
            if (Session["EditUserID"] != null)
            {
                Int64 userid = Convert.ToInt64(Session["EditUserID"]);

                if (userid == 0)
                {
                    UsersDetailsView.FindControl("txtPrimaryEmail").Visible = true;
                    UsersDetailsView.FindControl("PrimaryEmail").Visible = false;
                }
                else if (userid > 0)
                {
                    UsersDetailsView.FindControl("txtPrimaryEmail").Visible = false;
                    UsersDetailsView.FindControl("PrimaryEmail").Visible = true;
                    UsersDetailsView.FindControl("PrimaryEmailRegularExpressionValidator").Visible = false;
                    UsersDetailsView.FindControl("PrimaryEmailRequiredFieldValidator").Visible = false;
                    
                }
            }
            else
            {
                UsersDetailsView.FindControl("txtPrimaryEmail").Visible = true;
                UsersDetailsView.FindControl("PrimaryEmail").Visible = false;
            }

        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            //Session.Remove("EditUserID");
            //this.UsersGridView.DataBind();
            //this.MiniUserFormView.DataBind();
            //this.MiniUserDetailsView.DataBind();
            //upListView.Update();
            //miniDetails.Update();
        }

        protected void UserInsertButton_Click(object sender, EventArgs e)
        {       
            Session["EditUserID"] = 0;
            UsersDetailsView.ChangeMode(DetailsViewMode.Insert);
            UsersDetailsView.DataBind();
          // UsersDetailsView.AutoGenerateInsertButton = true;


        }

        protected void EditLinkButton_Click(object sender, EventArgs e)
        {
            UserInsertButton.Text = "User Details";
            UsersDetailsView.ChangeMode(DetailsViewMode.Edit);
          //  UsersDetailsView.AutoGenerateEditButton = true;

        }

        protected void UserDeleteButton_Click(object sender, EventArgs e)
        {
            UserBL userBL = new UserBL();
            Int64 userid = Convert.ToInt64(Session["EditUserID"]);
            userBL.DeactivateUser(userid);
            Session["EditUserID"] = 0;
            this.UsersGridView.DataBind();
            this.UsersGridView.SelectedIndex = -1;
            this.MiniUserFormView.DataBind();
            this.MiniUserDetailsView.DataBind();
            upListView.Update();
            miniDetails.Update();
            EditLinkButton.Visible = false;
          //  ModalPopButton2.Visible = false;
            DeleteLinkButton.Visible = false;

           // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
          
        }

        protected void UsersObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
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
                Session["NewUser"] = value;
            }
        }

        protected void UsersObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Update failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;

            }
            else
            {
                string value = "";
                value = Convert.ToString(e.ReturnValue);
                Session["UpdateUser"] = value;
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
           
            //ModalPopButton2.Visible = false;
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            UsersGridView.DataSourceID = SearchObjectDataSource.ID;
            this.UsersGridView.DataBind();
            this.UsersGridView.SelectedIndex = -1;
            this.MiniUserFormView.DataBind();
            this.MiniUserDetailsView.DataBind();
            upListView.Update();
            miniDetails.Update();

        }

        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {

            //ModalPopButton2.Visible = false;
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            UsersGridView.DataSourceID = UsersviewObjectDataSource.ID;
            this.UsersGridView.DataBind();
            this.UsersGridView.SelectedIndex = -1;
            this.MiniUserFormView.DataBind();
            this.MiniUserDetailsView.DataBind();
            upListView.Update();
            miniDetails.Update();
           
        }

        protected void PasswordTextBox_Load(object sender, EventArgs e)
        {
            UserBL userBL = new UserBL();
            string password = "";
            ErrorLabel.Text = "message will show here";

            password = userBL.GetUserPassword();

            if (password != null)
            {
                TextBox pe = (TextBox)UsersDetailsView.FindControl("PasswordTextBox");
                pe.Text = password;

            }
        }


        protected void ModalPopButton2_Click(object sender, EventArgs e)
        {

        }

        protected void PasswordSaveButton_Click(object sender, EventArgs e)
        {
            long userid = Convert.ToInt64(Session["EditUserID"]);
            string newpassword = NewPasswordTextBox.Text;
            string confirmpassword = ConfirmPasswordTextBox.Text;
    
            UserBL userBL = new UserBL();
            
                if (newpassword.Length >= 6)
                {
                    if (newpassword == confirmpassword)
                    {
                        // save password
                        ErrorLabel.Text = "Success and Saved!";
                        userBL.SetUserPassword(newpassword,userid);

                        TextBox pe = (TextBox)UsersDetailsView.FindControl("PasswordTextBox");
                        pe.Text = newpassword;
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);

                    }
                    else
                    {
                        // new and confirm did not match
                        ErrorLabel.Text = "Confirm Password did not match! Please try again";
                    }

                }
                else
                {
                    // more than 6 char
                    ErrorLabel.Text = "Password length should be more than 5 characters";
                }

        }

        protected void CreatePasswordTextBox_Init(object sender, EventArgs e)
        {
            if (Session["EditUserID"] != null)
            {
                Int64 userid = Convert.ToInt64(Session["EditUserID"]);

                if (userid == 0)
                {
                    UsersDetailsView.FindControl("CreatePasswordTextBox").Visible = true;
                    UsersDetailsView.FindControl("PasswordTextBox").Visible = false;
                    UsersDetailsView.FindControl("ModalPopButton2").Visible = false;
                    UsersDetailsView.FindControl("PasswordRequiredFieldValidator").Visible = true;
                }
                else if (userid > 0)
                {
                 
                    UsersDetailsView.FindControl("PasswordTextBox").Visible = true;
                    UsersDetailsView.FindControl("ModalPopButton2").Visible = true;
                    UsersDetailsView.FindControl("PasswordRequiredFieldValidator").Visible = false;
                    UsersDetailsView.FindControl("CreatePasswordTextBox").Visible = false;

                }
            }
            else
            {
                UsersDetailsView.FindControl("CreatePasswordTextBox").Visible = true;
                UsersDetailsView.FindControl("PasswordTextBox").Visible = false;
                UsersDetailsView.FindControl("ModalPopButton2").Visible = false;
                UsersDetailsView.FindControl("PasswordRequiredFieldValidator").Visible = true;

            }

        }


      
      
       
    }
}