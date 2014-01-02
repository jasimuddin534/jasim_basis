using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;



namespace C3App.BLL
{
    public class MeetingBL
    {
        private readonly IMeetingRepository meetingRepository;

        public MeetingBL()
        {
            this.meetingRepository = new MeetingRepository();
        }

        public IEnumerable<Meeting> GetMeetings()
        {
            long meetingCreatedBy = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return meetingRepository.GetMeetings(companyID, meetingCreatedBy);
        }

        //previous
        public IEnumerable<Meeting> GetMeetingsByCompanyID()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return meetingRepository.GetMeetingsByCompanyID(companyID);
        }
        //end previous

        public IEnumerable<Meeting> GetMyMeetings(long inviteeID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return meetingRepository.GetMyMeetings(companyID, inviteeID);

        }



        public IEnumerable<Meeting> GetMeetingByID(long meetingID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return meetingRepository.GetMeetingByID(companyID, meetingID);
        }
        public long InsertMeeting(Meeting meeting)
        {
            return meetingRepository.InsertMeeting(meeting);
        }

        public void UpdateMeeting(Meeting meeting)
        {
            meetingRepository.UpdateMeeting(meeting);
        }

        public IEnumerable<Meeting> SearchMeeting(string search)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return meetingRepository.SearchMeeting(companyID, search);
        }

        public void DeleteMeeting(long meetingID)
        {
            meetingRepository.DeleteMeeting(meetingID);
        }

        public IEnumerable<MeetingStatus> GetMeetingStatuses()
        {
            return meetingRepository.GetMeetingStatuses();
        }

        //  public int GetReminderTimesByMeetingID(long meetingID)
        // {
        //     return meetingRepository.GetReminderTimesByMeetingID(meetingID);
        // }

        //  public DateTime GetMeetingDateStartDateByMeetingID(long meetingID)
        // {
        //     return meetingRepository.GetMeetingDateStartDateByMeetingID(meetingID);
        // }

        //  public int GetMeetingDateStartHourByMeetingID(long meetingID)
        // {
        //     return meetingRepository.GetMeetingDateStartHourByMeetingID(meetingID);
        // }

        //  public int GetMeetingDateStartMinutesByMeetingID(long meetingID)
        // {
        //     return meetingRepository.GetMeetingDateStartMinutesByMeetingID(meetingID);
        // }

        //  public string GetMeetingDateStartPeriodByMeetingID(long meetingID)
        // {
        //     return meetingRepository.GetMeetingDateStartPeriodByMeetingID(meetingID);
        // }

        //  public int GetDurationMinutesByMeetingID(long meetingID)
        // {
        //     return meetingRepository.GetDurationMinutesByMeetingID(meetingID);
        // }

        //  public int GetDurationHoursByMeetingID(long meetingID)
        //{
        //    return meetingRepository.GetDurationHoursByMeetingID(meetingID);
        //}

        public IEnumerable<Meeting> GetTodaysMeetings()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return meetingRepository.GetTodaysMeetings(companyID);
        }

        public IEnumerable<Meeting> GetSelectedDaysMeeting(DateTime selectedDate)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return meetingRepository.GetSelectedDaysMeeting(selectedDate, companyID);
        }
        public IEnumerable<Meeting> GetWeeklyMeetings()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return meetingRepository.GetWeeklyMeetings(companyID);
        }

        public IEnumerable<Meeting> GetSelectedWeekMeetings(DateTime selectedDate)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return meetingRepository.GetSelectedWeekMeetings(selectedDate, companyID);
        }

        public void SaveMeetingInvitees(long meetingID, long inviteeID, string inviteeType)
        {
            meetingRepository.SaveMeetingInvitees(meetingID, inviteeID, inviteeType);
        }

        //public long? GetMeetingsByInvitee(string inviteeType, long inviteeID)
        //{
        //    return meetingRepository.GetMeetingsByInvitee(inviteeType, inviteeID);
        //}

        public IEnumerable<Meeting> GetMeetingsByInvitee(string inviteeType, long inviteeID)
        {
            return meetingRepository.GetMeetingsByInvitee(inviteeType, inviteeID);
        }

        public IEnumerable<Meeting> GetWeeklyMeetingsByInvitee(string inviteeType, long inviteeID)
        {
            return meetingRepository.GetWeeklyMeetingsByInvitee(inviteeType, inviteeID);
        }

        public IEnumerable<MeetingInvitee> GetMeetingInviteesByMeetingID(int userID, long meetingID)
        {
            long userid = Convert.ToInt64(HttpContext.Current.Session["UserID"]);

            return meetingRepository.GetMeetingInviteesByMeetingID(userid, meetingID);
        }

        //by jasim vi
        public List<MeetingsInviteeSummary> GetContactByMeetingInvitee()
        {
            try
            {
                return meetingRepository.GetContactByMeetingInvitee();
            }
            catch (Exception e)
            {
                throw e;
            }

        }




        public long InsertOrUpdateMeeting(Meeting meeting)
        {
            try
            {
                return meetingRepository.InsertOrUpdateMeeting(meeting);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}