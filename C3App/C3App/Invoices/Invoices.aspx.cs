using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.App_Code;
using C3App.BLL;
using C3App.DAL;

namespace C3App.Invoices
{
    public partial class Invoices : PageBase
    {
        private DropDownList TeamDropDownList;
        private DropDownList AssignedToDropDownList;
        private DropDownList InvoiceStageDropDownList;
        private DropDownList PaymentTermDropDownList;
        private InvoiceBL invoiceBL = new InvoiceBL();
        private OpportunityBL opportunityBL = new OpportunityBL();
        Order order=new Order();
        private OrderBL orderBL = new OrderBL();
        public long invoiceID;
         public int companyID;

        protected void Page_Load(object sender, EventArgs e)
        {
           // Page.Validate();
            companyID = Convert.ToInt32(Session["CompanyID"]);
            try
            {
                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        //EditLinkButton.Visible = false;
                        //ModalPopButton2.Visible = false;
                        ReportModalPopButton.Visible = false;
                        DeleteLinkButton.Visible = false;
                        Session.Remove("EditInvoiceID");
                    }
                }
                long invoiceID = Convert.ToInt64(Session["EditInvoiceID"]);

                if (Session["EditInvoiceID"] != null)
                {
                    if (invoiceID == 0)
                    {
                        InvoiceDetailsView.ChangeMode(DetailsViewMode.Insert);
                        //if (invoiceID == 0) GetInvoiceNumber();
                    }
                    else if (invoiceID > 0)
                    {
                        InvoiceDetailsView.ChangeMode(DetailsViewMode.Edit);
                        //if (invoiceID == 0) GetInvoiceNumber();
                    }
                }
                else
                {
                    InvoiceDetailsView.ChangeMode(DetailsViewMode.Insert);
                    //auto generate invoice number on 
                    //if (invoiceID == 0) GetInvoiceNumber();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            } 

            //if (Session["InvoiceID"] != null)
            //{
            //    invoiceID = Convert.ToInt32(Session["InvoiceID"]);
            //    int OrderID = Convert.ToInt32(Session["EditOrderID"]);
            //    if (invoiceID == 0)
            //    {
            //        InvoiceDetailsView.ChangeMode(DetailsViewMode.Insert);
            //    }
            //    else if (invoiceID > 0)
            //    {
            //        InvoiceDetailsView.ChangeMode(DetailsViewMode.Edit);
            //    }
            //}
            //else
            //{
            //    InvoiceDetailsView.ChangeMode(DetailsViewMode.Insert);
            //}
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            InvoiceDetailsView.EnableDynamicData(typeof(DAL.Invoice));
        }

      //catch error
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
            ExceptionUtility.LogException(exc, "InvoicePage");
            ExceptionUtility.NotifySystemOps(exc, "InvoicePage");

            //Clear the error from the server
            Server.ClearError();
        }

        //auto generate invoice number on CreateInvoice
        private string GetInvoiceNumber()
        {
            string invoiceSerial = null;
            string month = DateTime.Today.Month.ToString(CultureInfo.InvariantCulture);
            if (month.Length != 2) month = "0" + month;
            string year = DateTime.Today.Year.ToString(CultureInfo.InvariantCulture);
            string lastInvoiceNumber = invoiceBL.GetInvoiceNumber();
            if(lastInvoiceNumber!=null)
            {
                invoiceSerial = lastInvoiceNumber.Split('-')[2];

            }
            int newInovoiceserial = Convert.ToInt32(invoiceSerial) + 1;
            string serialno = newInovoiceserial.ToString();
            int i = serialno.Length;
            int append = 5 - i;
            string serial = "";
            for (int j = 0; j < append; j++)
            {
                serial += "0";
            }
            //serial = serial + i;
            serial = serial + newInovoiceserial;
            string invoiceNumber = month + year + "-" + "I-" + serial;
            return invoiceNumber;

            //TextBox invoiceNumberTextBox = InvoiceDetailsView.FindControl("InvoiceNumberTextBox") as TextBox;
            //if (invoiceNumberTextBox != null)
            //{
            //    invoiceNumberTextBox.Text = invoiceNumber;
            //    invoiceNumberTextBox.ReadOnly = true;
            //}
        }

        //start dropdownlist initialization
        protected void TeamNameDropDownList_Init(object sender, EventArgs e)
        {
            TeamDropDownList = sender as DropDownList;
        }
        protected void AssignedToDropDownList_Init(object sender, EventArgs e)
        {
            AssignedToDropDownList = sender as DropDownList;
        }
        protected void InvoiceStageDropDownList_Init(object sender, EventArgs e)
        {
            InvoiceStageDropDownList = sender as DropDownList;
        }
        protected void PaymentTermDropDownList_Init(object sender, EventArgs e)
        {
            PaymentTermDropDownList = sender as DropDownList;
        }
        //end dropdownlist initialization

        //CreateInvoice button click
        protected void InvoiceInsertButton_Click(object sender, EventArgs e)
        {
            //Button btn = sender as Button;
            //string insert = btn.CommandArgument.ToString();
            //Session["InvoiceID"] = 0;
            InvoiceDetailsView.DataSource = null;
            orderDetailsview.DataSource = null;
            OrderDetailsGridView.DataSource = null;
            //DetailsViewlist.Update();
            InvoiceDetailsView.DataBind();
            orderDetailsview.DataBind();
            OrderDetailsGridView.DataBind();
            Session["EditInvoiceID"] = 0;
            InvoiceDetailsView.ChangeMode(DetailsViewMode.Insert);
           // GetInvoiceNumber();

        }

        //select invoice from list
        protected void InvoiceListSelectButton_Command(object sender, CommandEventArgs e)
        {
            //highlight selected row start
            int gindex = Convert.ToInt32(InvoiceGridView.SelectedIndex);
            if (gindex > -1)
            {
                LinkButton linkbutton = InvoiceGridView.Rows[gindex].FindControl("InvoiceListSelectButton") as LinkButton;
                linkbutton.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            if (lbtn != null) lbtn.CssClass = "active";
            //highlight selected row end

            string arguments = Convert.ToString(e.CommandArgument);
            string[] arg = arguments.Split(';');
            Session["EditInvoiceID"] = Convert.ToInt64(arg[0]);
            Session["EditOrderID"] = Convert.ToInt32(arg[1]);

            //Edit link btn is commented out
            //if (CheckEdit() != false)
            //    EditLinkButton.Visible = true;
            if (CheckDelete() != false) DeleteLinkButton.Visible = true;
            ReportModalPopButton.Visible = true;
            MiniInvoiceUpdatePanel.Update();
            //if ((Session["OrderID"] != null)||(Session["OpportunityID"]!=null))
            //{
            //    Session.Remove("OrderID");
            //    Session.Remove("OpportunityID");
            //    OrderDetailsGridView.DataSource = null;
            //    OrderDetailsGridView.DataBind();
            //    orderDetailsview.DataSource = null;
            //    orderDetailsview.DataBind();
            //}
            //InvoiceListUpdatePanel.Update();
        }


        //inserting new invoice
        protected void InvoiceDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            long opportunityID = Convert.ToInt64(Session["OpportunityID"]);
            if(opportunityID==0)
            {
                e.Values["OpportunityID"] = null;
            }
            else
            {
                e.Values["OpportunityID"] = opportunityID;
            }

            long orderID = Convert.ToInt64(Session["OrderID"]);

            if (orderID == 0)
            {
                e.Values["OrderID"] = null;
            }
            else
            {
                e.Values["OrderID"] = orderID;
            }
           
            e.Values["CompanyID"] = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
          
            if (Convert.ToInt32(AssignedToDropDownList.SelectedValue) == 0)
            {
                e.Values["AssignedUserID"] = null;
            }
            else
            {
                e.Values["AssignedUserID"] = AssignedToDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0)
            {
                e.Values["TeamID"] = null;
            }
            else
            {
                e.Values["TeamID"] = TeamDropDownList.SelectedValue;
            }
            
            if (Convert.ToInt32(InvoiceStageDropDownList.SelectedValue) == 0)
            {
                e.Values["InvoiceStageID"] = null;
            }
            else
            {
                e.Values["InvoiceStageID"] = InvoiceStageDropDownList.SelectedValue;
            }
          
            if (Convert.ToInt32(PaymentTermDropDownList.SelectedValue) == 0)
            {
                e.Values["PaymentTermID"] = null;
            }
            else
            {
                e.Values["PaymentTermID"] = PaymentTermDropDownList.SelectedValue;
            }

            string invoiceNumber = GetInvoiceNumber();
            e.Values["InvoiceNumber"] = invoiceNumber;
            e.Values["CreatedBy"] = Convert.ToInt64(Session["UserID"]);
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedBy"] = Convert.ToInt64(Session["UserID"]);
            e.Values["ModifiedTime"] = DateTime.Now;
        }


        //Updating old invoice
        protected void InvoiceDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            long opportunityID = Convert.ToInt64(Session["OpportunityID"]);
            if (opportunityID == 0)
            {
                e.NewValues["OpportunityID"] = null;
            }
            else
            {
                e.NewValues["OpportunityID"] = opportunityID;
            }
            long orderID = Convert.ToInt64(Session["EditOrderID"]);

            if (orderID == 0)
            {
                e.NewValues["OrderID"] = null;
            }
            else
            {
                e.NewValues["OrderID"] = orderID;
            }
            
            if (Convert.ToInt32(AssignedToDropDownList.SelectedValue) == 0)
            {
                e.NewValues["AssignedUserID"] = null;
            }
            else
            {
                e.NewValues["AssignedUserID"] = AssignedToDropDownList.SelectedValue;
            }
          
            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0)
            {
                e.NewValues["TeamID"] = null;
            }
            else
            {
                e.NewValues["TeamID"] = TeamDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(InvoiceStageDropDownList.SelectedValue) == 0)
            {
                e.NewValues["InvoiceStageID"] = null;
            }
            else
            {
                e.NewValues["InvoiceStageID"] = InvoiceStageDropDownList.SelectedValue;
            }
        
            if (Convert.ToInt32(PaymentTermDropDownList.SelectedValue) == 0)
            {
                e.NewValues["PaymentTermID"] = null;
            }
            else
            {
                e.NewValues["PaymentTermID"] = PaymentTermDropDownList.SelectedValue;
            }
            e.NewValues["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.NewValues["ModifiedBy"] = Convert.ToInt64(Session["UserID"]);
            e.NewValues["ModifiedTime"] = DateTime.Now;
        }


        //after inserting new invoice
        protected void InvoiceDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {

            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Save failed: " + e.Exception.InnerException.Message; 
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;
            }
            else
            {
                int rowcount = e.AffectedRows;
                if (rowcount == -1)
                {
                    string name = e.Values["Name"].ToString();
                    MsgLiteral.Text = "Success";
                    alertLabel.Text = "Invoice of " + name + " has been saved";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                    
                    //update the order(converted to true) thats invoice has been created..
                    long orderID = Convert.ToInt64(Session["OrderID"]);
                    orderBL.UpdateConvertOrder(orderID);
                }
            }
            //ShowAlertModal();
            MiniInvoiceFormView.DataBind();
            MiniInvoiceDetailsView.DataBind();
            InvoiceGridView.DataBind();
            MiniInvoiceUpdatePanel.Update();
            Session["EditInvoiceID"] = 0;
            Session["EditOrderID"] = 0;
            InvoiceDetailsView.DataBind();
        }


        //after Updating an invoice
        protected void InvoiceDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Save failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;
            }
            else
            {
                int rowcount = e.AffectedRows;
                if (rowcount == -1)
                {
                    string name = e.NewValues["Name"].ToString();
                    MsgLiteral.Text = "Success";
                    alertLabel.Text = "Invoice of " + name + " has been saved";
                    //ShowAlertModal();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                }
                //else
                //{
                //    MsgLiteral.Text = "Sorry,save failed";
                //    alertLabel.Text = "Please try again";
                //}
            }
           
            MiniInvoiceFormView.DataBind();
            MiniInvoiceDetailsView.DataBind();
            InvoiceGridView.DataBind();
            MiniInvoiceUpdatePanel.Update();
            Session["EditInvoiceID"] = 0;
            Session["EditOrderID"] = 0;
            InvoiceDetailsView.DataBind();
        }


        // clears & update panels
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            Session["EditProductID"] = 0;
            InvoiceGridView.DataBind();
            InvoiceGridView.SelectedIndex = -1;
            InvoiceListUpdatePanel.Update();
            MiniInvoiceFormView.DataBind();
            MiniInvoiceUpdatePanel.Update();
            // ModalPopButton2.Visible = false;
            //EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            ReportModalPopButton.Visible = false;
        }

        //cancel invoice
        protected void InvoiceDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                //stay current tab
                MsgLiteral.Text = "Submission cancelled";
                alertLabel.Text = "Your changes have been discarded";
                InvoiceDetailsView.DataBind();
                InvoiceDetailsView.ChangeMode(DetailsViewMode.Insert);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                //Move to View Tab
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
            }
        }


        //edit invoice info
        protected void InvoiceEditButton_Click(object sender, EventArgs e)
        {
            InvoiceDetailsView.ChangeMode(DetailsViewMode.Edit);
            //code for show order in details & gridview start
            int orderID = Convert.ToInt32(Session["EditOrderID"]);
            long invoiceID = Convert.ToInt64(Session["EditInvoiceID"]);
            if ((orderID | invoiceID) == 0)
            {
                OrderDetailsGridView.DataSource = null;
                OrderDetailsGridView.DataBind();
                orderDetailsview.DataSource = null;
                orderDetailsview.DataBind();
                return;
            }
            try
            {
                FillUpOrderFields(orderID, invoiceID);
                FillUpOrderDetailsFields(orderID);
            }
            catch(Exception ex)
            {
                throw ex;
            }
            //code for show order in details & gridview end

        }


        //delete invoice
        protected void InvoiceDeleteButton_Click(object sender, EventArgs e)
        {
            InvoiceBL invoiceBL = new InvoiceBL();
            long invoiceID = Convert.ToInt64(Session["EditInvoiceID"]);
            invoiceBL.DeleteInvoice(invoiceID);
            this.InvoiceGridView.DataBind();
            this.MiniInvoiceFormView.DataBind();
            this.MiniInvoiceDetailsView.DataBind();
            InvoiceListUpdatePanel.Update();
            MiniInvoiceUpdatePanel.Update();
           ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
        }

       //opportunity search change
        protected void OpportunitySearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = OpportunitySearchTextBox.Text;
            opportunityBL.SearchOpportunities(search);
            this.OpportunityGridView.DataBind();
        }


        //opportunity search
        protected void OpportunitySearchLinkButton_Click(object sender, EventArgs e)
        {
            string search = OpportunitySearchTextBox.Text;
            opportunityBL.SearchOpportunities(search);
            this.OpportunityGridView.DataBind();
        }


        //select an opportunity
        protected void SelectOpportunityList_Command(object sender, CommandEventArgs e)
        {
            Session["OpportunityID"] = e.CommandArgument.ToString();
            long opportunityID = Convert.ToInt64(Session["OpportunityID"]);
            IEnumerable<Opportunity> opportunities = opportunityBL.OpportunityByID(opportunityID);
            foreach (var opportunity in opportunities)
            {
                string opportunityName = opportunity.Name;
                using (TextBox OpportunityName = InvoiceDetailsView.FindControl("OpportunityNameTextBox") as TextBox)
                {
                    if (OpportunityName != null) OpportunityName.Text = opportunityName;
                }
            }
            //message.Text = Convert.ToInt32(Session["OpportunityID"]).ToString();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script","CloseModal('BodyContent_ModalPanel1');", true);
        }


      //Code for showing changed searching invoices of the company
        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            invoiceBL.SearchInvoice(search);
        }


        //Code for showing searching invoices of the company
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            InvoiceGridView.DataSourceID = SearchObjectDataSource.ID;
            InvoiceGridView.DataBind();
            InvoiceListUpdatePanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }


        //Code for showing all invoices of the company
        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            InvoiceGridView.DataSourceID = InvoiceViewObjectDataSource.ID;
            InvoiceGridView.DataBind();
            InvoiceListUpdatePanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }


        //Order search change
        protected void OrderSearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = OrderSearchTextBox.Text;
            orderBL.SearchOrders(search);
            this.OrderListGridView.DataBind();
        }


        //Order search
        protected void OrderSearchLinkButton_Click(object sender, EventArgs e)
        {
            string search = OrderSearchTextBox.Text;
            orderBL.SearchOrders(search);
            this.OrderListGridView.DataBind();
        }


        //select an Order
        protected void SelectOrderList_Command(object sender, CommandEventArgs e)
        {
            Session["OrderID"] = e.CommandArgument.ToString();
            long orderID = Convert.ToInt64(Session["OrderID"]);
            IEnumerable<Order> orders = orderBL.OrderByID(orderID);
            foreach (var order in orders)
            {
                string orderName = order.Name;
                string orderNumber = order.OrderNumber;
                if (order.OrderDueDate != null)
                {
                    DateTime duedate = (DateTime) order.OrderDueDate;
                }
                
                TextBox OrderName = InvoiceDetailsView.FindControl("OrderTextBox") as TextBox;
                if (OrderName != null)
                {
                    OrderName.Text = orderName;
                }
                else
                {
                    OrderName.Text = "No Order";
                }
                //fillup selected order information into invoice field i.e-PurchaseOrderno,Amount due,Due date,Payment term
                CopyOrderInformationToInvoice(orderID);
            }
            long invoiceID = Convert.ToInt64(Session["EditInvoiceID"]);

            FillUpOrderFields(orderID, invoiceID);
            FillUpOrderDetailsFields(orderID);
            
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script","CloseModal('BodyContent_ModalPanel1');", true);
        }

        private void CopyOrderInformationToInvoice(long orderID)
        {
             var purchaseOrdernoTextBox = InvoiceDetailsView.FindControl("PurchaseOrderNumTextBox") as TextBox;
             var amountdueTextBox = InvoiceDetailsView.FindControl("AmountDueTextBox") as TextBox;
             var duedateTextBox = InvoiceDetailsView.FindControl("DueDateTextBox") as TextBox;
             IEnumerable<Order> orders = orderBL.OrderByID(orderID);
            
            foreach (var order in orders)
            {
                string purchaseOrderNumber = order.OrderNumber;
                if (purchaseOrderNumber != null && !String.IsNullOrEmpty(purchaseOrderNumber))
                {
                    if (purchaseOrdernoTextBox != null) purchaseOrdernoTextBox.Text = purchaseOrderNumber;
                }

                if (order.OrderDueDate != null)
                {
                    DateTime duedate = (DateTime) order.OrderDueDate;
                    if (duedateTextBox != null) duedateTextBox.Text = duedate.ToString("MM/dd/yyyy");
                }

                string amountDue = order.Total.ToString();
                if (!String.IsNullOrEmpty(amountDue))
                {
                    if (amountdueTextBox != null) amountdueTextBox.Text = amountDue;
                }

           }
     }

        //GenerateInvoiceReport Button Click

         protected void ReportModalPopButton_Click(object sender, EventArgs e)
         {
             long orderID = Convert.ToInt64(Session["EditOrderID"]);
             long invoiceID = Convert.ToInt64(Session["EditInvoiceID"]);

             FillUpInvoiceOrderFields(orderID, invoiceID);
             FillUpInvoiceOrderDetailsFields(orderID);
         }


        //Generate OrderDetailsGridView  
        private void FillUpOrderDetailsFields(long orderID)
        {
            IEnumerable<CustomOrderDetails> customorderdetails = invoiceBL.GetCustomOrderDetails(orderID);
            OrderDetailsGridView.DataSource = customorderdetails;
            OrderDetailsGridView.DataBind();
        }
      
        // class for a Order Details 
        public class CustomOrderDetails
        {
            public Nullable<int> Quantity { get; set; }
            // public Nullable<long> ProductID { get; set; }
            public string Name { get; set; }
            public string MftPartNum { get; set; }
            public Nullable<decimal> Cost { get; set; }
            public Nullable<decimal> Listprice { get; set; }
            public Nullable<decimal> Discount { get; set; }
            // public Nullable<long> OrderLineID { get; set; }
            public string Note { get; set; }
        }

        // class for an Order
        public class BillingShippingDetails
        {
            public string BillingAccountName { get; set; }
            public string BillingContactName { get; set; }
            public string BillingStreet { get; set; }
            public string BillingCity { get; set; }
            public string BillingState { get; set; }
            public string BillingPostalCode { get; set; }
            public string BillingCountry { get; set; }
            public string ShipingAccountName { get; set; }
            public string ShipingContactName { get; set; }
            public string ShipingStreet { get; set; }
            public string ShipingCity { get; set; }
            public string ShipingState { get; set; }
            public string ShipingPostalCode { get; set; }
            public string ShipingCountry { get; set; }
            public string Currency { get; set; }
            public Nullable<decimal> ConversionRate { get; set; }
            public Nullable<decimal> TaxRate { get; set; }
            public string Shipper { get; set; }
            public Nullable<decimal> SubTotal { get; set; }
            public string Discount { get; set; }
            public Nullable<decimal> Shipping { get; set; }
            public Nullable<decimal> Tax { get; set; }
            public Nullable<decimal> Total { get; set; }
            public string Description { get; set; }
            public Nullable<decimal> AmountDue { get; set; }
            public Nullable<decimal> AmountPaid { get; set; }


        }

        //Generate orderDetailsview
        private void FillUpOrderFields(long orderID, long invoiceId)
        {
            //custom
            IEnumerable<BillingShippingDetails> billingshippingDetails = invoiceBL.GetBillingShippingDetails(orderID, invoiceId);
            orderDetailsview.DataSource = billingshippingDetails;
            orderDetailsview.AutoGenerateRows = false;
            orderDetailsview.DataBind();
        }

        //Generate InvoicedOrderDetailsGridView
        private void FillUpInvoiceOrderDetailsFields(long orderID)
         {
             IEnumerable<CustomOrderDetails> customorderdetails = invoiceBL.GetCustomOrderDetails(orderID);
             InvoicedOrderDetailsGridView.DataSource = customorderdetails;
             InvoicedOrderDetailsGridView.DataBind();
         }

        //Generate InvoicedOrderDetailsView
        private void FillUpInvoiceOrderFields(long invoiceID, long orderID)
         {
             IEnumerable<BillingShippingDetails> billingshippingDetails = invoiceBL.GetBillingShippingDetails(orderID, invoiceID);
             InvoicedOrderDetailsView.DataSource = billingshippingDetails;
             InvoicedOrderDetailsView.AutoGenerateRows = false;
             InvoicedOrderDetailsView.DataBind();
         }

        //Modal for Opprotunity & Order
        protected void ModalPopButton_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            if (btn != null && btn.CommandArgument == "Opportunity")
            {
                ModalLabel.Text = "Select Opportunity";
                OrderSearchPanel.Visible = false;
                OrderListGridView.Visible = false;
                OpportunitySearchPanel.Visible = true;
                OpportunityGridView.Visible = true;
            }
            else if (btn != null && btn.CommandArgument == "Order")
            {
                ModalLabel.Text = "Select Order";
                OpportunitySearchPanel.Visible = false;
                OpportunityGridView.Visible = false;
                OrderSearchPanel.Visible = true;
                OrderListGridView.Visible = true;
            }
        }
    }
}