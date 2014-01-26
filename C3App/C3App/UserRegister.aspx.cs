using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;
using C3App.App_MasterPages;
using System.Text.RegularExpressions;
using C3App.App_Code;
using System.Collections.Specialized;

namespace C3App
{
    public partial class UserRegister : System.Web.UI.Page
    {

        private DropDownList countryDropDownList;



        protected void Page_Load(object sender, EventArgs e)
        {

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
            ExceptionUtility.LogException(exc, "UserRegisterPage");
            ExceptionUtility.NotifySystemOps(exc, "UserRegisterPage");

            //Clear the error from the server
            Server.ClearError();

        }

        protected void CountryDropDownList_Init(object sender, EventArgs e)
        {

            countryDropDownList = sender as DropDownList;

        }


        protected void cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/UserRegister.aspx");
        }

        protected void submit_Click(object sender, EventArgs e)
        {
                try
                {
                    string companyname = "";
                    companyname = CompanyTextBox.Text;
                    int countryid = Convert.ToInt32(countryDropDownList.SelectedValue);
                    string rolename = "Administrator";
                    UserBL userBL = new UserBL();
                    ACLRoleBL aclroleBL = new ACLRoleBL();

                    bool existcompany = false;
                    bool emailaddress = false;

                    existcompany = userBL.IsCompanyExists(companyname);
                    emailaddress = userBL.IsEmailExists(PrimaryEmailTextBox.Text);

                    if (
                        existcompany == false && emailaddress == false && companyname != "" && FirstNameTextBox.Text != ""
                        && LastNameTextBox.Text != "" && TitleTextBox.Text != "" && StreetTextBox.Text != ""
                        && CityTextBox.Text != "" && PostalCodeTextBox.Text != ""
                        && MobilePhoneTextBox.Text != "" && PrimaryEmailTextBox.Text != ""
                     )
                    {
                        Int32 companyID = userBL.GetCompanyID(companyname, countryid);
                        Int32 roleID = userBL.GetRoleID(rolename, companyID);
                        string password = userBL.GenerateRandomPassword();
                        string m = aclroleBL.InsertCompanyModules(companyID);
                        aclroleBL.InsertACLAction(roleID, companyID);
                        object[] objp;
                        int i = 0;

                        objp = new object[12];

                        objp.SetValue(FirstNameTextBox.Text, i++);
                        objp.SetValue(LastNameTextBox.Text, i++);
                        objp.SetValue(TitleTextBox.Text, i++);
                        objp.SetValue(StreetTextBox.Text, i++);
                        objp.SetValue(CityTextBox.Text, i++);
                        //objp.SetValue(StateTextBox.Text, i++);
                        objp.SetValue(PostalCodeTextBox.Text, i++);
                        objp.SetValue(countryDropDownList.SelectedValue, i++);
                        objp.SetValue(MobilePhoneTextBox.Text, i++);
                        objp.SetValue(PrimaryEmailTextBox.Text, i++);
                        objp.SetValue(companyID, i++);
                        objp.SetValue(roleID, i++);
                        objp.SetValue(password, i++);

                        long id = userBL.RegisterUser(objp);

                        /// Code done by Pavel to Activate Registered User
                        /// Start

                        string emailID = PrimaryEmailTextBox.Text;
                       // String mailbody = null;
                        Guid? activationID = userBL.GetActivationID(emailID);


                        ListDictionary templateValues = new ListDictionary();
                        templateValues.Add("<%=PrimaryEmail%>", emailID);
                        templateValues.Add("<%=ActivationID%>", activationID);
                        templateValues.Add("<%=Password%>", password);

                        Session["CompanyID"] = companyID;
                        Session["UserID"] = id;

                        C3App.App_Code.Notification.Notify("User", id, 1, emailID, 1, templateValues);

                        Session.Clear();
                        Session.Abandon();

                        Literal1.Text = "Registration Successfull";
                        Label1.Text = "To activate your account please check your email.<br>";
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                        CloseHyperLink.NavigateUrl = "~/UserLogin.aspx";
                        // ClientScript.RegisterClientScriptBlock(Page.GetType(), "validation", "<script language='javascript'>ShowAlertModal();</script>");
                    }
                    else
                    {
                        Literal1.Text = "Registration Error";
                        Label1.Text = "Registration is not completed.Please try again";
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                        CloseHyperLink.NavigateUrl = "~/UserRegister.aspx";
                        //ClientScript.RegisterClientScriptBlock(Page.GetType(), "validation", "<script language='javascript'>ShowAlertModal();</script>");
                    }

                }

                catch (Exception ex)
                {
                    throw ex;
                }
   
        }

        protected void SubmitLinkButton_Click(object sender, EventArgs e)
        {
            string fname = FirstNameTextBox.Text;
            string lname = LastNameTextBox.Text;
            string designation = TitleTextBox.Text;
            string company = CompanyTextBox.Text;
            UserBL userBL = new UserBL();
            bool existcompany = userBL.IsCompanyExists(company);
            Regex regex = new Regex(@"^[a-zA-Z''-'.\s]{1,200}$");
            Match fmatch = regex.Match(fname);
            Match lmatch = regex.Match(lname);
            Match dmatch = regex.Match(designation);
            Match cmatch = regex.Match(company);


            if (fname !="" && lname !="" && designation!="" && company!="" && existcompany==false)
            {
                if (!fmatch.Success)
                {
                    Literal1.Text = "Error";
                    Label1.Text = "First Name is not valid ";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    return;
                }
                if (!lmatch.Success)
                {
                    Literal1.Text = "Error";
                    Label1.Text = "Last Name is not valid ";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    return;
                }
                if (!dmatch.Success)
                {
                    Literal1.Text = "Error";
                    Label1.Text = "Designation Field is not valid ";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    return;
                }
                if (!cmatch.Success)
                {
                    Literal1.Text = "Error";
                    Label1.Text = "Company Name is not valid ";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    return;
                }
                if (fmatch.Success && lmatch.Success && dmatch.Success && cmatch.Success)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToSlide(1);", true);
                }
            }
            
            if(fname == "")
            {
                Literal1.Text = "Error";
                Label1.Text = "First Name cannot be empty";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }
            if (lname == "")
            {
                Literal1.Text = "Error";
                Label1.Text = "Last Name cannot be empty";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }
            if (designation == "")
            {
                Literal1.Text = "Error";
                Label1.Text = "Designation Field cannot be empty";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }
            if (company == "")
            {
                Literal1.Text = "Error";
                Label1.Text = "Company Name cannot be empty";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }
            if (existcompany == true)
            {
                Literal1.Text = "Error";
                Label1.Text = "This company alreday exists. Please try another one.";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }

        }

        protected void SubmitLinkButton2_Click(object sender, EventArgs e)
        {
            string street = StreetTextBox.Text;
            string city = CityTextBox.Text;
            string postal = PostalCodeTextBox.Text;
            string phone = MobilePhoneTextBox.Text;
            string email = PrimaryEmailTextBox.Text;
            UserBL userBL = new UserBL();
            bool emailaddress = userBL.IsEmailExists(PrimaryEmailTextBox.Text);
            Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
            Match match = regex.Match(email);
            Regex sregex = new Regex(@"^[a-zA-Z0-9\s\(\)\/,\:\;\.-]+$");
            Match smatch = sregex.Match(street);
            Regex cregex = new Regex(@"^[a-zA-Z''-'.\s]{1,200}$");
            Match cmatch = cregex.Match(city);
            Regex pregex = new Regex(@"^\d{4}$");
            Match pmatch = pregex.Match(postal);
            Regex mregex = new Regex(@"^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$");
            Match mmatch = mregex.Match(phone);


            if (street != "" && city != "" && postal != "" && phone != "" && email !="" && emailaddress == false)
            {
                if (!smatch.Success)
                {
                    Literal1.Text = "Error";
                    Label1.Text = "Street Field is not valid ";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    return;
                }
                if (!cmatch.Success)
                {
                    Literal1.Text = "Error";
                    Label1.Text = "City Name is not valid ";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    return;
                }
                if (!pmatch.Success)
                {
                    Literal1.Text = "Error";
                    Label1.Text = "Postal code is not valid ";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    return;
                }
                if (!mmatch.Success)
                {
                    Literal1.Text = "Error";
                    Label1.Text = "Phone number is not valid ";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    return;
                }
                if (!match.Success)
                {
                    Literal1.Text = "Error";
                    Label1.Text = "This Email Address is not valid. Please give valid Email Address.";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    return;
                }
                if (smatch.Success && cmatch.Success && pmatch.Success && mmatch.Success && match.Success)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToSlide(2);", true);
                }
                
            }

            if (street == "")
            {
                Literal1.Text = "Error";
                Label1.Text = "Street Field cannot be empty";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }
            if (city == "")
            {
                Literal1.Text = "Error";
                Label1.Text = "City field cannot be empty";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }
            if (postal == "")
            {
                Literal1.Text = "Error";
                Label1.Text = "Postal Code Field cannot be empty";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }
            if (phone == "")
            {
                Literal1.Text = "Error";
                Label1.Text = "Phone field cannot be empty";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }
            if (email == "")
            {
                Literal1.Text = "Error";
                Label1.Text = "Email Address cannot be empty";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }
            if (emailaddress == true)
            {
                Literal1.Text = "Error";
                Label1.Text = "This Email Address alreday exists. Please try another one.";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                return;
            }
        
            

        }




    }
}