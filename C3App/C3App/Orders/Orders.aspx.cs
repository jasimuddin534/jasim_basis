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

namespace C3App.Orders
{
    public partial class Orders : PageBase
    {
        #region Initializing
        AccountBL accountBL = new AccountBL();
        ContactBL contactBL = new ContactBL();
        OpportunityBL opportunityBL = new OpportunityBL();
        OrderBL orderBL = new OrderBL();
        private DropDownList paymentTermsDropDownList;
        private DropDownList orderStagesDropDownList;
        private DropDownList teamsDropDownList;
        private DropDownList billingCountryDropDownList;
        private DropDownList shippingCountryDropDownList;
        private DropDownList CurrenciesDropDownList;
        private DropDownList assignedToUsersDropDownList;
        private DropDownList accountsDropDownList;
        DataTable myDataTable = new DataTable();
        
        #endregion
        #region page property
        protected void Page_Load(object sender, EventArgs e)
        {
            //Page.Validate();
            //OrderDetailsGridView.Columns.Clear();

            if (Request.QueryString["ShowPanel"] != null)
            {
                if ((!IsPostBack))
                {
                    Session.Remove("EditOrderID");
                    if (Session["products"] != null)
                    {
                        Session.Remove("products");
                        OrderDetailsGridView.DataSource = null;
                        OrderDetailsGridView.DataBind();
                    }
                    ApproveLinkButton.Visible = false;
                    EditLinkButton.Visible = false;
                    ConvertLinkButton.Visible = false;
                    DeleteLinkButton.Visible = false;
                    OrderDetailsLinkButton.Visible = false;
                    //Session.Remove("products");
                    //myDataTable = CreateNewDataTable();

                }
            }

            long OrderID = Convert.ToInt64(Session["EditOrderID"]);
            if (OrderID == 0)
            {

                OrdersDetailsView.ChangeMode(DetailsViewMode.Insert);

                //OrdersDetailsView.AutoGenerateInsertButton = true;
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
            ExceptionUtility.LogException(exc, "orderPage");
            ExceptionUtility.NotifySystemOps(exc, "OrderPage");

            //Clear the error from the server
            Server.ClearError();
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            OrdersDetailsView.EnableDynamicData(typeof(Order));

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
        protected void OrderStagesDropDownList_Init(object sender, EventArgs e)
        {
            orderStagesDropDownList = sender as DropDownList;
            orderStagesDropDownList.Items.Add(new ListItem("None", "-1"));

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
            int ordercontact = Convert.ToInt32(Session["Contacts"]);
            TextBox ShippingContacts = OrdersDetailsView.FindControl("ShippingContactNameTextBox") as TextBox;
            TextBox BillingContacts = OrdersDetailsView.FindControl("BillingContactNameTextBox") as TextBox;
            if (ordercontact == 1)
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
            else if (ordercontact == 2)
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


            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);


        }
        #endregion
        #region select a account from modal...
        public void AccountsSelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            int orderaccount = Convert.ToInt32(Session["Accounts"]);
            TextBox BillingAccounts = OrdersDetailsView.FindControl("BillingAccountNameTextBox") as TextBox;
            TextBox ShippingAccounts = OrdersDetailsView.FindControl("ShippingAccountNameTextBox") as TextBox;



            if (orderaccount == 1)
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
            else if (orderaccount == 2)
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
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
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

                TextBox OpportunityName = OrdersDetailsView.FindControl("OpportunityNameTextBox") as TextBox;
                OpportunityName.Text = opportunityName;

            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }
        #endregion
        #region order inserting....
        public void OrdersDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
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
                string number = "order";
                var generateNumber = GenerateCustomizeNumber(number);
                string orderNumber = generateNumber.Replace("Insert", "O");
                e.Values["OrderNumber"] = orderNumber;
                if (Convert.ToInt32(paymentTermsDropDownList.SelectedValue) == -1) { e.Values["PaymentTermID"] = null; }
                else
                {
                    e.Values["PaymentTermID"] = paymentTermsDropDownList.SelectedValue;
                }

                if (Convert.ToInt32(teamsDropDownList.SelectedValue) == -1) { e.Values["TeamID"] = null; }
                else
                {
                    e.Values["TeamID"] = teamsDropDownList.SelectedValue;
                }
                if (Convert.ToInt32(assignedToUsersDropDownList.SelectedValue) == -1) { e.Values["AssignedUserID"] = null; }
                else
                {
                    e.Values["AssignedUserID"] = assignedToUsersDropDownList.SelectedValue;
                }
                if (Convert.ToInt32(orderStagesDropDownList.SelectedValue) == -1) { e.Values["OrderStageID"] = null; }
                else
                {
                    e.Values["OrderStageID"] = orderStagesDropDownList.SelectedValue;
                }
                if (Convert.ToInt32(shippingCountryDropDownList.SelectedValue) == -1) { e.Values["ShippingCountry"] = null; }
                else
                {
                    e.Values["ShippingCountry"] = shippingCountryDropDownList.SelectedValue;
                }
                if (Convert.ToInt32(billingCountryDropDownList.SelectedValue) == -1) { e.Values["BillingCountry"] = null; }
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
                e.Values["IsApproved"] = false;
                e.Values["Converted"] = false;
            }
        }
        protected void OrdersDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            //long orderId = Convert.ToInt64(e.Values["OrderID"]);
            long orderID = Convert.ToInt64(Session["OrderID"]);
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
                    OrderDetailsGridView.DataSource = null;
                    OrderDetailsGridView.DataBind();
                }
            }
            else
            {
                if (orderID > 0)
                {
                    SaveOrderDetails();
                    this.OrdersGridView.DataBind();
                    this.MiniOrdersFormView.DataBind();
                    this.MiniMoreOrdersDetailsView.DataBind();
                    upListView.Update();
                    miniDetails.Update();
                    if (Session["products"] != null)
                    {
                        Session.Remove("products");
                        OrderDetailsGridView.DataSource = null;
                        OrderDetailsGridView.DataBind();
                    }
                    Literal1.Text = "Successfully Saved";
                    Label1.Text = "Order has been successfully Saved";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                }
                else
                {
                    if (Session["products"] != null)
                    {
                        Session.Remove("products");
                        OrderDetailsGridView.DataSource = null;
                        OrderDetailsGridView.DataBind();
                    }


                }
            }
            Session["OpportunityID"] = 0;

        }
        protected void OrdersObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long orderID;
            orderID = Convert.ToInt64(e.ReturnValue);
            Session["OrderID"] = orderID;

        }
        #endregion
        #region order updating....
        protected void OrdersDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            long billingAccountID = Convert.ToInt64(Session["BillingAccountID"]);
            long shippingAccountID = Convert.ToInt64(Session["ShippingAccountID"]);
            long ShippingContactID = Convert.ToInt64(Session["ShippingContactID"]);
            long billingContactID = Convert.ToInt64(Session["BillingContactID"]);
            long opportunityID = Convert.ToInt64(Session["OpportunityID"]);

            if (Convert.ToInt32(paymentTermsDropDownList.SelectedValue) == -1) { e.NewValues["PaymentTermID"] = null; }
            else
            {
                e.NewValues["PaymentTermID"] = paymentTermsDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(teamsDropDownList.SelectedValue) == -1) { e.NewValues["TeamID"] = null; }
            else
            {
                e.NewValues["TeamID"] = teamsDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(assignedToUsersDropDownList.SelectedValue) == -1) { e.NewValues["AssignedUserID"] = null; }
            else
            {
                e.NewValues["AssignedUserID"] = assignedToUsersDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(orderStagesDropDownList.SelectedValue) == -1) { e.NewValues["OrderStageID"] = null; }
            else
            {
                e.NewValues["OrderStageID"] = orderStagesDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(shippingCountryDropDownList.SelectedValue) == -1) { e.NewValues["ShippingCountry"] = null; }
            else
            {
                e.NewValues["ShippingCountry"] = shippingCountryDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(billingCountryDropDownList.SelectedValue) == -1) { e.NewValues["BillingCountry"] = null; }
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
        protected void OrdersDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            long orderID = Convert.ToInt64(Session["UpdateOrderID"]);
            if (orderID > 0)
            {
                SaveOrderDetails();
                this.OrdersGridView.DataBind();
                this.MiniOrdersFormView.DataBind();
                this.MiniMoreOrdersDetailsView.DataBind();
                upListView.Update();
                miniDetails.Update();
                Session["OrderID"] = 0;
                OrdersDetailsView.DataBind();
                if (Session["products"] != null)
                {
                    Session.Remove("products");
                    OrderDetailsGridView.DataSource = null;
                    OrderDetailsGridView.DataBind();
                }
                Literal1.Text = "Successfully Saved";
                Label1.Text = "Order has been successfully Saved";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
            else
            {
                Session["OrderID"] = 0;
                OrdersDetailsView.DataBind();
                if (Session["products"] != null)
                {
                    Session.Remove("products");
                    OrderDetailsGridView.DataSource = null;
                    OrderDetailsGridView.DataBind();
                }
                Literal1.Text = "Not Saved";
                Label1.Text = "!!!Order not saved, Check the inputs";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

            }
            Session["OpportunityID"] = 0;
        }
        protected void OrdersObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long orderID;
            orderID = Convert.ToInt64(e.ReturnValue);
            Session["UpdateOrderID"] = orderID;
        }
        protected void OrdersDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            //abc
            if (e.CommandName == "Cancel")
            {
                Literal1.Text = "Changes Discarded !";
                Label1.Text = " Your changes have been discarded.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ShowAlertModal();", true);
                if (Session["products"] != null)
                {
                    Session.Remove("products");
                    OrderDetailsGridView.DataSource = null;
                    OrderDetailsGridView.DataBind();
                }
                Session["EditOrderID"] = 0;
                OrdersDetailsView.DataBind();
                OrdersDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }
        #endregion
        #region order deleting & Coverting....
        protected void deleteButton1_Click(object sender, EventArgs e)
        {
            long OrderID = Convert.ToInt64(Session["EditOrderID"]);
            orderBL.DeleteById(OrderID);
            this.OrdersGridView.DataBind();
            this.OrdersGridView.SelectedIndex = -1;
            this.MiniOrdersFormView.DataBind();
            this.MiniMoreOrdersDetailsView.DataBind();
            upListView.Update();
            miniDetails.Update();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
        }
        protected void ConvertButton_Click(object sender, EventArgs e)
        {
            long invoiceID;
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            long orderID = Convert.ToInt32(Session["EditOrderID"]);
            var orders = orderBL.ConvertOrderByID(orderID);

            if (orders.Count() > 0)
            {
                foreach (var order in orders)
                {
                    long orderId = order.OrderID;
                    Invoice invoice = new Invoice();
                    invoice.OrderID = orderId;
                    string number = "invoice";
                    var generateNumber = GenerateCustomizeNumber(number);
                    string invoiceNumber = generateNumber.Replace("Insert", "I");
                    invoice.Name = order.Name;
                    invoice.InvoiceNumber = invoiceNumber;
                    invoice.CreatedTime = DateTime.Now;
                    invoice.ModifiedTime = DateTime.Now;
                    invoice.CompanyID = companyid;
                    invoice.CreatedBy = userid;
                    invoiceID = orderBL.OrderToInvoiceInsert(invoice);
                    if (invoiceID > 0)
                    {
                        
                        orderBL.UpdateConvertOrder(orderId);
                        Literal1.Text = "Convert Successfully";
                        Label1.Text = "This Order is Convert to Invoice Successfully";
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                    }
                }
            }
            else
            {


                Literal1.Text = "!!!Not converted";
                Label1.Text = "This Order is already converted to Invoice";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
        }
        protected void approveButton_Click(object sender, EventArgs e)
        {
            long orderID = Convert.ToInt32(Session["EditOrderID"]);
            bool approve = orderBL.ApproveOrder(orderID);
            if (approve == true)
            {
                Literal1.Text = "Approved";
                Label1.Text = "This Order is approved by Administrator";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
            else
            {
                Literal1.Text = "!!!";
                Label1.Text = "This Order is Already approved by Administrator";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }

        }
        protected void OrderDetailsButton_Click(object sender, EventArgs e)
        {
            UpdatePanel122.Update();
        }
        private string GenerateCustomizeNumber(string number)
        {
            string Number1 = null;
            string lastNumber=null;
            string month = DateTime.Today.Month.ToString();
            int year = DateTime.Today.Year;
            if (number == "invoice")
            {
                InvoiceBL invoiceBL=new InvoiceBL();
                Number1 = invoiceBL.GetInvoiceNumber();
            }
            else
            {
                Number1 = orderBL.GetOrderNumber();
            }
            if (Number1!=null)
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

        #region search the orders.......
        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            orderBL.SearchOrders(search);
            this.OrdersGridView.DataBind();
            this.OrdersGridView.SelectedIndex = -1;
            this.MiniOrdersFormView.DataBind();
            this.MiniMoreOrdersDetailsView.DataBind();
            upListView.Update();
            miniDetails.Update();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);


        }
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            ApproveLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            OrderDetailsLinkButton.Visible = false;
            OrdersGridView.DataSourceID = OrderSearchObjectDataSource.ID;
            OrdersGridView.DataBind();
            this.OrdersGridView.SelectedIndex = -1;
            this.MiniOrdersFormView.DataBind();
            this.MiniMoreOrdersDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }
        protected void SearchAllButton_Click(object sender, EventArgs e)
        {
            ApproveLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            OrderDetailsLinkButton.Visible = false;
            SearchTextBox.Text = string.Empty;
            OrdersGridView.DataSourceID = ListPanelObjectDataSource.ID;
            OrdersGridView.DataBind();
            this.OrdersGridView.SelectedIndex = -1;
            this.MiniOrdersFormView.DataBind();
            this.MiniMoreOrdersDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }
        protected void ApprovedOrder_Click(object sender, EventArgs e)
        {
            ApproveLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            OrderDetailsLinkButton.Visible = false;
            OrdersGridView.DataSourceID = ApprovedOrderObjectDataSource.ID;
            OrdersGridView.DataBind();
            this.OrdersGridView.SelectedIndex = -1;
            this.MiniOrdersFormView.DataBind();
            this.MiniMoreOrdersDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }
        protected void UnApprovedOrder_Click(object sender, EventArgs e)
        {
            ApproveLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            OrderDetailsLinkButton.Visible = false;
            OrdersGridView.DataSourceID = UnapprovedOrderObjectDataSource.ID;
            OrdersGridView.DataBind();
            this.OrdersGridView.SelectedIndex = -1;
            this.MiniOrdersFormView.DataBind();
            this.MiniMoreOrdersDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }

        #endregion
        #region select a order from gridview in view panel.....
        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            // Label2.Text = "dffd";
            // message.Text = "You chose: " + e.CommandName + " Item " + e.CommandArgument;
            Session["EditOrderID"] = e.CommandArgument.ToString();
            long orderID = Convert.ToInt64(Session["EditOrderID"]);
            if (Session["products"] != null)
            {
                Session.Remove("products");
                OrderDetailsGridView.DataSource = null;
                OrderDetailsGridView.DataBind();
            }
            int gindex = Convert.ToInt32(OrdersGridView.SelectedIndex);
            if (gindex > -1)
            {

                LinkButton nlbtn = OrdersGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                nlbtn.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            lbtn.CssClass = "active";
            miniDetails.Update();
            var order = orderBL.ConvertOrderByID(orderID);
            if (order.Count() > 0)
            {
                ConvertLinkButton.Visible = true;
                ApproveLinkButton.Visible = true;
                if (CheckEdit() != false)
                EditLinkButton.Visible = true;
                if (CheckDelete() != false)
                DeleteLinkButton.Visible = true;
                OrderDetailsLinkButton.Visible = true;
            }
            else
            {
                ApproveLinkButton.Visible = true;
                if (CheckEdit() != false)
                EditLinkButton.Visible = true;
                ConvertLinkButton.Visible = false;
                if (CheckDelete() != false)
                DeleteLinkButton.Visible = true;
                OrderDetailsLinkButton.Visible = true;

            }

            // Label2.Text = e.CommandArgument.ToString();
        }
        #endregion
        #region tab buttons.....
        protected void OrderInsertButton_Click(object sender, EventArgs e)
        {
            // DetailsViewlist.Update();
            //OrderDetailsGridView.Columns.Clear();
            LinkButton btn = sender as LinkButton;
            OrderInsertButton.Text = "Create Order";
            string insert = btn.CommandArgument.ToString();
            Session["OrderID"] = 0;
            if (Session["products"] != null)
            {
                Session.Remove("products");
                OrderDetailsGridView.DataSource = null;
                OrderDetailsGridView.DataBind();
            }
            OrdersDetailsView.ChangeMode(DetailsViewMode.Insert);
            this.OrdersDetailsView.DataBind();
            // OrdersDetailsView.AutoGenerateInsertButton = true;
        }
        protected void OrderEditButton_Click(object sender, EventArgs e)
        {
            // DetailsViewlist.Update();
            // OrderDetailsGridView.Visible = false;
            OrderInsertButton.Text = "Order Details";
            long orderid = Convert.ToInt64(Session["EditOrderID"]);
            Session["OrderID"] = orderid;

            OrdersDetailsView.ChangeMode(DetailsViewMode.Edit);
            if (Session["products"] == null)
            {
                myDataTable = CreateNewDataTable();
            }
            else
            {
                myDataTable = (DataTable)Session["products"];
            }
            IEnumerable<CustomOrderDetails> productOrders = orderBL.GetOrderDetailsByID(orderid);
            if (productOrders != null)
            {
                foreach (var orderDetail in productOrders)
                {
                    DataRow dataRow = myDataTable.NewRow();

                    dataRow["Quantity"] = orderDetail.Quantity;
                    dataRow["Name"] = orderDetail.Name;
                    dataRow["MftPartNum"] = orderDetail.MftPartNum;
                    dataRow["Cost"] = orderDetail.Cost;
                    dataRow["ListPrice"] = orderDetail.List;
                    if (orderDetail.Discount != null)
                    {
                        dataRow["Discount"] = orderDetail.Discount;
                    }
                    if (orderDetail.Note != null)
                    {
                        dataRow["Note"] = orderDetail.Note;
                    }
                    dataRow["ProductID"] = orderDetail.ProductID;
                    //hforderlineID.Value = orderDetail.OrderLineID.ToString();
                    if (orderDetail.OrderLineID != null)
                    {
                        dataRow["OrderLineID"] = orderDetail.OrderLineID;
                    }
                    myDataTable.Rows.Add(dataRow);
                }
            }
            myDataTable.AcceptChanges();
            Session.Add("Products", myDataTable);
            OrderDetailsGridView.DataSource = myDataTable;
            OrderDetailsGridView.DataBind();
            //OrdersDetailsView.AutoGenerateEditButton = true;

        }
        protected void UpdateButton_Click(object sender, EventArgs e)
        {


            if (Session["products"] != null)
            {
                Session.Remove("products");
                OrderDetailsGridView.DataSource = null;
                OrderDetailsGridView.DataBind();
            }
            Session["EditOrderID"] = 0;
            ApproveLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            OrderDetailsLinkButton.Visible = false;

            OrdersGridView.DataBind();
            OrdersGridView.SelectedIndex = -1;
            upListView.Update();
            MiniOrdersFormView.DataBind();
            miniDetails.Update();
            foreach (GridViewRow gvrow in ProductsGridView.Rows)
            {
                CheckBox selectProduct = gvrow.FindControl("selectProduct") as CheckBox;
                //CheckBox selectProduct = ProductsGridView.FindControl("selectProduct") as CheckBox;
                selectProduct.Checked = false;
            }
            UpdatePanel4.Update();
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
        public class CustomOrderDetails
        {
            public Nullable<int> Quantity { get; set; }
            public Nullable<long> ProductID { get; set; }
            public string Name { get; set; }
            public string MftPartNum { get; set; }
            public Nullable<decimal> Cost { get; set; }
            public Nullable<decimal> List { get; set; }
            public Nullable<decimal> Discount { get; set; }
            public Nullable<long> OrderLineID { get; set; }
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
            myDataColumn.ColumnName = "OrderLineID";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "OrderID";
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
                myDataTable = (DataTable)Session["products"];
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
            OrderDetailsGridView.DataSource = myDataTable;
            OrderDetailsGridView.DataBind();

            this.UpdatePanel4.Update();
            ScriptManager.RegisterStartupScript(this, typeof(string), "script", "subTotal();", true);

        }
        #endregion
        #region Check product if it is already exists in the gridview....
        private bool CheckProduct(int productid)
        {
            bool Isexists = true;
            foreach (GridViewRow row in OrderDetailsGridView.Rows)
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
        private void SaveOrderDetails()
        {
            int[] no = new int[OrderDetailsGridView.Rows.Count];
            int i = 0;
            //long orderID = Convert.ToInt64(Session["OrderID"]);

            foreach (GridViewRow row in OrderDetailsGridView.Rows)
            {
                OrderDetail orderDetail = new OrderDetail();
                long orderID = Convert.ToInt64(Session["OrderID"]);
                Label Name = row.FindControl("NameLabel") as Label;
                TextBox Quantity = row.FindControl("QuantityTextBox") as TextBox;
                TextBox CostPrice = row.FindControl("CostPriceTextBox") as TextBox;
                Label MftPartNum = row.FindControl("MftPartNumLabel") as Label;
                TextBox ListPrice = row.FindControl("ListPriceTextBox") as TextBox;
                TextBox Discount = row.FindControl("DiscountTextBox") as TextBox;
                TextBox Note = row.FindControl("NoteTextBox") as TextBox;
                Label ProductNo = row.FindControl("ProductIDLabel") as Label;
                Label OrderLineID = row.FindControl("OrderLineIDLabel") as Label;
                //hforderlineID.Value ="5";
                if (OrderLineID.Text != "")
                {
                    orderDetail.OrderLineID = Convert.ToInt64(OrderLineID.Text);
                }
                orderDetail.OrderID = orderID;
                orderDetail.Discount = Convert.ToInt64(Discount.Text);
                orderDetail.ProductID = Convert.ToInt64(ProductNo.Text);
                orderDetail.Cost = Convert.ToDecimal(CostPrice.Text);
                orderDetail.ListPrice = Convert.ToDecimal(ListPrice.Text);
                orderDetail.Quantity = Convert.ToInt32(Quantity.Text);
                if (Note.Text != "")
                {
                    orderDetail.Note = Note.Text;
                }
                orderBL.InsertOrderDetails(orderDetail);
            }
            if (Session["DeleteProducts"] != null)
            {
                string deleted1 = Session["DeleteProducts"].ToString();
                string del = deleted1.TrimEnd(',');
                string[] productdelete = del.Split(',');

                foreach (string orderLineId in productdelete)
                {
                    //OrderDetail orderDetail = new OrderDetail();
                    //orderDetail.OrderLineID = Convert.ToInt64(deleteproduct);
                    //orderDetail.IsDeleted = true;
                    long orderLineID = Convert.ToInt64(orderLineId);
                    orderBL.ProductRowDelete(orderLineID);
                }
            }


        }
        #endregion
        #region delete a row from productsgridview....
        protected void OrderDetailsGridView_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string idToDelete = String.Empty;
            string orderLinesID = OrderDetailsGridView.DataKeys[e.RowIndex].Value.ToString();
            if (orderLinesID != "")
            {
                long orderLineID = Convert.ToInt64(orderLinesID);
                if (Session["DeleteProducts"] != null)
                {

                    idToDelete = Session["DeleteProducts"].ToString();
                    idToDelete += orderLinesID.ToString() + ",";
                }
                else
                {
                    idToDelete = orderLinesID.ToString() + ",";
                }




                //bool success = orderBL.ProductRowDelete(orderLineID);
                //OrderDetail orderDetails = new OrderDetail();
                //orderDetails.OrderLineID = orderLineID;
                //orderDetails.IsDeleted = true;
                Session["DeleteProducts"] = idToDelete;
            }
            int rowIndex = Convert.ToInt32(e.RowIndex);
            myDataTable = (DataTable)Session["products"];
            //int iCount = (int)OrderDetailsGridView.DataKeys[e.RowIndex].Value;
            myDataTable.Rows.RemoveAt(rowIndex);
            myDataTable.AcceptChanges();

            OrderDetailsGridView.DataSource = myDataTable;
            OrderDetailsGridView.DataBind();
            ScriptManager.RegisterStartupScript(this, typeof(string), "script", "subTotal();", true);

        }
        #endregion
    }


}