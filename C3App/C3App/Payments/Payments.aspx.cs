using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;
using C3App.App_Code;
using System.Collections.Specialized;

namespace C3App.Payments
{
    public partial class Payments : System.Web.UI.Page
    {
        private DropDownList accountsDropDownList;
        private DropDownList currenciesDropDownList;
        private DropDownList paymentTypesDropDownList;
        private DropDownList teamsDropDownList;
        //private DropDownList usersDropDownList;

        #region Page Events
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                EditLinkButton.Visible = false;
                DeleteLinkButton.Visible = false;
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            PaymentsDetailsView.EnableDynamicData(typeof(Payment));
        }

        protected void Page_Error(object sender, EventArgs e)
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
            ExceptionUtility.LogException(exc, "PaymentPage");
            ExceptionUtility.NotifySystemOps(exc,"PaymentPage");

            //Clear the error from the server
            Server.ClearError();
        }
        #endregion

        #region Tab Events
        /// <summary>
        /// Create Payment LinkButton Event
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void PaymentDetailLinkButton_Click(object sender, EventArgs e)
        {
            PaymentsDetailsView.ChangeMode(DetailsViewMode.Insert);
            //PaymentDetailUpdatePanel.Update();
        }

        /// <summary>
        /// View Payment LinkButton Event
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ViewPaymentsLinkButton_Click(object sender, EventArgs e)
        {
            PaymentsGridView.DataSourceID = PaymentsObjectDataSource.ID;
            PaymentsGridView.SelectedIndex = -1;
            PaymentsGridView.DataBind();
            PaymentsUpdatePanel.Update();
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            MiniDetailsUpdatePanel.Update();
        }
        #endregion

        #region Payment Detail Events

        /// <summary>
        /// Payment Detail
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void PaymentDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Insert failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "PaymentDetail";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;

            }
            else
            {
                MessageHeaderLiteral.Text = "Success!";
                MessageBodyLabel.Text = "Payment has been successfully saved";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#BodyContent_myModal').reveal();", true);
                Session["PaymentID"] = 0;
                PaymentsDetailsView.DataBind();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void PaymentDetailsObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Update failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "PaymentDetail";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;

            }
            else
            {
                MessageHeaderLiteral.Text = "Success!";
                MessageBodyLabel.Text = "Payment has been successfully saved";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#BodyContent_myModal').reveal();", true);
                Session["PaymentID"] = 0;
                PaymentsDetailsView.DataBind();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void PaymentsDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            
            if (Session["CompanyID"] != null) 
            {
                e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            }
            else
            {               
                Page_Error(sender, e);
            }
            //if (Session["AccountID"] != null) 
            //{
            //    e.Values["AccountID"] = Convert.ToInt32(Session["AccountID"]);         
            //}
            //else
            //{
            //    e.Values["AccountID"] = null;
            //}
            TextBox txtbox = PaymentsDetailsView.FindControl("AccountTextBox") as TextBox;
            e.Values["AccountID"] = txtbox.Text;
            e.Values["CurrencyID"] = currenciesDropDownList.SelectedValue;
            e.Values["PaymentTypeID"] = paymentTypesDropDownList.SelectedValue;
            e.Values["TeamID"] = teamsDropDownList.SelectedValue;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            if (Session["UserID"] != null) 
            {
                e.Values["CreatedBy"] = Convert.ToInt64(Session["UserID"]);
                e.Values["ModifiedBy"] = Convert.ToInt64(Session["UserID"]);             
            }
            else
            {
                Page_Error(sender, e);
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void PaymentsDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            e.NewValues["ModifiedTime"] = DateTime.Now;
            e.NewValues["ModifiedBy"] = Convert.ToInt64(Session["UserID"]);
        }
        #endregion

        #region DropDownList Initialization
        protected void CurrenciesDropDownList_Init(object sender, EventArgs e)
        {
            currenciesDropDownList = sender as DropDownList;
        }

        protected void PaymentTypesDropDownList_Init(object sender, EventArgs e)
        {
            paymentTypesDropDownList = sender as DropDownList;
        }

        protected void TeamsDropDownList_Init(object sender, EventArgs e)
        {
            teamsDropDownList = sender as DropDownList;
        }

        //protected void UsersDropDownList_Init(object sender, EventArgs e)
        //{
        //    usersDropDownList = sender as DropDownList;
        //}

        protected void AccountsDropDownList_Init(object sender, EventArgs e)
        {
            accountsDropDownList = sender as DropDownList;
        }

        protected void TeamsEditDropDownList_Init(object sender, EventArgs e)
        {
            teamsDropDownList = sender as DropDownList;
            //TeamBL teamBL = new TeamBL();
            //teamsDropDownList = PaymentsDetailsView.FindControl("TeamsEditDropDownList") as DropDownList;

            //teamsDropDownList.DataSource = teamBL.GetTeams();
            //teamsDropDownList.DataSourceID = null;
            //teamsDropDownList.DataBind();
            //teamsDropDownList.DataTextField = "Name";
            //teamsDropDownList.DataValueField = "TeamID";
        }
        #endregion            

        #region Search Events
        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            PaymentsGridView.DataSourceID = PaymentsObjectDataSource.ID;
            PaymentsGridView.SelectedIndex = -1;
            PaymentsGridView.DataBind();
            PaymentsUpdatePanel.Update();
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            MiniDetailsUpdatePanel.Update();
        }

        protected void SearchKeywordLinkButton_Click(object sender, EventArgs e)
        {
            PaymentsGridView.DataSourceID = SearchKeywordObjectDataSource.ID;
            PaymentsGridView.SelectedIndex = -1;
            PaymentsGridView.DataBind();
            PaymentsUpdatePanel.Update();
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            MiniDetailsUpdatePanel.Update();
        }
        #endregion

        #region List Selection Events
        protected void SelectPaymentLinkButton_Command(object sender, CommandEventArgs e)
        {
            //System.Threading.Thread.Sleep(3000);
            //Session["PaymentID"] = e.CommandArgument.ToString();
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Session["PaymentID"] = arg[0];
            Session["PaymentTeamID"] = arg[1];
            int gindex = Convert.ToInt32(PaymentsGridView.SelectedIndex);
            if (gindex > -1)
            {

                LinkButton nlbtn = PaymentsGridView.Rows[gindex].FindControl("SelectPaymentLinkButton") as LinkButton;
                nlbtn.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            lbtn.CssClass = "active";
            EditLinkButton.Visible = true;
            DeleteLinkButton.Visible = true;
            MiniDetailsUpdatePanel.Update();

        }
        #endregion

        #region Mini Detail Action Events
        protected void EditLinkButton_Click(object sender, EventArgs e)
        {
            PaymentsDetailsView.ChangeMode(DetailsViewMode.Edit);
        }

        protected void DeleteConfirmedLinkButton_Click(object sender, EventArgs e)
        {
            int paymentID = Convert.ToInt32(Session["PaymentID"]);
            PaymentBL paymentBL = new PaymentBL();
            paymentBL.DeletePaymentByID(paymentID);
            Session["PaymentID"] = 0;
            PaymentsGridView.DataBind();
            PaymentsGridView.SelectedIndex = -1;
            PaymentsUpdatePanel.Update();
        }
        #endregion      

        #region Modal Events
        protected void SelectAccountLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["AccountID"] = e.CommandArgument.ToString();
            TextBox accountTextBox = PaymentsDetailsView.FindControl("AccountTextBox") as TextBox;
            accountTextBox.Text = Session["AccountID"].ToString();

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_AccountsContentPanel');", true);
        }
        #endregion

        protected void NotifyLinkButton_Click(object sender, EventArgs e)
        {
            int paymentID = Convert.ToInt32(Session["PaymentID"]);
            ListDictionary templateValues = new ListDictionary();
            templateValues.Add("<%PrimaryEmail%>", "someone@mail.com");
            templateValues.Add("<%ActivationID%>", "A37DDB5C-440C-461F-B573-6A09D9EF937B");
            templateValues.Add("<%Password%>", "Abcd1234");
            //C3App.App_Code.Notification.Notify("Payment", paymentID, 1, "hasan.khaled@panacea.com.bd", 1, templateValues);
            //C3App.App_Code.Notification.Notify("Payment", paymentID, 2, "8801717077776", 1, templateValues);
            MessageHeaderLiteral.Text = "Success!";
            MessageBodyLabel.Text = "Notification has been successfully saved";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#BodyContent_myModal').reveal();", true);
        }

        
    }
}