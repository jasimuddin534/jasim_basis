using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.App_Code;
using System.Net.Mail;
using C3App.DAL;
using System.Text.RegularExpressions;
using System.Globalization;

namespace C3App.Campaigns
{
    public partial class Campaigns : PageBase
    {
        
        #region Initializing....
        public CampaignBL campaignBL = new CampaignBL();
        private DropDownList CampaignTypeDropDownList;
        private DropDownList CurrencyDropDownList;
        private DropDownList AssignedUserDropDownList;
        private DropDownList TeamDropDownList;
        private DropDownList CampaignStatusDropDownList;
        private DropDownList TargetTypeDropDownList;
        public long campaignID = 0;
        public Int32 companyID;
        #endregion


        #region Page Function....
        protected void Page_Load(object sender, EventArgs e)
        {
            companyID = Convert.ToInt32(Session["CompanyID"]);
            try
            {
                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        Session["EditCampaignID"] = 0;
                    }
                }
                if (Session["EditCampaignID"] != null)
                {
                    campaignID = Convert.ToInt64(Session["EditCampaignID"]);

                    if (campaignID == 0)
                    {
                        CampaignDetailsView.ChangeMode(DetailsViewMode.Insert);
                        CampaignRunLinkButton.Visible = false;
                        EditLinkButton.Visible = false;
                        DeleteLinkButton.Visible = false;
                        CampaignTargetLinkButton.Visible = false;

                        this.CampaignsGridView.DataBind();
                        this.CampaignsGridView.SelectedIndex = -1;
                        this.MiniCampaignFormView.DataBind();
                        this.MiniMoreDetailsView.DataBind();
                        CampaignListUpdatePanel.Update();
                        MiniDetailsUpdatePanel.Update();

                    }
                    else if (campaignID > 0)
                    {
                        CampaignDetailsView.ChangeMode(DetailsViewMode.Edit);
                        CampaignRunLinkButton.Visible = true;
                        CampaignTargetLinkButton.Visible = true;
                        if (CheckEdit() != false)
                            EditLinkButton.Visible = true;
                        if (CheckDelete() != false)
                            DeleteLinkButton.Visible = true;
                    }
                }
                else
                {
                    CampaignDetailsView.ChangeMode(DetailsViewMode.Insert);
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
            ExceptionUtility.LogException(exc, "CampaignPage");
            ExceptionUtility.NotifySystemOps(exc, "CampaignPage");
            Server.ClearError();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            CampaignDetailsView.EnableDynamicData(typeof(Campaign));
        }

        #endregion


        
        #region select and Command Function of Campaign...
        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {

            if (e.CommandArgument.ToString() != null)
            {
                Session["EditCampaignID"] = e.CommandArgument.ToString();
                campaignID = Convert.ToInt64(e.CommandArgument.ToString());
                IEnumerable<Campaign> campaigns = campaignBL.GetCampaignByID(campaignID);

                foreach (var campaign in campaigns)
                {
                    if (campaign.Name != null) { Session["campaignName"] = campaign.Name; } else { Session["campaignName"] = ""; }
                    if (campaign.Content != null) { Session["campaignContent"] = campaign.Content; } else { Session["campaignContent"] = ""; }
                }
                int gindex = Convert.ToInt32(CampaignsGridView.SelectedIndex);
                if (gindex > -1)
                {
                    LinkButton nlbtn = CampaignsGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                    nlbtn.CssClass = "";
                }
                LinkButton lbtn = sender as LinkButton;
                lbtn.CssClass = "active";
                MiniDetailsUpdatePanel.Update();
                MiniCampaignFormView.DataBind();
                MiniMoreDetailsView.DataBind();
                CampaignRunLinkButton.Visible = true;
                CampaignTargetLinkButton.Visible = true;
                if (CheckEdit() != false)
                    EditLinkButton.Visible = true;
                if (CheckDelete() != false)
                    DeleteLinkButton.Visible = true;
            }
            else
            {
                Session["EditCampaignID"] = 0;
            }
        }

        protected void CampaignDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Session["EditCampaignID"] = 0;
                MessageLiteral.Text = "Changes discarded <br /> <br /> <p>Your changes have been discarded</p>";
                CampaignDetailsView.DataBind();
                CampaignDetailsView.ChangeMode(DetailsViewMode.Insert);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
            }
        }

        protected void CampaignTargetLinkButton_Click(object sender, EventArgs e)
        {
            CampaignSummaryUpdatePanel.Update();
        }


        #endregion



        #region Insert Function of Campaign....
        protected void CampaignDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            long userid;
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

            if (Convert.ToInt32(CampaignStatusDropDownList.SelectedValue) == 0)
            {
                e.Values["CampaignStatusID"] = null;
            }
            else { e.Values["CampaignStatusID"] = CampaignStatusDropDownList.SelectedValue; }


            if (Convert.ToInt32(CampaignTypeDropDownList.SelectedValue) == 0) { e.Values["CampaignTypeID"] = null; }
            else { e.Values["CampaignTypeID"] = CampaignTypeDropDownList.SelectedValue; }
            if (Convert.ToInt32(CurrencyDropDownList.SelectedValue) == 0) { e.Values["CurrencyID"] = null; }
            else { e.Values["CurrencyID"] = CurrencyDropDownList.SelectedValue; }
            if (Convert.ToInt32(AssignedUserDropDownList.SelectedValue) == 0) { e.Values["AssignedUserID"] = null; }
            else { e.Values["AssignedUserID"] = AssignedUserDropDownList.SelectedValue; }
            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.Values["TeamID"] = null; }
            else { e.Values["TeamID"] = TeamDropDownList.SelectedValue; }
            e.Values["CreatedBy"] = userid;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;

        }

        protected void CampaignObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
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
                this.CampaignsGridView.DataBind();
                this.MiniCampaignFormView.DataBind();
                this.MiniMoreDetailsView.DataBind();
                MessageLiteral.Text = "Success </br></br> <p> Cmapaign has been successfully saved</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                CampaignDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }

        #endregion



        #region Update Function of Campaign....
        protected void CampaignDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            if (Convert.ToInt32(CampaignStatusDropDownList.SelectedValue) == 0)
            {
                e.NewValues["CampaignStatusID"] = null;
            }
            else { e.NewValues["CampaignStatusID"] = CampaignStatusDropDownList.SelectedValue; }


            if (Convert.ToInt32(CampaignTypeDropDownList.SelectedValue) == 0) { e.NewValues["CampaignTypeID"] = null; }
            else { e.NewValues["CampaignTypeID"] = CampaignTypeDropDownList.SelectedValue; }
            if (Convert.ToInt32(CurrencyDropDownList.SelectedValue) == 0) { e.NewValues["CurrencyID"] = null; }
            else { e.NewValues["CurrencyID"] = CurrencyDropDownList.SelectedValue; }
            if (Convert.ToInt32(AssignedUserDropDownList.SelectedValue) == 0) { e.NewValues["AssignedUserID"] = null; }
            else { e.NewValues["AssignedUserID"] = AssignedUserDropDownList.SelectedValue; }
            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.NewValues["TeamID"] = null; }
            else { e.NewValues["TeamID"] = TeamDropDownList.SelectedValue; }
            e.NewValues["CreatedBy"] = Convert.ToInt64(Session["UserID"]);
            e.NewValues["CreatedTime"] = DateTime.Now;
            e.NewValues["ModifiedBy"] = Convert.ToInt64(Session["UserID"]);
            e.NewValues["ModifiedTime"] = DateTime.Now;

        }

        protected void CampaignObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
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
                this.CampaignsGridView.DataBind();
                this.MiniCampaignFormView.DataBind();
                this.MiniMoreDetailsView.DataBind();
                MessageLiteral.Text = "Success </br><br/> <p> Campaign has been successfully updated</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                CampaignDetailsView.ChangeMode(DetailsViewMode.Insert);
                Session["EditCampaignID"] = 0;
            }
        }

        #endregion



        #region Dropdown List Initialization....
        protected void CampaignStatusDropDownList_Init(object sender, EventArgs e)
        {
            CampaignStatusDropDownList = sender as DropDownList;
        }

        protected void CampaignTypeDropDownList_Init(object sender, EventArgs e)
        {
            CampaignTypeDropDownList = sender as DropDownList;
        }

        protected void CurrencyDropDownList_Init(object sender, EventArgs e)
        {
            CurrencyDropDownList = sender as DropDownList;
        }

        protected void AssignedUserDropDownList_Init(object sender, EventArgs e)
        {
            AssignedUserDropDownList = sender as DropDownList;
        }

        protected void TeamNameDropDownList_Init(object sender, EventArgs e)
        {
            TeamDropDownList = sender as DropDownList;
        }

        #endregion



        #region Campaign Edit, Delete, Search Function.......

        protected void DeleteLinkButton_Click(object sender, EventArgs e)
        {
            campaignID = Convert.ToInt64(Session["EditCampaignID"]);
            CampaignBL campaignBl = new CampaignBL();
            campaignBl.DeleteCampaignByID(campaignID);
            Session["EditCampaignID"] = 0;
            this.CampaignsGridView.DataBind();
            this.CampaignsGridView.SelectedIndex = -1;
            this.MiniCampaignFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            CampaignListUpdatePanel.Update();
            MiniDetailsUpdatePanel.Update();
            CampaignRunLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            CampaignTargetLinkButton.Visible = false;

        }

        protected void EditLinkButton_Click(object sender, EventArgs e)
        {
            if (campaignID == 0)
            {
                CampaignDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
            else if (campaignID > 0)
            {
                CampaignDetailsView.ChangeMode(DetailsViewMode.Edit);
            }
        }

        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            CampaignRunLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            CampaignTargetLinkButton.Visible = false;

            CampaignsGridView.DataSourceID = CampaignListObjectDataSource.ID;
            this.CampaignsGridView.DataBind();
            this.CampaignsGridView.SelectedIndex = -1;
            this.MiniCampaignFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            CampaignListUpdatePanel.Update();
            MiniDetailsUpdatePanel.Update();
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            CampaignRunLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            CampaignTargetLinkButton.Visible = false;

            CampaignsGridView.DataSourceID = SearchCampaignObjectDataSource.ID;
            this.CampaignsGridView.DataBind();
            this.CampaignsGridView.SelectedIndex = -1;
            this.MiniCampaignFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            CampaignListUpdatePanel.Update();
            MiniDetailsUpdatePanel.Update();
        }

        protected void SearchActiveCampaignLinkButton_Click(object sender, EventArgs e)
        {
            CampaignRunLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            CampaignTargetLinkButton.Visible = false;

            CampaignsGridView.DataSourceID = SearchActiveCampaignsObjectDataSource.ID;
            this.CampaignsGridView.DataBind();
            this.CampaignsGridView.SelectedIndex = -1;
            this.MiniCampaignFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            CampaignListUpdatePanel.Update();
            MiniDetailsUpdatePanel.Update();
        }
        #endregion



        #region Campaign Tab Function....
        protected void CampaignDetailsLinkButton_Click(object sender, EventArgs e)
        {
            CampaignDetailsView.DataSource = null;
            CampaignDetailsView.DataBind();
            Session["EditCampaignID"] = 0;
            CampaignDetailsView.ChangeMode(DetailsViewMode.Insert);

        }

        protected void ViewCampaignLinkButton_Click(object sender, EventArgs e)
        {
            CampaignsGridView.DataSourceID = CampaignListObjectDataSource.ID;
            CampaignsGridView.SelectedIndex = -1;
            CampaignsGridView.DataBind();
            CampaignListUpdatePanel.Update();
            CampaignRunLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            CampaignTargetLinkButton.Visible = false;
            MiniDetailsUpdatePanel.Update();
            Session["EditCampaignID"] = 0;
        }
        #endregion


       
        #region Run Campaign Function......


        protected void SelectAllCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (SelectAllCheckBox.Checked == true)
            {
                foreach (GridViewRow gvRow in ContactGridView.Rows)
                {
                    CheckBox chkSel = (CheckBox)gvRow.FindControl("ContactCheckBox") as CheckBox;
                    chkSel.Checked = true;
                    //SelectAllCheckBox.Text = "Deselect All";
                }
            }
            else
            {
                foreach (GridViewRow gvRow in ContactGridView.Rows)
                {
                    CheckBox chkSel = (CheckBox)gvRow.FindControl("ContactCheckBox") as CheckBox;
                    chkSel.Checked = false;
                    //SelectAllCheckBox.Text = "Select All";

                }
            }
        }

        protected void TargetTypeDropDownList_Init(object sender, EventArgs e)
        {
            TargetTypeDropDownList = sender as DropDownList;
        }

        protected void IssueLinkButton_Click(object sender, EventArgs e)
        {
            string email = String.Empty;
            string contactName = String.Empty;
            string targetid = String.Empty;

            foreach (GridViewRow row in ContactGridView.Rows)
            {
                if ((row.FindControl("ContactCheckBox") as CheckBox).Checked)
                {
                    var dataKey = ContactGridView.DataKeys[row.RowIndex];
                    if (dataKey != null)
                    {
                        ContactBL contactBL = new ContactBL();
                        long contactID = Convert.ToInt64(dataKey.Value);
                        IEnumerable<DAL.Contact> contacts = contactBL.GetContactByID(contactID);
                        foreach (var contact in contacts)
                        {
                            if (contact.PrimaryEmail != null)
                            {
                                string emailaddress = contact.PrimaryEmail.ToString();
                                if (emailaddress != null)
                                {
                                    Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
                                    Match match = regex.Match(emailaddress);
                                    if (match.Success)
                                    {
                                        email += emailaddress + ";";
                                        targetid += contactID.ToString(CultureInfo.InvariantCulture) + ";";
                                        contactName += contact.FirstName.ToString() + ", ";
                                    }
                                }
                            }

                        }
                    }
                }
            }
            Session["targetID"] = targetid.TrimEnd(';');
            Session["toUser"] = email;
            TextBox ContactName = CampaignTargetDetailsView.FindControl("TargetTextBox") as TextBox;
            ContactName.Text = contactName;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModals(['BodyContent_TargetListModalPanel']);", true);


        }

        protected void CampaignTargetInsertLinkButton_Click(object sender, EventArgs e)
        {
            string content = Session["campaignContent"].ToString();
            string subject = Session["campaignName"].ToString();
            string body = String.Empty;
            if (content != String.Empty) { body = content; }
            else { body = "Dear Sir / Madam ,  </br> We are running a campaign. Please contact us for details."; }

            string emailAdddress = Session["toUser"].ToString();
            string touser = emailAdddress.TrimEnd(';');
            string campaignMessage = String.Empty;

            long campaignID = Convert.ToInt64(Session["EditCampaignID"]);
            string targetType = TargetTypeDropDownList.SelectedValue.ToString();
            string allTarge = Session["targetID"].ToString();
            string[] targets = allTarge.Split(';');

            try
            {
                App_Code.Notification.SendEmail(touser, subject, body);
                foreach (string target in targets)
                {
                    long targetID = Convert.ToInt64(target);
                    campaignBL.InsertCampaignTarget(campaignID, targetID, targetType);
                }
                ContactGridView.DataBind();
                SelectAllCheckBox.Checked = false;
                //SelectAllCheckBox.Text = "Select All";
                campaignMessage = "Success <br/><br/> <p>Campaign has been successfully run</p>";
            }
            catch (Exception ex)
            {
                campaignMessage = "Failed <br/><br/> <p>Campaign has been failed Problem is  : " + ex.Message.ToString() + "</p>";
            }
            MessageLiteral.Text = campaignMessage;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

            Session["targetID"] = 0;
            Session["toUser"] = 0;
            CampaignTargetDetailsView.DataSource = null;
            CampaignTargetDetailsView.DataBind();
        }

        protected void CampaignTargetCancelLinkButton_Click(object sender, EventArgs e)
        {
            CampaignTargetDetailsView.DataSource = null;
            CampaignTargetDetailsView.DataBind();
            SelectAllCheckBox.Checked = false;
            ContactGridView.DataBind();
        }

        #endregion




    }
}