using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;
using C3App.App_Code;

namespace C3App.Opportunities
{
    public partial class Opportunities : PageBase
    {
        #region Initialize
        OpportunityBL opportunityBL = new OpportunityBL();
        AccountBL accountBL = new AccountBL();
        UserBL userBL = new UserBL();
        //CampaignBL campaignBL = new CampaignBL();
        //private DropDownList AccountsDropDownList;
        private DropDownList OpportunityTypesDropDownList;
        private DropDownList LeadSourcesDropDownList;
        private DropDownList TeamsDropDownList;
        private DropDownList AssignedToDropDownList;
        private DropDownList CurrenciesDropDownList;
        private DropDownList SalesStagesDropDownList;
        private DropDownList CampaignNamesDropDownList;
        //private long OpportunityID;
        #endregion
        #region Page property
        protected void Page_Load(object sender, EventArgs e)
        {

            //Page.Validate();

            try
            {



                if (Request.QueryString["ShowPanel"] != null)
                {
                    if ((!IsPostBack))
                    {
                        Session.Remove("OpportunityID");
                        CalenderLinkButton.Visible = false;
                        EditLinkButton .Visible = false;
                        DeleteLinkButton.Visible = false;
                        SendMailLinkButton.Visible = false;

                    }
                }

                if (Session["OpportunityID"] != null)
                {

                    long OpportunityID = Convert.ToInt64(Session["OpportunityID"]);

                    if (OpportunityID == 0)
                    {

                        OpportunityDetailsView.ChangeMode(DetailsViewMode.Insert);
                    }
                    else if (OpportunityID > 0)
                    {
                        OpportunityDetailsView.ChangeMode(DetailsViewMode.Edit);
                    }
                }
                else
                {
                    OpportunityDetailsView.ChangeMode(DetailsViewMode.Insert);
                }
                //OpportunityID = Convert.ToInt32(Session["OpportunityID"]);
                //if (OpportunityID == 0)
                //{
                //    OpportunityDetailsView.ChangeMode(DetailsViewMode.Insert);
                //}

            }
            catch (Exception ex)
            {

                throw ex;
            }
            // SearchTextBox.TextChanged += new System.EventHandler(this.SearchTextBox_TextChanged);
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            OpportunityDetailsView.EnableDynamicData(typeof(Opportunity));

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
            ExceptionUtility.LogException(exc, "OpportunityPage");
            ExceptionUtility.NotifySystemOps(exc, "OpportunityPage");

            //Clear the error from the server
            Server.ClearError();
        }
        #endregion
        //protected void AccountsDropDownList_Init(object sender, EventArgs e)
        //{
        //    AccountsDropDownList = sender as DropDownList;
        //    AccountsDropDownList.Items.Add(new ListItem("None", "-1"));



        //}
        #region DropDown Init
        protected void OpportunityTypesDropDownList_Init(object sender, EventArgs e)
        {
            OpportunityTypesDropDownList = sender as DropDownList;
            OpportunityTypesDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        protected void LeadSourcesDropDownList_Init(object sender, EventArgs e)
        {
            LeadSourcesDropDownList = sender as DropDownList;
            LeadSourcesDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        protected void TeamsDropDownList_Init(object sender, EventArgs e)
        {
            TeamsDropDownList = sender as DropDownList;
            TeamsDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        protected void AssignedToDropDownList_Init(object sender, EventArgs e)
        {
            AssignedToDropDownList = sender as DropDownList;
            AssignedToDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        protected void CurrenciesDropDownList_Init(object sender, EventArgs e)
        {
            CurrenciesDropDownList = sender as DropDownList;
            //CurrenciesDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        protected void SalesStagesDropDownList_Init(object sender, EventArgs e)
        {
            SalesStagesDropDownList = sender as DropDownList;
            SalesStagesDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        protected void CampaignNamesDropDownList_Init(object sender, EventArgs e)
        {
            CampaignNamesDropDownList = sender as DropDownList;
            CampaignNamesDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        #endregion



        //protected void UpdateButton1_Click(object sender, EventArgs e)
        //{
        //    OpportunityDetailsView.ChangeMode(DetailsViewMode.Edit);
        //    OpportunityDetailsView.AutoGenerateEditButton = true;
        //    DeleteLinkButton.Visible = false;
        //    UpdateButton.Visible = false;
        //}

        //protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        //{
        //    string search = SearchTextBox.Text;
        //    opportunityBL.SearchOpportunities(search);
        //    this.OpportunityGridView.DataBind();
        //    this.MiniOpportunityFormView.DataBind();
        //    this.MiniMoreDetailsView.DataBind();
        //    upListView.Update();
        //    miniDetails.Update();
        //    //SearchopportunityView.Update();

        //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);

        //}

        #region Inserting && Updating
        protected void OpportunityDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            long accountID = Convert.ToInt64(Session["AccountID"]);
            CheckBox NotifyCheckBox = OpportunityDetailsView.FindControl("NotifyCheckBox") as CheckBox;
            if (NotifyCheckBox.Checked)
            {
                Session["NotifyUser"] = 1;
            }
            else
            {
                Session["NotifyUser"] = 2;
            }

            //if (Convert.ToInt32(AccountsDropDownList.SelectedValue) == -1) { e.Values["AccountID"] = null; }
            //else
            //{
            //    e.Values["AccountID"] = AccountsDropDownList.SelectedValue;
            //}
            e.Values["AccountID"] = accountID;

            if (Convert.ToInt32(OpportunityTypesDropDownList.SelectedValue) == -1) { e.Values["OpportunityTypeID"] = null; }
            else
            {
                e.Values["OpportunityTypeID"] = OpportunityTypesDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(LeadSourcesDropDownList.SelectedValue) == -1) { e.Values["LeadSourceID"] = null; }
            else
            {
                e.Values["LeadSourceID"] = LeadSourcesDropDownList.SelectedValue;
            } if (Convert.ToInt32(TeamsDropDownList.SelectedValue) == -1) { e.Values["TeamID"] = null; }
            else
            {
                e.Values["TeamID"] = TeamsDropDownList.SelectedValue;
            } if (Convert.ToInt32(AssignedToDropDownList.SelectedValue) == -1) { e.Values["AssignedUserID"] = null; }
            else
            {
                e.Values["AssignedUserID"] = AssignedToDropDownList.SelectedValue;
            }

            e.Values["CurrencyID"] = CurrenciesDropDownList.SelectedValue;
            if (Convert.ToInt32(SalesStagesDropDownList.SelectedValue) == -1) { e.Values["SalesStageID"] = null; }
            else
            {
                e.Values["SalesStageID"] = SalesStagesDropDownList.SelectedValue;
            } if (Convert.ToInt32(CampaignNamesDropDownList.SelectedValue) == -1) { e.Values["CampaignID"] = null; }
            else
            {
                e.Values["CampaignID"] = CampaignNamesDropDownList.SelectedValue;
            }
            e.Values["CompanyID"] = companyid;
            e.Values["CreatedBy"] = userid;


        }

        protected void OpportunityDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

            long accountID = Convert.ToInt64(Session["AccountID"]);

            if (accountID != 0)
            {
                e.NewValues["AccountID"] = accountID;
            }

            if (Convert.ToInt32(OpportunityTypesDropDownList.SelectedValue) == -1) { e.NewValues["OpportunityTypeID"] = null; }
            else
            {
                e.NewValues["OpportunityTypeID"] = OpportunityTypesDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(LeadSourcesDropDownList.SelectedValue) == -1) { e.NewValues["LeadSourceID"] = null; }
            else
            {
                e.NewValues["LeadSourceID"] = LeadSourcesDropDownList.SelectedValue;
            } if (Convert.ToInt32(TeamsDropDownList.SelectedValue) == -1) { e.NewValues["TeamID"] = null; }
            else
            {
                e.NewValues["TeamID"] = TeamsDropDownList.SelectedValue;
            } if (Convert.ToInt32(AssignedToDropDownList.SelectedValue) == -1) { e.NewValues["AssignedUserID"] = null; }
            else
            {
                e.NewValues["AssignedUserID"] = AssignedToDropDownList.SelectedValue;
            }

            e.NewValues["CurrencyID"] = CurrenciesDropDownList.SelectedValue;
            if (Convert.ToInt32(SalesStagesDropDownList.SelectedValue) == -1) { e.NewValues["SalesStageID"] = null; }
            else
            {
                e.NewValues["SalesStageID"] = SalesStagesDropDownList.SelectedValue;
            } if (Convert.ToInt32(CampaignNamesDropDownList.SelectedValue) == -1) { e.NewValues["CampaignID"] = null; }
            else
            {
                e.NewValues["CampaignID"] = CampaignNamesDropDownList.SelectedValue;
            }
            e.NewValues["ModifiedBy"] = userid;
            e.NewValues["ModifiedTime"] = DateTime.Now;
        }

        protected void OpportunityDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            string userEmail = null;
            string userName = null;
            long opportunityID = Convert.ToInt64(Session["InsertOpportunityID"]);
            int Notifyuser = (int)Session["NotifyUser"];
            if (Notifyuser == 1)
            {
                long assignedUserID = Convert.ToInt64(e.Values["AssignedUserID"]);
                //string useremail = opportunityBL.GetEmailByUserid(userid);
                IEnumerable<DAL.User> userdetails = userBL.GetUsersByID(assignedUserID);
                foreach (var user in userdetails)
                {
                    userName = user.FirstName + " " + user.LastName;
                    userEmail = user.PrimaryEmail;
                }
                string touser = userEmail;
                string receivername = e.Values["Name"].ToString();
                string subject = "Opportunity Notification";
                string body = "Mr/Mrs" + " " + userName + "," + "<br/>You have been asssigned to deal with " + receivername + " ";
                App_Code.Notification.SendEmail(touser, subject, body);
                Session["NotifyUser"] = 0;
            }
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
                if (opportunityID > 0)
                {
                    this.OpportunityGridView.DataBind();
                    this.MiniOpportunityFormView.DataBind();
                    this.MiniMoreDetailsView.DataBind();
                    upListView.Update();
                    miniDetails.Update();
                    //SearchopportunityView.Update();
                    Literal1.Text = "Successfully Saved";
                    Label1.Text = "Opportunity has been successfully Saved";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                }
                //else
                //{
                //    Literal1.Text = "Not Saved";
                //    Label1.Text = "!!!Opportunity not saved, Check the inputs";
                //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

            }

        }
        protected void OpportunityDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long opportunityID;
            opportunityID = Convert.ToInt64(e.ReturnValue);
            Session["InsertOpportunityID"] = opportunityID;

        }

        protected void OpportunityDetailsObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long opportunityID;
            opportunityID = Convert.ToInt64(e.ReturnValue);
            Session["UpdateOpportunityID"] = opportunityID;

        }

        protected void OpportunityDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            long opportunityID = Convert.ToInt64(Session["UpdateOpportunityID"]);
            if (opportunityID > 0)
            {
                this.OpportunityGridView.DataBind();
                this.MiniOpportunityFormView.DataBind();
                this.MiniMoreDetailsView.DataBind();
                upListView.Update();
                miniDetails.Update();
                //SearchopportunityView.Update();
                Session["OpportunityID"] = 0;
                OpportunityDetailsView.DataBind();
                Literal1.Text = "Successfully Saved";
                Label1.Text = "Opportunity has been successfully Saved";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
            else
            {
                Session["OpportunityID"] = 0;
                OpportunityDetailsView.DataBind();
                Literal1.Text = "Not Saved";
                Label1.Text = "!!!Opportunity not saved, Check the inputs";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

            }
        }

        protected void OpportunityDetailsView_ItemCommand(Object sender,
                                                                   DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Literal1.Text = "Changes Discarded !";
                Label1.Text = " Your changes have been discarded.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ShowAlertModal();", true);
                Session["OpportunityID"] = 0;
                OpportunityDetailsView.DataBind();
                OpportunityDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }
        #endregion
        #region Select account from modal
        protected void OpportunitySelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["OpportunityID"] = e.CommandArgument.ToString();
            CalenderLinkButton.Visible = true;
            if (CheckEdit() != false)
            EditLinkButton .Visible = true;
            if (CheckDelete() != false)
            DeleteLinkButton.Visible = true;
            SendMailLinkButton.Visible = true;
            int gindex = Convert.ToInt32(OpportunityGridView.SelectedIndex);
            if (gindex > -1)
            {

                LinkButton nlbtn = OpportunityGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                nlbtn.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            lbtn.CssClass = "active";
            miniDetails.Update();
        }
        public void AccountSelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["AccountID"] = e.CommandArgument.ToString();
            int accountID = Convert.ToInt32(Session["AccountID"]);
            IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(accountID);


            foreach (var account in accounts)
            {
                string accountName = account.Name;

                TextBox AccountName = OpportunityDetailsView.FindControl("AccountNameTextBox") as TextBox;
                AccountName.Text = accountName;

            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);


        }
        protected void SelectButton_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            if (btn.CommandArgument.ToString() == "Accounts")
            {
                //AccountPanel.Visible = true;
                AccountGridView.Visible = true;
                AccountSearchPanel.Visible = true;
            }

        }
        #endregion
        #region Tab Button
        protected void OpportunityInsertButton_Click(object sender, EventArgs e)
        {

            LinkButton btn = sender as LinkButton;

            string insert = btn.CommandArgument.ToString();
            Session["OpportunityID"] = 0;

            //Label1.Text = Convert.ToString(Session["OpportunityID"]);

            OpportunityDetailsView.ChangeMode(DetailsViewMode.Insert);
            //OpportunityDetailsView.AutoGenerateInsertButton = false;
        }
        protected void OpportunityEditButton_Click(object sender, EventArgs e)
        {
            OpportunityInsertLinkButton.Text = "Opportuinity Details";
            message.Text = Convert.ToString(Session["OpportunityID"]);
            OpportunityDetailsView.ChangeMode(DetailsViewMode.Edit);
            //OpportunityDetailsView.AutoGenerateEditButton = true;
        }
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            Session["OpportunityID"] = 0;
            CalenderLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            SendMailLinkButton.Visible = false;
            OpportunityGridView.DataBind();
            OpportunityGridView.SelectedIndex = -1;
            upListView.Update();
            MiniOpportunityFormView.DataBind();
            miniDetails.Update();
        }
        #endregion






        //protected void CreateAccountLinkButton_Click(object sender, EventArgs e)
        //{
        //    ModalAccountDetailsView.Visible = true;
        //    // ModalAccountDetailsView.ChangeMode(DetailsViewMode.Insert);
        //    //ModalAccountDetailsView.AutoGenerateInsertButton = true;
        //    //CreateAccountLinkButton.Visible = false;
        //}
        //protected void AccountCreateDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        //{
        //    e.Values["CreatedTime"] = DateTime.Now;
        //    e.Values["ModifiedTime"] = DateTime.Now;
        //    e.Values["CompanyID"] = 8;
        //}

        //protected void AccountCreateDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        //{
        //    AccountCreateDetailsView.Visible = false;
        //    this.AccountGridView.DataBind();
        //    AccountList.Update();

        //}

        //protected void ContactCreateDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "Cancel")
        //    {

        //    }
        //}

        //protected void AccountSearchTextBox_TextChanged(object sender, EventArgs e)
        //{
        //    string search = SearchTextBox.Text;
        //    accountBL.SearchAccount(search);
        //    this.AccountGridView.DataBind();

        //}

        //protected void accountSearchButton_Click(object sender, EventArgs e)
        //{
        //    string search = SearchTextBox.Text;
        //    accountBL.SearchAccount(search);
        //    this.AccountGridView.DataBind();


        //}

        //protected void ModalAccountDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        //{
        //    e.Values["CreatedTime"] = DateTime.Now;
        //    e.Values["ModifiedTime"] = DateTime.Now;
        //    e.Values["CompanyID"] = 8;

        //}
        //protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        //{
        //    e.Values["CreatedTime"] = DateTime.Now;
        //    e.Values["ModifiedTime"] = DateTime.Now;
        //    e.Values["CompanyID"] = 8;
        //}

        //protected void AccountCreateDetailsView_ItemInserting1(object sender, DetailsViewInsertEventArgs e)
        //{

        //    e.Values["CreatedTime"] = DateTime.Now;
        //    e.Values["ModifiedTime"] = DateTime.Now;
        //    e.Values["CompanyID"] = 8;
        //}
        ////protected void AccountCreateDetailsView_ItemInserted1(object sender, DetailsViewInsertedEventArgs e)
        ////{
        ////    AccountCreateDetailsView.Visible = false;
        ////    this.AccountGridView.DataBind();
        ////    AccountList.Update();
        ////}


        //protected void CreateAccount_Click(object sender, EventArgs e)
        //{
        //    //AccountCreateDetailsView.Visible = true;
        //    //AccountCreateDetailsView.AutoGenerateInsertButton = true;
        //    // CreateAccountLinkButton.Visible = false;
        //}


        //protected void AccountCreateDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        //{
        //    e.Values["CreatedTime"] = DateTime.Now;
        //    e.Values["ModifiedTime"] = DateTime.Now;
        //    e.Values["CompanyID"] = 8;

        //}

        //protected void AccountCreateDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        //{
        //    //AccountCreateDetailsView.Visible = false;
        //    this.AccountGridView.DataBind();
        //    AccountList.Update();

        //}



        //protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        //{
        //    int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

        //    e.Values["CreatedTime"] = DateTime.Now;
        //    e.Values["ModifiedTime"] = DateTime.Now;
        //    e.Values["CompanyID"] = companyid;
        //}







        #region Searching && Deleting
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            CalenderLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            SendMailLinkButton.Visible = false;
            OpportunityGridView.DataSourceID = opportunitySearchObjectDataSource.ID;
            OpportunityGridView.DataBind();
            this.OpportunityGridView.SelectedIndex = -1;
            this.MiniOpportunityFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();

        }
        protected void SearchAllButton_Click(object sender, EventArgs e)
        {
            CalenderLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            SendMailLinkButton.Visible = false;
            OpportunityGridView.DataSourceID = OpportunityListObjectDataSource.ID;
            OpportunityGridView.DataBind();
            this.OpportunityGridView.SelectedIndex = -1;
            this.MiniOpportunityFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }
        protected void TopOpportunityButton_Click(object sender, EventArgs e)
        {
            CalenderLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            SendMailLinkButton.Visible = false;
            OpportunityGridView.DataSourceID = TopOpportunityObjectDataSource.ID;
            OpportunityGridView.DataBind();
            this.OpportunityGridView.SelectedIndex = -1;
            this.MiniOpportunityFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }
        protected void ProspectingOpportunityButton_Click(object sender, EventArgs e)
        {
            CalenderLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            SendMailLinkButton.Visible = false;
            OpportunityGridView.DataSourceID = ProspectingObjectDataSource.ID;
            OpportunityGridView.DataBind();
            this.OpportunityGridView.SelectedIndex = -1;
            this.MiniOpportunityFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();
        }
        protected void OpportunityDeleteButton_Click(object sender, EventArgs e)
        {
            long OpportunityID = Convert.ToInt64(Session["OpportunityID"]);
            opportunityBL.DeleteById(OpportunityID);
            this.OpportunityGridView.DataBind();
            this.OpportunityGridView.SelectedIndex = -1;
            this.MiniOpportunityFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            upListView.Update();
            miniDetails.Update();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
        }

        #endregion 

        #region Account Modal
        protected void AccountDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.Values["CreatedBy"] = Convert.ToInt64(Session["UserID"]);
        }
        protected void AccountDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            long accountId = Convert.ToInt64(Session["AccountID"]);

            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Insert failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "avs";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;
            }
            else
            {
                if (accountId > 0)
                {
                    AccountGridView.DataBind();
                    string accountName = e.Values["Name"].ToString();
                    TextBox AccountName = OpportunityDetailsView.FindControl("AccountNameTextBox") as TextBox;
                    AccountName.Text = accountName;
                    AccountList.Update();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script",
                                                            "CloseModals(['BodyContent_ModalPanel1','BodyContent_ModalPanel291']);",
                                                            true);
                }
            }
        }

        protected void AccountsDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long accountID;
            accountID = Convert.ToInt64(e.ReturnValue);
            Session["AccountID"] = accountID;
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

        #region Notify User
        protected void AssignedToDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label NotifyLabel = OpportunityDetailsView.FindControl("NotifyLabel") as Label;
            CheckBox NotifyCheckBox = OpportunityDetailsView.FindControl("NotifyCheckBox") as CheckBox;
            if (AssignedToDropDownList.SelectedItem.Text != "None")
            {

                NotifyLabel.Visible = true;
                NotifyCheckBox.Visible = true;
            }
            else
            {
                NotifyLabel.Visible = false;
                NotifyCheckBox.Visible = false;
            }

        }
        protected void SendMailButton_Click(object sender, EventArgs e)
        {
            string userEmail = null;
            string userName = null;
            long assignedUserID = 0;
            string reciverName = string.Empty;
            long OpportunityID = Convert.ToInt64(Session["OpportunityID"]);
            var opportunities = opportunityBL.OpportunityByID(OpportunityID);
            foreach(var opportunity in opportunities)
            {
                if (opportunity.AssignedUserID!= null)
                {
                    assignedUserID = (long)opportunity.AssignedUserID;
                    reciverName = opportunity.Name;
                }
            }
            IEnumerable<DAL.User> userdetails = userBL.GetUsersByID(assignedUserID);
            if (userdetails.Count() > 0)
            {
                foreach (var user in userdetails)
                {
                    userName = user.FirstName + " " + user.LastName;
                    userEmail = user.PrimaryEmail;
                }
                string touser = userEmail;
                //string receivername = e.Values["Name"].ToString();
                string subject = "Opportunity Notification";
                string body = "Mr/Mrs" + " " + userName + "," + "<br/>You have been asssigned to deal with " + " " + reciverName;
                App_Code.Notification.SendEmail(touser, subject, body);
                Literal1.Text = "Successfully Send";
                Label1.Text = "A mail has been successfully Send to Assigned user";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
            else
            {
                Label1.Text = "No user is Assigned";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }

        }
        #endregion

        //protected void Button1_Click(object sender, EventArgs e)
        //{
        //    Response.Redirect("http://203.202.241.240:8088/requestpayment.aspx?action=1");
        //}


    }


}