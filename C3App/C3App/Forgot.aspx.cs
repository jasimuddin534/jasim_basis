using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.App_Code;
using C3App.BLL;

namespace C3App
{
    public partial class Forgot : System.Web.UI.Page
    {
        UserBL userBL=new UserBL();
        
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
            ExceptionUtility.LogException(exc, "ForgotPasswordPage");
            ExceptionUtility.NotifySystemOps(exc, "ForgotPasswordPage");

            //Clear the error from the server
            Server.ClearError();

        }

        protected void EmailAddressButton_Click(object sender, EventArgs e)
        {
            string email = EmailTextBox.Text;
            var users = userBL.GetUserByEmail(email);
            if (users.Count() > 0)
            {
                foreach (var user in users)
                {
                    Session["primaryEmail"] = user.PrimaryEmail;
                    Session["securityAnswer"] = user.SecurityAnswer;
                    Session["question"] = user.SecurityQuestion;
                    Session["dob"] = Convert.ToDateTime(user.BirthDate);
                    Session["Name"] = user.FirstName;
                    EmailTextBox.ReadOnly = true;
                    SecurityQuestionLabel.Text = user.SecurityQuestion;
                }
                string s = "";
                if (Session["question"] != null)
                {
                    s = Session["question"].ToString();
                }
                if (String.IsNullOrEmpty(s))
                {
                    Literal1.Text = "Error";
                    Label1.Text = "You don't have any Security Question.Please contact to your Admin";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    CloseLinkButton.PostBackUrl = "~/UserLogin.aspx";
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToSlide(1);", true);
                }
            }
            else 
            {
                Literal1.Text = "Error";
                Label1.Text = "Please write correct Email Address" + Session["question"];
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
               // CloseLinkButton.PostBackUrl = "~/Forgot.aspx";
            }

        }

        protected void SecurityAnswerButton_Click(object sender, EventArgs e)
        {
            string chkAnswer = SecurityAnswerTextBox.Text;
            string s = "";
            string qa = "";
            if (Session["question"] != null)
            {
                s = Session["question"].ToString();
            }
            if (Session["securityAnswer"] != null)
            {
                qa = Session["securityAnswer"].ToString();
            }


            //if (String.IsNullOrEmpty(s))
            //{
            //    Literal1.Text = "Error";
            //    Label1.Text = "You don't have any Security Question.Please contact to your Admin";
            //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
            //    CloseLinkButton.PostBackUrl = "~/UserLogin.aspx";
            //}
            //else
            //{
                if (String.IsNullOrEmpty(qa))
                   {
                       Literal1.Text = "Error";
                       Label1.Text = "You didn't set any Security Answer.Please contact to your Admin";
                       ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                       CloseLinkButton.PostBackUrl = "~/UserLogin.aspx";
                   }
                   else
                   {
                       if (Session["securityAnswer"].ToString() == chkAnswer)
                       {
                           SecurityAnswerTextBox.ReadOnly = true;
                           ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToSlide(2);", true);
                       }
                       else
                       {
                           Literal1.Text = "Error";
                           Label1.Text = "Please give correct Answer";
                           ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                       }
                    
                   }
            //}
           
          
        }
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
           // if (BirthTextBox.Text != "")
           //{
                //DateTime chkDob = Convert.ToDateTime(BirthTextBox.Text);
                //if (Convert.ToDateTime(Session["dob"]) == chkDob)
                //{
                    string primaryEmail = Session["primaryEmail"].ToString();
                    string randomPassword = userBL.GenerateRandomPassword();
  
                    userBL.SetRandomPassword(randomPassword, primaryEmail);
                    string emailID = primaryEmail;
                    string name = Convert.ToString(Session["Name"]);
                   
                   string mailbody = "Hello, " + "<br><br>" + "We've received an password reset request for your account. Please use the following credential to access your account.<br><br>";
                    mailbody += "User Name: " + primaryEmail + "<br>Password: " + randomPassword;
                    mailbody += "<br><br>Please disregard this message if you did not make a password reset request.If you continue to experience difficulties accessing your account, visit the Help Center.";
                    mailbody += "<br><br>This is an automatically generated message. Replies are not monitored or answered.";
                    mailbody += "<br><br>Sincerely,<br>The C3 Apps Team";
                    
            
            //mail
                   
          //  C3App.App_Code.MailHelper.SendEmail("noreply@c3.com.bd", "Panacea Systems", emailID,String.Empty, String.Empty,String.Empty + "Password Recovery", mailbody, String.Empty);


                    ListDictionary templateValues = new ListDictionary();
                    templateValues.Add("<%=PrimaryEmail%>", primaryEmail);
                    templateValues.Add("<%=Password%>", randomPassword);

                    var user = userBL.GetUserByEmail(emailID);
                    long id = user.ElementAt(0).UserID;

                    Session["CompanyID"] = user.ElementAt(0).CompanyID;
                    Session["UserID"] = user.ElementAt(0).UserID;

                    C3App.App_Code.Notification.Notify("User", id, 1, emailID, 3, templateValues);

                    Session.Clear();
                    Session.Abandon();


            
                    //end
                    Literal1.Text = "Success";
                    Label1.Text = "You should receive an email shortly with new password.";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                    CloseLinkButton.PostBackUrl = "~/UserLogin.aspx";

           //     }
           //     else
           //     {
           //         Label1.Text = "Date of Birth is Incorrect.";
           //         ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                   
           //     }
           //}
           //else
           //{
           //    Literal1.Text = "Error";
           //     Label1.Text = "Date of Birth is Incorrect.";
           //      ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
                   
           //}
         

        }//submit

        protected void cancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Forgot.aspx");
        }


        }
    }
