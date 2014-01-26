using System;
using System.Collections.Specialized;
using System.Web.UI.WebControls;
using C3App.App_Code;
using C3App.BLL;
using System.Collections.Generic;
using System.Web.UI;
using System.Web;

namespace C3App.Accounts
{

    public partial class Accounts : PageBase
    {
        private DropDownList usersDropDownList;
        private DropDownList industryDropDownList;
        private DropDownList accountTypeDropDownList;
        private DropDownList teamDropdownList;
        private DropDownList parentCompanyDropDownList;
        private DropDownList billingCountryDropDownList;
        private DropDownList shippingCountryDropDownList;
        public long accountID;       
        public int companyID;

        protected void Page_Init(object sender, EventArgs e)
        {
            AccountDetailsView.EnableDynamicData(typeof(DAL.Account));
        }

        public void Page_Load(object sender, EventArgs e)
        {
            companyID = Convert.ToInt32(Session["CompanyID"]);
           
            try
            {
                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        EditLinkButton.Visible = false;
                        ModalPopButton2.Visible = false;
                        DeleteLinkButton.Visible = false;
                        NotifyLinkButton.Visible = false;
                        Session.Remove("EditAccountID");
                    }
                }
                if (Session["EditAccountID"] != null)
                {
                    long accountID = Convert.ToInt64(Session["EditAccountID"]);

                    if (accountID == 0)
                    {
                        AccountDetailsView.ChangeMode(DetailsViewMode.Insert);
                    }
                    else if (accountID > 0)
                    {
                        AccountDetailsView.ChangeMode(DetailsViewMode.Edit);
                    }
                }
                else
                {
                    AccountDetailsView.ChangeMode(DetailsViewMode.Insert);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            } 

            //Previous page load code 
                //if (Request.QueryString["ShowPanel"] != null)
                //{
                //    if ((!IsPostBack) || (Request.QueryString["ShowPanel"] == "DetailsPanel"))
                //    {
                //        Session.Remove("EditAccountID");
                //    }
                //}
                //try
                //{
                //    Int64 accountID = Convert.ToInt64(Session["EditAccountID"]);
                //    AccountDetailsView.ChangeMode(accountID == 0 ? DetailsViewMode.Insert : DetailsViewMode.Edit);
                //}
                //catch(Exception ex)
                //{
                //    throw ex;
                //}
            }

        /// <summary>
        /// Function to catch page-level error
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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
            ExceptionUtility.LogException(exc, "AccountPage");
            ExceptionUtility.NotifySystemOps(exc, "AccountPage");

            //Clear the error from the server
            Server.ClearError();
        }


        //start dropdownlist initialization
        protected void UsersDropDownList_Init(object sender, EventArgs e)
        {
            usersDropDownList = sender as DropDownList;
        }
        protected void IndustriesDropDownList_Init(object sender, EventArgs e)
        {
            industryDropDownList = sender as DropDownList;
        }
        protected void TeamsDropDownList_Init(object sender, EventArgs e)
        {
            teamDropdownList = sender as DropDownList;
        }
        protected void AccountTypeDropDownList_Init(object sender, EventArgs e)
        {
            accountTypeDropDownList = sender as DropDownList;
        }
        protected void ParentCompanyDropDownList_Init(object sender, EventArgs e)
        {
            parentCompanyDropDownList = sender as DropDownList;
        }
        protected void BillingCountriesDropDownList_Init(object sender, EventArgs e)
        {
            billingCountryDropDownList = sender as DropDownList;
        }
        protected void ShippingCountriesDropDownList_Init(object sender, EventArgs e)
        {
            shippingCountryDropDownList = sender as DropDownList;
        }
        //end dropdownlist initialization

        //notifyCheckbox to send mail for assigned person
        protected void UsersDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            CheckBox notifyCheckbox = AccountDetailsView.FindControl("notifyCheckBox") as CheckBox;
            Label notifylabel = AccountDetailsView.FindControl("NotifyLabel") as Label;
            notifylabel.Visible = true;
            notifyCheckbox.Visible = true;
        }


        //select an account from list
        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            //highlight selected row start
            int gindex = Convert.ToInt32(ViewAccountsGridView.SelectedIndex);
            if (gindex > -1)
            {
                LinkButton nlbtn = ViewAccountsGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                nlbtn.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            if (lbtn != null) lbtn.CssClass = "active";
            //highlight selected row end

            if (CheckEdit() != false)
                EditLinkButton.Visible = true;
            if (CheckDelete() != false)
                DeleteLinkButton.Visible = true;
            ModalPopButton2.Visible = true;
            NotifyLinkButton.Visible = true;

            // Session["EditAccountID"] = e.CommandArgument.ToString();
            //added on 17.01.2013
            try
            {
                UserBL userBL = new UserBL();
                string arguments = Convert.ToString(e.CommandArgument);
                string[] arg = arguments.Split(';');
                Session["EditAccountID"] = Convert.ToInt64(arg[0]);
                if (arg[1] != string.Empty)
                {
                    long assignedUserID = Convert.ToInt64(arg[1]);
                    Session["AccountName"] = Convert.ToString(arg[2]);
                    try
                    {
                        IEnumerable<DAL.User> userdetails = userBL.GetUsersByID(assignedUserID);
                        foreach (var user in userdetails)
                        {
                            Session["ReceiverName"] = user.FirstName;
                            Session["ReceiverEmail"] = user.PrimaryEmail;
                        }

                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }

                MiniAccountsFormView.DataBind();
                miniAccountDetailsView.DataBind();
                miniAccountDetailsUpdatePanel.Update();
            }

            catch (Exception ex)
            {
                throw ex;
            }
            //end on 17.01.2013
            //comment out to enable singleaccount in formview
        }


        //inserting new account
        protected void AccountDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            CheckBox notifyCheckbox = AccountDetailsView.FindControl("NotifyCheckBox") as CheckBox;

            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.Values["CreatedBy"] = Convert.ToInt64(HttpContext.Current.Session["UserID"]);

            if (Convert.ToInt32(usersDropDownList.SelectedValue) == 0)
            {
                e.Values["AssignedUserID"] = null;
            }
            else
            {
                e.Values["AssignedUserID"] = usersDropDownList.SelectedValue;
                if (notifyCheckbox != null && (notifyCheckbox.Checked = true))
                {
                    Session["NotifyStatus"] = "1";
                }
            }
            if (Convert.ToInt32(industryDropDownList.SelectedValue) == 0)
            {
                e.Values["IndustryID"] = null;

            }
            else
            {
                e.Values["IndustryID"] = industryDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(accountTypeDropDownList.SelectedValue) == 0)
            {
                e.Values["AccountTypesID"] = null;
            }
            else
            {
                e.Values["AccountTypesID"] = accountTypeDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(teamDropdownList.SelectedValue) == 0)
            {
                e.Values["TeamID"] = null;
            }
            else
            {
                e.Values["TeamID"] = teamDropdownList.SelectedValue;
            }

            if (Convert.ToInt32(billingCountryDropDownList.SelectedValue) == 0)
            {
                e.Values["BillingCountry"] = null;
            }
            else
            {
                e.Values["BillingCountry"] = billingCountryDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(shippingCountryDropDownList.SelectedValue) == 0)
            {
                e.Values["ShippingCountry"] = null;
            }
            else
            {
                e.Values["ShippingCountry"] = shippingCountryDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(parentCompanyDropDownList.SelectedValue) == 0)
            {
                e.Values["ParentID"] = null;
            }
            else
            {
                e.Values["ParentID"] = parentCompanyDropDownList.SelectedValue;
            }

        }


        //Updating old account
        protected void AccountDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            CheckBox notifyCheckbox = AccountDetailsView.FindControl("NotifyCheckBox") as CheckBox;
            if (Convert.ToInt32(usersDropDownList.SelectedValue) == 0)
            {
                e.NewValues["AssignedUserID"] = null;
            }
            else
            {
                e.NewValues["AssignedUserID"] = usersDropDownList.SelectedValue;
                if (notifyCheckbox != null && (notifyCheckbox.Checked = true))
                {
                    Session["NotifyStatus"] = "1";
                }
            }


            if (Convert.ToInt32(industryDropDownList.SelectedValue) == 0)
            {
                e.NewValues["IndustryID"] = null;
            }
            else
            {
                e.NewValues["IndustryID"] = industryDropDownList.SelectedValue;
            }


            if (Convert.ToInt32(accountTypeDropDownList.SelectedValue) == 0)
            {
                e.NewValues["AccountTypesID"] = null;
            }
            else
            {
                e.NewValues["AccountTypesID"] = accountTypeDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(teamDropdownList.SelectedValue) == 0)
            {
                e.NewValues["TeamID"] = null;
            }
            else
            {
                e.NewValues["TeamID"] = teamDropdownList.SelectedValue;
            }

            if (Convert.ToInt32(billingCountryDropDownList.SelectedValue) == 0)
            {
                e.NewValues["BillingCountry"] = null;
            }
            else
            {
                e.NewValues["BillingCountry"] = billingCountryDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(shippingCountryDropDownList.SelectedValue) == 0)
            {
                e.NewValues["ShippingCountry"] = null;
            }
            else
            {
                e.NewValues["ShippingCountry"] = shippingCountryDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(parentCompanyDropDownList.SelectedValue) == 0)
            {
                e.NewValues["ParentID"] = null;
            }
            else
            {
                e.NewValues["ParentID"] = parentCompanyDropDownList.SelectedValue;
            }

            e.NewValues["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.NewValues["ModifiedTime"] = DateTime.Now;
            e.NewValues["ModifiedBy"] = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
        }


        //after inserting an account
       protected void AccountDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            UserBL userBL = new UserBL();
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
                string receiverName = string.Empty;
                string receiverEmail = string.Empty;
                if (rowcount == -1)
                {
                    string name = e.Values["Name"].ToString();
                    MsgLiteral.Text = "Success";
                    alertLabel.Text = "This Account " + name + " has been saved";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                }
                //else
                //{
                //    MsgLiteral.Text = "Save failed";
                //    alertLabel.Text = "Sorry,this Account has not been saved";
                //}

                if (Session["NotifyStatus"] != null)
                {
                    long assignedUserID = Convert.ToInt64(e.Values["AssignedUserID"]);
                    string accountName = e.Values["Name"].ToString();
                    IEnumerable<DAL.User> userdetails = userBL.GetUsersByID(assignedUserID);
                    foreach (var user in userdetails)
                    {
                        receiverName = user.FirstName;
                        receiverEmail = user.PrimaryEmail;
                    }
                    const string subject = "Account Notification";
                    string body = "Dear " + receiverName + ",You have been assigned to deal with " + accountName + " ";
                    try
                    {
                        Notification.SendEmail(receiverEmail, subject, body);
                        Session["NotifyStatus"] = 0;
                        MiniAccountsFormView.DataBind();
                        miniAccountDetailsView.DataBind();
                        ViewAccountsGridView.DataBind();
                        miniAccountDetailsUpdatePanel.Update();
                        Session["EditAccountID"] = 0;
                        AccountDetailsView.ChangeMode(DetailsViewMode.Insert);
                        AccountDetailsView.DataBind();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            }
        }


       //after updating an account
        protected void AccountDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
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
                string receiverName = string.Empty;
                string receiverEmail = string.Empty;
                if (rowcount == -1)
                {
                    string name = e.NewValues["Name"].ToString();
                    MsgLiteral.Text = "Success";
                    alertLabel.Text = "This account " + name + " has been saved";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                }

                //else
                //{
                //    MsgLiteral.Text = "Save failed";
                //    alertLabel.Text = "Sorry,this Account has not been saved";
                //}

                if (Session["NotifyStatus"] != null)
                {
                    UserBL userBL = new UserBL();
                    long assignedUserID = Convert.ToInt64(e.NewValues["AssignedUserID"]);
                    string accountName = e.NewValues["Name"].ToString();
                    IEnumerable<DAL.User> userdetails = userBL.GetUsersByID(assignedUserID);
                    foreach (var user in userdetails)
                    {
                        receiverName = user.FirstName;
                        receiverEmail = user.PrimaryEmail;
                    }
                    const string subject = "Account Notification";
                    string body = "Dear " + receiverName + ",Your new assignment is to deal with " + accountName + " ";
                    try
                    {
                        Notification.SendEmail(receiverEmail, subject, body);
                        Session["NotifyStatus"] = 0;
                        MiniAccountsFormView.DataBind();
                        miniAccountDetailsView.DataBind();
                        ViewAccountsGridView.DataBind();
                        miniAccountDetailsUpdatePanel.Update();
                        Session["EditAccountID"] = 0;
                        AccountDetailsView.DataBind();
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            }
        }

        
        //cancel account
        protected void AccountDetailsView_ItemCommand(Object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                //code to stay in current tab
                //Session["EditAccountID"] = 0;
                MsgLiteral.Text = "Submission cancelled";
                alertLabel.Text = "Your changes have been discarded";
                AccountDetailsView.DataBind();
                AccountDetailsView.ChangeMode(DetailsViewMode.Insert);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                //Code to move to ViewProducts Tab
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
            }
            //if (e.CommandName == "Edit")
            //{                
            //    AccountDetailsView.ChangeMode(DetailsViewMode.Edit);
            //}

            //if (e.CommandName == "Update")
            //{
            //  AccountDetailsView.ChangeMode(DetailsViewMode.Edit);
            //}
        }


        //Code for showing changed searching accounts of the company
        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            AccountBL accountBL = new AccountBL();       
            string search = SearchTextBox.Text;
            accountBL.SearchAccount(search);
        }


        //Code for showing searching accounts of the company
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            ViewAccountsGridView.DataSourceID = SearchObjectDataSource.ID;
            ViewAccountsGridView.DataBind();
            ViewAccountsUpdatepanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }


        //Code for showing all accounts of the company
        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            ViewAccountsGridView.DataSourceID = AccountsViewObjectDataSource.ID;
            ViewAccountsGridView.DataBind();
            ViewAccountsUpdatepanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }

        protected void BankingIndustrySearchButton_Click(object sender, EventArgs e)
        {
            ViewAccountsGridView.DataSourceID = BankingIndustryObjectDataSource.ID;
            ViewAccountsGridView.DataBind();
            ViewAccountsUpdatepanel.Update();
        }

        protected void ApparelIndustrySearchButton_Click(object sender, EventArgs e)
        {
            ViewAccountsGridView.DataSourceID = ApparelIndustryObjectDataSource.ID;
            ViewAccountsGridView.DataBind();
            ViewAccountsUpdatepanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }

        protected void CustomerAccountTypeSearchButton_Click(object sender, EventArgs e)
        {
           ViewAccountsGridView.DataSourceID = CustomerAccountTypeObjectDataSource.ID;
            ViewAccountsGridView.DataBind();
            ViewAccountsUpdatepanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }

        //delete an account
        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            AccountBL accountBL = new AccountBL();       
            long accountID = Convert.ToInt64(Session["EditAccountID"]);
            accountBL.DeleteAccount(accountID);           
            this.ViewAccountsGridView.DataBind();
            this.MiniAccountsFormView.DataBind();
            this.miniAccountDetailsView.DataBind();
            ViewAccountsUpdatepanel.Update();
            miniAccountDetailsUpdatePanel.Update();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
        }


        //edit an account
        protected void AccountEditButton_Click(object sender, EventArgs e)
        {
            long accountID = Convert.ToInt64(Session["EditAccountID"]);
            if(accountID==0)
            {
                AccountDetailsView.DataSource = null;
                AccountDetailsView.DataBind();
            }
            // Session["AccountID"] = btn.CommandArgument.ToString();
           // Label1.Text = Convert.ToString(Session["AccountID"]);
            AccountDetailsView.ChangeMode(DetailsViewMode.Edit);
        }

        // clears & update panels
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            Session["EditAccountID"] = 0;
            ViewAccountsGridView.DataBind();
            ViewAccountsGridView.SelectedIndex = -1;
            ViewAccountsUpdatepanel.Update();
            MiniAccountsFormView.DataBind();
            miniAccountDetailsUpdatePanel.Update();
            ModalPopButton2.Visible = false;
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;
        }


        //CreateAccount Button
        protected void AccountInsertLinkButton_Click(object sender, EventArgs e)
        {
            Session["EditAccountID"] = 0;
            AccountDetailsView.ChangeMode(DetailsViewMode.Insert);
        }


        //send notification mail to assigned person
       protected void NotifyLinkButton_Click(object sender, EventArgs e)
        {
            //new notification
            string touser = Session["ReceiverEmail"].ToString();
            string receivername = Session["ReceiverName"].ToString();
            ListDictionary templateValues = new ListDictionary();
            templateValues.Add("<%ModuleName%>", "Accounts");
            templateValues.Add("<%Key%>", "AccountName");
            templateValues.Add("<%Value%>", receivername);
            C3App.App_Code.Notification.Notify("Account", accountID, 1, touser, 2, templateValues);
            Session["ReceiverName"] = 0;
            Session["ReceiverEmail"] = 0;
            Session["AccountName"] = 0;

            //old notification
            //string touser = Session["ReceiverEmail"].ToString();
            //string receivername = Session["ReceiverName"].ToString();
            //string accountName = Session["AccountName"].ToString();
            //const string subject = "Account Notification";
            //string body = "Dear " + receivername + ",You have been asssigned to deal with " + accountName + " ";
            //Notification.SendEmail(touser, subject, body);
            //Session["ReceiverName"] = 0;
            //Session["ReceiverEmail"] = 0;
            //Session["AccountName"] = 0;
        }
    }
}