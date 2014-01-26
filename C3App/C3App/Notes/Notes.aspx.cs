using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;
using System.Data;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using C3App.App_Code;
using System.Text;
using AjaxControlToolkit;
using System.Globalization;
using System.Data.SqlClient;
using System.Net;
using System.ComponentModel;
using System.Diagnostics;


namespace C3App.Notes
{
    public partial class Notes : System.Web.UI.Page
    {
        #region Initializing...........

        private NoteBL noteBL = new NoteBL();
        private AccountBL accountBL = new AccountBL();
        private TeamBL teamBL = new TeamBL();
        private UserBL userBL = new UserBL();
        private ContactBL contactBL = new ContactBL();
        private OpportunityBL opportunityBL = new OpportunityBL();
        private DropDownList AssaigendUserDropDownList;
        private DropDownList ParentTypeDropDownList;
        private long noteID = 0;
        private long companyID;
        long userid;

        #endregion


        #region Note Page Functions..........


        protected void Page_Load(object sender, EventArgs e)
        {
            companyID = Convert.ToInt32(Session["CompanyID"]);
            try
            {
                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        Session["EditNoteID"] = 0;
                        Session.Remove("EditParentID");
                        Session.Remove("FilePath");
                        Session.Remove("NoteParentName");
                    }
                }
                if (Session["EditNoteID"] != null)
                {
                    noteID = Convert.ToInt64(Session["EditNoteID"]);
                    if (noteID == 0)
                    {
                        NoteDetailsView.ChangeMode(DetailsViewMode.Insert);

                        this.NotesListGridView.DataBind();
                        this.NotesListGridView.SelectedIndex = -1;
                        this.NoteMiniDetailFormView.DataBind();
                        this.NoteMiniMoreDetailsView.DataBind();
                        NotesListUpdatePanel.Update();
                        NoteMiniDetailsUpdatePanel.Update();

                        EditLinkButton.Visible = false;
                        DeleteLinkButton.Visible = false;
                        FileDownloadLinkButton.Visible = false;

                    }
                    else if (noteID > 0)
                    {
                        NoteDetailsView.ChangeMode(DetailsViewMode.Edit);
                        //if (CheckEdit() != false)
                        EditLinkButton.Visible = true;
                        //if (CheckDelete() != false)
                        DeleteLinkButton.Visible = true;
                        FileDownloadLinkButton.Visible = true;
                    }
                }
                else
                {
                    NoteDetailsView.ChangeMode(DetailsViewMode.Insert);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        #endregion


        #region Note Tab Functions.................

        protected void NoteDetailLinkButton_Click(object sender, EventArgs e)
        {
            Session.Remove("EditParentID");
            Session.Remove("FilePath");
            Session.Remove("NoteParentName");
            Session["EditNoteID"] = 0;
            NoteDetailsView.DataSource = null;
            NoteDetailsView.DataBind();
            NoteDetailsView.ChangeMode(DetailsViewMode.Insert);
        }

        protected void ViewNoteLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            SearchTextBox.Text = "";

            NotesListGridView.DataSourceID = NotesListObjectDataSource.ID;
            this.NotesListGridView.DataBind();
            this.NotesListGridView.SelectedIndex = -1;
            this.NoteMiniDetailFormView.DataBind();
            this.NoteMiniMoreDetailsView.DataBind();
            NotesListUpdatePanel.Update();
            NoteMiniDetailsUpdatePanel.Update();
        }


        #endregion


        #region Note Dropdown List Functions........
        protected void AssaigendUserDropDownList_Init(object sender, EventArgs e)
        {
            AssaigendUserDropDownList = sender as DropDownList;
        }

        protected void ParentTypeDropDownList_Init(object sender, EventArgs e)
        {
            ParentTypeDropDownList = sender as DropDownList;
        }

        #endregion

        #region Note Insert Functions............

        protected void NoteDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
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

            if (Convert.ToInt32(AssaigendUserDropDownList.SelectedValue) == 0) { e.Values["AssignedUserID"] = null; }
            else { e.Values["AssignedUserID"] = AssaigendUserDropDownList.SelectedValue; }

            if (ParentTypeDropDownList.SelectedValue.ToString() == "None") { e.Values["ParentType"] = null; }
            else { e.Values["ParentType"] = ParentTypeDropDownList.SelectedValue.ToString(); }

            if (Session["EditParentID"] != null)
            {
                long editParentID = Convert.ToInt64(Session["EditParentID"]);
                e.Values["ParentID"] = editParentID;
            }
            else
            {
                e.Values["ParentID"] = null;
            }
            //e.Values["FilePath"] = Session["FilePath"].ToString();
            if (Session["FilePath"] != null)
            {
                string fp = Session["FilePath"].ToString();
                e.Values["FilePath"] = fp.ToString();
            }
            else
            {
                e.Values["FilePath"] = null;
            }

            e.Values["CreatedBy"] = userid;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;

        }


        protected void NoteDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
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

                NoteDetailsView.DataBind();
                this.NotesListGridView.DataBind();
                this.NoteMiniDetailFormView.DataBind();
                this.NoteMiniMoreDetailsView.DataBind();

                MessageLiteral.Text = "Success </br></br> <p> Note has been successfully saved <br/> </p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                NoteDetailsView.ChangeMode(DetailsViewMode.Insert);

                Session["EditNoteID"] = 0;
                Session.Remove("EditParentID");
                Session.Remove("FilePath");
                Session.Remove("NoteParentName");
            }
        }




        #endregion


        #region Note Update Functions.............

        protected void NoteDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            userid = Convert.ToInt64(Session["UserID"]);

            if (Convert.ToInt32(AssaigendUserDropDownList.SelectedValue) == 0) { e.NewValues["AssignedUserID"] = null; }
            else { e.NewValues["AssignedUserID"] = AssaigendUserDropDownList.SelectedValue; }

            if (ParentTypeDropDownList.SelectedValue.ToString() == "None") { e.NewValues["ParentType"] = null; }
            else { e.NewValues["ParentType"] = ParentTypeDropDownList.SelectedValue.ToString(); }


            if (Session["EditParentID"] != null)
            {
                long editParentID = Convert.ToInt64(Session["EditParentID"]);
                e.NewValues["ParentID"] = editParentID;
            }
            else
            {
                e.NewValues["ParentID"] = null;
            }

            e.NewValues["ModifiedBy"] = userid;
            e.NewValues["ModifiedTime"] = DateTime.Now;

        }

        protected void NoteDetailsObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
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
                NoteDetailsView.DataBind();
                this.NotesListGridView.DataBind();
                this.NoteMiniDetailFormView.DataBind();
                this.NoteMiniMoreDetailsView.DataBind();

                MessageLiteral.Text = "Success </br></br> <p> Note has been successfully updated <br/> </p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                NoteDetailsView.ChangeMode(DetailsViewMode.Insert);

                Session["EditNoteID"] = 0;
                Session.Remove("EditParentID");
                Session.Remove("FilePath");
                Session.Remove("NoteParentName");

            }
        }

        #endregion




        #region Note Select And Command Functions..........

        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {

            string parentType = String.Empty;
            long parenID = 0;

            if (e.CommandArgument.ToString() != null)
            {
                //selected List
                int gindex = Convert.ToInt32(NotesListGridView.SelectedIndex);
                if (gindex > -1)
                {
                    LinkButton nlbtn = NotesListGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                    nlbtn.CssClass = "";
                }
                LinkButton lbtn = sender as LinkButton;
                lbtn.CssClass = "active";
                //if (CheckEdit() != false)
                EditLinkButton.Visible = true;
                // if (CheckDelete() != false)
                DeleteLinkButton.Visible = true;
                FileDownloadLinkButton.Visible = true;


                try
                {
                    string arguments = Convert.ToString(e.CommandArgument);
                    string[] arg = arguments.Split(';');

                    Session["EditNoteID"] = Convert.ToInt64(arg[0]);
                    noteID = Convert.ToInt64(arg[0]);

                    if (arg[1] != String.Empty)
                    {
                        Session["EditParentID"] = Convert.ToInt64(arg[1]);
                        parenID = Convert.ToInt64(arg[1]);
                    }

                    if (arg[2] != String.Empty)
                    {
                        parentType = Convert.ToString(arg[2]);
                    }
                    if (arg[3] != String.Empty)
                    {
                        Session["FilePath"] = Convert.ToString(arg[3]);
                    }
                }

                catch (Exception ex)
                {
                    throw ex;
                }


                switch (parentType.ToString())
                {
                    case "Accounts":
                        IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(parenID);
                        foreach (var account in accounts)
                        {
                            string pn = account.Name.ToString();
                            Session["NoteParentName"] = account.Name.ToString();
                        }
                        break;
                    case "Teams":
                        IEnumerable<Team> teams = teamBL.GetTeamsByID(parenID);

                        foreach (var team in teams)
                        {
                            Session["NoteParentName"] = team.Name;
                        }
                        break;
                    case "Users":
                        IEnumerable<User> users = userBL.GetUsersByID(parenID);

                        foreach (var user in users)
                        {
                            Session["NoteParentName"] = user.FirstName;
                        }
                        break;
                    case "Contacts":
                        IEnumerable<DAL.Contact> contacts = contactBL.GetContactByID(parenID);

                        foreach (var contact in contacts)
                        {
                            Session["NoteParentName"] = contact.FirstName;
                        }
                        break;
                    case "Opportunity":
                        long opportunityId = Convert.ToInt64(parenID);
                        IEnumerable<Opportunity> opportunits = opportunityBL.OpportunityByID(opportunityId);

                        foreach (var opportunity in opportunits)
                        {
                            Session["NoteParentName"] = opportunity.Name;
                        }
                        break;
                    case "":
                        Session["NoteParentName"] = String.Empty;
                        break;

                }


                NotesListUpdatePanel.Update();
                NoteMiniDetailsUpdatePanel.Update();
                NoteMiniDetailFormView.DataBind();
                NoteMiniMoreDetailsView.DataBind();
            }
            else
            {
                Session["EditNoteID"] = 0;

            }


        }


        protected void NoteDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Session["EditNoteID"] = 0;
                Session.Remove("EditParentID");
                Session.Remove("FilePath");
                Session.Remove("NoteParentName");

                MessageLiteral.Text = "Changes discarded !</br></br> <p> Your changes have been discarded.</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                NoteDetailsView.DataBind();
                NoteDetailsView.ChangeMode(DetailsViewMode.Insert);


            }
        }


        protected void NoteDetailsView_DataBound(object sender, EventArgs e)
        {

            noteID = Convert.ToInt64(Session["EditNoteID"]);
            if (noteID != 0 && Session["NoteParentName"] != null)
            {
                TextBox ParentName = NoteDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = Session["NoteParentName"].ToString();

                FileFormat.Visible = false;
                NoteFileUpload.Visible = false;
                DownloadLinkButton.Visible = true;
            }
            else
            {
                NoteDetailsView.ChangeMode(DetailsViewMode.Insert);

                DownloadLinkButton.Visible = false;
                NoteFileUpload.Visible = true;
                FileFormat.Visible = true;
            }
        }

        #endregion



        #region Note Edit, Delete, Search Functions.......

        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            FileDownloadLinkButton.Visible = false;
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            SearchTextBox.Text = String.Empty;

            NotesListGridView.DataSourceID = NotesListObjectDataSource.ID;
            this.NotesListGridView.DataBind();
            this.NotesListGridView.SelectedIndex = -1;
            this.NoteMiniDetailFormView.DataBind();
            this.NoteMiniMoreDetailsView.DataBind();
            NotesListUpdatePanel.Update();
            NoteMiniDetailsUpdatePanel.Update();

        }

        protected void SearchLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;

            NotesListGridView.DataSourceID = SearchNoteObjectDataSource.ID;
            this.NotesListGridView.DataBind();
            this.NotesListGridView.SelectedIndex = -1;
            this.NoteMiniDetailFormView.DataBind();
            this.NoteMiniMoreDetailsView.DataBind();
            NotesListUpdatePanel.Update();
            NoteMiniDetailsUpdatePanel.Update();
        }


        protected void EditLinkButton_Click(object sender, EventArgs e)
        {
            noteID = Convert.ToInt64(Session["EditNoteID"]);

            if (noteID > 0)
            {
                NoteDetailsView.ChangeMode(DetailsViewMode.Edit);
            }
            else
            {
                NoteDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }

        protected void DeleteLinkButton_Click(object sender, EventArgs e)
        {
            noteID = Convert.ToInt64(Session["EditNoteID"]);
            noteBL = new NoteBL();
            noteBL.DeleteNoteByID(noteID);

            Session["EditNoteID"] = 0;
            Session.Remove("EditParentID");
            Session.Remove("FilePath");
            Session.Remove("NoteParentName");

            this.NotesListGridView.DataBind();
            this.NotesListGridView.SelectedIndex = -1;
            this.NoteMiniDetailFormView.DataBind();
            this.NoteMiniMoreDetailsView.DataBind();
            NotesListUpdatePanel.Update();
            NoteMiniDetailsUpdatePanel.Update();
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
        }



        #endregion




        #region Note Parent Type Search Functions.......

        protected void AccountSearch_Event(object sender, EventArgs e)
        {
            string search = AccountSearchTextBox.Text;
            accountBL.SearchAccount(search);
            this.AccountGridView.DataBind();
        }

        protected void TeamSearch_Event(object sender, EventArgs e)
        {
            string nameSearchString = AccountSearchTextBox.Text;
            teamBL.GetTeamsByName(nameSearchString);
            this.TeamsGridView.DataBind();
        }

        protected void UserSearch_Event(object sender, EventArgs e)
        {
            string nameSearchString = UserSearchTextBox.Text;
            userBL.GetUsersByFirstName(nameSearchString);
            this.UserGridView.DataBind();
        }

        protected void ContactSearch_Event(object sender, EventArgs e)
        {
            string nameSearchString = ContactSearchTextBox.Text;
            contactBL.GetContactByName(nameSearchString);
            this.ContactListGridView.DataBind();
        }

        protected void OpportunitySearch_Event(object sender, EventArgs e)
        {
            string search = OpportunitySearchTextBox.Text;
            opportunityBL.SearchOpportunities(search);
            this.OpportunityListGridView.DataBind();
        }


        #endregion


        #region Note Parent Type Select Functions.......

        protected void AccountListLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditParentID"] = e.CommandArgument.ToString();
            long accountID = Convert.ToInt64(Session["EditParentID"]);

            IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(accountID);
            foreach (var account in accounts)
            {
                string accountName = account.Name;
                TextBox ParentName = NoteDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = accountName;
            }

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }

        protected void TeamListLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditParentID"] = e.CommandArgument.ToString();
            long tid = Convert.ToInt64(Session["EditParentID"]);

            IEnumerable<Team> teams = teamBL.GetTeamsByID(tid);
            foreach (var team in teams)
            {
                string teamName = team.Name;
                TextBox ParentName = NoteDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = teamName;
            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }

        protected void UserListLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditParentID"] = e.CommandArgument.ToString();
            long uid = Convert.ToInt64(Session["EditParentID"]);

            IEnumerable<User> users = userBL.GetUsersByID(uid);
            foreach (var user in users)
            {
                string userName = user.FirstName + " " + user.LastName;
                TextBox ParentName = NoteDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = userName;
            }

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }

        protected void ContactListLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditParentID"] = e.CommandArgument.ToString();
            long contactID = Convert.ToInt64(Session["EditParentID"]);

            IEnumerable<DAL.Contact> contacts = contactBL.GetContactByID(contactID);
            foreach (var contact in contacts)
            {
                string contactName = contact.FirstName + " " + contact.LastName;
                TextBox ParentName = NoteDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = contactName;
            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }

        protected void OpportunityListLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditParentID"] = e.CommandArgument.ToString();
            long opportunitID = Convert.ToInt64(Session["EditParentID"]);
            IEnumerable<Opportunity> opportunitys = opportunityBL.OpportunityByID(opportunitID);
            foreach (var opportunity in opportunitys)
            {
                string opportunityName = opportunity.Name;
                TextBox ParentName = NoteDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = opportunityName;
            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }

        #endregion



        protected void ModalPopButton_Click(object sender, EventArgs e)
        {
            if (ParentTypeDropDownList.SelectedValue == "Accounts")
            {
                OpportunitySearchPanel.Visible = false;
                OpportunityListGridView.Visible = false;
                ContactSearchPanel.Visible = false;
                ContactListGridView.Visible = false;
                UserSearchPanel.Visible = false;
                UserGridView.Visible = false;
                TeamSearchPanel.Visible = false;
                TeamsGridView.Visible = false;
                AccountSearchPanel.Visible = true;
                AccountGridView.Visible = true;
                ModalTitleLabel.Text = "Select Accounts";

            }
            else if (ParentTypeDropDownList.SelectedValue == "Teams")
            {
                OpportunitySearchPanel.Visible = false;
                OpportunityListGridView.Visible = false;
                ContactSearchPanel.Visible = false;
                ContactListGridView.Visible = false;
                UserSearchPanel.Visible = false;
                UserGridView.Visible = false;
                AccountSearchPanel.Visible = false;
                AccountGridView.Visible = false;
                TeamSearchPanel.Visible = true;
                TeamsGridView.Visible = true;
                ModalTitleLabel.Text = "Select Teams";
            }
            else if (ParentTypeDropDownList.SelectedValue == "Users")
            {
                OpportunitySearchPanel.Visible = false;
                OpportunityListGridView.Visible = false;
                ContactSearchPanel.Visible = false;
                ContactListGridView.Visible = false;
                AccountSearchPanel.Visible = false;
                AccountGridView.Visible = false;
                TeamSearchPanel.Visible = false;
                TeamsGridView.Visible = false;
                UserSearchPanel.Visible = true;
                UserGridView.Visible = true;
                ModalTitleLabel.Text = "Select Users";
            }
            else if (ParentTypeDropDownList.SelectedValue == "Contacts")
            {
                OpportunitySearchPanel.Visible = false;
                OpportunityListGridView.Visible = false;
                AccountSearchPanel.Visible = false;
                AccountGridView.Visible = false;
                TeamSearchPanel.Visible = false;
                TeamsGridView.Visible = false;
                UserSearchPanel.Visible = false;
                UserGridView.Visible = false;
                ContactSearchPanel.Visible = true;
                ContactListGridView.Visible = true;
                ModalTitleLabel.Text = "Select Contacts";
            }
            else if (ParentTypeDropDownList.SelectedValue == "Opportunity")
            {
                AccountSearchPanel.Visible = false;
                AccountGridView.Visible = false;
                TeamSearchPanel.Visible = false;
                TeamsGridView.Visible = false;
                UserSearchPanel.Visible = false;
                UserGridView.Visible = false;
                ContactSearchPanel.Visible = false;
                ContactListGridView.Visible = false;
                OpportunitySearchPanel.Visible = true;
                OpportunityListGridView.Visible = true;
                ModalTitleLabel.Text = "Select Opportunity";
            }
            else if (ParentTypeDropDownList.SelectedValue == "None")
            {
                AccountSearchPanel.Visible = false;
                AccountGridView.Visible = false;
                TeamSearchPanel.Visible = false;
                TeamsGridView.Visible = false;
                UserSearchPanel.Visible = false;
                UserGridView.Visible = false;
                ContactSearchPanel.Visible = false;
                ContactListGridView.Visible = false;
                OpportunitySearchPanel.Visible = false;
                OpportunityListGridView.Visible = false;
                ModalTitleLabel.Text = "Data Not Found";
            }
        }

        protected void NoteFileUpload_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {

            string year = DateTime.Today.Year.ToString(CultureInfo.InvariantCulture);
            string month = DateTime.Today.Month.ToString(CultureInfo.InvariantCulture);
            if (month.Length != 2) { month = "0" + month; }

            string date = DateTime.Today.Day.ToString(CultureInfo.InvariantCulture);
            if (date.Length != 2) { date = "0" + date; }

            string hour = DateTime.Now.Hour.ToString(CultureInfo.InvariantCulture);
            if (hour.Length != 2) { hour = "0" + hour; }

            string minute = DateTime.Now.Minute.ToString(CultureInfo.InvariantCulture);
            if (minute.Length != 2) { minute = "0" + minute; }

            string secound = DateTime.Now.Second.ToString(CultureInfo.InvariantCulture);
            if (secound.Length != 2) { secound = "0" + secound; }


            var test = companyID.ToString();
            int i = test.Length;
            int append = 8 - i;
            string serial = "";
            for (int j = 0; j < append; j++)
            {
                serial += "0";
            }
            serial = serial + companyID;

            string fileUploadDirectory = "~/UserData/Notes/" + companyID + "/";

            var PhysicalFileUploadDirectory = Server.MapPath(fileUploadDirectory);

            if (!Directory.Exists(PhysicalFileUploadDirectory))
            {
                Directory.CreateDirectory(PhysicalFileUploadDirectory);
            }

            string fileName = e.FileName;
            string extension = System.IO.Path.GetExtension(fileName);
            string fileNameWithoutExtension = System.IO.Path.GetFileNameWithoutExtension(fileName);

            //string imagefilename = "D" + serial + "-" + year + month + "-";
            string imagefilename = "N" + serial + "-" + year + month + date + hour + minute + secound + "";

            //string encodedImageName = Encryptdata(fileName);
            //string documentPath = string.Concat(fileUploadDirectory + imagefilename + encodedImageName + extension);
            string documentPath = string.Concat(fileUploadDirectory + imagefilename + extension);
            NoteFileUpload.SaveAs(Server.MapPath(documentPath));
            Session["FilePath"] = documentPath;


        }

        protected void DownloadLinkButton_Click(object sender, EventArgs e)
        {
            //NoteMiniDetailsUpdatePanel.Update();

            if (Session["FilePath"] != null)
            {
                string filePath = Session["FilePath"].ToString();
                if (filePath != "")
                {
                    string path = Server.MapPath(filePath);
                    System.IO.FileInfo file = new System.IO.FileInfo(path);
                    if (file.Exists)
                    {
                        Response.Clear();
                        Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
                        Response.AddHeader("Content-Length", file.Length.ToString());
                        Response.ContentType = "application/octet-stream";
                        Response.WriteFile(file.FullName);
                        Response.End();
                    }
                    else
                    {
                        Response.Write("This file does not exist.");
                    }

                }
                else
                {
                    Response.Write("This file does not exist.");
                }
            }
            else
            {
                Response.Write("This file does not exist.");
            }

        }


    }
}

//EditNoteID
//Session.Remove("EditParentID");
//Session.Remove("FilePath");
//Session.Remove("NoteParentName");
