using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.App_Code;
using C3App.BLL;
using C3App.DAL;

namespace C3App.Quotes
{
    public partial class Quotes : System.Web.UI.Page
    {
        #region Initializing

        private AccountBL accountBL = new AccountBL();
        private ContactBL contactBL = new ContactBL();
        private OpportunityBL opportunityBL = new OpportunityBL();
        private QuoteBL quoteBL = new QuoteBL();
        private DropDownList paymentTermsDropDownList;
        private DropDownList QuoteStagesDropDownList;
        private DropDownList teamsDropDownList;
        private DropDownList billingCountryDropDownList;
        private DropDownList shippingCountryDropDownList;
        private DropDownList CurrenciesDropDownList;
        private DropDownList assignedToUsersDropDownList;
        private DropDownList accountsDropDownList;
        private DataTable myDataTable = new DataTable();

        #endregion

        #region page property

        protected void Page_Load(object sender, EventArgs e)
        {
            //Page.Validate();
            //QuoteDetailsGridView.Columns.Clear();

            if (Request.QueryString["ShowPanel"] != null)
            {
                if ((!IsPostBack))
                {
                    Session.Remove("EditQuoteID");
                    if (Session["products"] != null)
                    {
                        Session.Remove("products");
                        QuoteDetailsGridView.DataSource = null;
                        QuoteDetailsGridView.DataBind();
                    }
                    //ApproveLinkButton.Visible = false;
                    //QuoteEditLinkButton.Visible = false;
                    //ConvertLinkButton.Visible = false;
                    //DeleteLinkButton.Visible = false;
                    //QuoteDetailsLinkButton.Visible = false;
                    //Session.Remove("products");
                    //myDataTable = CreateNewDataTable();

                }
            }

            long QuoteID = Convert.ToInt64(Session["EditQuoteID"]);
            if (QuoteID == 0)
            {

                QuotesDetailsView.ChangeMode(DetailsViewMode.Insert);

                //QuotesDetailsView.AutoGenerateInsertButton = true;
            }
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
            ExceptionUtility.LogException(exc, "QuotePage");
            ExceptionUtility.NotifySystemOps(exc, "QuotePage");

            //Clear the error from the server
            Server.ClearError();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            QuotesDetailsView.EnableDynamicData(typeof (Quote));

        }

        #endregion

        #region DropDownList Initialization

        protected void PaymentTermsDropDownList_Init(object sender, EventArgs e)
        {
            paymentTermsDropDownList = sender as DropDownList;
            paymentTermsDropDownList.Items.Add(new ListItem("None", "-1"));

        }

        protected void accountDropDownList_Init(object sender, EventArgs e)
        {
            accountsDropDownList = sender as DropDownList;
            accountsDropDownList.Items.Add(new ListItem("None", "-1"));
        }

        protected void TeamsDropDownList_Init(object sender, EventArgs e)
        {
            teamsDropDownList = sender as DropDownList;
            teamsDropDownList.Items.Add(new ListItem("None", "-1"));

        }

        protected void AssignedToDropDownList_Init(object sender, EventArgs e)
        {
            assignedToUsersDropDownList = sender as DropDownList;
            assignedToUsersDropDownList.Items.Add(new ListItem("None", "-1"));


        }

        protected void QuoteStagesDropDownList_Init(object sender, EventArgs e)
        {
            QuoteStagesDropDownList = sender as DropDownList;
            QuoteStagesDropDownList.Items.Add(new ListItem("None", "-1"));

        }

        protected void BillingCountryDropDownList_Init(object sender, EventArgs e)
        {
            billingCountryDropDownList = sender as DropDownList;
            billingCountryDropDownList.Items.Add(new ListItem("None", "-1"));

        }

        protected void ShippingCountryDropDownList_Init(object sender, EventArgs e)
        {
            shippingCountryDropDownList = sender as DropDownList;
            shippingCountryDropDownList.Items.Add(new ListItem("None", "-1"));

        }

        protected void CurrenciesDropDownList_Init(object sender, EventArgs e)
        {
            CurrenciesDropDownList = sender as DropDownList;
            //CurrenciesDropDownList.Items.Add(new ListItem("None", "-1"));

        }

        #endregion

        #region select modal with specified module

        protected void BillingAccountsSelectButton_Click(object sender, EventArgs e)
        {
            ModalLabel.Text = "Select Billing Account";
            OpportunityGridView.Visible = false;
            OpportunityPanel.Visible = false;
            OpportuntySearchPanel.Visible = false;
            AccountGridView.Visible = true;
            ContactsGridView.Visible = false;
            AccountPanel.Visible = true;
            ContactPanel.Visible = false;
            AccountSearchPanel.Visible = true;
            ContactSearchPanel.Visible = false;
            Session["Accounts"] = 1;

        }

        protected void ShippingAccountsSelectButton_Click(object sender, EventArgs e)
        {
            ModalLabel.Text = "Select Shipping Account";
            OpportunityGridView.Visible = false;
            OpportunityPanel.Visible = false;
            OpportuntySearchPanel.Visible = false;
            AccountGridView.Visible = true;
            ContactsGridView.Visible = false;
            AccountPanel.Visible = true;
            ContactPanel.Visible = false;
            AccountSearchPanel.Visible = true;
            ContactSearchPanel.Visible = false;
            Session["Accounts"] = 2;
        }

        protected void BillingContactsSelectButton_Click(object sender, EventArgs e)
        {
            ModalLabel.Text = "Select Billing Contact";
            OpportunityGridView.Visible = false;
            OpportunityPanel.Visible = false;
            OpportuntySearchPanel.Visible = false;
            ContactsGridView.Visible = true;
            AccountGridView.Visible = false;
            ContactPanel.Visible = true;
            AccountPanel.Visible = false;
            ContactSearchPanel.Visible = true;
            AccountSearchPanel.Visible = false;
            Session["Contacts"] = 1;


        }

        protected void ShippingContactsSelectButton_Click(object sender, EventArgs e)
        {
            ModalLabel.Text = "Select Shipping Contact";
            OpportunityGridView.Visible = false;
            OpportunityPanel.Visible = false;
            OpportuntySearchPanel.Visible = false;
            ContactsGridView.Visible = true;
            AccountGridView.Visible = false;
            ContactPanel.Visible = true;
            AccountPanel.Visible = false;
            ContactSearchPanel.Visible = true;
            AccountSearchPanel.Visible = false;
            Session["Contacts"] = 2;

        }

        protected void SelectButton_Click(object sender, EventArgs e)
        {
            ModalLabel.Text = "Select Opportunity ";
            AccountGridView.Visible = false;
            ContactsGridView.Visible = false;
            AccountPanel.Visible = false;
            ContactPanel.Visible = false;
            AccountSearchPanel.Visible = false;
            ContactSearchPanel.Visible = false;
            OpportunityGridView.Visible = true;
            OpportunityPanel.Visible = true;
            OpportuntySearchPanel.Visible = true;
        }

        #endregion

        #region select a contact from modal...

        public void ContactsSelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            int Quotecontact = Convert.ToInt32(Session["Contacts"]);
            TextBox ShippingContacts = QuotesDetailsView.FindControl("ShippingContactNameTextBox") as TextBox;
            TextBox BillingContacts = QuotesDetailsView.FindControl("BillingContactNameTextBox") as TextBox;
            if (Quotecontact == 1)
            {
                Session["ContactID"] = e.CommandArgument.ToString();
                int contactID = Convert.ToInt32(Session["ContactID"]);
                Session["BillingContactID"] = contactID;
                IEnumerable<DAL.Contact> contacts = contactBL.GetContactByID(contactID);
                foreach (var contact in contacts)
                {
                    string firstName = contact.FirstName;
                    string LastName = contact.LastName;
                    BillingContacts.Text = firstName + " " + LastName;
                }

            }
            else if (Quotecontact == 2)
            {
                Session["ContactID"] = e.CommandArgument.ToString();
                int contactID = Convert.ToInt32(Session["ContactID"]);
                Session["ShippingContactID"] = contactID;
                IEnumerable<DAL.Contact> contacts = contactBL.GetContactByID(contactID);
                foreach (var contact in contacts)
                {
                    string firstName = contact.FirstName;
                    string LastName = contact.LastName;
                    ShippingContacts.Text = firstName + " " + LastName;
                }
            }


            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script",
                                                    "CloseModal('BodyContent_ModalPanel1');", true);


        }

        #endregion

        #region select a account from modal...

        public void AccountsSelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            int Quoteaccount = Convert.ToInt32(Session["Accounts"]);
            TextBox BillingAccounts = QuotesDetailsView.FindControl("BillingAccountNameTextBox") as TextBox;
            TextBox ShippingAccounts = QuotesDetailsView.FindControl("ShippingAccountNameTextBox") as TextBox;



            if (Quoteaccount == 1)
            {

                Session["AccountID"] = e.CommandArgument.ToString();
                int accountID = Convert.ToInt32(Session["AccountID"]);
                Session["BillingAccountID"] = accountID;
                IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(accountID);
                foreach (var account in accounts)
                {
                    string accountName = account.Name;
                    BillingAccounts.Text = accountName;
                }
            }
            else if (Quoteaccount == 2)
            {

                Session["AccountID"] = e.CommandArgument.ToString();
                int accountID = Convert.ToInt32(Session["AccountID"]);
                Session["ShippingAccountID"] = accountID;
                IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(accountID);


                foreach (var account in accounts)
                {
                    string accountName = account.Name;
                    ShippingAccounts.Text = accountName;
                }
            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script",
                                                    "CloseModal('BodyContent_ModalPanel1');", true);
        }

        #endregion

        #region select a opportunity from modal...

        public void OpportunitySelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["OpportunityID"] = e.CommandArgument.ToString();
            int opportunityID = Convert.ToInt32(Session["OpportunityID"]);
            IEnumerable<DAL.Opportunity> opportunities = opportunityBL.OpportunityByID(opportunityID);


            foreach (var opportunity in opportunities)
            {
                string opportunityName = opportunity.Name;

                TextBox OpportunityName = QuotesDetailsView.FindControl("OpportunityNameTextBox") as TextBox;
                OpportunityName.Text = opportunityName;

            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script",
                                                    "CloseModal('BodyContent_ModalPanel1');", true);
        }

        #endregion

        #region Quote inserting....

        public void QuotesDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            if (Session["products"] != null)
            {
                int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
                long billingAccountID = Convert.ToInt64(Session["BillingAccountID"]);
                long shippingAccountID = Convert.ToInt64(Session["ShippingAccountID"]);
                long ShippingContactID = Convert.ToInt64(Session["ShippingContactID"]);
                long billingContactID = Convert.ToInt64(Session["BillingContactID"]);
                long opportunityID = Convert.ToInt64(Session["OpportunityID"]);
                string number = "Quote";
                var generateNumber = GenerateCustomizeNumber(number);
                string QuoteNumber = generateNumber.Replace("Insert", "Q");
                e.Values["QuoteNumber"] = QuoteNumber;
                if (Convert.ToInt32(paymentTermsDropDownList.SelectedValue) == -1)
                {
                    e.Values["PaymentTermID"] = null;
                }
                else
                {
                    e.Values["PaymentTermID"] = paymentTermsDropDownList.SelectedValue;
                }

                if (Convert.ToInt32(teamsDropDownList.SelectedValue) == -1)
                {
                    e.Values["TeamID"] = null;
                }
                else
                {
                    e.Values["TeamID"] = teamsDropDownList.SelectedValue;
                }
                if (Convert.ToInt32(assignedToUsersDropDownList.SelectedValue) == -1)
                {
                    e.Values["AssignedUserID"] = null;
                }
                else
                {
                    e.Values["AssignedUserID"] = assignedToUsersDropDownList.SelectedValue;
                }
                if (Convert.ToInt32(QuoteStagesDropDownList.SelectedValue) == -1)
                {
                    e.Values["QuoteStageID"] = null;
                }
                else
                {
                    e.Values["QuoteStageID"] = QuoteStagesDropDownList.SelectedValue;
                }
                if (Convert.ToInt32(shippingCountryDropDownList.SelectedValue) == -1)
                {
                    e.Values["ShippingCountry"] = null;
                }
                else
                {
                    e.Values["ShippingCountry"] = shippingCountryDropDownList.SelectedValue;
                }
                if (Convert.ToInt32(billingCountryDropDownList.SelectedValue) == -1)
                {
                    e.Values["BillingCountry"] = null;
                }
                else
                {
                    e.Values["BillingCountry"] = billingCountryDropDownList.SelectedValue;
                }
                e.Values["CurrencyID"] = CurrenciesDropDownList.SelectedValue;
                if (shippingAccountID != 0)
                {
                    e.Values["ShippingAccountID"] = shippingAccountID;

                }
                if (billingAccountID != 0)
                {
                    e.Values["BillingAccountID"] = billingAccountID;

                }
                if (ShippingContactID != 0)
                {
                    e.Values["ShippingContactID"] = ShippingContactID;

                }
                if (billingContactID != 0)
                {
                    e.Values["BillingContactID"] = billingContactID;

                }
                if (opportunityID != 0)
                {
                    e.Values["OpportunityID"] = opportunityID;
                }
                e.Values["CompanyID"] = companyid;
                e.Values["CreatedBy"] = userid;
                //e.Values["IsApproved"] = false;
                //e.Values["Converted"] = false;
            }
        }

        protected void QuotesDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            //long QuoteId = Convert.ToInt64(e.Values["QuoteID"]);
            long QuoteID = Convert.ToInt64(Session["QuoteID"]);
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Insert failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;
                if (Session["products"] != null)
                {
                    Session.Remove("products");
                    QuoteDetailsGridView.DataSource = null;
                    QuoteDetailsGridView.DataBind();
                }
            }
            else
            {
                if (QuoteID > 0)
                {
                    SaveQuoteDetails();
                    this.QuotesGridView.DataBind();
                    this.MiniQuotesFormView.DataBind();
                    this.MiniMoreQuotesDetailsView.DataBind();
                    upListView.Update();
                    miniDetails.Update();
                    if (Session["products"] != null)
                    {
                        Session.Remove("products");
                        QuoteDetailsGridView.DataSource = null;
                        QuoteDetailsGridView.DataBind();
                    }
                    Literal1.Text = "Successfully Saved";
                    Label1.Text = "Quote has been successfully Saved";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                }
                else
                {
                    if (Session["products"] != null)
                    {
                        Session.Remove("products");
                        QuoteDetailsGridView.DataSource = null;
                        QuoteDetailsGridView.DataBind();
                    }


                }
            }
            Session["OpportunityID"] = 0;

        }

        protected void QuotesObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long QuoteID;
            QuoteID = Convert.ToInt64(e.ReturnValue);
            Session["QuoteID"] = QuoteID;

        }

        #endregion

        #region Quote updating....

        protected void QuotesDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            long billingAccountID = Convert.ToInt64(Session["BillingAccountID"]);
            long shippingAccountID = Convert.ToInt64(Session["ShippingAccountID"]);
            long ShippingContactID = Convert.ToInt64(Session["ShippingContactID"]);
            long billingContactID = Convert.ToInt64(Session["BillingContactID"]);
            long opportunityID = Convert.ToInt64(Session["OpportunityID"]);

            if (Convert.ToInt32(paymentTermsDropDownList.SelectedValue) == -1)
            {
                e.NewValues["PaymentTermID"] = null;
            }
            else
            {
                e.NewValues["PaymentTermID"] = paymentTermsDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(teamsDropDownList.SelectedValue) == -1)
            {
                e.NewValues["TeamID"] = null;
            }
            else
            {
                e.NewValues["TeamID"] = teamsDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(assignedToUsersDropDownList.SelectedValue) == -1)
            {
                e.NewValues["AssignedUserID"] = null;
            }
            else
            {
                e.NewValues["AssignedUserID"] = assignedToUsersDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(QuoteStagesDropDownList.SelectedValue) == -1)
            {
                e.NewValues["QuoteStageID"] = null;
            }
            else
            {
                e.NewValues["QuoteStageID"] = QuoteStagesDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(shippingCountryDropDownList.SelectedValue) == -1)
            {
                e.NewValues["ShippingCountry"] = null;
            }
            else
            {
                e.NewValues["ShippingCountry"] = shippingCountryDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(billingCountryDropDownList.SelectedValue) == -1)
            {
                e.NewValues["BillingCountry"] = null;
            }
            else
            {
                e.NewValues["BillingCountry"] = billingCountryDropDownList.SelectedValue;
            }
            e.NewValues["CurrencyID"] = CurrenciesDropDownList.SelectedValue;
            if (shippingAccountID != 0)
            {
                e.NewValues["ShippingAccountID"] = shippingAccountID;

            }
            if (billingAccountID != 0)
            {
                e.NewValues["BillingAccountID"] = billingAccountID;

            }
            if (ShippingContactID != 0)
            {
                e.NewValues["ShippingContactID"] = ShippingContactID;

            }
            if (billingContactID != 0)
            {
                e.NewValues["BillingContactID"] = billingContactID;

            }
            if (opportunityID != 0)
            {
                e.NewValues["OpportunityID"] = opportunityID;
            }

            e.NewValues["ModifiedBy"] = userid;
            e.NewValues["ModifiedTime"] = DateTime.Now;
        }

        protected void QuotesDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            long QuoteID = Convert.ToInt64(Session["UpdateQuoteID"]);
            if (QuoteID > 0)
            {
                SaveQuoteDetails();
                this.QuotesGridView.DataBind();
                this.MiniQuotesFormView.DataBind();
                this.MiniMoreQuotesDetailsView.DataBind();
                upListView.Update();
                miniDetails.Update();
                Session["QuoteID"] = 0;
                QuotesDetailsView.DataBind();
                if (Session["products"] != null)
                {
                    Session.Remove("products");
                    QuoteDetailsGridView.DataSource = null;
                    QuoteDetailsGridView.DataBind();
                }
                Literal1.Text = "Successfully Saved";
                Label1.Text = "Quote has been successfully Saved";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
            else
            {
                Session["QuoteID"] = 0;
                QuotesDetailsView.DataBind();
                if (Session["products"] != null)
                {
                    Session.Remove("products");
                    QuoteDetailsGridView.DataSource = null;
                    QuoteDetailsGridView.DataBind();
                }
                Literal1.Text = "Not Saved";
                Label1.Text = "!!!Quote not saved, Check the inputs";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

            }
            Session["OpportunityID"] = 0;
        }

        protected void QuotesObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long QuoteID;
            QuoteID = Convert.ToInt64(e.ReturnValue);
            Session["UpdateQuoteID"] = QuoteID;
        }

        protected void QuotesDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Literal1.Text = "Changes Discarded !";
                Label1.Text = " Your changes have been discarded.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ShowAlertModal();", true);
                Session["EditQuoteID"] = 0;
                QuotesDetailsView.DataBind();
                QuotesDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }

        #endregion

        #region Quote deleting & Coverting....

        protected void deleteButton1_Click(object sender, EventArgs e)
        {
            long QuoteID = Convert.ToInt64(Session["EditQuoteID"]);
            quoteBL.DeleteById(QuoteID);
            this.QuotesGridView.DataBind();
            this.QuotesGridView.SelectedIndex = -1;
            this.MiniQuotesFormView.DataBind();
            this.MiniMoreQuotesDetailsView.DataBind();
            upListView.Update();
            miniDetails.Update();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
        }

        protected void ConvertButton_Click(object sender, EventArgs e)
        {
            long invoiceID;
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            long QuoteID = Convert.ToInt32(Session["EditQuoteID"]);
            var Quotes = quoteBL.ConvertQuoteByID(QuoteID);

            if (Quotes.Count() > 0)
            {
                foreach (var Quote in Quotes)
                {
                    long QuoteId = Quote.QuoteID;
                    Invoice invoice = new Invoice();
                    //invoice.QuoteID = QuoteId;
                    string number = "invoice";
                    var generateNumber = GenerateCustomizeNumber(number);
                    string invoiceNumber = generateNumber.Replace("Insert", "I");
                    invoice.Name = Quote.Name;
                    invoice.InvoiceNumber = invoiceNumber;
                    invoice.CreatedTime = DateTime.Now;
                    invoice.ModifiedTime = DateTime.Now;
                    invoice.CompanyID = companyid;
                    invoice.CreatedBy = userid;
                    invoiceID = quoteBL.QuoteToInvoiceInsert(invoice);
                    if (invoiceID > 0)
                    {

                        quoteBL.UpdateConvertQuote(QuoteId);
                        Literal1.Text = "Convert Successfully";
                        Label1.Text = "This Quote is Convert to Invoice Successfully";
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();",
                                                                true);
                    }
                }
            }
            else
            {


                Literal1.Text = "!!!Not converted";
                Label1.Text = "This Quote is already converted to Invoice";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
        }

        protected void approveButton_Click(object sender, EventArgs e)
        {
            long QuoteID = Convert.ToInt32(Session["EditQuoteID"]);
            bool approve = quoteBL.ApproveQuote(QuoteID);
            if (approve == true)
            {
                Literal1.Text = "Approved";
                Label1.Text = "This Quote is approved by Administrator";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
            else
            {
                Literal1.Text = "!!!";
                Label1.Text = "This Quote is Already approved by Administrator";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }

        }

        protected void QuoteDetailsButton_Click(object sender, EventArgs e)
        {
            UpdatePanel122.Update();
        }

        private string GenerateCustomizeNumber(string number)
        {
            string Number1 = null;
            string lastNumber = null;
            string month = DateTime.Today.Month.ToString();
            int year = DateTime.Today.Year;
            if (number == "invoice")
            {
                InvoiceBL invoiceBL = new InvoiceBL();
                Number1 = invoiceBL.GetInvoiceNumber();
            }
            else
            {
                Number1 = quoteBL.GetQuoteNumber();
            }
            if (Number1 != null)
            {
                lastNumber = Number1.Split('-')[2];
            }
            long jkl = Convert.ToInt64(lastNumber) + 1;
            string lmn = jkl.ToString();
            int i = Convert.ToInt32(lastNumber) + 1;
            int append = 5 - lmn.Length;
            string sid = "";
            for (int j = 0; j < append; j++)
            {
                sid += "0";
            }
            sid = sid + i;
            string GenerateNumber = month + +year + "-" + "Insert" + "-" + sid;
            return GenerateNumber;
        }

        #endregion

        #region search the Quotes.......

        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            quoteBL.SearchQuotes(search);
            this.QuotesGridView.DataBind();
            this.QuotesGridView.SelectedIndex = -1;
            this.MiniQuotesFormView.DataBind();
            this.MiniMoreQuotesDetailsView.DataBind();
            upListView.Update();
            miniDetails.Update();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);


        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            ApproveLinkButton.Visible = false;
            QuoteEditLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            QuoteDetailsLinkButton.Visible = false;
            QuotesGridView.DataSourceID = QuoteSearchObjectDataSource.ID;
            QuotesGridView.DataBind();
            this.QuotesGridView.SelectedIndex = -1;
            this.MiniQuotesFormView.DataBind();
            this.MiniMoreQuotesDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }

        protected void SearchAllButton_Click(object sender, EventArgs e)
        {
            ApproveLinkButton.Visible = false;
            QuoteEditLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            QuoteDetailsLinkButton.Visible = false;
            SearchTextBox.Text = string.Empty;
            QuotesGridView.DataSourceID = ListPanelObjectDataSource.ID;
            QuotesGridView.DataBind();
            this.QuotesGridView.SelectedIndex = -1;
            this.MiniQuotesFormView.DataBind();
            this.MiniMoreQuotesDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }

        protected void ApprovedQuote_Click(object sender, EventArgs e)
        {
            ApproveLinkButton.Visible = false;
            QuoteEditLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            QuoteDetailsLinkButton.Visible = false;
            QuotesGridView.DataSourceID = ApprovedQuoteObjectDataSource.ID;
            QuotesGridView.DataBind();
            this.QuotesGridView.SelectedIndex = -1;
            this.MiniQuotesFormView.DataBind();
            this.MiniMoreQuotesDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }

        protected void UnApprovedQuote_Click(object sender, EventArgs e)
        {
            ApproveLinkButton.Visible = false;
            QuoteEditLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            QuoteDetailsLinkButton.Visible = false;
            QuotesGridView.DataSourceID = UnapprovedQuoteObjectDataSource.ID;
            QuotesGridView.DataBind();
            this.QuotesGridView.SelectedIndex = -1;
            this.MiniQuotesFormView.DataBind();
            this.MiniMoreQuotesDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }

        #endregion

        #region select a Quote from gridview in view panel.....

        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            // Label2.Text = "dffd";
            // message.Text = "You chose: " + e.CommandName + " Item " + e.CommandArgument;
            Session["EditQuoteID"] = e.CommandArgument.ToString();
            long QuoteID = Convert.ToInt64(Session["EditQuoteID"]);
            if (Session["products"] != null)
            {
                Session.Remove("products");
                QuoteDetailsGridView.DataSource = null;
                QuoteDetailsGridView.DataBind();
            }
            int gindex = Convert.ToInt32(QuotesGridView.SelectedIndex);
            if (gindex > -1)
            {

                LinkButton nlbtn = QuotesGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                nlbtn.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            lbtn.CssClass = "active";
            miniDetails.Update();
            //var Quote = quoteBL.ConvertQuoteByID(QuoteID);
            //if (Quote.Count() > 0)
            //{
                //ConvertLinkButton.Visible = true;
                //ApproveLinkButton.Visible = true;
                QuoteEditLinkButton.Visible = true;
                DeleteLinkButton.Visible = true;
                //QuoteDetailsLinkButton.Visible = true;
            //}
            //else
            //{
                //ApproveLinkButton.Visible = true;
                //QuoteEditLinkButton.Visible = true;
                //ConvertLinkButton.Visible = false;
                //DeleteLinkButton.Visible = true;
                //QuoteDetailsLinkButton.Visible = true;

            //}

            // Label2.Text = e.CommandArgument.ToString();
        }

        #endregion

        #region tab buttons.....

        protected void QuoteInsertButton_Click(object sender, EventArgs e)
        {
            // DetailsViewlist.Update();
            //QuoteDetailsGridView.Columns.Clear();
            LinkButton btn = sender as LinkButton;
            QuoteInsertButton.Text = "Create Quotation";
            string insert = btn.CommandArgument.ToString();
            Session["QuoteID"] = 0;
            if (Session["products"] != null)
            {
                Session.Remove("products");
                QuoteDetailsGridView.DataSource = null;
                QuoteDetailsGridView.DataBind();
            }
            QuotesDetailsView.ChangeMode(DetailsViewMode.Insert);
            this.QuotesDetailsView.DataBind();
            //QuotesDetailsView.AutoGenerateInsertButton = true;
            //testing
        }

        protected void QuoteEditButton_Click(object sender, EventArgs e)
        {
            // DetailsViewlist.Update();
            // QuoteDetailsGridView.Visible = false;
            QuoteInsertButton.Text = "Quotation Details";
            long Quoteid = Convert.ToInt64(Session["EditQuoteID"]);
            Session["QuoteID"] = Quoteid;

            QuotesDetailsView.ChangeMode(DetailsViewMode.Edit);
            if (Session["products"] == null)
            {
                myDataTable = CreateNewDataTable();
            }
            else
            {
                myDataTable = (DataTable) Session["products"];
            }
            IEnumerable<CustomQuoteDetails> productQuotes = quoteBL.GetQuoteDetailsByID(Quoteid);
            if (productQuotes != null)
            {
                foreach (var QuoteDetail in productQuotes)
                {
                    DataRow dataRow = myDataTable.NewRow();

                    dataRow["Quantity"] = QuoteDetail.Quantity;
                    dataRow["Name"] = QuoteDetail.Name;
                    dataRow["MftPartNum"] = QuoteDetail.MftPartNum;
                    dataRow["Cost"] = QuoteDetail.Cost;
                    dataRow["ListPrice"] = QuoteDetail.List;
                    if (QuoteDetail.Discount != null)
                    {
                        dataRow["Discount"] = QuoteDetail.Discount;
                    }
                    if (QuoteDetail.Note != null)
                    {
                        dataRow["Note"] = QuoteDetail.Note;
                    }
                    dataRow["ProductID"] = QuoteDetail.ProductID;
                    //hfQuotelineID.Value = QuoteDetail.QuoteLineID.ToString();
                    if (QuoteDetail.QuoteLineID != null)
                    {
                        dataRow["QuoteLineID"] = QuoteDetail.QuoteLineID;
                    }
                    myDataTable.Rows.Add(dataRow);
                }
            }
            myDataTable.AcceptChanges();
            Session.Add("Products", myDataTable);
            QuoteDetailsGridView.DataSource = myDataTable;
            QuoteDetailsGridView.DataBind();
            //QuotesDetailsView.AutoGenerateEditButton = true;

        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {


            if (Session["products"] != null)
            {
                Session.Remove("products");
                QuoteDetailsGridView.DataSource = null;
                QuoteDetailsGridView.DataBind();
            }
            Session["EditQuoteID"] = 0;
            ApproveLinkButton.Visible = false;
            QuoteEditLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            QuoteDetailsLinkButton.Visible = false;

            QuotesGridView.DataBind();
            QuotesGridView.SelectedIndex = -1;
            upListView.Update();
            MiniQuotesFormView.DataBind();
            miniDetails.Update();

        }

        #endregion

        #region Contact Modal start here.....

        protected void ContactCreateDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {

            //Session["ContactID"] = 
            //int contactID = Convert.ToInt32(Session["ContactID"]);
            e.Values["AccountID"] = accountsDropDownList.SelectedValue;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] = 8;

        }

        protected void ContactCreateDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            ContactCreateDetailsView.Visible = false;
            this.ContactsGridView.DataBind();
            ContactList.Update();

        }

        protected void ContactCreateDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {

            }
        }

        protected void ContactSearchButton_Click(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            contactBL.GetContactByName(search);
            this.ContactsGridView.DataBind();

        }

        //protected void ContactSelectLinkButton_Command(object sender, CommandEventArgs e)
        //{
        //    // message.Text = "You chose: " + e.CommandName + " Item " + e.CommandArgument;
        //    Session["ContactID"] = e.CommandArgument.ToString();
        //    // Label2.Text = e.CommandArgument.ToString();
        //}
        protected void ContactSearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            contactBL.GetContactByName(search);
            this.ContactsGridView.DataBind();
        }

        #endregion

        #region Account Model Start here.......

        protected void CreateAccountLinkButton_Click(object sender, EventArgs e)
        {
            AccountCreateDetailsView.Visible = true;
            AccountCreateDetailsView.AutoGenerateInsertButton = true;
            //CreateAccountLinkButton.Visible = false;
        }

        protected void AccountCreateDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] = 8;
        }

        protected void AccountCreateDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            AccountCreateDetailsView.Visible = false;
            this.AccountGridView.DataBind();
            AccountList.Update();

        }

        protected void AccountSearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            accountBL.SearchAccount(search);
            this.AccountGridView.DataBind();

        }

        protected void accountSearchButton_Click(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            accountBL.SearchAccount(search);
            this.AccountGridView.DataBind();


        }

        #endregion

        #region opportunity modal start here....

        protected void CreateOpportunityLinkButton_Click(object sender, EventArgs e)
        {
            OpportunityCreateDetailsView.Visible = true;
            OpportunityCreateDetailsView.AutoGenerateInsertButton = true;
            // CreateOpportunityLinkButton.Visible = false;

        }

        protected void OpportunitySearchButton_Click(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            opportunityBL.SearchOpportunities(search);
            this.OpportunityGridView.DataBind();
        }

        protected void OpportunitySearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            opportunityBL.SearchOpportunities(search);
            this.OpportunityGridView.DataBind();
        }

        protected void OpportunityCreateDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["AccountID"] = accountsDropDownList.SelectedValue;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] = 8;
        }

        protected void OpportunityCreateDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            OpportunityCreateDetailsView.Visible = false;
            this.OpportunityGridView.DataBind();
            opportunityList.Update();
        }

        #endregion

        #region create a custom class

        public class CustomQuoteDetails
        {
            public Nullable<int> Quantity { get; set; }
            public Nullable<long> ProductID { get; set; }
            public string Name { get; set; }
            public string MftPartNum { get; set; }
            public Nullable<decimal> Cost { get; set; }
            public Nullable<decimal> List { get; set; }
            public Nullable<decimal> Discount { get; set; }
            public Nullable<long> QuoteLineID { get; set; }
            public string Note { get; set; }
        }

        #endregion

        #region Initialize a data table for products...

        private static DataTable CreateNewDataTable()
        {
            DataTable myDataTable = new DataTable();
            DataColumn myDataColumn = new DataColumn();
            myDataColumn.AllowDBNull = false;
            myDataColumn.AutoIncrement = true;
            myDataColumn.AutoIncrementSeed = 1;
            myDataColumn.AutoIncrementStep = 1;

            myDataColumn.ColumnName = "Quantity";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            //myDataColumn.Unique = true;
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Name";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "MftPartNum";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Cost";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "ListPrice";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Discount";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Note";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "ProductID";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "QuoteLineID";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "QuoteID";
            myDataColumn.DataType = System.Type.GetType("System.Int64");
            myDataTable.Columns.Add(myDataColumn);
            return myDataTable;
        }

        #endregion

        #region select a product and add to gridview....

        protected void AddProduct_Click(object sender, EventArgs e)
        {
            ProductBL productBL = new ProductBL();
            if (Session["products"] == null)
            {
                myDataTable = CreateNewDataTable();
            }
            else
            {
                myDataTable = (DataTable) Session["products"];
            }
            IEnumerable<Product> products = null;
            foreach (GridViewRow gvrow in ProductsGridView.Rows)
            {

                CheckBox selectProduct = gvrow.FindControl("selectProduct") as CheckBox;
                if (selectProduct.Checked)
                {
                    int productid = Convert.ToInt32(ProductsGridView.DataKeys[gvrow.RowIndex].Value);
                    bool isExist = CheckProduct(productid);
                    if (isExist == true)
                        //checks if this product doesn't exist in the gridview
                    {
                        products = productBL.GetProductByID(productid);
                        if (products != null)
                        {
                            DataRow dataRow = myDataTable.NewRow();
                            foreach (var product in products)
                            {
                                if (product.Quantity != null)
                                {
                                    dataRow["Quantity"] = product.Quantity;
                                }
                                dataRow["Name"] = product.Name;
                                dataRow["MftPartNum"] = product.MFTPartNumber;
                                dataRow["Cost"] = product.Cost;
                                dataRow["ListPrice"] = product.ListPrice;
                                dataRow["Discount"] = "0";
                                dataRow["ProductID"] = product.ProductID;
                            }
                            myDataTable.Rows.Add(dataRow);
                        }
                    }
                    selectProduct.Checked = false;
                }
            }
            myDataTable.AcceptChanges();
            Session.Add("Products", myDataTable);
            QuoteDetailsGridView.DataSource = myDataTable;
            QuoteDetailsGridView.DataBind();

            this.UpdatePanel4.Update();
            ScriptManager.RegisterStartupScript(this, typeof (string), "script", "subTotal();", true);

        }

        #endregion

        #region Check product if it is already exists in the gridview....

        private bool CheckProduct(int productid)
        {
            bool Isexists = true;
            foreach (GridViewRow row in QuoteDetailsGridView.Rows)
            {
                Label ProductNo = row.FindControl("ProductIDLabel") as Label;
                if (Convert.ToInt32(ProductNo.Text) == productid)
                {
                    Isexists = false;
                }
            }
            return Isexists;
        }

        #endregion

        #region save products in database...

        private void SaveQuoteDetails()
        {
            int[] no = new int[QuoteDetailsGridView.Rows.Count];
            int i = 0;
            //long QuoteID = Convert.ToInt64(Session["QuoteID"]);

            foreach (GridViewRow row in QuoteDetailsGridView.Rows)
            {
                QuoteDetail QuoteDetail = new QuoteDetail();
                long QuoteID = Convert.ToInt64(Session["QuoteID"]);
                Label Name = row.FindControl("NameLabel") as Label;
                TextBox Quantity = row.FindControl("QuantityTextBox") as TextBox;
                TextBox CostPrice = row.FindControl("CostPriceTextBox") as TextBox;
                Label MftPartNum = row.FindControl("MftPartNumLabel") as Label;
                TextBox ListPrice = row.FindControl("ListPriceTextBox") as TextBox;
                TextBox Discount = row.FindControl("DiscountTextBox") as TextBox;
                TextBox Note = row.FindControl("NoteTextBox") as TextBox;
                Label ProductNo = row.FindControl("ProductIDLabel") as Label;
                Label QuoteLineID = row.FindControl("QuoteLineIDLabel") as Label;
                //hfQuotelineID.Value ="5";
                if (QuoteLineID.Text != "")
                {
                    QuoteDetail.QuoteLineID = Convert.ToInt64(QuoteLineID.Text);
                }
                QuoteDetail.QuoteID = QuoteID;
                QuoteDetail.Discount = Convert.ToInt64(Discount.Text);
                QuoteDetail.ProductID = Convert.ToInt64(ProductNo.Text);
                QuoteDetail.Cost = Convert.ToDecimal(CostPrice.Text);
                QuoteDetail.ListPrice = Convert.ToDecimal(ListPrice.Text);
                QuoteDetail.Quantity = Convert.ToInt32(Quantity.Text);
                if (Note.Text != "")
                {
                    QuoteDetail.Note = Note.Text;
                }
                quoteBL.InsertQuoteDetails(QuoteDetail);
            }
            if (Session["DeleteProducts"] != null)
            {
                string deleted1 = Session["DeleteProducts"].ToString();
                string del = deleted1.TrimEnd(',');
                string[] productdelete = del.Split(',');

                foreach (string QuoteLineId in productdelete)
                {
                    //QuoteDetail QuoteDetail = new QuoteDetail();
                    //QuoteDetail.QuoteLineID = Convert.ToInt64(deleteproduct);
                    //QuoteDetail.IsDeleted = true;
                    long QuoteLineID = Convert.ToInt64(QuoteLineId);
                    quoteBL.ProductRowDelete(QuoteLineID);
                }
            }


        }

        #endregion

        #region delete a row from productsgridview....

        protected void QuoteDetailsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string idToDelete = String.Empty;
            string QuoteLinesID = QuoteDetailsGridView.DataKeys[e.RowIndex].Value.ToString();
            if (QuoteLinesID != "")
            {
                long QuoteLineID = Convert.ToInt64(QuoteLinesID);
                if (Session["DeleteProducts"] != null)
                {

                    idToDelete = Session["DeleteProducts"].ToString();
                    idToDelete += QuoteLinesID.ToString() + ",";
                }
                else
                {

                    idToDelete = QuoteLinesID.ToString() + ",";
                }




                //bool success = quoteBL.ProductRowDelete(QuoteLineID);
                //QuoteDetail QuoteDetails = new QuoteDetail();
                //QuoteDetails.QuoteLineID = QuoteLineID;
                //QuoteDetails.IsDeleted = true;
                Session["DeleteProducts"] = idToDelete;
            }
            int rowIndex = Convert.ToInt32(e.RowIndex);
            myDataTable = (DataTable) Session["products"];
            //int iCount = (int)QuoteDetailsGridView.DataKeys[e.RowIndex].Value;
            myDataTable.Rows.RemoveAt(rowIndex);
            myDataTable.AcceptChanges();

            QuoteDetailsGridView.DataSource = myDataTable;
            QuoteDetailsGridView.DataBind();
            ScriptManager.RegisterStartupScript(this, typeof (string), "script", "subTotal();", true);

        }

        #endregion    }
    }
}