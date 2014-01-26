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
using AjaxControlToolkit;
using C3App.App_Code;

namespace C3App
{
    public partial class UserProfile : System.Web.UI.Page
    {
        private DropDownList countryDropDownList;
        private DropDownList genderDropDownList;
        private DropDownList reportsToDropDownList;
        private DropDownList roleDropDownList;
        private DropDownList isActiveDropDownList;
        private DropDownList messengerTypeDropDownList;
        private DropDownList securityQuestionDropDownList;
        private DropDownList teamDropDownList;

        protected void Page_Load(object sender, EventArgs e)
        {
            long userid = Convert.ToInt64(Session["UserID"]);
            UserBL userBL = new UserBL();
            var user = userBL.GetUsersByID(userid);
            string image = user.ElementAt(0).Image;

            UserImage.ImageUrl = "~/Users/" + Decryptdata(image);
         
        }

        protected void UserEditButton_Click(object sender, EventArgs e)
        {
            UserInsertButton.Text = "User Details";
            UsersDetailsView.ChangeMode(DetailsViewMode.Edit);
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
            ExceptionUtility.LogException(exc, "UserProfilePage");
            ExceptionUtility.NotifySystemOps(exc, "UserProfilePage");

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



        //protected void MaritalStatusDropDownList_Init(object sender, EventArgs e)
        //{
        //    UserBL userBL = new UserBL();
        //    maritalStatusDropDownList = sender as DropDownList;
        //    string value = userBL.GetMaritalStatus(Convert.ToInt64(Session["UserID"]));
        //    foreach (ListItem item in maritalStatusDropDownList.Items)
        //    {
        //        if (item.Text == value)
        //        {
        //            item.Selected = true;
        //            break;
        //        }
        //    }

        //}

        protected void IsActiveDropDownList_Init(object sender, EventArgs e)
        {
            isActiveDropDownList = sender as DropDownList;
            UserBL userBL = new UserBL();
            string value = userBL.IsActive(Convert.ToInt64(Session["UserID"]));

            foreach (ListItem item in isActiveDropDownList.Items)
            {
                if (item.Value == value)
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
            string value = userBL.GetGender(Convert.ToInt64(Session["UserID"]));

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
            string value = userBL.GetMessengerType(Convert.ToInt64(Session["UserID"]));
            foreach (ListItem item in messengerTypeDropDownList.Items)
            {
                if (item.Text == value)
                {
                    item.Selected = true;
                    break;
                }
            }

        }

        protected void SecurityQuestionDropDownList_Init(object sender, EventArgs e)
        {
            UserBL userBL = new UserBL();
            securityQuestionDropDownList = sender as DropDownList;
            string value = userBL.GetsecurityQuestion(Convert.ToInt64(Session["UserID"]));
            foreach (ListItem item in securityQuestionDropDownList.Items)
            {
                if (item.Text == value)
                {
                    item.Selected = true;
                    break;
                }
            }
        }

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
            long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            long currentuserid = Int64.Parse(ID);
            string password = null;
            string passwordsalt = null;
            UserBL userBL = new UserBL();
            var user = userBL.GetUsersByID(userid);

            if (user.Count() > 0)
            {
                password = user.ElementAt(0).Password;
                passwordsalt = user.ElementAt(0).PasswordSalt;
            }
            //FileUpload imageFileUpload = (FileUpload)UsersDetailsView.FindControl("fileUpload");
            //if (imageFileUpload.HasFile)
            //{
            //    const string fileUploadDirectory = "Images/";
            //    string fileName = Server.HtmlEncode(imageFileUpload.FileName);
            //    string extension = System.IO.Path.GetExtension(fileName);
            //    string fileNameWithoutExtension = System.IO.Path.GetFileNameWithoutExtension(imageFileUpload.FileName);
            //    string imagefilename = userid + "_" + "ProfilePic";
            //    string encodedImageName = Encryptdata(imagefilename);

            //    string imagePath = fileUploadDirectory + encodedImageName + extension;


            //    string fileString = System.IO.Path.GetExtension(imageFileUpload.FileName);
            //    if (extension == ".jpg" || extension == ".bmp" || extension == ".gif")
            //    {
            //        string file = imagefilename + extension;
            //        //imageFileUpload.SaveAs(Path.Combine(fileUploadDirectory, file));
            //       imageFileUpload.SaveAs(Server.MapPath("Images/" + imagefilename + extension));
            //        // imageFileUpload.SaveAs(fileUploadDirectory + imageFileUpload.FileName);
            //        e.NewValues["Image"] = imagePath;
            //    }
            //    else
            //    {
            //        ScriptManager.RegisterStartupScript(this,this.GetType(), "script", "alert('Only jpg, bmp and gif files are allowed.')",true);

            //    }
            //}

            e.NewValues["Image"] = Convert.ToString(Session["ImagePath"]);
            e.NewValues["Password"] = password;
            e.NewValues["PasswordSalt"] = passwordsalt;
            e.NewValues["Gender"] = genderDropDownList.SelectedValue;
            e.NewValues["ModifiedBy"] = userid;
            e.NewValues["ModifiedTime"] = DateTime.Now;
           // e.NewValues["IsActive"] = isActiveDropDownList.SelectedValue;
          //  e.NewValues["MaritalStatus"] = maritalStatusDropDownList.SelectedValue;
            e.NewValues["MessengerType"] = messengerTypeDropDownList.SelectedValue;
            e.NewValues["SecurityQuestion"] = securityQuestionDropDownList.SelectedValue;
            //e.NewValues["TeamID"] = teamDropDownList.SelectedValue;

            if (Convert.ToInt32(countryDropDownList.SelectedValue) == 0) { e.NewValues["CountryID"] = null; }
            else { e.NewValues["CountryID"] = countryDropDownList.SelectedValue; }

            //if (Convert.ToInt32(roleDropDownList.SelectedValue) == 0) { e.NewValues["RoleID"] = null; }
            //else { e.NewValues["RoleID"] = roleDropDownList.SelectedValue; }
            
            if (Convert.ToInt32(reportsToDropDownList.SelectedValue) == 0) { e.NewValues["ReportsTo"] = null; }
            else { e.NewValues["ReportsTo"] = reportsToDropDownList.SelectedValue; }



        }

        protected void UsersDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            Int64 id = 0;
            string value = Convert.ToString(Session["UpdateUserProfile"]);
            if (value != "")
            id = int.Parse(value);
        
            if (id > 0)
            {
                //Literal1.Text = "Success";
                //Label6.Text =  "Profile has been saved successfully.";
                long userid = Convert.ToInt64(Session["UserID"]);
                UserBL userBL = new UserBL();
                var user = userBL.GetUsersByID(userid);
                string image = user.ElementAt(0).Image;
                UserImage.ImageUrl = "~/Users/" + Decryptdata(image);

                Literal1.Text = "Success !</br></br> <p>Profile information has been updated successfully</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                UsersDetailsView.DataBind();
            }
            else
            {
               // Literal1.Text = "Error";
               // Label6.Text =  "Profile did not save.";
                Literal1.Text = "Error !</br></br> <p>Profile information did not save.</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
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
                UsersDetailsView.DataBind();
               // Literal1.Text = "Cancel";
                //Label6.Text = "Your changes have been discarded.";
                Literal1.Text = "Submission cancelled <br/> <p>Your changes have been discarded</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
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
            if (imagepath != "" && imagepath != null)
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
                image = "Images/Chrysanthemum.jpg";
            }
            return image;
        }

        protected void txtPrimaryEmail_Init(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                long userid = Convert.ToInt64(Session["UserID"]);

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
        }

        protected void UsersObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            string value = "";
            value = Convert.ToString(e.ReturnValue);
            Session["UpdateUserProfile"] = value;
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
            long userid = Convert.ToInt64(Session["UserID"]);
            string oldpassword = OldPasswordTextBox.Text;
            string newpassword = NewPasswordTextBox.Text;
            string confirmpassword = Server.HtmlEncode(ConfirmPasswordTextBox.Text);
            string hash = null;
            string salt = null;
            string goodHash = null;
            bool chk = false;
            UserBL userBL = new UserBL();
            var user = userBL.GetUsersByID(userid);
            
            if(user.Count()>0)
            {
                    hash = user.ElementAt(0).Password;
                    salt = user.ElementAt(0).PasswordSalt;
                    goodHash = "1000:" + salt + ":" + hash;
                    chk =  Authentication.ValidatePassword(oldpassword,goodHash);
             }
            
            if (chk == true)
            {
                if(newpassword.Length >=6)
                {
                    if(newpassword == confirmpassword)
                    {
                        // save password
                        ErrorLabel.Text = "Success and Saved!";
                        userBL.SetPassword(newpassword);
                       
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
            else
            {
                // password not match;
                ErrorLabel.Text = "Wrong Password! Please try again.";
   
            }

     


        }

        protected void AjaxFileUpload1_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
                long userid = Convert.ToInt64(Session["UserID"]);
               // AjaxFileUpload imageFileUpload = (AjaxFileUpload)UsersDetailsView.FindControl("AjaxFileUpload1");
                const string fileUploadDirectory = "Images/";
                string fileName = e.FileName;//Server.HtmlEncode(imageFileUpload.FileName);
                string extension = System.IO.Path.GetExtension(fileName);
                string imagefilename = userid + "_" + "ProfilePic";
                string encodedImageName = Encryptdata(imagefilename);
                string imagePath = fileUploadDirectory + encodedImageName + extension;
                string file = imagefilename + extension;
                AjaxFileUpload1.SaveAs(Server.MapPath("~/Users/Images/" + imagefilename + extension));
                Session["ImagePath"] = "Images/" + encodedImageName + extension;
                //UserImage.ImageUrl = "~/Users/Images/" + imagefilename + extension;
               
        }

      


    }
}