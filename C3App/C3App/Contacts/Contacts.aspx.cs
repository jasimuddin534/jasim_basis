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

namespace C3App.Contacts
{
    public partial class Contacts : PageBase
    {
        //ldsjfsld
        #region Initializing....
        private DropDownList SalutationDropDownList;
        private DropDownList ReportToDropDownList;
        private DropDownList TeamDropDownList;
        private DropDownList AssaigendToDropDownList;
        private DropDownList LeadSourcesDropDownList;
        private DropDownList PrimaryCountryDropDownList;
        private DropDownList AlternateCountryDropDownList;
        private long contactID = 0;
        private Int32 companyID;
        private AccountBL accountBL = new AccountBL();
        private UserBL userBL = new UserBL();
        #endregion


        #region Page Functions.....
        protected void Page_Load(object sender, EventArgs e)
        {
            companyID = Convert.ToInt32(Session["CompanyID"]);
            try
            {
                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        Session["EditContactID"] = 0;
                    }
                }
                if (Session["EditContactID"] != null)
                {
                    contactID = Convert.ToInt64(Session["EditContactID"]);
                    if (contactID == 0)
                    {
                        ContactDetailsView.ChangeMode(DetailsViewMode.Insert);

                        this.ContactGridView.DataBind();
                        this.ContactGridView.SelectedIndex = -1;
                        this.MiniContactFormView.DataBind();
                        this.MiniContactDetailsView.DataBind();
                        ContactListUpdatePanel.Update();
                        MiniDetailsUpdatePanel.Update();


                        EditLinkButton.Visible = false;
                        DeleteLinkButton.Visible = false;
                        MeetingSummaryLinkButton.Visible = false;
                        NotifyLinkButton.Visible = false;
                    }
                    else if (contactID > 0)
                    {
                        ContactDetailsView.ChangeMode(DetailsViewMode.Edit);
                        MeetingSummaryLinkButton.Visible = true;
                        NotifyLinkButton.Visible = true;
                        if (CheckEdit() != false)
                            EditLinkButton.Visible = true;
                        if (CheckDelete() != false)
                            DeleteLinkButton.Visible = true;
                    }
                }
                else
                {
                    ContactDetailsView.ChangeMode(DetailsViewMode.Insert);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        protected void Page_Error(object sender, EventArgs e)
        {
            Exception exc = Server.GetLastError();
            Response.Write("<h2>Something wrong happend!</h2>");
            Response.Write("<b>Exception Type: </b>" + exc.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Exception: </b>" + exc.Message.ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception Type: </b>" + exc.InnerException.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception: </b>" + exc.InnerException.Message + "<br/><br/>");
            Response.Write("<b>Inner Source: </b>" + exc.InnerException.Source + "<br/><br/>");
            ExceptionUtility.LogException(exc, "ContactsPage");
            ExceptionUtility.NotifySystemOps(exc, "ContactsPage");
            Server.ClearError();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            ContactDetailsView.EnableDynamicData(typeof(DAL.Contact));
        }
        #endregion


        #region Dropdown List Initialization....
        protected void SalutationDropDownList_Init(object sender, EventArgs e)
        {
            SalutationDropDownList = sender as DropDownList;
        }

        protected void TeamNameDropDownList_Init(object sender, EventArgs e)
        {
            TeamDropDownList = sender as DropDownList;
        }

        protected void ReportToDropDownList_Init(object sender, EventArgs e)
        {
            ReportToDropDownList = sender as DropDownList;
        }

        protected void AssaigendToDropDownList_Init(object sender, EventArgs e)
        {
            AssaigendToDropDownList = sender as DropDownList;
        }

        protected void LeadSourceDropDownList_Init(object sender, EventArgs e)
        {
            LeadSourcesDropDownList = sender as DropDownList;
        }

        protected void PrimaryCountryDropDownList_Init(object sender, EventArgs e)
        {
            PrimaryCountryDropDownList = sender as DropDownList;
        }

        protected void AlternateCountryDropDownList_Init(object sender, EventArgs e)
        {
            AlternateCountryDropDownList = sender as DropDownList;
        }
        #endregion


        #region select and Command Function of Contacts...
        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandArgument.ToString() != null)
            {
                int gindex = Convert.ToInt32(ContactGridView.SelectedIndex);
                if (gindex > -1)
                {
                    LinkButton nlbtn = ContactGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                    nlbtn.CssClass = "";
                }
                LinkButton lbtn = sender as LinkButton;
                lbtn.CssClass = "active";
                MeetingSummaryLinkButton.Visible = true;
                NotifyLinkButton.Visible = true;
                if (CheckEdit() != false)
                    EditLinkButton.Visible = true;
                if (CheckDelete() != false)
                    DeleteLinkButton.Visible = true;

                try
                {
                    string arguments = Convert.ToString(e.CommandArgument);
                    string[] arg = arguments.Split(';');
                    Session["EditContactID"] = Convert.ToInt64(arg[0]);
                    contactID = Convert.ToInt64(Session["EditContactID"]);
                    if (arg[1] != string.Empty)
                    {
                        long assignedUserID = Convert.ToInt64(arg[1]);
                        Session["ContactName"] = Convert.ToString(arg[2]);
                        try
                        {
                            IEnumerable<DAL.User> userdetails = userBL.GetUsersByID(assignedUserID);
                            foreach (var user in userdetails)
                            {
                                Session["ReceiverName"] = user.FirstName + " " + user.LastName;
                                Session["ReceiverEmail"] = user.PrimaryEmail;
                            }
                        }
                        catch (Exception ex)
                        {
                            throw ex;
                        }
                    }
                }

                catch (Exception ex)
                {
                    throw ex;
                }
                MiniDetailsUpdatePanel.Update();
                MiniContactFormView.DataBind();
                MiniContactDetailsView.DataBind();

                MeetingSummaryUpdatePanel.Update();
                MeetingsInvitedGridView.DataBind();
            }
            else
            {
                Session["EditContactID"] = 0;
            }

        }

        protected void ContactDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Session["EditContactID"] = 0;
                Session.Remove("ContactName");
                Session.Remove("AssignedTo");
                Session.Remove("ReceiverName");
                Session.Remove("ReceiverEmail");
                Session.Remove("NotifyUser");
                Session.Remove("ContactAccountID");
                Session.Remove("ContactName");
                ContactDetailsView.DataBind();
                ContactDetailsView.ChangeMode(DetailsViewMode.Insert);
                MessageLiteral.Text = "Changes discarded <br/> <p>Your changes have been discarded</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
        }
        #endregion


        #region Insert Function of Contacts...
        protected void ContactDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            long userid;
            Session["ContactName"] = e.Values["FirstName"] + " " + e.Values["LastName"];

            CheckBox notifyCheckbox = ContactDetailsView.FindControl("NotifyCheckBox") as CheckBox;
            if (notifyCheckbox.Checked)
            {
                Session["NotifyUser"] = 1;
            }
            else
            {
                Session["NotifyUser"] = 2;
            }


            if (String.IsNullOrEmpty(Session["CompanyID"].ToString())) { return; }
            else
            {
                e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            }
            if (String.IsNullOrEmpty(Session["UserID"].ToString())) { return; }
            else
            {
                userid = Convert.ToInt64(Session["UserID"]);
            }

            if (SalutationDropDownList.SelectedValue.ToString() == "None") { e.Values["Salutation"] = null; }
            else { e.Values["Salutation"] = SalutationDropDownList.SelectedValue.ToString(); }

            if (Session["ContactAccountID"] != null)
            {
                e.Values["AccountID"] = Convert.ToInt64(Session["ContactAccountID"]);
            }
            else
            {
                e.Values["AccountID"] = null;
            }

            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.Values["TeamID"] = null; }
            else { e.Values["TeamID"] = TeamDropDownList.SelectedValue; }

            if (Convert.ToInt32(ReportToDropDownList.SelectedValue) == 0) { e.Values["ReportsTo"] = null; }
            else { e.Values["ReportsTo"] = ReportToDropDownList.SelectedValue; }

            if (Convert.ToInt32(AssaigendToDropDownList.SelectedValue) == 0) { e.Values["AssignedTo"] = null; }
            else { e.Values["AssignedTo"] = AssaigendToDropDownList.SelectedValue; }


            if (Convert.ToInt32(LeadSourcesDropDownList.SelectedValue) == 0) { e.Values["LeadSourcesID"] = null; }
            else { e.Values["LeadSourcesID"] = LeadSourcesDropDownList.SelectedValue; }

            if (Convert.ToInt32(PrimaryCountryDropDownList.SelectedValue) == 0) { e.Values["PrimaryCountry"] = null; }
            else { e.Values["PrimaryCountry"] = PrimaryCountryDropDownList.SelectedValue; }

            if (Convert.ToInt32(AlternateCountryDropDownList.SelectedValue) == 0) { e.Values["AlternateCountry"] = null; }
            else { e.Values["AlternateCountry"] = AlternateCountryDropDownList.SelectedValue; }

            e.Values["CreatedBy"] = userid;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;

        }

        protected void CreateContactObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Insert failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;
            }
            else
            {
                string contactName = Session["ContactName"].ToString();
                Int64 assignedUserID = Convert.ToInt64(Session["AssignedTo"]);
                int Notifyuser = (int)Session["NotifyUser"];
                string userEmail = String.Empty;
                string receivername = String.Empty;
                string NotifyMessage = String.Empty;
                if (Notifyuser == 1)
                {
                    IEnumerable<DAL.User> userdetails = userBL.GetUsersByID(assignedUserID);
                    foreach (var user in userdetails)
                    {
                        receivername = user.FirstName + " " + user.LastName;
                        userEmail = user.PrimaryEmail;
                    }
                    string touser = userEmail;
                    string body = "Mr/Mrs" + " " + receivername + "," + "<br/>You have been asssigned to deal with " + contactName + " ";

                    try
                    {
                        ListDictionary templateValues = new ListDictionary();
                        templateValues.Add("<%=ModuleName%>", "Contacts");
                        templateValues.Add("<%=Key%>", "Contact Name");
                        templateValues.Add("<%=Value%>", receivername);
                        C3App.App_Code.Notification.Notify("Contacts", contactID, 1, touser, 2, templateValues);


                        NotifyMessage = "and successfully notify to " + receivername;
                    }
                    catch (Exception ex)
                    {
                        NotifyMessage = "Notification unsuccess </br> Problem is : " + ex.InnerException.Message.ToString();
                    }
                }

                MessageLiteral.Text = "Success </br></br> <p> Contact has been successfully saved <br/> " + NotifyMessage + "</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

                this.ContactGridView.DataBind();
                this.MiniContactFormView.DataBind();
                this.MiniContactDetailsView.DataBind();
                ContactDetailsView.ChangeMode(DetailsViewMode.Insert);

                Session["EditContactID"] = 0;
                Session.Remove("ContactName");
                Session.Remove("AssignedTo");
                Session.Remove("ReceiverName");
                Session.Remove("ReceiverEmail");
                Session.Remove("NotifyUser");
                Session.Remove("ContactAccountID");
                Session.Remove("ContactName");
            }
        }
        #endregion


        #region Update Function of Contacts...
        protected void ContactDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            Session["ContactName"] = e.NewValues["FirstName"] + " " + e.NewValues["LastName"];
            CheckBox notifyCheckbox = ContactDetailsView.FindControl("NotifyCheckBox") as CheckBox;
            if (notifyCheckbox.Checked)
            {
                Session["NotifyUser"] = 1;
            }
            else
            {
                Session["NotifyUser"] = 2;
            }

            //TextBox AccountName = ContactDetailsView.FindControl("AccountNameTextBox") as TextBox;

            if (SalutationDropDownList.SelectedValue.ToString() == "None") { e.NewValues["Salutation"] = null; }
            else { e.NewValues["Salutation"] = SalutationDropDownList.SelectedValue.ToString(); }

            if (Session["ContactAccountID"] != null)
            {
                long accountID = Convert.ToInt64(Session["ContactAccountID"]);
                e.NewValues["AccountID"] = accountID;
            }
            else
            {
                e.NewValues["AccountID"] = null;
            }

            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.NewValues["TeamID"] = null; }
            else { e.NewValues["TeamID"] = TeamDropDownList.SelectedValue; }

            if (Convert.ToInt32(ReportToDropDownList.SelectedValue) == 0) { e.NewValues["ReportsTo"] = null; }
            else { e.NewValues["ReportsTo"] = ReportToDropDownList.SelectedValue; }

            if (Convert.ToInt32(AssaigendToDropDownList.SelectedValue) == 0) { e.NewValues["AssignedTo"] = null; }
            else { e.NewValues["AssignedTo"] = AssaigendToDropDownList.SelectedValue; }

            if (Convert.ToInt32(LeadSourcesDropDownList.SelectedValue) == 0) { e.NewValues["LeadSourcesID"] = null; }
            else { e.NewValues["LeadSourcesID"] = LeadSourcesDropDownList.SelectedValue; }

            if (Convert.ToInt32(PrimaryCountryDropDownList.SelectedValue) == 0) { e.NewValues["PrimaryCountry"] = null; }
            else { e.NewValues["PrimaryCountry"] = PrimaryCountryDropDownList.SelectedValue; }

            if (Convert.ToInt32(AlternateCountryDropDownList.SelectedValue) == 0) { e.NewValues["AlternateCountry"] = null; }
            else { e.NewValues["AlternateCountry"] = AlternateCountryDropDownList.SelectedValue; }

            e.NewValues["ModifiedBy"] = Convert.ToInt64(Session["UserID"]);
            e.NewValues["ModifiedTime"] = DateTime.Now;

        }

        protected void CreateContactObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Update failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;

            }
            else
            {
                contactID = Convert.ToInt64(Session["EditContactID"]);
                string contactName = Session["ContactName"].ToString();
                Int64 assignedUserID = Convert.ToInt64(Session["AssignedTo"]);
                int Notifyuser = (int)Session["NotifyUser"];

                string userEmail = null;
                string receivername = null;
                string NotifyMessage = null;

                if (Notifyuser == 1)
                {
                    IEnumerable<DAL.User> userdetails = userBL.GetUsersByID(assignedUserID);
                    foreach (var user in userdetails)
                    {
                        receivername = user.FirstName + " " + user.LastName;
                        userEmail = user.PrimaryEmail;
                    }
                    string touser = userEmail;
                    string body = "Mr/Mrs" + " " + receivername + "," + "<br/>You have been asssigned to deal with " + contactName + " ";

                    try
                    {
                        ListDictionary templateValues = new ListDictionary();
                        templateValues.Add("<%=ModuleName%>", "Contacts");
                        templateValues.Add("<%=Key%>", "Contact Name");
                        templateValues.Add("<%=Value%>", receivername);
                        C3App.App_Code.Notification.Notify("Contacts", contactID, 1, touser, 2, templateValues);
                        NotifyMessage = "and successfully notify to " + receivername;
                    }
                    catch (Exception ex)
                    {
                        NotifyMessage = "Notification Unsuccess </br> Problem is : " + ex.InnerException.Message.ToString();
                    }
                }

                MessageLiteral.Text = "Success </br></br> <p> Contact has been successfully updated. <br/> " + NotifyMessage + "</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

                this.ContactGridView.DataBind();
                this.MiniContactFormView.DataBind();
                this.MiniContactDetailsView.DataBind();

                ContactDetailsView.ChangeMode(DetailsViewMode.Insert);
                Session["EditContactID"] = 0;
                Session.Remove("ContactName");
                Session.Remove("AssignedTo");
                Session.Remove("ReceiverName");
                Session.Remove("ReceiverEmail");
                Session.Remove("NotifyUser");
                Session.Remove("ContactAccountID");
                Session.Remove("ContactName");
            }
        }

        #endregion


        #region Contact Tab Function......
        protected void ViewContactsLinkButton_Click(object sender, EventArgs e)
        {

            ContactGridView.DataSourceID = ContactListObjectDataSource.ID;
            ContactGridView.SelectedIndex = -1;
            ContactGridView.DataBind();
            ContactListUpdatePanel.Update();
            MiniDetailsUpdatePanel.Update();
            MiniContactFormView.DataBind();

            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            MeetingSummaryLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            Session["EditContactID"] = 0;
            Session.Remove("ContactName");
            Session.Remove("AssignedTo");
            Session.Remove("ReceiverName");
            Session.Remove("ReceiverEmail");
            Session.Remove("NotifyUser");
            Session.Remove("ContactAccountID");
            Session.Remove("ContactName");
        }

        protected void ContactDetailsLinkButton_Click(object sender, EventArgs e)
        {
            Session["EditContactID"] = 0;
            Session.Remove("ContactName");
            Session.Remove("AssignedTo");
            Session.Remove("ReceiverName");
            Session.Remove("ReceiverEmail");
            Session.Remove("NotifyUser");
            Session.Remove("ContactAccountID");
            Session.Remove("ContactName");

            ContactDetailsView.DataSource = null;
            ContactDetailsView.DataBind();
            ContactDetailsView.ChangeMode(DetailsViewMode.Insert);
        }
        protected void ShowMeetings_Click(object sender, EventArgs e)
        {
            MeetingSummaryUpdatePanel.Update();
        }
        #endregion


        #region Contact Edit, Delete, Search Function.......
        protected void EditLinkButton_Click(object sender, EventArgs e)
        {
            if (contactID == 0)
            {
                ContactDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
            else if (contactID > 0)
            {
                ContactDetailsView.ChangeMode(DetailsViewMode.Edit);
            }
        }

        protected void DeleteLinkButton_Click(object sender, EventArgs e)
        {
            contactID = Convert.ToInt32(Session["EditContactID"]);
            ContactBL contactBL = new ContactBL();
            contactBL.DeleteContactByID(contactID);

            this.ContactGridView.DataBind();
            this.ContactGridView.SelectedIndex = -1;
            this.MiniContactFormView.DataBind();
            this.MiniContactDetailsView.DataBind();
            ContactListUpdatePanel.Update();
            MiniDetailsUpdatePanel.Update();

            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            MeetingSummaryLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            Session["EditContactID"] = 0;
            Session.Remove("ContactName");
            Session.Remove("AssignedTo");
            Session.Remove("ReceiverName");
            Session.Remove("ReceiverEmail");
            Session.Remove("NotifyUser");
            Session.Remove("ContactAccountID");
            Session.Remove("ContactName");
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            MeetingSummaryLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            ContactGridView.DataSourceID = SearchContactObjectDataSource.ID;
            this.ContactGridView.DataBind();
            this.ContactGridView.SelectedIndex = -1;
            this.MiniContactFormView.DataBind();
            this.MiniContactDetailsView.DataBind();
            ContactListUpdatePanel.Update();
            MiniDetailsUpdatePanel.Update();
        }

        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            MeetingSummaryLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            ContactGridView.DataSourceID = ContactListObjectDataSource.ID;
            this.ContactGridView.DataBind();
            this.ContactGridView.SelectedIndex = -1;
            this.MiniContactFormView.DataBind();
            this.MiniContactDetailsView.DataBind();
            ContactListUpdatePanel.Update();
            MiniDetailsUpdatePanel.Update();
        }
        #endregion


        #region Modal Function For Accounts.....

        protected void SelectButton_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            if (btn.CommandArgument.ToString() == "Accounts")
            {
                AccountGridView.Visible = true;
                AccountSearchPanel.Visible = true;
            }
        }

        protected void AccountSearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            accountBL.SearchAccount(search);
            this.AccountGridView.DataBind();
        }

        protected void SelectAccountLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["ContactAccountID"] = e.CommandArgument.ToString();
            long accountID = Convert.ToInt64(Session["ContactAccountID"]);
            IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(accountID);
            foreach (var account in accounts)
            {
                string accountName = account.Name;
                TextBox AccountName = ContactDetailsView.FindControl("AccountNameTextBox") as TextBox;
                AccountName.Text = accountName;

            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModals(['BodyContent_AccountListModalPanel','BodyContent_CreateAccountModalPanel']);", true);
            AccountSearchTextBox.Text = String.Empty;
        }

        protected void AccountDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.Values["CreatedBy"] = Convert.ToInt64(Session["UserID"]);
        }

        protected void AccountDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            AccountGridView.DataBind();
            string accountName = e.Values["Name"].ToString();
            TextBox AccountName = ContactDetailsView.FindControl("AccountNameTextBox") as TextBox;
            AccountName.Text = accountName;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModals(['BodyContent_AccountListModalPanel','BodyContent_CreateAccountModalPanel']);", true);
        }

        protected void AccountsDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long accountID;
            accountID = Convert.ToInt64(e.ReturnValue);
            Session["ContactAccountID"] = accountID;
        }

        protected void AccountDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                AccountDetailsView.DataBind();
                AccountDetailsView.ChangeMode(DetailsViewMode.Insert);
            }

        }

        #endregion


        #region Notification Function.....
        protected void AssaigendToDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label notifylabel = ContactDetailsView.FindControl("NotifyLabel") as Label;
            CheckBox notifyCheckbox = ContactDetailsView.FindControl("NotifyCheckBox") as CheckBox;
            if (AssaigendToDropDownList.SelectedItem.Text != "None")
            {
                notifylabel.Visible = true;
                notifyCheckbox.Visible = true;
            }
            else
            {
                notifylabel.Visible = false;
                notifyCheckbox.Visible = false;
            }
        }

        protected void NotifyLinkButton_Click(object sender, EventArgs e)
        {
            contactID = Convert.ToInt64(Session["EditContactID"]);
            string touser = Session["ReceiverEmail"].ToString();
            string receivername = Session["ReceiverName"].ToString();
            string message = String.Empty;
            try
            {
                ListDictionary templateValues = new ListDictionary();
                templateValues.Add("<%=ModuleName%>", "Contacts");
                templateValues.Add("<%=Key%>", "Contact Name");
                templateValues.Add("<%=Value%>", receivername);
                C3App.App_Code.Notification.Notify("Contacts", contactID, 1, touser, 2, templateValues);
                message = "Notification Success </br></br> <p> Mail has been successfully sent to <b> " + receivername + "</b></p>";
            }
            catch (Exception ex)
            {
                message = "Notification Unsuccess </br></br> <p> <b>Problem is : </b> " + ex.InnerException.Message.ToString() + "</p>";
            }

            MessageLiteral.Text = message;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);


            Session.Remove("ReceiverName");
            Session.Remove("ReceiverEmail");
            Session.Remove("ContactName");
        }

        protected void NotifyCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            Session["AssignedTo"] = AssaigendToDropDownList.SelectedValue;
        }

        protected void MeetingsInvitedGridView_Init(object sender, EventArgs e)
        {
            MeetingsInvitedGridView.DataSourceID = MeetingInviteeObjectDataSource.ID;
        }

        #endregion


    }
}
