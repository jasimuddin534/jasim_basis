using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.App_Code;
using C3App.BLL;
using C3App.DAL;

namespace C3App.Leads
{
    public partial class Leads : PageBase
    {
        #region Initializing....
        LeadBL leadBL = new LeadBL();
        OpportunityBL opportunityBL = new OpportunityBL();
        ContactBL contactBL = new ContactBL();
        AccountBL accountBL = new AccountBL();
        private DropDownList leadSourcesDropDownList;
        private DropDownList accountsDropDownList;
        private DropDownList teamsDropDownList;
        private DropDownList assignedToUsersDropDownList;
        private DropDownList leadStatusesDropDownList;
        private DropDownList PrimaryCountryDropDownList;
        private DropDownList AltCountryDropDownList;
        #endregion

        #region Page Functions
        protected void Page_Load(object sender, EventArgs e)
        {
            //Page.Validate();

            if (Request.QueryString["ShowPanel"] != null)
            {
                if ((!IsPostBack))
                {
                    Session.Remove("EditLeadID");
                    MeetingSummaryLinkButton.Visible = false;
                    EditLinkButton .Visible = false;
                    DeleteLinkButton.Visible = false;
                    ConvertLinkButton.Visible = false;
                }
            }
            int leadID = Convert.ToInt32(Session["EditLeadID"]);
            if (leadID == 0)
            {
                LeadsDetailsView.ChangeMode(DetailsViewMode.Insert);
                // LeadsDetailsView.AutoGenerateInsertButton = true;
            }
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            LeadsDetailsView.EnableDynamicData(typeof(Lead));
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
            ExceptionUtility.LogException(exc, "LeadsPage");
            ExceptionUtility.NotifySystemOps(exc, "LeadPage");

            //Clear the error from the server
            Server.ClearError();
        }
        #endregion
        //protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        //{
        //    string search = SearchTextBox.Text;
        //    leadBL.SearchLeads(search);
        //    this.LeadsGridView.DataBind();
        //    this.MiniLeadsFormView.DataBind();
        //    this.MiniMoreLeadsDetailsView.DataBind();
        //    upListView.Update();
        //    miniDetails.Update();
        //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);


        //}
        #region Dropdown Initialization..
        protected void leadSourcesDropDownList_Init(object sender, EventArgs e)

        {
            leadSourcesDropDownList = sender as DropDownList;
            leadSourcesDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        protected void AccountsDropDownList_Init(object sender, EventArgs e)
        {
            accountsDropDownList = sender as DropDownList;
            accountsDropDownList.Items.Add(new ListItem("None", "-1"));
        }
        protected void TeamsDropDownList_Init(object sender, EventArgs e)
        {
            teamsDropDownList = sender as DropDownList;
            teamsDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        protected void AssignedToUsersDropDownList_Init(object sender, EventArgs e)
        {
            assignedToUsersDropDownList = sender as DropDownList;
            assignedToUsersDropDownList.Items.Add(new ListItem("None", "-1"));


        }
        protected void LeadStatusesDropDownList_Init(object sender, EventArgs e)
        {
            leadStatusesDropDownList = sender as DropDownList;
            leadStatusesDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        protected void PrimaryCountryDropDownList_Init(object sender, EventArgs e)
        {
            PrimaryCountryDropDownList = sender as DropDownList;
            PrimaryCountryDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        protected void AltCountryDropDownList_Init(object sender, EventArgs e)
        {
            AltCountryDropDownList = sender as DropDownList;
            AltCountryDropDownList.Items.Add(new ListItem("None", "-1"));

        }
        #endregion

        #region select Contact/Account from modal... 
        public void SelectContactLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["ContactID"] = e.CommandArgument.ToString();
            int contactID = Convert.ToInt32(Session["ContactID"]);
            

            IEnumerable<DAL.Contact> contacts = contactBL.GetContactByID(contactID);
            foreach (var contact in contacts)
            {
                string firstName = contact.FirstName;
                string lastName = contact.LastName;
                Session["ContactfirstName"] = firstName;
                Session["ContactLastName"] = lastName;
                TextBox ContactName = LeadsDetailsView.FindControl("ContactNameTextBox") as TextBox;
                ContactName.Text = firstName + " " + lastName;
            }
            //GetContactInformation(contactID);

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);


        }

        private void GetContactInformation(int contactId)
        {
            var contact = contactBL.GetContactByID(contactId).FirstOrDefault();
            
        }

        public void SelectAccountLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["AccountID"] = e.CommandArgument.ToString();
            Int32 accountID = Convert.ToInt32(Session["AccountID"]);
            IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(accountID);


            foreach (var account in accounts)
            {
                string accountName = account.Name;
                Session["AccountName"] = accountName;
                TextBox AccountName = LeadsDetailsView.FindControl("AccountNameTextBox") as TextBox;

                AccountName.Text = accountName;

            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);


        }
        #endregion
        //protected void UpdateButton1_Click(object sender, EventArgs e)
        //{
        //    LeadsDetailsView.ChangeMode(DetailsViewMode.Edit);
        //    LeadsDetailsView.AutoGenerateEditButton = true;
        //    DeleteLinkButton.Visible = false;
        //    UpdateButton.Visible = false;
        //}


         #region select lead in viewmode of gridview...
        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            string arguments = Convert.ToString(e.CommandArgument);
            string[] arg = arguments.Split(';');

            Session["EditLeadID"] = Convert.ToInt64(arg[0]);
            long a = Convert.ToInt64(Session["EditLeadID"]);
            Session["EditContactID"] = Convert.ToInt64(arg[1]);
            long b = Convert.ToInt64(Session["EditContactID"]);
            int gindex = Convert.ToInt32(LeadsGridView.SelectedIndex);
            if (gindex > -1)
            {

                LinkButton nlbtn = LeadsGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                nlbtn.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            lbtn.CssClass = "active";
            miniDetails.Update();
            MeetingSummaryLinkButton.Visible = true;
            if (CheckEdit() != false)
                EditLinkButton.Visible = true;
            if (CheckDelete() != false)
                DeleteLinkButton.Visible = true;
            ConvertLinkButton.Visible = true;
            // Label2.Text = e.CommandArgument.ToString();
        }
         #endregion

        protected void ContactSelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            // Label2.Text = "dffd"
            // message.Text = "You chose: " + e.CommandName + " Item " + e.CommandArgument;
            Session["ContactID"] = e.CommandArgument.ToString();
            // Label2.Text = e.CommandArgument.ToString();
        }

        #region Tab Buttons..
        protected void LeadEditButton_Click(object sender, EventArgs e)
        {
            //DetailsViewlist.Update();
            LeadInsertButton.Text = "Lead Details";
            message.Text = Convert.ToString(Session["EditLeadID"]);
            LeadsDetailsView.ChangeMode(DetailsViewMode.Edit);
            //LeadsDetailsView.AutoGenerateEditButton = true;

        }
        protected void LeadInsertButton_Click(object sender, EventArgs e)
        {
            //DetailsViewlist.Update();
            LinkButton btn = sender as LinkButton;
            LeadInsertButton.Text = "Create Lead";
            string insert = btn.CommandArgument.ToString();
            Session["EditLeadID"] = 0;
            LeadsDetailsView.ChangeMode(DetailsViewMode.Insert);
            LeadsDetailsView.DataBind();
            // LeadsDetailsView.AutoGenerateInsertButton = true;
        }
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            Session["EditLeadID"] = 0;
            MeetingSummaryLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            LeadsGridView.DataBind();
            LeadsGridView.SelectedIndex = -1;
            upListView.Update();
            MiniLeadsFormView.DataBind();
            miniDetails.Update();


        }

        #endregion

        #region Lead Inserting
        public void LeadDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            long contactID = Convert.ToInt64(Session["ContactID"]);
            long accountID = Convert.ToInt64(Session["AccountID"]);
            string firstName = Convert.ToString(Session["ContactfirstName"]);
            string lastName = Convert.ToString(Session["ContactLastName"]);
            e.Values["FirstName"] = firstName;
            e.Values["LastName"] = lastName;
            if (Convert.ToInt32(leadSourcesDropDownList.SelectedValue) == -1) { e.Values["LeadSourceID"] = null; }
            else
            {
                e.Values["LeadSourceID"] = leadSourcesDropDownList.SelectedValue;
            }
            e.Values["ContactID"] = contactID;
            if (accountID != 0)
            {
                e.Values["AccountID"] = accountID;

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
            if (Convert.ToInt32(leadStatusesDropDownList.SelectedValue) == -1) { e.Values["LeadStatusID"] = null; }
            else
            {
                e.Values["LeadStatusID"] = leadStatusesDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(PrimaryCountryDropDownList.SelectedValue) == -1) { e.Values["PrimaryCountry"] = null; }
            else
            {
                e.Values["PrimaryCountry"] = PrimaryCountryDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(AltCountryDropDownList.SelectedValue) == -1) { e.Values["AlternateCountry"] = null; }
            else
            {
                e.Values["AlternateCountry"] = AltCountryDropDownList.SelectedValue;
            }
            e.Values["CompanyID"] = companyid;
            e.Values["CreatedBy"] = userid;

        }
        protected void LeadsDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            long leadId = Convert.ToInt64(Session["InsertleadID"]);
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
                if (leadId > 0)
                {
                    this.LeadsGridView.DataBind();
                    this.MiniLeadsFormView.DataBind();
                    this.MiniMoreLeadsDetailsView.DataBind();
                    upListView.Update();
                    miniDetails.Update();
                    Literal1.Text = "Successfully Saved";
                    Label1.Text = "Lead has been successfully Saved";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                }
                
            }
            //Session.Remove("FirstName");
            //Session.Remove("LastName");

        }
        protected void LeadsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long leadID;
            leadID = Convert.ToInt64(e.ReturnValue);
            Session["InsertleadID"] = leadID;
        }
        #endregion

        #region Lead updating...
        protected void LeadDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            long contactID = Convert.ToInt64(Session["ContactID"]);
            long accountID = Convert.ToInt64(Session["AccountID"]);
            string firstName = Convert.ToString(Session["ContactfirstName"]);
            string lastName = Convert.ToString(Session["ContactLastName"]);
            //string accountName = Convert.ToString(Session["AccountName"]);
            if (firstName != "")
            {
                e.NewValues["FirstName"] = firstName;
            }
            if (lastName != "")
            {
                e.NewValues["LastName"] = lastName;
            }
            // e.NewValues["AccountName"] = accountName;
            if (contactID != 0)
            {
                e.NewValues["ContactID"] = contactID;
            }
            if (accountID != 0)
            {
                e.NewValues["AccountID"] = accountID;
            }

            if (Convert.ToInt32(leadSourcesDropDownList.SelectedValue) == -1) { e.NewValues["LeadSourceID"] = null; }
            else
            {
                e.NewValues["LeadSourceID"] = leadSourcesDropDownList.SelectedValue;
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
            if (Convert.ToInt32(leadStatusesDropDownList.SelectedValue) == -1) { e.NewValues["LeadStatusID"] = null; }
            else
            {
                e.NewValues["LeadStatusID"] = leadStatusesDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(PrimaryCountryDropDownList.SelectedValue) == -1) { e.NewValues["PrimaryCountry"] = null; }
            else
            {
                e.NewValues["PrimaryCountry"] = PrimaryCountryDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(AltCountryDropDownList.SelectedValue) == -1) { e.NewValues["AlternateCountry"] = null; }
            else
            {
                e.NewValues["AlternateCountry"] = AltCountryDropDownList.SelectedValue;
            }
            e.NewValues["ModifiedBy"] = userid;
            e.NewValues["ModifiedTime"] = DateTime.Now;

        }
        protected void LeadsDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            long leadId = Convert.ToInt64(Session["UpdateleadID"]);
            if (leadId > 0)
            {
                this.LeadsGridView.DataBind();
                this.MiniLeadsFormView.DataBind();
                this.MiniMoreLeadsDetailsView.DataBind();
                upListView.Update();
                miniDetails.Update();
                Session["ContactfirstName"] = "";
                Session["ContactLastName"] = "";
                Session["EditLeadID"] = 0;
                LeadsDetailsView.DataBind();
                Literal1.Text = "Successfully Saved";
                Label1.Text = "Lead has been successfully Saved";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
            else
            {
                Session["EditLeadID"] = 0;
                LeadsDetailsView.DataBind();
                Literal1.Text = "Not Saved";
                Label1.Text = "!!!Lead not saved, Check the inputs";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }

        }
        protected void LeadsObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long leadID;
            leadID = Convert.ToInt64(e.ReturnValue);
            Session["UpdateleadID"] = leadID;
        }
        protected void LeadsDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Literal1.Text = "Changes Discarded !";
                Label1.Text = " Your changes have been discarded.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ShowAlertModal();", true);
                Session["EditLeadID"] = 0;
                LeadsDetailsView.DataBind();
                LeadsDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }

        #endregion


        #region Deleting and converting...
        protected void deleteButton1_Click(object sender, EventArgs e)
        {
            long leadID = Convert.ToInt32(Session["EditLeadID"]);
            leadBL.DeleteLeadById(leadID);
            this.LeadsGridView.DataBind();
            this.MiniLeadsFormView.DataBind();
            this.MiniMoreLeadsDetailsView.DataBind();
            upListView.Update();
            miniDetails.Update();
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
        }
        protected void ImportButton_Click(object sender, EventArgs e)
        {
            long count = 0;
            string firstName=null;
            string lastname=null;
            StreamReader Sr =new StreamReader(@"C:\Users\rizwanul.islam\My Projects\Default Collections\C3\C3App\C3App\LeadImport.csv");
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            // System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand();
            string s;
            bool passedFirstline = false;
            while (!Sr.EndOfStream)
            {
                s = Sr.ReadLine();
                string[] value = s.Split(',');
                if (passedFirstline)
                {
                    DAL.Contact contact=new DAL.Contact();
                    if (value[0]!=null)
                    {
                        firstName = value[0];
                        contact.FirstName = firstName;
                    }
                    else
                    {
                        contact.FirstName = "None";
                    }
                    if (value[1] != null)
                    {
                        lastname = value[1];
                        contact.LastName = lastname;
                    }
                    else
                    {
                        contact.LastName = "None";
                    }
                    if (value[2] != null)
                    {
                        contact.PrimaryEmail = value[2];
                    }
                    else
                    {
                        contact.PrimaryEmail = "None";
                    }
                    contact.CompanyID = Convert.ToInt32(Session["CompanyID"]);
                    contact.CreatedBy = Convert.ToInt64(Session["UserID"]);
                    contact.CreatedTime = DateTime.Now;
                    contact.ModifiedTime = DateTime.Now;
                    Int64 contactID = contactBL.InsertContact(contact);
                    if (contactID!=null)
                    {
                        Lead lead=new Lead();
                        lead.ContactID = contactID;
                        lead.FirstName = firstName;
                        lead.LastName = lastname;
                        lead.CompanyID = Convert.ToInt32(Session["CompanyID"]);
                        lead.CreatedBy = Convert.ToInt64(Session["UserID"]);
                        lead.CreatedTime = DateTime.Now;
                        lead.ModifiedTime = DateTime.Now;
                        Int64 leadID = leadBL.InsertLeads(lead);
                        if (leadID!=0)
                        {
                            count++;
                        }
                    }
                }
                else
                {
                    passedFirstline = true;
                }

            }
            Literal1.Text = "Successfully Imported";
            Label1.Text = count +" "+"Data has been successfully imported to lead";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
        }
        protected void ConvertButton_Click(object sender, EventArgs e)
        {
            long opportunityID;
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            long userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            long leadID = Convert.ToInt32(Session["EditLeadID"]);
            var leads = leadBL.CheckConvertedLeadById(leadID);

            if (leads.Count() > 0)
            {
                var lead = leads.FirstOrDefault();
                string firstName = lead.FirstName;
                string lastName = lead.LastName;
                string accountName = lead.AccountName;
                Session["ContactfirstName"] = firstName;
                Session["ContactLastName"] = lastName;
                Opportunity opportunity = new Opportunity();
                opportunity.Name = accountName;
                opportunity.AccountID = Convert.ToInt64(lead.AccountID);
                opportunity.TeamID = lead.TeamID;
                opportunity.AssignedUserID = lead.AssignedUserID;
                opportunity.LeadSourceID = lead.LeadSourceID;
                opportunity.CurrencyID = 1;
                opportunity.CreatedTime = DateTime.Now;
                opportunity.ModifiedTime = DateTime.Now;
                opportunity.CompanyID = companyid;
                opportunity.CreatedBy = userid;

                bool exists = opportunityBL.CheckOppportintyName(opportunity);
                if (exists == true)
                {
                    Label1.Text = (String.Format(
                        "Opportunity Name {0} is already exist",
                        opportunity.Name
                        ));
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

                }
                else
                {


                    opportunityID = opportunityBL.leadToOpportunityInsert(opportunity);
                    Session["OpportunityID"] = opportunityID;

                    opportunityID = Convert.ToInt64(Session["OpportunityID"]);
                    string firstname = Session["ContactfirstName"].ToString();
                    string lastname = Session["ContactLastName"].ToString();
                    string name = firstname + " " + lastname;
                    //update lead of newly converted opportunity
                    //Lead lead1=new Lead();
                    //lead1.LeadID = leadID;
                    //lead1.OpportunityID = Convert.ToInt64(opportunityID);
                    //lead1.OpportunityName = firstname + " " + lastname;
                    //leadBL.UpdateLeads(lead1);
                    leadBL.UpdateConvertedLead(leadID, opportunityID, name);
                    Literal1.Text = "Convert Successfully";
                    Label1.Text = "This Lead is Convert to Opportunity Successfully";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();",
                                                            true);
                }

            }
            else
                {

                    Literal1.Text = "!!!Not converted";
                    Label1.Text = "This Lead is already converted to Opportunity";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                }


                //Session.Remove("FirstName");
                //Session.Remove("LastName");
            }
        #endregion

        //protected void CreateLinkButton_Click(object sender, EventArgs e)
        //{
        //    int button = Convert.ToInt32(Session["Select"]);
        //    if (button == 1)
        //    {
        //        AccountPanel.Visible = false;
        //        ContactPanel.Visible = true;
        //        AccountCreateDetailsView.Visible = false;
        //        ContactCreateDetailsView.Visible = true;
        //        ContactCreateDetailsView.AutoGenerateInsertButton = true;
        //    }
        //    else
        //    {
        //        ContactPanel.Visible = false;
        //        AccountPanel.Visible = true;
        //        ContactCreateDetailsView.Visible = false;
        //        AccountCreateDetailsView.Visible = true;
        //        AccountCreateDetailsView.AutoGenerateInsertButton = true;

        //    }
        //    //CreateAccountLinkButton.Visible = false;
        //}






        #region Searching funtions...
        protected void SearchAllButton_Click(object sender, EventArgs e)
        {
            SearchTextBox.Text = string.Empty;
            MeetingSummaryLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            LeadsGridView.DataSourceID = ListPanelObjectDataSource.ID;
            LeadsGridView.DataBind();
            this.LeadsGridView.SelectedIndex = -1;
            this.MiniLeadsFormView.DataBind();
            this.MiniMoreLeadsDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();           
            //ModalPopButton2.Visible = false;
            //EditLinkButton.Visible = false;
            //DeleteLinkButton.Visible = false;
            //UsersGridView.DataSourceID = UsersviewObjectDataSource.ID;
            //this.UsersGridView.DataBind();
            //this.UsersGridView.SelectedIndex = -1;
            //this.MiniUserFormView.DataBind();
            //this.MiniUserDetailsView.DataBind();
            //upListView.Update();
            //miniDetails.Update();
           
        }
        protected void SearchNewLead_Click(object sender, EventArgs e)
        {
            MeetingSummaryLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            LeadsGridView.DataSourceID = NewLeadObjectDataSource.ID;
            LeadsGridView.DataBind();
            this.LeadsGridView.SelectedIndex = -1;
            this.MiniLeadsFormView.DataBind();
            this.MiniMoreLeadsDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();           

        }
        protected void AssignedLead_Click(object sender, EventArgs e)
        {
            MeetingSummaryLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            LeadsGridView.DataSourceID = AssignedLeadsObjectDataSource.ID;
            LeadsGridView.DataBind();
            this.LeadsGridView.SelectedIndex = -1;
            this.MiniLeadsFormView.DataBind();
            this.MiniMoreLeadsDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();           

        }
        protected void ConvertedLead_Click(object sender, EventArgs e)
        {
            MeetingSummaryLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            LeadsGridView.DataSourceID = ConvertedLeadsObjectDataSource.ID;
            LeadsGridView.DataBind();
            this.LeadsGridView.SelectedIndex = -1;
            this.MiniLeadsFormView.DataBind();
            this.MiniMoreLeadsDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();  
            //aa
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            MeetingSummaryLinkButton.Visible = false;
            EditLinkButton .Visible = false;
            DeleteLinkButton.Visible = false;
            ConvertLinkButton.Visible = false;
            LeadsGridView.DataSourceID = LeadSearchObjectDataSource.ID;
            LeadsGridView.DataBind();
            this.LeadsGridView.SelectedIndex = -1;
            this.MiniLeadsFormView.DataBind();
            this.MiniMoreLeadsDetailsView.DataBind();
            miniDetails.Update();
            upListView.Update();           

        }
        # endregion
        #region Account Modal start here...
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
                if (accountId>0)
                {
                    AccountGridView.DataBind();
                    string accountName = e.Values["Name"].ToString();
                    TextBox AccountName = LeadsDetailsView.FindControl("AccountNameTextBox") as TextBox;
                    AccountName.Text = accountName;
                    AccountList.Update();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModals(['BodyContent_ModalPanel1','BodyContent_ModalPanel291']);", true);

                }

            }
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
        protected void AccountsDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long accountID;
            accountID = Convert.ToInt64(e.ReturnValue);
            Session["AccountID"] = accountID;
        }
        #endregion
        #region Contact Modal start here...
        protected void ContactDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.Values["CreatedBy"] = Convert.ToInt64(Session["UserID"]);
        }
        protected void ContactDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            long contactId = Convert.ToInt64(Session["ContactID"]);

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
                if (contactId > 0)
                {
                    ContactsGridView.DataBind();
                    string LastName = null;
                    string FirstName = e.Values["FirstName"].ToString();
                    if (e.Values["LastName"] != null)
                    {
                        string ContactLastName = e.Values["LastName"].ToString();
                        Session["ContactLastName"] = ContactLastName;
                        LastName = ContactLastName;
                    }
                    Session["ContactfirstName"] = FirstName;
                    TextBox ContactName = LeadsDetailsView.FindControl("ContactNameTextBox") as TextBox;
                    ContactName.Text = FirstName + " " + LastName;
                    ContactList.Update();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script",
                                                            "CloseModals(['BodyContent_ModalPanel1','BodyContent_ModalPanel291']);",
                                                            true);
                }
            }
        }

        protected void ContactDetailsCreateObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long contactID;
            contactID = Convert.ToInt64(e.ReturnValue);
            Session["ContactID"] = contactID;
        }
        protected void ContactButton_Click(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            contactBL.GetContactByName(search);
            this.ContactsGridView.DataBind();
        }
        protected void ContactSearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            contactBL.GetContactByName(search);
            this.ContactsGridView.DataBind();
        }
        #endregion

        #region Open modal with account/contact in button click
        protected void ModalSelectButton_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;

            if (btn.CommandArgument.ToString() == "Contacts")
            {
                ModalLabel.Text = "Select Contact";
                AccountGridView.Visible = false;
                ContactsGridView.Visible = true;
                //AccountPanel.Visible = false;
                //ContactPanel.Visible = true;
                AccountSearchPanel.Visible = false;
                ContactSearchPanel.Visible = true;
                Session["Select"] = 1;

            }
            else if (btn.CommandArgument.ToString() == "Accounts")
            {
                ModalLabel.Text = "Select Account";
                ContactsGridView.Visible = false;
                //ContactPanel.Visible = false;
                //AccountPanel.Visible = true;
                AccountGridView.Visible = true;
                ContactSearchPanel.Visible = false;
                AccountSearchPanel.Visible = true;
                Session["Select"] = 2;
            }

        }
        protected void ModalCreateButton_Click(object sender, EventArgs e)
        {

            int button = Convert.ToInt32(Session["Select"]);
            if (button == 1)
            {
                AccountPanel.Visible = false;
                ContactPanel.Visible = true;
                CreateUpdatePanel.Update();
            }
            else
            {
                ContactPanel.Visible = false;
                AccountPanel.Visible = true;
                CreateUpdatePanel.Update();

            }

        }
        protected void ShowMeetings_Click(object sender, EventArgs e)
        {
            //MeetingSummaryUpdatePanel.Update();
            WeeklymeetingUpdatePanel.Update();
        }

        #endregion
    }
}