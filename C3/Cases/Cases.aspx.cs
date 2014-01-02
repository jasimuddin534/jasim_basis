using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using C3App.DAL;
using C3App.BLL;
using C3App.App_Code;
using System.Collections;
using System.Globalization;
using System.Collections.Specialized;

namespace C3App.Cases
{
    public partial class Cases : PageBase
    {
        #region Initializing...........
        private DropDownList AssaigendToDropDownList;
        private DropDownList StatusDropDownList;
        private DropDownList PriorityDropDownList;
        private DropDownList TeamDropDownList;
        private TeamBL teamBL = new TeamBL();
        private AccountBL accountBL = new AccountBL();
        private CaseBL caseBL = new CaseBL();
        private UserBL userBL = new UserBL();
        private long caseID = 0;
        private Int32 companyID;
        #endregion


        #region Cases Page Function............
        protected void Page_Load(object sender, EventArgs e)
        {
            companyID = Convert.ToInt32(Session["CompanyID"]);
            try
            {
                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        Session["EditCaseID"] = 0;
                        Session.Remove("CasesAccountID");
                    }
                }
                if (Session["EditCaseID"] != null)
                {
                    caseID = Convert.ToInt32(Session["EditCaseID"]);

                    if (caseID == 0)
                    {
                        this.CaseListGridView.DataBind();
                        this.CaseListGridView.SelectedIndex = -1;
                        this.CaseMiniDetailFormView.DataBind();
                        this.CaseMiniMoreDetailsView.DataBind();
                        CaseListUpdatePanel.Update();
                        MiniDetailBasicUpdatePanel.Update();

                        CaseDetailsView.ChangeMode(DetailsViewMode.Insert);
                        DeleteLinkButton.Visible = false;
                        EditLinkButton.Visible = false;
                        NotifyLinkButton.Visible = false;

                    }
                    else if (caseID > 0)
                    {
                        CaseDetailsView.ChangeMode(DetailsViewMode.Edit);
                        if (CheckEdit() != false)
                            EditLinkButton.Visible = true;
                        if (CheckDelete() != false)
                            DeleteLinkButton.Visible = true;
                        NotifyLinkButton.Visible = true;
                    }
                }
                else
                {
                    CaseDetailsView.ChangeMode(DetailsViewMode.Insert);
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
            ExceptionUtility.LogException(exc, "CasePage");
            ExceptionUtility.NotifySystemOps(exc, "CasePage");
            Server.ClearError();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            CaseDetailsView.EnableDynamicData(typeof(Case));
        }
        #endregion


        #region Cases Tab Function.........
        protected void CaseDetailsLinkButton_Click(object sender, EventArgs e)
        {

            //caseID = 0;
            Session["EditCaseID"] = 0;
            Session.Remove("CasesAccountID");
            CaseDetailsView.DataSource = null;

            CaseDetailsView.ChangeMode(DetailsViewMode.Insert);
            //if (caseID == 0)
            //    GetCaseNumber();
            //CaseDetailsView.DataBind();

        }

        protected void ViewCaseLinkButton_Click(object sender, EventArgs e)
        {
            CaseListGridView.DataSourceID = SearchAllCasesObjectDataSource.ID;
            CaseListGridView.SelectedIndex = -1;
            CaseListGridView.DataBind();
            CaseListUpdatePanel.Update();
            MiniDetailBasicUpdatePanel.Update();
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;
            Session["EditCaseID"] = 0;
            Session.Remove("CasesAccountID");

        }

        #endregion


        #region Cases Insert Function........
        protected void CaseDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            //string cn = GetCaseNumber();
            e.Values["CaseNumber"] = GetCaseNumber();

            Session["CaseSubject"] = e.Values["Subject"];
            CheckBox notifyCheckbox = CaseDetailsView.FindControl("NotifyCheckBox") as CheckBox;
            if (notifyCheckbox.Checked)
            {
                Session["NotifyUser"] = 1;
            }
            else
            {
                Session["NotifyUser"] = 2;
            }

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

            if (Session["CasesAccountID"] != null)
            {
                long accountID = Convert.ToInt64(Session["CasesAccountID"]);
                e.Values["AccountID"] = accountID;
            }
            else
            {
                e.Values["AccountID"] = null;
            }

            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.Values["TeamID"] = null; }
            else { e.Values["TeamID"] = TeamDropDownList.SelectedValue; }

            if (Convert.ToInt32(AssaigendToDropDownList.SelectedValue) == 0) { e.Values["AssignedUserID"] = null; }
            else { e.Values["AssignedUserID"] = AssaigendToDropDownList.SelectedValue; }
            if (Convert.ToInt32(StatusDropDownList.SelectedValue) == 0) { e.Values["StatusID"] = null; }
            else { e.Values["StatusID"] = StatusDropDownList.SelectedValue; }
            if (Convert.ToInt32(PriorityDropDownList.SelectedValue) == 0) { e.Values["Priority"] = null; }
            else { e.Values["Priority"] = PriorityDropDownList.SelectedValue; }
            e.Values["CreatedBy"] = userid;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;

        }

        protected void CaseDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
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
                string caseSubject = Session["CaseSubject"].ToString();
                Int64 assignedUserID = Convert.ToInt64(Session["AssignedUserID"]);
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

                    try
                    {
                        ListDictionary templateValues = new ListDictionary();
                        templateValues.Add("<%=ModuleName%>", "Cases");
                        templateValues.Add("<%=Key%>", "Cases Subject");
                        templateValues.Add("<%=Value%>", caseSubject);
                        C3App.App_Code.Notification.Notify("Cases", caseID, 1, touser, 2, templateValues);
                        NotifyMessage = "and successfully notify to " + receivername;
                    }
                    catch (Exception ex)
                    {
                        NotifyMessage = "Notification unsuccess </br> Problem is : " + ex.Message.ToString();
                    }
                }

                CaseDetailsView.DataBind();

                this.CaseListGridView.DataBind();
                this.CaseMiniDetailFormView.DataBind();
                this.CaseMiniMoreDetailsView.DataBind();

                MessageLiteral.Text = "Success </br></br> <p> Case has been successfully saved <br/> " + NotifyMessage + "</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                CaseDetailsView.ChangeMode(DetailsViewMode.Insert);

                Session["EditCaseID"] = 0;
                Session.Remove("CasesAccountID");
            }
        }

        //protected void CaseDetailsView_DataBound(object sender, EventArgs e)
        //{
        //    if (caseID == 0)
        //        GetCaseNumber();
        //}

        private string GetCaseNumber()
        {
            string caseNumber = String.Empty;

            string month = DateTime.Today.Month.ToString(CultureInfo.InvariantCulture);
            if (month.Length != 2) month = "0" + month;
            string year = DateTime.Today.Year.ToString(CultureInfo.InvariantCulture);

            string lastCaseNumber = caseBL.GetCaseNumber();
            if (lastCaseNumber != null)
            {
                string caseSerial = lastCaseNumber.Split('-')[2];
                int newCasesSerial = Convert.ToInt32(caseSerial) + 1;
                var test = new[] { Convert.ToInt32(caseSerial) };
                int i = test.Length;
                int append = 5 - i;
                string serial = "";
                for (int j = 0; j < append; j++)
                {
                    serial += "0";
                }
                serial = serial + newCasesSerial;
                caseNumber = month + year + "-C-" + serial;
            }
            else
            {
                caseNumber = month + year + "-C-" + "00001";
            }

            return caseNumber;
        }


        //private void GetCaseNumber()
        //{
        //    string caseNumber = String.Empty;

        //    string month = DateTime.Today.Month.ToString(CultureInfo.InvariantCulture);
        //    if (month.Length != 2) month = "0" + month;
        //    string year = DateTime.Today.Year.ToString(CultureInfo.InvariantCulture);

        //    string lastCaseNumber = caseBL.GetCaseNumber();
        //    if (lastCaseNumber != null)
        //    {
        //        string caseSerial = lastCaseNumber.Split('-')[2];
        //        int newCasesSerial = Convert.ToInt32(caseSerial) + 1;
        //        var test = new[] { Convert.ToInt32(caseSerial) };
        //        int i = test.Length;
        //        int append = 5 - i;
        //        string serial = "";
        //        for (int j = 0; j < append; j++)
        //        {
        //            serial += "0";
        //        }
        //        serial = serial + newCasesSerial;
        //        caseNumber = month + year + "-C-" + serial;
        //    }
        //    else
        //    {
        //        caseNumber = month + year + "-C-" + "00001";
        //    }


        //    TextBox CaseNumberTextBox = CaseDetailsView.FindControl("CaseNumberTextBox") as TextBox;

        //    if (CaseNumberTextBox != null)
        //    {
        //        CaseNumberTextBox.Text = caseNumber;
        //    }

        //}


        #endregion


        #region Cases Update Function........

        protected void CaseDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            Session["CaseSubject"] = e.NewValues["Subject"];
            CheckBox notifyCheckbox = CaseDetailsView.FindControl("NotifyCheckBox") as CheckBox;
            if (notifyCheckbox.Checked)
            {
                Session["NotifyUser"] = 1;
            }
            else
            {
                Session["NotifyUser"] = 2;
            }

            TextBox AccountName = CaseDetailsView.FindControl("AccountNameTextBox") as TextBox;
            if (Session["CasesAccountID"] != null)
            {
                long accountID = Convert.ToInt64(Session["CasesAccountID"]);
                e.NewValues["AccountID"] = accountID;
            }
            if (AccountName.Text == "")
            {
                e.NewValues["AccountID"] = null;
            }


            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.NewValues["TeamID"] = null; }
            else { e.NewValues["TeamID"] = TeamDropDownList.SelectedValue; }

            if (Convert.ToInt32(AssaigendToDropDownList.SelectedValue) == 0) { e.NewValues["AssignedUserID"] = null; }
            else { e.NewValues["AssignedUserID"] = AssaigendToDropDownList.SelectedValue; }
            if (Convert.ToInt32(StatusDropDownList.SelectedValue) == 0) { e.NewValues["StatusID"] = null; }
            else { e.NewValues["StatusID"] = StatusDropDownList.SelectedValue; }
            if (Convert.ToInt32(PriorityDropDownList.SelectedValue) == 0) { e.NewValues["Priority"] = null; }
            else { e.NewValues["Priority"] = PriorityDropDownList.SelectedValue; }
            e.NewValues["ModifiedBy"] = Convert.ToInt64(Session["UserID"]);
            e.NewValues["ModifiedTime"] = DateTime.Now;
        }

        protected void CaseDetailsObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
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
                //caseID = 0;

                string caseSubject = Session["CaseSubject"].ToString();
                Int64 assignedUserID = Convert.ToInt64(Session["AssignedUserID"]);
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

                    try
                    {
                        ListDictionary templateValues = new ListDictionary();
                        templateValues.Add("<%=ModuleName%>", "Cases");
                        templateValues.Add("<%=Key%>", "Cases Subject");
                        templateValues.Add("<%=Value%>", caseSubject);
                        C3App.App_Code.Notification.Notify("Cases", caseID, 1, touser, 2, templateValues);

                        NotifyMessage = "and successfully notify to " + receivername;
                    }
                    catch (Exception ex)
                    {
                        NotifyMessage = "Notification unsuccess </br> Problem is : " + ex.Message.ToString();
                    }
                }

                CaseDetailsView.DataBind();

                this.CaseListGridView.DataBind();
                this.CaseMiniDetailFormView.DataBind();
                this.CaseMiniMoreDetailsView.DataBind();

                MessageLiteral.Text = "Success </br></br> <p> Case has been successfully updated <br/> " + NotifyMessage + "</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                CaseDetailsView.ChangeMode(DetailsViewMode.Insert);


                //if (caseID == 0)
                //    GetCaseNumber();
                //CaseDetailsView.DataBind();

            }
        }


        #endregion


        #region select and Command Function of Cases...

        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandArgument.ToString() != null)
            {
                int gindex = Convert.ToInt32(CaseListGridView.SelectedIndex);
                if (gindex > -1)
                {
                    LinkButton nlbtn = CaseListGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                    nlbtn.CssClass = "";
                }
                LinkButton lbtn = sender as LinkButton;
                lbtn.CssClass = "active";
                if (CheckEdit() != false)
                    EditLinkButton.Visible = true;
                if (CheckDelete() != false)
                    DeleteLinkButton.Visible = true;
                NotifyLinkButton.Visible = true;

                try
                {
                    string arguments = Convert.ToString(e.CommandArgument);
                    string[] arg = arguments.Split(';');

                    Session["EditCaseID"] = Convert.ToInt64(arg[0]);
                    caseID = Convert.ToInt64(arg[0]);

                    if (arg[1] != string.Empty)
                    {
                        long assignedUserID = Convert.ToInt64(arg[1]);
                        IEnumerable<DAL.User> userdetails = userBL.GetUsersByID(assignedUserID);
                        foreach (var user in userdetails)
                        {
                            Session["ReceiverName"] = user.FirstName + " " + user.LastName;
                            Session["ReceiverEmail"] = user.PrimaryEmail;
                        }

                    }
                    if (arg[2] != String.Empty)
                    {
                        Session["CaseSubject"] = Convert.ToString(arg[2]);
                    }
                }

                catch (Exception ex)
                {
                    throw ex;
                }

                MiniDetailBasicUpdatePanel.Update();
                CaseMiniDetailFormView.DataBind();
                CaseMiniMoreDetailsView.DataBind();
            }
            else
            {
                Session["EditCaseID"] = 0;
            }



        }

        protected void CaseDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                //caseID = 0;
                Session["EditCaseID"] = 0;
                Session.Remove("CasesAccountID");

                MessageLiteral.Text = "Changes discarded <br/> <p>Your changes have been discarded</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

                CaseDetailsView.ChangeMode(DetailsViewMode.Insert);
                //if (caseID == 0)
                //    GetCaseNumber();
                //CaseDetailsView.DataBind();

            }
        }

        #endregion


        #region Cases Edit, Delete, Search Function.......

        protected void EditLinkButton_Click(object sender, EventArgs e)
        {
            if (caseID == 0)
            {
                CaseDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
            else if (caseID > 0)
            {
                CaseDetailsView.ChangeMode(DetailsViewMode.Edit);
            }
        }

        protected void DeleteLinkButton_Click(object sender, EventArgs e)
        {
            long caseID = Convert.ToInt64(Session["EditCaseID"]);
            CaseBL caseBL = new CaseBL();
            caseBL.DeleteCaseByID(caseID);
            Session["EditCaseID"] = 0;
            Session.Remove("CasesAccountID");
            this.CaseListGridView.DataBind();
            this.CaseListGridView.SelectedIndex = -1;
            this.CaseMiniDetailFormView.DataBind();
            this.CaseMiniMoreDetailsView.DataBind();
            CaseListUpdatePanel.Update();
            MiniDetailBasicUpdatePanel.Update();
            DeleteLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            DeleteLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            CaseListGridView.DataSourceID = SearchObjectDataSource.ID;
            this.CaseListGridView.DataBind();
            this.CaseListGridView.SelectedIndex = -1;
            this.CaseMiniDetailFormView.DataBind();
            this.CaseMiniMoreDetailsView.DataBind();
            CaseListUpdatePanel.Update();
            MiniDetailBasicUpdatePanel.Update();
        }

        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            DeleteLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            CaseListGridView.DataSourceID = SearchAllCasesObjectDataSource.ID;
            this.CaseListGridView.DataBind();
            this.CaseListGridView.SelectedIndex = -1;
            this.CaseMiniDetailFormView.DataBind();
            this.CaseMiniMoreDetailsView.DataBind();
            CaseListUpdatePanel.Update();
            MiniDetailBasicUpdatePanel.Update();
        }

        protected void SearchNewLinkButton_Click(object sender, EventArgs e)
        {
            DeleteLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            CaseListGridView.DataSourceID = SearchNewCasesObjectDataSource.ID;
            this.CaseListGridView.DataBind();
            this.CaseListGridView.SelectedIndex = -1;
            this.CaseMiniDetailFormView.DataBind();
            this.CaseMiniMoreDetailsView.DataBind();
            CaseListUpdatePanel.Update();
            MiniDetailBasicUpdatePanel.Update();
        }

        protected void SearchAssginedLinkButton_Click(object sender, EventArgs e)
        {
            DeleteLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            CaseListGridView.DataSourceID = SearchAssginedCasesObjectDataSource.ID;
            this.CaseListGridView.DataBind();
            this.CaseListGridView.SelectedIndex = -1;
            this.CaseMiniDetailFormView.DataBind();
            this.CaseMiniMoreDetailsView.DataBind();
            CaseListUpdatePanel.Update();
            MiniDetailBasicUpdatePanel.Update();
        }
        #endregion


        #region Dropdown List Initialization....

        protected void TeamNameDropDownList_Init(object sender, EventArgs e)
        {
            TeamDropDownList = sender as DropDownList;
        }

        protected void AssaigendToDropDownList_Init(object sender, EventArgs e)
        {
            AssaigendToDropDownList = sender as DropDownList;
        }

        protected void StatusDropDownList_Init(object sender, EventArgs e)
        {
            StatusDropDownList = sender as DropDownList;
        }

        protected void PriorityDropDownList_Init(object sender, EventArgs e)
        {
            PriorityDropDownList = sender as DropDownList;
        }
        #endregion


        #region Accounts Modal Function....

        protected void ModalPopButton_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            if (btn.CommandArgument.ToString() == "Accounts")
            {
                ModalTitleLabel.Visible = true;
                AccountGridView.Visible = true;
                AccountSearchPanel.Visible = true;
            }
        }

        protected void AccountSearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = AccountSearchTextBox.Text;
            accountBL.SearchAccount(search);
            this.AccountGridView.DataBind();
        }

        protected void SelectAccountLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["CasesAccountID"] = e.CommandArgument.ToString();
            long accountID = Convert.ToInt64(Session["CasesAccountID"]);

            IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(accountID);
            foreach (var account in accounts)
            {
                string accountName = account.Name;

                TextBox AccountName = CaseDetailsView.FindControl("AccountNameTextBox") as TextBox;
                AccountName.Text = accountName;

            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModals(['BodyContent_AccountsContentModalPanel','BodyContent_CreateModalPanel']);", true);
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
            TextBox AccountName = CaseDetailsView.FindControl("AccountNameTextBox") as TextBox;
            AccountName.Text = accountName;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModals(['BodyContent_AccountsContentModalPanel','BodyContent_CreateModalPanel']);", true);
        }

        protected void AccountsDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            long accountID;
            accountID = Convert.ToInt64(e.ReturnValue);
            Session["CasesAccountID"] = accountID;
        }
        #endregion


        #region Cases Notify Method...............
        protected void AssaigendToDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label notifylabel = CaseDetailsView.FindControl("NotifyLabel") as Label;
            CheckBox notifyCheckbox = CaseDetailsView.FindControl("NotifyCheckBox") as CheckBox;
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

        protected void NotifyCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            Session["AssignedUserID"] = AssaigendToDropDownList.SelectedValue;
        }

        protected void NotifyLinkButton_Click(object sender, EventArgs e)
        {
            caseID = Convert.ToInt32(Session["EditCaseID"]);
            string touser = Session["ReceiverEmail"].ToString();
            string receivername = Session["ReceiverName"].ToString();
            string caseSubject = Session["CaseSubject"].ToString();
            string notifyMessage = String.Empty;
            try
            {
                ListDictionary templateValues = new ListDictionary();
                templateValues.Add("<%=ModuleName%>", "Cases");
                templateValues.Add("<%=Key%>", "Cases Subject");
                templateValues.Add("<%=Value%>", caseSubject);
                C3App.App_Code.Notification.Notify("Cases", caseID, 1, touser, 2, templateValues);
                notifyMessage = "Notification Success </br></br> <p> Mail has been successfully sent to <b> " + receivername + "</b></p>";
            }
            catch (Exception ex)
            {
                notifyMessage = "Notification Unsuccess </br></br> <p> <b> Problem is :</b> " + ex.Message.ToString() + "</p>";
            }


            MessageLiteral.Text = notifyMessage;
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

            Session.Remove("ReceiverName");
            Session.Remove("ReceiverEmail");
            Session.Remove("CaseSubject");

        }

        #endregion


    }
}

