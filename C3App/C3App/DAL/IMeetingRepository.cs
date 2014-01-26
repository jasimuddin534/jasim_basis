using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IMeetingRepository
    {

        IEnumerable<Meeting> GetMeetings(int companyID, long meetingCreatedBy);
        IEnumerable<Meeting> GetMeetingsByCompanyID(int companyID);
        IEnumerable<Meeting> GetMeetingByID(int companyID, long meetingID);
        long InsertMeeting(Meeting meeting);
        void UpdateMeeting(Meeting meeting);
        void DeleteMeeting(long meetingID);
        IEnumerable<Meeting> SearchMeeting(int companyID,string search);
        IEnumerable<MeetingStatus> GetMeetingStatuses();
       // int GetReminderTimesByMeetingID(long meetingID);
       // DateTime GetMeetingDateStartDateByMeetingID(long meetingID);
       // int GetMeetingDateStartHourByMeetingID(long meetingID);
       // int GetMeetingDateStartMinutesByMeetingID(long meetingID);
       // string GetMeetingDateStartPeriodByMeetingID(long meetingID);
       // int GetDurationMinutesByMeetingID(long meetingID);
        //int GetDurationHoursByMeetingID(long meetingID);
        IEnumerable<Meeting> GetTodaysMeetings(int companyID);
        IEnumerable<Meeting> GetWeeklyMeetings(int companyID);

        void SaveMeetingInvitees(long meetingID, long inviteeID, string inviteeType);
       // long? GetMeetingsByInvitee(string inviteeType, long inviteeID);
        List<MeetingsInviteeSummary> GetContactByMeetingInvitee();
        IEnumerable<Meeting> GetMeetingsByInvitee(string inviteeType, long inviteeID);
        IEnumerable<Meeting> GetSelectedDaysMeeting(DateTime selectedDate, int companyID);
        IEnumerable<Meeting> GetSelectedWeekMeetings(DateTime selectedDate, int companyID);
        IEnumerable<Meeting> GetMyMeetings(int companyID, long inviteeID);
        IEnumerable<Meeting> GetWeeklyMeetingsByInvitee(string inviteeType, long inviteeId);
        IEnumerable<MeetingInvitee> GetMeetingInviteesByMeetingID(long userID, long meetingID);



        long InsertOrUpdateMeeting(Meeting meeting);
    }
}
