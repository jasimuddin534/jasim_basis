using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;
using C3App.App_Code;

namespace C3App
{
    public partial class UserLogin : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
            //string pathString2 = @"~\Users\Test";
            //System.IO.Directory.CreateDirectory(pathString2);



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
            ExceptionUtility.LogException(exc, "UserLoginPage");
            ExceptionUtility.NotifySystemOps(exc, "UserLoginPage");

            //Clear the error from the server
            Server.ClearError();

        }


        protected void SubmitButton_Click(object sender, EventArgs e)
        {
          
            string username = UserNameTextBox.Text;
            string password = PasswordTextBox.Text;  
            string status = "";
            string sessionid = "";
            string target = "Dashboard.aspx";
            bool islocked = false;

            UserBL objUserBL = new UserBL();
            var users = objUserBL.GetUserByEmail(username);
            if (users.Count() > 0)
            {
                islocked = Convert.ToBoolean(users.ElementAt(0).IsLockedOut);
                if (islocked == false)
                {
                    var user = objUserBL.VerifyLogIn(username, password);
                    Session.Clear();

                    if (user != null)
                    {

                        string primaryEmail = user.ElementAt(0).PrimaryEmail;
                        string firstName = user.ElementAt(0).FirstName;
                        string lastName = user.ElementAt(0).LastName;
                        string userName = user.ElementAt(0).UserName;
                        string mobilePhone = user.ElementAt(0).MobilePhone;
                        Int64 userId = user.ElementAt(0).UserID;
                        Int32 companyId = user.ElementAt(0).CompanyID;
                        Int32 roleid = Convert.ToInt32(user.ElementAt(0).RoleID);
                        bool isactive = Convert.ToBoolean(user.ElementAt(0).IsActive);
                        bool isadmin = Convert.ToBoolean(user.ElementAt(0).IsAdmin);
                        bool isemployee = Convert.ToBoolean(user.ElementAt(0).IsEmployee);
                        bool isapproved = Convert.ToBoolean(user.ElementAt(0).IsApproved);
                        bool isfirstlogin = Convert.ToBoolean(user.ElementAt(0).IsFirstLogin);

                        Session["UserName"] = userName;
                        Session["FirstName"] = firstName;
                        Session["LastName"] = lastName;
                        Session["PrimaryEmail"] = primaryEmail;
                        Session["MobilePhone"] = mobilePhone;
                        Session["UserID"] = userId;
                        Session["CompanyID"] = companyId;
                        Session["IsAuthorized"] = true;
                        Session["RoleID"] = roleid;
                        Session["IsAdmin"] = isadmin;
                        Session["FirstLogin"] = isfirstlogin;
                        status = "succeed";
                        sessionid = Session.SessionID;
                        long log = 0;




                        if (isapproved == false)
                        {
                            status = "Failed-approved";
                            log = objUserBL.InsertUserLogin(companyId, userId, sessionid, status, target);
                            Literal1.Text = "Login failed";
                            Label1.Text = "Your account is not activated.<br>Please check your email to activate your account.<br>";
                            ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>ShowAlertModal();</script>");
                            return;
                        }



                        if (isactive == false)
                        {
                            status = "Failed-activate";
                            log = objUserBL.InsertUserLogin(companyId, userId, sessionid, status, target);
                            Literal1.Text = "Login failed";
                            Label1.Text = "Your account is deactivated.<br>Please contact system administrator for details.<br>";
                            ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>ShowAlertModal();</script>");
                            return;
                        }


                        else
                        {
                            status = "Success";
                            log = objUserBL.InsertUserLogin(companyId, userId, sessionid, status, target);
                            if (isfirstlogin == false && isadmin == false)
                            {
                                Response.Redirect("~/Dashboard/Dashboard.aspx");
                            }
                            else if (isfirstlogin == true && isadmin == false)
                            {
                                Response.Redirect("~/Dashboard/Dashboard.aspx");
                            }
                            else if (isfirstlogin == true && isadmin == true)
                            {
                                Response.Redirect("~/CompanySetup.aspx");
                            }
                            else if (isfirstlogin == false && isadmin == true)
                            {
                                Response.Redirect("~/Dashboard/Dashboard.aspx");
                            }

                        }

                    }
                    else
                    {
                        int lockoutnumber = 0;
                        lockoutnumber = objUserBL.UserLockOut(username);
                        if (lockoutnumber >= 5)
                        {
                            Literal1.Text = "Login failed";
                            Label1.Text = "This Account has been Locked. Please Contact to your Administrator.<br>";
                        }
                        else
                        {
                            Literal1.Text = "Login failed";
                            Label1.Text = "Invalid username or password.<br>";
                        }
                        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>ShowAlertModal();</script>");
                    }
                }
                else
                {
                   
                        Literal1.Text = "Login failed";
                        Label1.Text = "This Account has been Locked. Please Contact to your Administrator.<br>";
                        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>ShowAlertModal();</script>");
                }
            }

            else
            {
             
                Literal1.Text = "Login failed";
                Label1.Text = "Invalid username or password.<br>";
                ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>ShowAlertModal();</script>");
               
            }


        }

    

    }
}