using System;
using System.Data;
using System.Linq;
using C3App.DAL;

namespace C3App
{
    public partial class Activation : System.Web.UI.Page
    {
        readonly C3Entities context = new C3Entities();
        private string activationID = string.Empty;
        private string email = string.Empty;


        protected void Page_Load(object sender, EventArgs e)
        {
            activationID = Request.QueryString["ActivationID"];
            email = Request.QueryString["PrimaryEmail"];
            Guid guid = new Guid(activationID);

            User user = (from p in context.Users
                         where (p.ActivationID == guid) && (p.PrimaryEmail == email)
                         select p).SingleOrDefault();

            if (user == null)
            {
                Literal1.Text = "Activation Error";
                Label1.Text = "Activation not successfull.";
                ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>$('#myModal').reveal();</script>");
                //Response.Write("Activation Not Succesfull");
            }

            else
            {
                try
                {

                    if (user.IsApproved == true)
                    {
                        Literal1.Text = "Account already activated.";
                        Label1.Text = "Please login to continue...<br><br><a href='http://dev.c3.com.bd/UserLogin.aspx' target = '_self' >Click here to login</a>";
                        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>$('#myModal').reveal();</script>");
                       // Response.Write("User already exists");
                    }
                    else
                    {
                        user.IsApproved = true;
                        context.Entry(user).State = EntityState.Modified;
                        context.SaveChanges();
                        Literal1.Text = "Activation Successfull";
                        Label1.Text = "<a href='http://dev.c3.com.bd/UserLogin.aspx' target = '_self' >Click here to login</a>";
                        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>$('#myModal').reveal();</script>");
                        //Response.Write("Activation Succesfull");
                    }

                }
                catch (OptimisticConcurrencyException)
                {
                    context.SaveChanges();
                    //Response.Write("Activation Not Succesfull");
                }
            }
        }
    }
}