using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.DAL;
using C3App.BLL;
using C3App.App_Code;
using System.Collections.Specialized;


namespace C3App.Tasks
{
    public partial class Tasks : PageBase
    {

        #region Initializing...........

        private DropDownList TeamDropDownList;
        private DropDownList AssaigendUserDropDownList;
        private DropDownList ContactDropDownList;
        private DropDownList StatusDropDownList;
        private DropDownList ParentTypeDropDownList;

        private TaskBL taskBL = new TaskBL();
        private AccountBL accountBL = new AccountBL();
        private TeamBL teamBL = new TeamBL();
        private UserBL userBL = new UserBL();
        private ContactBL contactBL = new ContactBL();
        private OpportunityBL opportunityBL = new OpportunityBL();

        private long taskID = 0;
        private Int32 companyID;

        #endregion



        #region Task Page Function..........

        protected void Page_Load(object sender, EventArgs e)
        {
            companyID = Convert.ToInt32(Session["CompanyID"]);
            try
            {
                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        Session["EditTaskID"] = 0;
                        Session.Remove("ReceiverName");
                        Session.Remove("ReceiverEmail");
                        Session.Remove("TaskSubject");
                        Session.Remove("AssignedUserID");
                        Session.Remove("EditParentID");
                        Session.Remove("TaskParentName");
                    }
                }
                if (Session["EditTaskID"] != null)
                {
                    taskID = Convert.ToInt64(Session["EditTaskID"]);
                    if (taskID == 0)
                    {
                        TaskDetailsView.ChangeMode(DetailsViewMode.Insert);

                        this.TaskListGridView.DataBind();
                        this.TaskListGridView.SelectedIndex = -1;
                        this.TaskMiniDetailFormView.DataBind();
                        this.TaskMiniMoreDetailsView.DataBind();
                        TaskListUpdatePanel.Update();
                        TaskMiniDetailsUpdatePanel.Update();

                        EditLinkButton.Visible = false;
                        DeleteLinkButton.Visible = false;
                        NotifyLinkButton.Visible = false;
                    }
                    else if (taskID > 0)
                    {
                        TaskDetailsView.ChangeMode(DetailsViewMode.Edit);
                        if (CheckEdit() != false)
                            EditLinkButton.Visible = true;
                        if (CheckDelete() != false)
                            DeleteLinkButton.Visible = true;
                        NotifyLinkButton.Visible = true;
                    }
                }
                else
                {
                    TaskDetailsView.ChangeMode(DetailsViewMode.Insert);
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
            ExceptionUtility.LogException(exc, "TaskPage");
            ExceptionUtility.NotifySystemOps(exc, "TaskPage");
            Server.ClearError();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            TaskDetailsView.EnableDynamicData(typeof(Task));
        }

        #endregion


        #region Task Tab Function........

        protected void TaskDetailLinkButton_Click(object sender, EventArgs e)
        {
            Session["EditTaskID"] = 0;
            Session.Remove("ReceiverName");
            Session.Remove("ReceiverEmail");
            Session.Remove("TaskSubject");
            Session.Remove("AssignedUserID");
            Session.Remove("EditParentID");
            Session.Remove("TaskParentName");

            TaskDetailsView.DataSource = null;
            TaskDetailsView.DataBind();
            TaskDetailsView.ChangeMode(DetailsViewMode.Insert);
        }

        protected void ViewTaskLinkButton_Click(object sender, EventArgs e)
        {
            TaskListGridView.DataSourceID = TaskListObjectDataSource.ID;
            TaskListGridView.SelectedIndex = -1;
            TaskListGridView.DataBind();
            TaskListUpdatePanel.Update();
            TaskMiniDetailsUpdatePanel.Update();
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            Session["EditTaskID"] = 0;
            Session.Remove("ReceiverName");
            Session.Remove("ReceiverEmail");
            Session.Remove("TaskSubject");
            Session.Remove("AssignedUserID");
            Session.Remove("EditParentID");
            Session.Remove("TaskParentName");
        }

        #endregion


        #region Task Insert Function..........
        protected void TaskDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            long userid;

            Session["TaskSubject"] = e.Values["Subject"];

            CheckBox notifyCheckbox = TaskDetailsView.FindControl("NotifyCheckBox") as CheckBox;
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

            if (Session["EditParentID"] != null)
            {
                long editParentID = Convert.ToInt64(Session["EditParentID"]);
                e.Values["ParentID"] = editParentID;
            }
            else
            {
                e.Values["ParentID"] = null;
            }

            if (Convert.ToInt32(AssaigendUserDropDownList.SelectedValue) == 0) { e.Values["AssignedUserID"] = null; }
            else { e.Values["AssignedUserID"] = AssaigendUserDropDownList.SelectedValue; }

            if (Convert.ToInt32(StatusDropDownList.SelectedValue) == 0) { e.Values["StatusID"] = null; }
            else { e.Values["StatusID"] = StatusDropDownList.SelectedValue; }

            if (Convert.ToInt32(ContactDropDownList.SelectedValue) == 0) { e.Values["ContactID"] = null; }
            else { e.Values["ContactID"] = ContactDropDownList.SelectedValue; }

            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.Values["TeamID"] = null; }
            else { e.Values["TeamID"] = TeamDropDownList.SelectedValue; }

            if (ParentTypeDropDownList.SelectedValue.ToString() == "None") { e.Values["ParentType"] = null; }
            else { e.Values["ParentType"] = ParentTypeDropDownList.SelectedValue.ToString(); }

            e.Values["CreatedBy"] = userid;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;

        }

        protected void TaskDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
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
                string taskSubject = Session["TaskSubject"].ToString();
                long assignedUserID = Convert.ToInt64(Session["AssignedUserID"]);
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
                        templateValues.Add("<%=ModuleName%>", "Tasks");
                        templateValues.Add("<%=Key%>", "Task Subject");
                        templateValues.Add("<%=Value%>", taskSubject);
                        C3App.App_Code.Notification.Notify("Tasks", taskID, 1, touser, 2, templateValues);



                        NotifyMessage = "and successfully notify to " + receivername;
                    }
                    catch (Exception ex)
                    {
                        NotifyMessage = "but notification unsuccess </br> Problem is : " + ex.Message.ToString();
                    }
                }

                TaskDetailsView.DataBind();
                this.TaskListGridView.DataBind();
                this.TaskMiniDetailFormView.DataBind();
                this.TaskMiniMoreDetailsView.DataBind();

                MessageLiteral.Text = "Success </br></br> <p> Task has been successfully saved <br/> " + NotifyMessage + "</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                TaskDetailsView.ChangeMode(DetailsViewMode.Insert);

                Session["EditTaskID"] = 0;
                Session.Remove("TaskSubject");
                Session.Remove("AssignedUserID");
                Session.Remove("NotifyUser");
            }
        }



        #endregion


        #region Task Update Function...........
        protected void TaskDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            Session["TaskSubject"] = e.NewValues["Subject"];

            CheckBox notifyCheckbox = TaskDetailsView.FindControl("NotifyCheckBox") as CheckBox;
            if (notifyCheckbox.Checked)
            {
                Session["NotifyUser"] = 1;
            }
            else
            {
                Session["NotifyUser"] = 2;
            }


            long parenid = Convert.ToInt64(Session["EditParentID"]);
            if (parenid > 0) { e.NewValues["ParentID"] = parenid; }
            else { e.NewValues["ParentID"] = null; }

            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.NewValues["TeamID"] = null; }
            else { e.NewValues["TeamID"] = TeamDropDownList.SelectedValue; }

            if (Convert.ToInt32(StatusDropDownList.SelectedValue) == 0) { e.NewValues["StatusID"] = null; }
            else { e.NewValues["StatusID"] = StatusDropDownList.SelectedValue; }

            if (Convert.ToInt32(ContactDropDownList.SelectedValue) == 0) { e.NewValues["ContactID"] = null; }
            else { e.NewValues["ContactID"] = ContactDropDownList.SelectedValue; }

            if (Convert.ToInt64(AssaigendUserDropDownList.SelectedValue) == 0) { e.NewValues["AssignedUserID"] = null; }
            else { e.NewValues["AssignedUserID"] = Convert.ToInt64(AssaigendUserDropDownList.SelectedValue); }

            if (ParentTypeDropDownList.SelectedValue.ToString() == "None") { e.NewValues["ParentType"] = null; }
            else { e.NewValues["ParentType"] = ParentTypeDropDownList.SelectedValue.ToString(); }

            e.NewValues["ModifiedBy"] = Convert.ToInt64(Session["UserID"]);
            e.NewValues["ModifiedTime"] = DateTime.Now;
        }

        protected void TaskDetailsObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
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
                taskID = Convert.ToInt64(Session["EditTaskID"]);
                string taskSubject = Session["TaskSubject"].ToString();
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
                        templateValues.Add("<%=ModuleName%>", "Tasks");
                        templateValues.Add("<%=Key%>", "Task Subject");
                        templateValues.Add("<%=Value%>", taskSubject);
                        C3App.App_Code.Notification.Notify("Tasks", taskID, 1, touser, 2, templateValues);

                        NotifyMessage = "and successfully notify to " + receivername;
                    }
                    catch (Exception ex)
                    {
                        NotifyMessage = "Notification unsuccess </br> Problem is : " + ex.Message.ToString();
                    }
                }

                MessageLiteral.Text = "Success </br></br> <p> Task has been successfully updated <br/> " + NotifyMessage + "</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

                TaskDetailsView.ChangeMode(DetailsViewMode.Insert);

                Session["EditTaskID"] = 0;
                Session.Remove("TaskSubject");
                Session.Remove("AssignedUserID");
                Session.Remove("NotifyUser");

                this.TaskListGridView.DataBind();
                this.TaskMiniDetailFormView.DataBind();
                this.TaskMiniMoreDetailsView.DataBind();
                TaskDetailsView.DataBind();
            }
        }

        #endregion



        #region Task Select And Command Function..........
        protected void TaskDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Session["EditTaskID"] = 0;
                Session.Remove("ReceiverName");
                Session.Remove("ReceiverEmail");
                Session.Remove("TaskSubject");
                Session.Remove("AssignedUserID");
                Session.Remove("EditParentID");
                Session.Remove("TaskParentName");
                Session.Remove("NotifyUser");

                MessageLiteral.Text = "Changes discarded !</br></br> <p> Your changes have been discarded.</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                TaskDetailsView.DataBind();
                TaskDetailsView.ChangeMode(DetailsViewMode.Insert);


            }
        }

        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            string parentType = String.Empty;
            long parenID = 0;

            if (e.CommandArgument.ToString() != null)
            {
                //selected List
                int gindex = Convert.ToInt32(TaskListGridView.SelectedIndex);
                if (gindex > -1)
                {
                    LinkButton nlbtn = TaskListGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
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

                    Session["EditTaskID"] = Convert.ToInt64(arg[0]);
                    taskID = Convert.ToInt64(arg[0]);

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
                        Session["EditParentID"] = Convert.ToInt64(arg[2]);
                        parenID = Convert.ToInt64(arg[2]);
                    }

                    if (arg[3] != String.Empty)
                    {
                        parentType = Convert.ToString(arg[3]);
                    }
                    if (arg[4] != String.Empty)
                    {
                        Session["TaskSubject"] = Convert.ToString(arg[4]);
                    }
                }

                catch (Exception ex)
                {
                    throw ex;
                }




                //if (parentType.ToString() == "Accounts" && parenID != 0)
                //{

                //    IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(parenID);
                //    foreach (var account in accounts)
                //    {
                //        string pn = account.Name.ToString();
                //        Session["TaskParentName"] = account.Name.ToString();

                //    }
                //}


                //else if (parentType.ToString() == "Teams" && parenID != 0)
                //{
                //    IEnumerable<Team> teams = teamBL.GetTeamsByID(parenID);

                //    foreach (var team in teams)
                //    {
                //        Session["TaskParentName"] = team.Name;
                //    }
                //}


                //else if (parentType.ToString() == "Users" && parenID != 0)
                //{
                //    IEnumerable<User> users = userBL.GetUsersByID(parenID);

                //    foreach (var user in users)
                //    {
                //        Session["TaskParentName"] = user.FirstName;
                //    }
                //}


                //else if (parentType.ToString() == "Contacts" && parenID != 0)
                //{
                //    IEnumerable<DAL.Contact> contacts = contactBL.GetContactByID(parenID);

                //    foreach (var contact in contacts)
                //    {
                //        Session["TaskParentName"] = contact.FirstName;
                //    }
                //}


                //else if (parentType.ToString() == "Opportunity" && parenID != 0)
                //{
                //    long opportunityId = Convert.ToInt64(parenID);
                //    IEnumerable<Opportunity> opportunits = opportunityBL.OpportunityByID(opportunityId);

                //    foreach (var opportunity in opportunits)
                //    {
                //        Session["TaskParentName"] = opportunity.Name;
                //    }
                //}
                //else
                //{
                //    Session["TaskParentName"] = String.Empty;
                //}


                switch (parentType.ToString())
                {
                    case "Accounts":
                        IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(parenID);
                        foreach (var account in accounts)
                        {
                            string pn = account.Name.ToString();
                            Session["TaskParentName"] = account.Name.ToString();
                        }
                        break;
                    case "Teams":
                        IEnumerable<Team> teams = teamBL.GetTeamsByID(parenID);

                        foreach (var team in teams)
                        {
                            Session["TaskParentName"] = team.Name;
                        }
                        break;
                    case "Users":
                        IEnumerable<User> users = userBL.GetUsersByID(parenID);

                        foreach (var user in users)
                        {
                            Session["TaskParentName"] = user.FirstName;
                        }
                        break;
                    case "Contacts":
                        IEnumerable<DAL.Contact> contacts = contactBL.GetContactByID(parenID);

                        foreach (var contact in contacts)
                        {
                            Session["TaskParentName"] = contact.FirstName;
                        }
                        break;
                    case "Opportunity":
                        long opportunityId = Convert.ToInt64(parenID);
                        IEnumerable<Opportunity> opportunits = opportunityBL.OpportunityByID(opportunityId);

                        foreach (var opportunity in opportunits)
                        {
                            Session["TaskParentName"] = opportunity.Name;
                        }
                        break;
                    case "":
                        Session["TaskParentName"] = String.Empty;
                        break;

                }


                TaskMiniDetailsUpdatePanel.Update();
                TaskMiniDetailFormView.DataBind();
                TaskMiniMoreDetailsView.DataBind();
            }
            else
            {
                Session["EditTaskID"] = 0;
            }
        }

        protected void TaskDetailsView_DataBound(object sender, EventArgs e)
        {
            taskID = Convert.ToInt64(Session["EditTaskID"]);
            if (taskID != 0 && Session["TaskParentName"] != null)
            {
                TextBox ParentName = TaskDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = Session["TaskParentName"].ToString();
            }
            else
            {
                TaskDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }

        #endregion



        #region Task Edit, Delete, Search Function.......

        protected void EditLinkButton_Click(object sender, EventArgs e)
        {
            taskID = Convert.ToInt64(Session["EditTaskID"]);

            if (taskID > 0)
            {
                TaskDetailsView.ChangeMode(DetailsViewMode.Edit);
            }
            else
            {
                TaskDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }

        protected void DeleteLinkButton_Click(object sender, EventArgs e)
        {
            taskID = Convert.ToInt64(Session["EditTaskID"]);
            taskBL.DeleteTaskByID(taskID);

            this.TaskListGridView.DataBind();
            this.TaskListGridView.SelectedIndex = -1;
            this.TaskMiniDetailFormView.DataBind();
            this.TaskMiniMoreDetailsView.DataBind();
            TaskListUpdatePanel.Update();
            TaskMiniDetailsUpdatePanel.Update();

            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            Session["EditTaskID"] = 0;
            Session.Remove("ReceiverName");
            Session.Remove("ReceiverEmail");
            Session.Remove("TaskSubject");
            Session.Remove("AssignedUserID");
            Session.Remove("EditParentID");
            Session.Remove("TaskParentName");
        }

        protected void SearchLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            TaskListGridView.DataSourceID = SearchTaskObjectDataSource.ID;
            this.TaskListGridView.DataBind();
            this.TaskListGridView.SelectedIndex = -1;
            this.TaskMiniDetailFormView.DataBind();
            this.TaskMiniMoreDetailsView.DataBind();
            TaskListUpdatePanel.Update();
            TaskMiniDetailsUpdatePanel.Update();
        }

        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            TaskListGridView.DataSourceID = TaskListObjectDataSource.ID;
            this.TaskListGridView.DataBind();
            this.TaskListGridView.SelectedIndex = -1;
            this.TaskMiniDetailFormView.DataBind();
            this.TaskMiniMoreDetailsView.DataBind();
            TaskListUpdatePanel.Update();
            TaskMiniDetailsUpdatePanel.Update();
        }

        protected void SearchNotStartedLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            TaskListGridView.DataSourceID = SearchNotStartedTaskObjectDataSource.ID;
            this.TaskListGridView.DataBind();
            this.TaskListGridView.SelectedIndex = -1;
            this.TaskMiniDetailFormView.DataBind();
            this.TaskMiniMoreDetailsView.DataBind();
            TaskListUpdatePanel.Update();
            TaskMiniDetailsUpdatePanel.Update();
        }

        protected void SearchInProgressLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            TaskListGridView.DataSourceID = SearchInProgressTaskObjectDataSource.ID;
            this.TaskListGridView.DataBind();
            this.TaskListGridView.SelectedIndex = -1;
            this.TaskMiniDetailFormView.DataBind();
            this.TaskMiniMoreDetailsView.DataBind();
            TaskListUpdatePanel.Update();
            TaskMiniDetailsUpdatePanel.Update();
        }

        protected void SearchCompletedLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            NotifyLinkButton.Visible = false;

            TaskListGridView.DataSourceID = SearchCompletedTaskObjectDataSource.ID;
            this.TaskListGridView.DataBind();
            this.TaskListGridView.SelectedIndex = -1;
            this.TaskMiniDetailFormView.DataBind();
            this.TaskMiniMoreDetailsView.DataBind();
            TaskListUpdatePanel.Update();
            TaskMiniDetailsUpdatePanel.Update();
        }

        #endregion



        #region Dropdown List Initialization....

        protected void TeamDropDownList_Init(object sender, EventArgs e)
        {
            TeamDropDownList = sender as DropDownList;
        }

        protected void AssaigendUserDropDownList_Init(object sender, EventArgs e)
        {
            AssaigendUserDropDownList = sender as DropDownList;
        }

        protected void ContactDropDownList_Init(object sender, EventArgs e)
        {
            ContactDropDownList = sender as DropDownList;
        }

        protected void StatusDropDownList_Init(object sender, EventArgs e)
        {
            StatusDropDownList = sender as DropDownList;
        }

        protected void ParentTypeDropDownList_Init(object sender, EventArgs e)
        {
            ParentTypeDropDownList = sender as DropDownList;
        }
        #endregion



        #region Task Modal Function..........
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
        #endregion


        #region Account Function........
        protected void AccountSearch_Event(object sender, EventArgs e)
        {
            string search = AccountSearchTextBox.Text;
            accountBL.SearchAccount(search);
            this.AccountGridView.DataBind();
        }

        protected void AccountListLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditParentID"] = e.CommandArgument.ToString();
            long accountID = Convert.ToInt64(Session["EditParentID"]);

            IEnumerable<DAL.Account> accounts = accountBL.GetAccountByID(accountID);
            foreach (var account in accounts)
            {
                string accountName = account.Name;
                TextBox ParentName = TaskDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = accountName;
            }

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }
        #endregion


        #region Team Function...........
        protected void TeamSearch_Event(object sender, EventArgs e)
        {
            string nameSearchString = AccountSearchTextBox.Text;
            teamBL.GetTeamsByName(nameSearchString);
            this.TeamsGridView.DataBind();
        }

        protected void TeamListLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditParentID"] = e.CommandArgument.ToString();
            long tid = Convert.ToInt64(Session["EditParentID"]);

            IEnumerable<Team> teams = teamBL.GetTeamsByID(tid);
            foreach (var team in teams)
            {
                string teamName = team.Name;
                TextBox ParentName = TaskDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = teamName;
            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }
        #endregion


        #region User Function.........
        protected void UserSearch_TextChanged(object sender, EventArgs e)
        {
            string nameSearchString = UserSearchTextBox.Text;
            userBL.GetUsersByFirstName(nameSearchString);
            this.UserGridView.DataBind();
        }

        protected void UserListLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditParentID"] = e.CommandArgument.ToString();
            long uid = Convert.ToInt64(Session["EditParentID"]);

            IEnumerable<User> users = userBL.GetUsersByID(uid);
            foreach (var user in users)
            {
                string userName = user.FirstName + " " + user.LastName;
                TextBox ParentName = TaskDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = userName;
            }

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }
        #endregion


        #region Contact Function.......
        protected void ContactSearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string nameSearchString = ContactSearchTextBox.Text;
            contactBL.GetContactByName(nameSearchString);
            this.ContactListGridView.DataBind();
        }

        protected void ContactListLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditParentID"] = e.CommandArgument.ToString();
            long contactID = Convert.ToInt64(Session["EditParentID"]);

            IEnumerable<DAL.Contact> contacts = contactBL.GetContactByID(contactID);
            foreach (var contact in contacts)
            {
                string contactName = contact.FirstName + " " + contact.LastName;
                TextBox ParentName = TaskDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = contactName;
            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }
        #endregion


        #region Opportunity........
        protected void OpportunitySearch_TextChanged(object sender, EventArgs e)
        {
            string search = OpportunitySearchTextBox.Text;
            opportunityBL.SearchOpportunities(search);
            this.OpportunityListGridView.DataBind();
        }

        protected void OpportunityListLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditParentID"] = e.CommandArgument.ToString();
            long opportunitID = Convert.ToInt64(Session["EditParentID"]);
            IEnumerable<Opportunity> opportunitys = opportunityBL.OpportunityByID(opportunitID);
            foreach (var opportunity in opportunitys)
            {
                string opportunityName = opportunity.Name;
                TextBox ParentName = TaskDetailsView.FindControl("ParentNameTextBox") as TextBox;
                ParentName.Text = opportunityName;
            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }
        #endregion


        #region Task Notifications Functions.........

        protected void AssaigendUserDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            Label notifylabel = TaskDetailsView.FindControl("NotifyLabel") as Label;
            CheckBox notifyCheckbox = TaskDetailsView.FindControl("NotifyCheckBox") as CheckBox;
            if (AssaigendUserDropDownList.SelectedItem.Text != "None")
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
            Session["AssignedUserID"] = AssaigendUserDropDownList.SelectedValue;
        }


        protected void NotifyLinkButton_Click(object sender, EventArgs e)
        {
            taskID = Convert.ToInt64(Session["EditTaskID"]);
            string touser = Session["ReceiverEmail"].ToString();
            string receivername = Session["ReceiverName"].ToString();
            string taskSubject = Session["TaskSubject"].ToString();
            string notifyMessage = String.Empty;
            try
            {
                ListDictionary templateValues = new ListDictionary();
                templateValues.Add("<%=ModuleName%>", "Tasks");
                templateValues.Add("<%=Key%>", "Task Subject");
                templateValues.Add("<%=Value%>", taskSubject);
                C3App.App_Code.Notification.Notify("Tasks", taskID, 1, touser, 2, templateValues);
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
            Session.Remove("TaskSubject");

        }

        #endregion


    }
}
//Session["EditTaskID"]=0;
//Session.Remove("ReceiverName");
//Session.Remove("ReceiverEmail");
//Session.Remove("TaskSubject");
//Session.Remove("AssignedUserID");
//Session.Remove("EditParentID");
//Session.Remove("TaskParentName");
//Session.Remove("NotifyUser");

