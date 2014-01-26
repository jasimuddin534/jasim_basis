using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;

namespace C3App.Meetings
{
    public partial class Meetings2 : System.Web.UI.Page
    {
        MeetingBL meetingBL = new MeetingBL();
        AccountBL accountBL=new AccountBL();
        TeamBL teamBL=new TeamBL();
        ContactBL contactBL=new ContactBL();
        UserBL userBL=new UserBL();
        OpportunityBL opportunityBL=new OpportunityBL();
        public Int32 companyID;
        private DropDownList teamsDropDownList;
        private DropDownList usersDropDownList;
        private DropDownList meetingStatusDropDownList;
        private DropDownList hoursDropDownList;
        private DropDownList minutesDropDownList;
        private DropDownList periodDropDownList;
        private DropDownList durationminutesDropDownList;
        private TextBox durationHoursTextBox;
        private DropDownList remindertimesDropDownList;
        private TextBox dateStartTextBox;
        private DropDownList meetingGroupDropDownList;
        protected void Page_Load(object sender, EventArgs e)
        {
            companyID = Convert.ToInt32(Session["CompanyID"]);

            //try
            //{
            //    if (Request.QueryString["ShowPanel"] != null)
            //    {
            //        if (!IsPostBack)
            //        {
            //            MeetingEditButton.Visible = false;
            //            ModalPopButton2.Visible = false;
            //            DeleteButton.Visible = false;
            //            Session.Remove("EditMeetingID");
            //        }
            //    }
            //    if (Session["EditMeetingID"] != null)
            //    {
            //        Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);

            //        if (meetingID == 0)
            //        {
            //            MeetingDetailsView.ChangeMode(DetailsViewMode.Insert);
            //        }
            //        else if (meetingID > 0)
            //        {
            //            MeetingDetailsView.ChangeMode(DetailsViewMode.Edit);
            //        }
            //    }
            //    else
            //    {
            //        MeetingDetailsView.ChangeMode(DetailsViewMode.Insert);
            //    }
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}

           // Previous page load code 

            if (Request.QueryString["ShowPanel"] != null)
            {
                if ((!IsPostBack) || (Request.QueryString["ShowPanel"] == "DetailsPanel"))
                {
                    Session.Remove("EditMeetingID");
                }
            }
            try
            {
                Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);
                MeetingDetailsView.ChangeMode(meetingID == 0 ? DetailsViewMode.Insert : DetailsViewMode.Edit);
            }
            catch(Exception ex)
            {
                throw ex;
            }

        }


        protected void MeetingDetailsView_ItemCommand(Object sender, DetailsViewCommandEventArgs e)
        {
           if (e.CommandName == "Cancel")
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
            }
        }


        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);
            meetingBL.DeletedByID(meetingID);
            this.ViewMeetingsGridView.DataBind();
            this.MiniMeetingsFormView.DataBind();
            this.miniMeetingDetailsView.DataBind();
            ViewMeetingsUpdatepanel.Update();
            miniMeetingDetailsUpdatePanel.Update();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
        }

        protected void ViewLinkButton_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;

            switch (btn.CommandArgument.ToString())
            {
                case "ShowDetailPanel":
                    this.DetailsPanel.Visible = true;
                    this.ViewPanel.Visible = false;
                    break;
                case "ShowViewPanel":
                    this.ViewPanel.Visible = true;
                    this.DetailsPanel.Visible = false;
                    break;
            }
        }

        protected void MeetingInsertLinkButton_Click(object sender, EventArgs e)
        {
            LinkButton btn = sender as LinkButton;
            string insert = btn.CommandArgument.ToString();
            Session["EditMeetingID"] = 0;
            MeetingDetailsView.ChangeMode(DetailsViewMode.Insert);
        }

        protected void MeetingsEditButton_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);
            if (meetingID == 0)
            {
                MeetingDetailsView.DataSource = null;
                MeetingDetailsView.DataBind();
            }
            MeetingDetailsView.ChangeMode(DetailsViewMode.Edit);
            // Session["AccountID"] = btn.CommandArgument.ToString();
            // Label1.Text = Convert.ToString(Session["AccountID"]);
            
        }


        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            MeetingEditButton.Visible = true;
            ModalPopButton2.Visible = true;
            DeleteButton.Visible = true;
            Session["EditMeetingID"] = e.CommandArgument.ToString();
            miniMeetingDetailsUpdatePanel.Update();
        }

        //Code for showing changed searching accounts of the company
        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            meetingBL.SearchMeeting(search);
        }

        //Code for showing searching accounts of the company
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            ViewMeetingsGridView.DataSourceID = SearchObjectDataSource.ID;
            ViewMeetingsGridView.DataBind();
            ViewMeetingsUpdatepanel.Update();
        }


        //Code for showing all accounts of the company
        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            ViewMeetingsGridView.DataSourceID = MeetingDetailsObjectDataSource.ID;
            ViewMeetingsGridView.DataBind();
            ViewMeetingsUpdatepanel.Update();
        }
        

        protected void MeetingDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            this.ViewMeetingsGridView.DataBind();
            this.MiniMeetingsFormView.DataBind();
            this.miniMeetingDetailsView.DataBind();
            ViewMeetingsUpdatepanel.Update();
            miniMeetingDetailsUpdatePanel.Update();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
        }


        protected void MeetingDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            this.ViewMeetingsGridView.DataBind();
            this.MiniMeetingsFormView.DataBind();
            this.miniMeetingDetailsView.DataBind();
            ViewMeetingsUpdatepanel.Update();
            miniMeetingDetailsUpdatePanel.Update();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
        }

        protected void MeetingDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.Values["CreatedBy"] = Convert.ToInt64(HttpContext.Current.Session["UserID"]);

            //Set Meeting Date & Time
            TextBox tb = (TextBox)MeetingDetailsView.FindControl("DateStartTextBox");
            string cal = tb.Text;
            //new 
            DropDownList hourDDL = MeetingDetailsView.FindControl("HoursDropDownList") as DropDownList;
            DropDownList minutesDDL = MeetingDetailsView.FindControl("MinutesDropDownList") as DropDownList;
            DropDownList periodDDL = MeetingDetailsView.FindControl("PeriodDropDownList") as DropDownList;
            string hour = hourDDL.SelectedItem.Text;
            string minute = minutesDDL.SelectedItem.Text;
            string period = periodDDL.SelectedItem.Text;
            //end new 
            //string hour = hoursDropDownList.SelectedItem.Text;
            //string minute = minutesDropDownList.SelectedItem.Text;
            //string period = periodDropDownList.SelectedItem.Text;
            string date = (cal + " " + hour + ":" + minute + " " + period);
            DateTime dateStart = DateTime.Parse(date);
            e.Values["DateStart"] = Convert.ToDateTime(dateStart);
            //Set Meeting Date & Time

            if (Convert.ToInt32(teamsDropDownList.SelectedValue) == 0)
            {
                e.Values["TeamID"] = null;
            }
            else
            {
                e.Values["TeamID"] = teamsDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(usersDropDownList.SelectedValue) == 0)
            {
                e.Values["AssignedUserID"] = null;
            }
            else
            {
                e.Values["AssignedUserID"] = usersDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(meetingStatusDropDownList.SelectedValue) == 0)
            {
                e.Values["StatusID"] = null;
            }
            else
            {
                e.Values["StatusID"] = meetingStatusDropDownList.SelectedValue;
            }

            DropDownList durationminutesDropDownList = MeetingDetailsView.FindControl("DurationMinutesDropDownList") as DropDownList;
            
            if (Convert.ToInt32(durationminutesDropDownList.SelectedValue) == 0)
            {
                e.Values["DurationMinutes"] = null;
            }
            else
            {
                e.Values["DurationMinutes"] = Convert.ToInt32(durationminutesDropDownList.SelectedItem.Text);
            }

            DropDownList reminderDDL = MeetingDetailsView.FindControl("ReminderTimesDropDownList") as DropDownList;
            if (Convert.ToInt32(reminderDDL.SelectedValue) == 0)
            {
                e.Values["ReminderTime"] = null;
            }
            else
            {
                e.Values["ReminderTime"] = Convert.ToInt32(reminderDDL.SelectedItem.Text);
            }


        }

        protected void MeetingDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            e.NewValues["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.NewValues["ModifiedTime"] = DateTime.Now;
            e.NewValues["ModifiedBy"] = Convert.ToInt64(HttpContext.Current.Session["UserID"]);

            //Set Meeting Date & Time
            TextBox tb = (TextBox)MeetingDetailsView.FindControl("DateStartTextBox");
            string cal = tb.Text;
            //new 
            DropDownList hourDDL = MeetingDetailsView.FindControl("HoursDropDownList") as DropDownList;
            DropDownList minutesDDL = MeetingDetailsView.FindControl("MinutesDropDownList") as DropDownList;
            DropDownList periodDDL = MeetingDetailsView.FindControl("PeriodDropDownList") as DropDownList;
            string hour = hourDDL.SelectedItem.Text;
            string minute = minutesDDL.SelectedItem.Text;
            string period = periodDDL.SelectedItem.Text;
            //end new 
            //string hour = hoursDropDownList.SelectedItem.Text;
            //string minute = minutesDropDownList.SelectedItem.Text;
            //string period = periodDropDownList.SelectedItem.Text;
            string date = (cal + " " + hour + ":" + minute + " " + period);
            DateTime dateStart = DateTime.Parse(date);
            e.NewValues["DateStart"] = Convert.ToDateTime(dateStart);

            //Set Meeting Date & Time

            if (Convert.ToInt32(teamsDropDownList.SelectedValue) == 0)
            {
                e.NewValues["TeamID"] = null;
            }
            else
            {
                e.NewValues["TeamID"] = teamsDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(usersDropDownList.SelectedValue) == 0)
            {
                e.NewValues["AssignedUserID"] = null;
            }
            else
            {
                e.NewValues["AssignedUserID"] = usersDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(meetingStatusDropDownList.SelectedValue) == 0)
            {
                e.NewValues["StatusID"] = null;
            }
            else
            {
                e.NewValues["StatusID"] = meetingStatusDropDownList.SelectedValue;
            }
          
            DropDownList durationminutesDropDownList = MeetingDetailsView.FindControl("DurationMinutesDropDownList") as DropDownList;
            if (Convert.ToInt32(durationminutesDropDownList.SelectedValue) == 0)
            {
                e.NewValues["DurationMinutes"] = null;
            }
            else
            {
                e.NewValues["DurationMinutes"] = Convert.ToInt32(durationminutesDropDownList.SelectedItem.Text);
            }

            DropDownList reminderDDL = MeetingDetailsView.FindControl("ReminderTimesDropDownList") as DropDownList;
            if (Convert.ToInt32(reminderDDL.SelectedValue) == 0)
            {
                e.NewValues["ReminderTime"] = null;
            }
            else
            {
                e.NewValues["ReminderTime"] = Convert.ToInt32(reminderDDL.SelectedItem.Text);
            }

        }

        //protected void MeetingGroupSearchTextBox_TextChanged(object sender, EventArgs e)
        //{
        //    string search = MeetingGroupSearchTextBox.Text;
        //   // orderBL.SearchOrders(search);
        //   // this.OrderListGridView.DataBind();
        //}

        protected void MeetingGroupDropDownList_Init(object sender, EventArgs e)
        {
            meetingGroupDropDownList = sender as DropDownList;
        }

        //protected void MeetingGroupSearchLinkButton_Click(object sender, EventArgs e)
        //{
        //    DropDownList meetingGroupDDL = MeetingDetailsView.FindControl("MeetingGroupDropDownList") as DropDownList;
        //    string search = MeetingGroupSearchTextBox.Text;
            
        //    if (meetingGroupDDL.SelectedValue == "Accounts")
        //    {
        //         =  accountBL.GetAccountForMeeting(search);
        //        MeetingGroupGridView.DataSource = AccountListObjectDataSource;
        //        MeetingGroupGridView.AutoGenerateColumns = true;
        //        MeetingGroupGridView.DataBind();
              
        //    }
        //    else if (meetingGroupDDL.SelectedValue == "Teams")
        //    {
        //        teamBL.GetTeamsByName(search);
        //        //MeetingGroupGridView.DataSource = TeamListObjectDataSource;
        //        MeetingGroupGridView.DataBind();
        //    }
        //    else if (meetingGroupDDL.SelectedValue == "Users")
        //    {
        //        userBL.GetUsersByFirstName(search);
        //       // MeetingGroupGridView.DataSource = UserListObjectDataSource;
        //        MeetingGroupGridView.DataBind();
        //    }
        //    else if (meetingGroupDDL.SelectedValue == "Contacts")
        //    {
        //        contactBL.GetContactByName(search);
        //        //MeetingGroupGridView.DataSource = ContactListObjectDataSource;
        //        MeetingGroupGridView.DataBind();
        //    }
        //    else if (meetingGroupDDL.SelectedValue == "Opportunity")
        //    {
        //        opportunityBL.SearchOpportunities(search);
        //       // MeetingGroupGridView.DataSource = OpportunityListObjectDataSource;
        //        MeetingGroupGridView.DataBind();
        //    }
        //    else if (meetingGroupDDL.SelectedValue == "None")
        //    {
        //        MeetingGroupGridView.DataSource = null;
        //        MeetingGroupGridView.DataBind();
        //    }
            
        //}

         //protected void ModalPopButton_Click(object sender, EventArgs e)
         //{
         //     DropDownList meetingGroupDropDownList = MeetingDetailsView.FindControl("MeetingGroupDropDownList") as DropDownList;

         //     if (meetingGroupDropDownList != null && meetingGroupDropDownList.SelectedValue == "Accounts")
         //     {
         //         ModalLabel.Text = "Select Account";
         //         ModalSearchPanel.Visible = true;

         //        // MeetingGroupGridView.DataSource = AccountListObjectDataSource;
         //       //  MeetingGroupGridView.DataBind();
         //     }
         //     else if (meetingGroupDropDownList.SelectedValue == "Teams")
         //     {
         //         ModalLabel.Text = "Select Teams";
         //         ModalSearchPanel.Visible = true;
         //         MeetingGroupGridView.DataSource = TeamListObjectDataSource;
         //         MeetingGroupGridView.DataBind();
         //     }
         //     else if (meetingGroupDropDownList.SelectedValue == "Users")
         //     {
         //         ModalLabel.Text = "Select Users";
         //         ModalSearchPanel.Visible = true;
         //         MeetingGroupGridView.DataSource = UserListObjectDataSource;
         //         MeetingGroupGridView.DataBind();
         //     }
         //     else if (meetingGroupDropDownList.SelectedValue == "Contacts")
         //     {
         //         ModalLabel.Text = "Select Contacts";
         //         ModalSearchPanel.Visible = true;
         //         MeetingGroupGridView.DataSource = ContactListObjectDataSource;
         //         MeetingGroupGridView.DataBind();
         //     }
         //     else if (meetingGroupDropDownList.SelectedValue == "Opportunity")
         //     {
         //         ModalLabel.Text = "Select Opportunity";
         //         ModalSearchPanel.Visible = true;
         //         MeetingGroupGridView.DataSource = OpportunityListObjectDataSource;
         //         //MeetingGroupGridView.
         //         MeetingGroupGridView.DataBind();
         //     }
         //     else if (meetingGroupDropDownList.SelectedValue == "None")
         //     {
         //         MeetingGroupGridView.DataSource = null;
         //         MeetingGroupGridView.DataBind();
         //     }
         //}


        protected void SelectAttendee_Command(object sender, CommandEventArgs e)
        {

            //int companyID = Convert.ToInt32(Session["CompanyID"]);

            IEnumerable<DAL.User> users = userBL.GetUsersByCompanyID();
            foreach (var user in users)
            {
                string atendeeName = user.FirstName;
                TextBox attendeeTextBox = MeetingDetailsView.FindControl("AttendeeTextBox") as TextBox;
                //if (atendeeName != null)
                //{
                //    attendeeTextBox.Text = atendeeName;
                //}
                //else
                //{
                //    attendeeTextBox.Text = "No atendee";
                //}
            }
        }

        protected void MeetingStatusDropDownList_Init(object sender, EventArgs e)
        {
            meetingStatusDropDownList = sender as System.Web.UI.WebControls.DropDownList;
        }


        protected void UsersDropDownList_Init(object sender, EventArgs e)
        {
            usersDropDownList = sender as System.Web.UI.WebControls.DropDownList;
        }

        protected void TeamsDropDownList_Init(object sender, EventArgs e)
        {
            teamsDropDownList = sender as System.Web.UI.WebControls.DropDownList;
        }

        protected void HoursDropDownList_Init(object sender, EventArgs e)
        {
            DropDownList hourDDL = MeetingDetailsView.FindControl("HoursDropDownList") as DropDownList;
            for (int i = 1; i <= 12; i++)
            {
                int hour = i;
                if (hourDDL != null) hourDDL.Items.Add(Convert.ToString(hour));
            }

            Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);
            if (meetingID > 0)
            {
                int meetingDateStartHour = 0;
                meetingDateStartHour = meetingBL.GetMeetingDateStartHourByMeetingID(meetingID);
                if(meetingDateStartHour==0)
                {
                    if (hourDDL != null) hourDDL.SelectedItem.Text = "1";
                }
                else
                {
                    if (hourDDL != null)
                        hourDDL.SelectedItem.Text = meetingDateStartHour.ToString(CultureInfo.InvariantCulture);
                    //hoursDropDownList.SelectedValue = meetingDateStartHour.ToString(CultureInfo.InvariantCulture);
                }
            }
        }

        protected void MinutesDropDownList_Init(object sender, EventArgs e)
        {
            DropDownList minutesDDL = MeetingDetailsView.FindControl("MinutesDropDownList") as DropDownList;
            for (int i = 0; i <= 60; i = i + 5)
            {
                int minute = i;
                if (minutesDDL != null) minutesDDL.Items.Add(Convert.ToString(minute));
            }
            Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);
            if (meetingID > 0)
            {
                int meetingDateStartMinutes = meetingBL.GetMeetingDateStartMinutesByMeetingID(meetingID);
                if (meetingDateStartMinutes == 0)
                {
                    if (minutesDDL != null) minutesDDL.SelectedItem.Text = "0";
                }
                else
                {
                    if (minutesDDL != null)
                        minutesDDL.SelectedItem.Text = meetingDateStartMinutes.ToString(CultureInfo.InvariantCulture);
                }
            }

        }
        protected void PeriodDropDownList_Init(object sender, EventArgs e)
        {
            DropDownList periodDDL = MeetingDetailsView.FindControl("PeriodDropDownList") as DropDownList;
            Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);
            if (meetingID > 0)
            {
                string meetingDateStartPeriod = meetingBL.GetMeetingDateStartPeriodByMeetingID(meetingID);
                if (meetingDateStartPeriod==string.Empty)
                {
                    periodDDL.SelectedItem.Text = "AM";
                }
                else
                {
                    periodDDL.SelectedItem.Text = meetingDateStartPeriod;
                }
            }
        }


        protected void DurationMinutesDropDownList_Init(object sender, EventArgs e)
        {
            DropDownList durationminutesDDL = MeetingDetailsView.FindControl("DurationMinutesDropDownList") as DropDownList;
            for (int i = 00; i <= 60; i = i + 10)
            {
                int minute = i;
                durationminutesDDL.Items.Add(Convert.ToString(minute));
            }
            Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);

            if (meetingID > 0)
            {
                int durationMinutes = meetingBL.GetDurationMinutesByMeetingID(meetingID);
                durationminutesDDL.SelectedValue = durationMinutes.ToString(CultureInfo.InvariantCulture);
            }
        }

        protected void ReminderTimesDropDownList_Init(object sender, EventArgs e)
        {
            DropDownList reminderDDL = MeetingDetailsView.FindControl("ReminderTimesDropDownList") as DropDownList;

            for (int i = 0; i <= 60; i = i + 15)
            {
                int minute = i;
                reminderDDL.Items.Add(Convert.ToString(minute));
            }

            Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);
            if (meetingID > 0)
            {
                int reminderTime = meetingBL.GetReminderTimesByMeetingID(meetingID);
                if (reminderTime == 0)
                {
                    reminderDDL.SelectedItem.Text = string.Empty;
                }
                else
                {
                    reminderDDL.SelectedItem.Text = reminderTime.ToString(CultureInfo.InvariantCulture);
                }
            }
        }


        protected void DateStartTextBox_Init(object sender, EventArgs e)
        {
            dateStartTextBox = sender as System.Web.UI.WebControls.TextBox;
            Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);
            if (meetingID > 0)
            {
                DateTime dateStart = meetingBL.GetMeetingDateStartDateByMeetingID(meetingID);
                dateStartTextBox.Text = dateStart.ToShortDateString();
            }
        }

        protected void DurationHoursTextBox_Init(object sender, EventArgs e)
        {
            durationHoursTextBox = sender as System.Web.UI.WebControls.TextBox;
            Int64 meetingID = Convert.ToInt64(Session["EditMeetingID"]);
            if (meetingID > 0)
            {
                int durationHours = meetingBL.GetDurationHoursByMeetingID(meetingID);
                durationHoursTextBox.Text = durationHours.ToString(CultureInfo.InvariantCulture);
            }
        }
    }
}