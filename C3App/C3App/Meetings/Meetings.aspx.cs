using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.App_Code;
using C3App.BLL;
using C3App.DAL;
using Calendar = System.Web.UI.WebControls.Calendar;
using Notification = C3App.App_Code.Notification;

namespace C3App.Meetings
{
    public partial class Meetings : PageBase
    {

        #region Initializing....
        MeetingBL meetingBL = new MeetingBL();
        ContactBL contactBL = new ContactBL();
        UserBL userBL = new UserBL();
        private Calendar calendar;
        long meetingID = 0;
        #endregion


        #region Page Functions.....
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Request.QueryString["ShowPanel"] != null)
            {
                if ((!IsPostBack) || (Request.QueryString["ShowPanel"] == "DetailsPanel"))
                {
                    Session.Remove("EditMeetingID");
                    Session["inviteeName"] = "";
                }
            }

            try
            {
                long meetingID = Convert.ToInt64(Session["EditMeetingID"]);
                MeetingDetailsView.ChangeMode(meetingID == 0 ? DetailsViewMode.Insert : DetailsViewMode.Edit);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void MeetingDetailsView_DataBound(object sender, EventArgs e)
        {
            meetingID = Convert.ToInt64(Session["EditMeetingID"]);
            TextBox attendeeName = MeetingDetailsView.FindControl("AttendeeTextBox") as TextBox;
            if (meetingID == 0)
            {
                MeetingDetailsView.ChangeMode(DetailsViewMode.Insert);
                attendeeName.Text = "";
            }
            else
            {
                MeetingDetailsView.ChangeMode(DetailsViewMode.Edit);
                attendeeName.Text = Session["inviteeName"].ToString();
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
            ExceptionUtility.LogException(exc, "MeetingsPage");
            ExceptionUtility.NotifySystemOps(exc, "MeetingsPage");
            Server.ClearError();
        }


        #endregion


        #region Tab function.....
        protected void ViewMeetingLinkButton_Click(object sender, EventArgs e)
        {

        }
        #endregion


        #region select and Command Function of Meeting...

        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            string contactName = String.Empty;
            string email = String.Empty;
            string targetid = String.Empty;

            if (e.CommandArgument.ToString() != null)
            {
                Session["EditMeetingID"] = e.CommandArgument.ToString();
                meetingID = Convert.ToInt64(e.CommandArgument.ToString());


                //int gindex = Convert.ToInt32(WeeklyMeetingGridView.SelectedIndex);
                //if (gindex > -1)
                //{
                //    LinkButton nlbtn = WeeklyMeetingGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                //    nlbtn.CssClass = "";

                //}
                //LinkButton lbtn = sender as LinkButton;
                //lbtn.CssClass = "active";


                IEnumerable<DAL.Contact> contacts = contactBL.GetContactByMeetingInvitee(meetingID);
                foreach (var contact in contacts)
                {
                    contactName += contact.FirstName.ToString() + ", ";
                    email += contact.PrimaryEmail.ToString() + ";";
                    targetid += contact.ContactID.ToString() + ";";
                }
                Session["inviteeName"] = contactName.TrimEnd(',');
                Session["toUser"] = email;
                Session["targetID"] = targetid;
            }
            else
            {
                Session["EditMeetingID"] = 0;
            }

        }

        protected void MeetingDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Session["EditMeetingID"] = 0;
                Session.Remove("targetID");
                Session["toUser"] = "";
                MessageLiteral.Text = "Changes discarded <br /> <br /> <p>Your changes have been discarded</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                MeetingDetailsView.DataBind();
                MeetingDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }


        #endregion


        #region Insert Function of Meeting...

        protected void MeetingCreateLinkButton_Click(object sender, EventArgs e)
        {
            ModalTitleLabel.Text = "Create Meeting";
            Session["EditMeetingID"] = 0;
            Session["inviteeName"] = "";
            MeetingDetailsView.ChangeMode(DetailsViewMode.Insert);
            MeetingDetailsView.DataBind();
            MeetingTargetListUpdatePanel.Update();
            ContactGridView.DataBind();
        }

        protected void MeetingDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {

            Session["Subject"] = e.Values["Subject"];

            TextBox startdatetextbox = (TextBox)MeetingDetailsView.FindControl("DateStartTextBox");
            TextBox startTimetextbox = (TextBox)MeetingDetailsView.FindControl("StartTimeTextBox");
            CheckBox allDayCheckBox = (CheckBox)MeetingDetailsView.FindControl("AllDayCheckBox");
            TextBox endDatetextbox = (TextBox)MeetingDetailsView.FindControl("DateEndTextBox");
            TextBox endTimetextbox = (TextBox)MeetingDetailsView.FindControl("EndTimeTextBox");


            string startTime, endtime;
            //Set start Meeting Date & Time

            string getstartDate = startdatetextbox.Text;
            DateTime dateStart = DateTime.Parse(getstartDate);
            string fulldate = dateStart.ToString("MM-dd-yyyy HH:mm tt");
            string startdate = fulldate.Split(' ')[0];
            if (allDayCheckBox.Checked)
            {
                startTime = "09:00";
                endtime = "05:00";
            }
            else
            {
                startTime = startTimetextbox.Text;
                endtime = endTimetextbox.Text;
            }
            string startdatetime = (startdate + " " + startTime);


            //Set end Meeting Date & Time
            string getEndDate = endDatetextbox.Text;
            DateTime dateEnd = DateTime.Parse(getEndDate);
            string dateend = dateEnd.ToString("MM-dd-yyyy HH:mm tt");
            string endDate = dateend.Split(' ')[0];
            string endDatetime = (endDate + " " + endtime);
            int result = DateTime.Compare(dateStart, dateEnd);
            if (result <= 0)
            {
                e.Values["StartDate"] = startdatetime;
                e.Values["EndDate"] = endDatetime;
            }


            e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["CreatedBy"] = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["ModifiedBy"] = Convert.ToInt64(HttpContext.Current.Session["UserID"]);

        }

        protected void MeetingDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
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
                    string mailresult = String.Empty;

                    if (Session["toUser"] != null)
                    {
                        string usertname = String.Empty;
                        long recentmeetingID = Convert.ToInt64(Session["NewMeeting"]);
                        ListDictionary templateValues = new ListDictionary();
                        string subject = e.Values["Subject"].ToString();
                        string startDate = e.Values["StartDate"].ToString();
                        string endDate = e.Values["EndDate"].ToString();
                        string location = e.Values["Location"].ToString();

                        long uid = Convert.ToInt64(e.Values["CreatedBy"]);
                        IEnumerable<User> userdetails = userBL.GetUsersByID(uid);

                        foreach (var name in userdetails)
                        {
                            usertname = name.FirstName;
                        }
                        templateValues.Add("<%=CreatedBy%>", usertname);
                        templateValues.Add("<%=Subject%>", subject);
                        templateValues.Add("<%=StartDate%>", startDate);
                        templateValues.Add("<%=EndDate%>", endDate);
                        templateValues.Add("<%=Location%>", location);

                        string emailAdd = Session["toUser"].ToString();
                        string attendees = emailAdd.TrimEnd(';');


                        if (attendees.Contains(';'))
                        {
                            string[] emails = attendees.Split(';');
                            foreach (string email in emails)
                            {
                                string receiver = email;
                                C3App.App_Code.Notification.Notify("Meeting", recentmeetingID, 1, receiver, 4, templateValues);
                                mailresult = "and mail successfully sent";
                            }
                        }
                        else
                        {
                            if (attendees != string.Empty)
                            {
                                C3App.App_Code.Notification.Notify("Meeting", recentmeetingID, 1, attendees, 4, templateValues);
                                mailresult = "and mail successfully sent";
                            }
                        }
                        //save meeting invitees
                        long meetingID = Convert.ToInt64(Session["NewMeeting"]);
                        const string inviteeType = "Contacts";
                        string allInvitee = Session["targetID"].ToString().TrimEnd(';');
                        string[] invitees = allInvitee.Split(';');
                        foreach (string invitee in invitees)
                        {
                            long inviteeID = Convert.ToInt64(invitee);
                            meetingBL.SaveMeetingInvitees(meetingID, inviteeID, inviteeType);
                        }
                        Session.Remove("toUser");
                        Session["targetID"] = 0;
                    }
                    else
                    {
                        mailresult = "but not selecected any meeting invitee";
                    }

                    string meetingSubject = e.Values["Subject"].ToString();
                    MessageLiteral.Text = "Success <br /><p> Meeting on " + meetingSubject + " has been saved " + mailresult + " </p>";
                    ViewMeetingsGridView.DataBind();
                    WeeklyMeetingGridView.DataBind();
                    MiniDetailsUpdatePanel.Update();
                    Session["NewMeeting"] = 0;
                }
                else
                {
                    MessageLiteral.Text = "Sorry,save failed <br /> <p> Please try again</p>";
                }

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                MeetingDetailsView.DataBind();
                MeetingDetailsView.ChangeMode(DetailsViewMode.Insert);
                //CreateMeetingUpdatePanel.Update();
                MeetingTargetListUpdatePanel.Update();
                ContactGridView.DataBind();
            }


        }

        protected void MeetingDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            Session["NewMeeting"] = Convert.ToString(e.ReturnValue);
        }

        protected void AllDayCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox alldayCheckbox = (CheckBox)MeetingDetailsView.FindControl("AllDayCheckBox");
            TextBox startTimeTextBox = MeetingDetailsView.FindControl("StartTimeTextBox") as TextBox;
            TextBox endTimeTextBox = MeetingDetailsView.FindControl("EndTimeTextBox") as TextBox;

            if (alldayCheckbox.Checked)
            {
                startTimeTextBox.Text = "09:00";
                startTimeTextBox.ReadOnly = true;
                endTimeTextBox.Text = "05:00";
                endTimeTextBox.ReadOnly = true;
            }
            else
            {
                startTimeTextBox.ReadOnly = false;
                endTimeTextBox.ReadOnly = false;
            }

        }


        #endregion


        #region Update Function of Meeting...

        protected void MeetingDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            Session["Subject"] = e.NewValues["Subject"];

            TextBox startdatetextbox = (TextBox)MeetingDetailsView.FindControl("DateStartTextBox");
            TextBox startTimetextbox = (TextBox)MeetingDetailsView.FindControl("StartTimeTextBox");
            CheckBox allDayCheckBox = (CheckBox)MeetingDetailsView.FindControl("AllDayCheckBox");
            TextBox endDatetextbox = (TextBox)MeetingDetailsView.FindControl("DateEndTextBox");
            TextBox endTimetextbox = (TextBox)MeetingDetailsView.FindControl("EndTimeTextBox");


            string startTime, endtime;

            string getstartDate = startdatetextbox.Text;
            DateTime dateStart = DateTime.Parse(getstartDate);
            string fulldate = dateStart.ToString("MM-dd-yyyy HH:mm tt");
            string startdate = fulldate.Split(' ')[0];
            if (allDayCheckBox.Checked)
            {
                startTime = "09:00";
                endtime = "05:00";
            }
            else
            {
                startTime = startTimetextbox.Text;
                endtime = endTimetextbox.Text;
            }
            string startdatetime = (startdate + " " + startTime);

            string getEndDate = endDatetextbox.Text;
            DateTime dateEnd = DateTime.Parse(getEndDate);
            string dateend = dateEnd.ToString("MM-dd-yyyy HH:mm tt");
            string endDate = dateend.Split(' ')[0];
            string endDatetime = (endDate + " " + endtime);
            int result = DateTime.Compare(dateStart, dateEnd);
            if (result <= 0)
            {
                e.NewValues["StartDate"] = startdatetime;
                e.NewValues["EndDate"] = endDatetime;
            }

            e.NewValues["ModifiedTime"] = DateTime.Now;
            e.NewValues["ModifiedBy"] = Convert.ToInt64(HttpContext.Current.Session["UserID"]);

        }

        protected void MeetingDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
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
                string meetingSubject = e.NewValues["Subject"].ToString();
                int rowcount = e.AffectedRows;
                if (rowcount == -1)
                {
                    string mailresult = String.Empty;

                    if (Session["toUser"] != null)
                    {
                        string usertname = String.Empty;
                        long recentmeetingID = Convert.ToInt64(Session["NewMeeting"]);
                        ListDictionary templateValues = new ListDictionary();
                        string subject = e.NewValues["Subject"].ToString();
                        string startDate = e.NewValues["StartDate"].ToString();
                        string endDate = e.NewValues["EndDate"].ToString();
                        string location = e.NewValues["Location"].ToString();

                        long uid = Convert.ToInt64(e.NewValues["ModifiedBy"]);
                        IEnumerable<User> userdetails = userBL.GetUsersByID(uid);

                        foreach (var name in userdetails)
                        {
                            usertname = name.FirstName;
                        }
                        templateValues.Add("<%=CreatedBy%>", usertname);
                        templateValues.Add("<%=Subject%>", subject);
                        templateValues.Add("<%=StartDate%>", startDate);
                        templateValues.Add("<%=EndDate%>", endDate);
                        templateValues.Add("<%=Location%>", location);

                        string emailAdd = Session["toUser"].ToString();
                        string attendees = emailAdd.TrimEnd(';');


                        if (attendees.Contains(';'))
                        {
                            string[] emails = attendees.Split(';');
                            foreach (string email in emails)
                            {
                                string receiver = email;
                                C3App.App_Code.Notification.Notify("Meeting", recentmeetingID, 1, receiver, 4, templateValues);
                                mailresult = "and mail successfully sent";
                            }
                        }
                        else
                        {
                            if (attendees != string.Empty)
                            {
                                C3App.App_Code.Notification.Notify("Meeting", recentmeetingID, 1, attendees, 4, templateValues);
                                mailresult = "and mail successfully sent";
                            }
                        }
                        long meetingID = Convert.ToInt64(Session["NewMeeting"]);
                        const string inviteeType = "Contacts";
                        string allInvitee = Session["targetID"].ToString().TrimEnd(';');
                        string[] invitees = allInvitee.Split(';');
                        foreach (string invitee in invitees)
                        {
                            long inviteeID = Convert.ToInt64(invitee);
                            meetingBL.SaveMeetingInvitees(meetingID, inviteeID, inviteeType);
                        }
                        Session["toUser"] = "";
                        Session["targetID"] = 0;

                    }
                    else
                    {
                        mailresult = "but not selecected any meeting invitee";
                    }

                    MessageLiteral.Text = "Success <br /><p> Meeting on " + meetingSubject + " has been updated " + mailresult + " </p>";
                    ViewMeetingsGridView.DataBind();
                    WeeklyMeetingGridView.DataBind();
                    MiniDetailsUpdatePanel.Update();
                    Session["NewMeeting"] = 0;

                }
                else
                {
                    MessageLiteral.Text = "Sorry, update failed <br /> <p> Please try again</p>";
                }

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);

                this.MeetingDetailsView.DataBind();
                this.ContactGridView.DataBind();
                this.ViewMeetingsGridView.DataBind();
                this.WeeklyMeetingGridView.DataBind();

                MeetingDetailsView.ChangeMode(DetailsViewMode.Insert);

                MeetingTargetListUpdatePanel.Update();
                MiniDetailsUpdatePanel.Update();

            }

        }

        protected void MeetingDetailsObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            Session["NewMeeting"] = Convert.ToString(e.ReturnValue);
        }


        #endregion


        #region Meeting Edit, Search Function.......

        protected void EditLinkButton_Click(object sender, EventArgs e)
        {
            meetingID = Convert.ToInt64(Session["EditMeetingID"].ToString());
            if (meetingID == 0)
            {
                ModalTitleLabel.Text = "Create Meeting";
                MeetingDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
            else if (meetingID > 0)
            {
                ModalTitleLabel.Text = "View Meeting";
                MeetingDetailsView.ChangeMode(DetailsViewMode.Edit);
            }

        }


        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            WeeklyMeetingGridView.DataSourceID = WeekMeetingsObjectDataSource.ID;
            this.WeeklyMeetingGridView.DataBind();
            this.WeeklyMeetingGridView.SelectedIndex = -1;
        }


        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            WeeklyMeetingGridView.DataSource = SearchMeetingBySubjectObjectDataSource;
            this.WeeklyMeetingGridView.DataBind();
        }


        protected void SearchButton_Click(object sender, EventArgs e)
        {
            WeeklyMeetingGridView.DataSource = SearchMeetingBySubjectObjectDataSource;
            this.WeeklyMeetingGridView.DataBind();
            this.WeeklyMeetingGridView.SelectedIndex = -1;
        }


        #endregion


        #region Meeting Calendar functions.......

        protected void MeetingCalendar_Init(object sender, EventArgs e)
        {
            calendar = sender as Calendar;
            if (calendar == null) return;
            calendar.SelectedDate = DateTime.Now.Date;
        }

        protected void MeetingCalendar_SelectionChanged(object sender, EventArgs e)
        {
            ViewMeetingsGridView.DataSource = null;
            ViewMeetingsGridView.DataBind();
            WeeklyMeetingGridView.DataSource = null;
            WeeklyMeetingGridView.DataBind();
            DateTime selectedDate = calendar.SelectedDate;
            // calendar.SelectedDate = dateTime.Date;
            IEnumerable<Meeting> DayObjectDataSource = meetingBL.GetSelectedDaysMeeting(selectedDate);

            ViewMeetingsGridView.DataSource = DayObjectDataSource;
            ViewMeetingsGridView.DataBind();
            IEnumerable<Meeting> WeekObjectDataSource = meetingBL.GetSelectedWeekMeetings(selectedDate);
            WeeklyMeetingGridView.DataSource = WeekObjectDataSource;
            WeeklyMeetingGridView.DataBind();
            MiniDetailsUpdatePanel.Update();
            calendar.SelectedDate = selectedDate.Date;
        }
        #endregion


        #region Meeting Invitee Functions....

        protected void IssueLinkButton_Click(object sender, EventArgs e)
        {
            TextBox attendeeName = MeetingDetailsView.FindControl("AttendeeTextBox") as TextBox;
            string insertedContactName = attendeeName.Text.ToString();
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
                        long contactID = Convert.ToInt64(dataKey.Value);
                        IEnumerable<DAL.Contact> contacts = contactBL.GetContactByID(contactID);
                        foreach (var contact in contacts)
                        {
                            if (contact.PrimaryEmail != null)
                            {
                                string emailaddress = contact.PrimaryEmail.ToString();
                                string tid = contactID.ToString(CultureInfo.InvariantCulture);
                                string cName = contact.FirstName.ToString();

                                if (Session["toUser"] != null)
                                {
                                    string insertedEmail = Session["toUser"].ToString();
                                    if (!insertedEmail.Contains(emailaddress))
                                    {
                                        email += emailaddress + ";";
                                    }
                                }
                                else
                                {
                                    email += emailaddress + ";";
                                }
                                if (Session["targetID"] != null)
                                {
                                    string insertedTargetID = Session["targetID"].ToString();
                                    if (!insertedTargetID.Contains(tid))
                                    {
                                        targetid += tid + ";";
                                    }
                                }
                                else
                                {
                                    targetid += tid + ";";
                                }

                                if (insertedContactName != "")
                                {
                                    if (!insertedContactName.Contains(cName))
                                    {
                                        contactName += cName + ", ";
                                    }
                                }
                                else
                                {
                                    contactName += cName + ", ";
                                }
                            }

                        }
                    }
                }
            }
            Session["toUser"] += email;
            Session["targetID"] += targetid;
            string cn = insertedContactName + contactName;
            string cname = cn.TrimEnd(',');
            attendeeName.Text = cname;

            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModals(['BodyContent_TargetListModalPanel']);", true);
            SelectAllCheckBox.Checked = false;
            ContactGridView.DataBind();
            MeetingTargetListUpdatePanel.Update();

        }

        protected void SelectAllCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (SelectAllCheckBox.Checked == true)
            {
                foreach (GridViewRow gvRow in ContactGridView.Rows)
                {
                    CheckBox chkSel = (CheckBox)gvRow.FindControl("ContactCheckBox") as CheckBox;
                    chkSel.Checked = true;
                    SelectAllCheckBox.Text = "Deselect All";
                }
            }
            else
            {
                foreach (GridViewRow gvRow in ContactGridView.Rows)
                {
                    CheckBox chkSel = (CheckBox)gvRow.FindControl("ContactCheckBox") as CheckBox;
                    chkSel.Checked = false;
                    SelectAllCheckBox.Text = "Select All";

                }
            }
        }

        #endregion


        #region Meeging Gridview Function.....

        protected void ViewMeetingsGridView_Init(object sender, EventArgs e)
        {
            ViewMeetingsGridView.DataSource = TodayMeetingObjectDataSource;
            ViewMeetingsGridView.DataBind();
        }


        protected void WeeklyMeetingGridView_Init(object sender, EventArgs e)
        {
            WeeklyMeetingGridView.DataSource = WeekMeetingsObjectDataSource;
            WeeklyMeetingGridView.DataBind();
        }


        protected void WeeklyMeetingGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            WeeklyMeetingGridView.DataBind();
            GridViewRow row = WeeklyMeetingGridView.SelectedRow;
            row.CssClass = "active";
            LinkButton linkButton = WeeklyMeetingGridView.SelectedRow.Cells[0].FindControl("EditLinkButton") as LinkButton;
            linkButton.Enabled = true;
            linkButton.Visible = true;

        }

        #endregion


    }
}