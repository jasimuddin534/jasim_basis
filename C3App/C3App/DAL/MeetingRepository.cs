using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Data.Objects;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class MeetingRepository :IDisposable,IMeetingRepository
    {
        private C3Entities context = new C3Entities();

        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }

            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        public IEnumerable<Meeting> GetMeetings(int companyID,long meetingCreatedBy)
        {
            //return context.Meetings.AsNoTracking().Where(c => c.CompanyID == companyID && c.CreatedBy==meetingCreatedBy && c.IsDeleted == false).Take(20).ToList();

            IEnumerable<Meeting> meetings = (from p in context.Meetings
                                             where p.CompanyID == companyID && p.CreatedBy==meetingCreatedBy && p.IsDeleted == false
                                             select p).Take(20).ToList();
            return meetings;
        }

        //previous
        public IEnumerable<Meeting> GetMeetingsByCompanyID(int companyID)
        {
            IEnumerable<Meeting> meetings = (from p in context.Meetings
                                             where p.CompanyID == companyID && p.IsDeleted == false
                                             select p).ToList();
            return meetings;
        }


        public IEnumerable<Meeting> GetMyMeetings(int companyID, long inviteeID)
        {
            IEnumerable<Meeting> mymeetings = (from p in context.Meetings
                                                where p.CompanyID == companyID && p.CreatedBy==inviteeID && p.IsDeleted == false
                                                orderby p.StartDate ascending 
                                                select p).ToList();
            return mymeetings;
        }

        public IEnumerable<MeetingInvitee> GetMeetingInviteesByMeetingID(long userID, long meetingID)
        {
            IEnumerable<MeetingInvitee> meetinginvitee = (from inv in context.MeetingInvitees
                                                           where inv.MeetingID == meetingID && inv.InviteeID == userID
                                                           select inv).ToList();
            return meetinginvitee;
        }

        public IEnumerable<Meeting> GetWeeklyMeetingsByInvitee(string inviteeType, long inviteeId)
        {
            //DateTime weekstartday = DateTime.Today.AddDays(6);
            var meeting = new List<Meeting>();
            IEnumerable<MeetingInvitee> meettinginvitee = (from inv in context.MeetingInvitees
                                                           where inv.InviteeType == inviteeType && inv.InviteeID == inviteeId
                                                           select inv).ToList();



            foreach (var meettinginvite in meettinginvitee)
            {
                var meetingdetails = (from mee in context.Meetings
                                      where mee.MeetingID == meettinginvite.MeetingID && mee.IsDeleted == false
                                      orderby mee.StartDate ascending 
                                      select mee).ToList();
                meeting.AddRange(meetingdetails);
            }
            return meeting;
        }



        public IEnumerable<Meeting> GetMeetingByID(int companyID,long meetingID)
        {
           IEnumerable<Meeting> meetings = (from p in context.Meetings
                                            where p.CompanyID == companyID && p.MeetingID == meetingID && p.IsDeleted==false 
                                            select p).ToList();
            return meetings;
        }

        //public List<int> GetMeetingsByInvitee(string inviteeType, List<string>[] invitees)
        //{
        //    int count=invitees.Length;
        //    var inviteeIDs = new List<long>[100];
        //   // int count = 0;
        //    for (int index = 0; index < invitees.Length; index++)
        //    {
        //        List<string> inviteeID = invitees[index];
        //        List<string> id = inviteeID;
        //        var meetingID = (from p in context.MeetingInvitees
        //                         where id != null && (p.InviteeType == inviteeType && Equals(p.MeetingID, id))
        //                         select p);
        //        count = count + 1;
        //    }

        //    //long? meetingID =(from p in context.MeetingInvitees
        //    //                       where p.InviteeType == inviteeType && p.MeetingID == inviteeID
        //    //                       select p.MeetingID).FirstOrDefault();
        //    //return meetingID;
        //}

        public IEnumerable<Meeting>GetMeetingsByInvitee(string inviteeType, long inviteeID)
        {
            var today = DateTime.Today;
            var meeting = new List<Meeting>();
            IEnumerable<MeetingInvitee> meettinginvitee = (from inv in context.MeetingInvitees
                                                           where inv.InviteeType == inviteeType && inv.InviteeID == inviteeID
                                                           select inv).ToList();



            foreach (var meettinginvite in meettinginvitee)
            {

                var meetingdetails = (from mee in context.Meetings
                                      where mee.MeetingID == meettinginvite.MeetingID && mee.IsDeleted == false && EntityFunctions.TruncateTime(mee.StartDate) == today
                                      select mee).ToList();

                meeting.AddRange(meetingdetails);
            }
            return meeting;
            //IEnumerable<Meeting> meetings = (from p in context.Meetings
            //                                 where p.IsDeleted == false && EntityFunctions.TruncateTime(p.StartDate) == today
            //                                 select p).ToList();
            //return meetings;
        }


        //public long? GetMeetingsByInvitee(string inviteeType, long inviteeID)
        //{

        //    long? meetingID = (from p in context.MeetingInvitees
        //                       where p.InviteeType == inviteeType && p.MeetingID == inviteeID
        //                       select p.MeetingID).FirstOrDefault();
        //    return meetingID;
        //}


        public long InsertMeeting(Meeting meeting)
        {
            context.Entry(meeting).State = EntityState.Added;
            SaveChanges();
            long id = meeting.MeetingID;
            return id;
        }
       
        public void UpdateMeeting(Meeting meeting)
        {
            context.Entry(meeting).State = EntityState.Modified;
            SaveChanges();
        }

        public void SaveChanges()
        {
            bool saveFailed;
            do
            {
                saveFailed = false;
                try
                {
                    context.SaveChanges();
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    saveFailed = true;

                    // Update the values of the entity that failed to save from the store
                    ex.Entries.Single().Reload();

                    // Update original values from the database
                    //var entry = ex.Entries.Single();
                    //entry.OriginalValues.SetValues(entry.GetDatabaseValues());
                }
            } while (saveFailed);
        }

        public void DeleteMeeting(Int64 meetingID)
        {
            Meeting meeting = (from p in context.Meetings
                               where p.MeetingID == meetingID
                               select p).FirstOrDefault();
            
            if (meeting != null)
            {
                meeting.IsDeleted = true;
                context.Entry(meeting).State = EntityState.Modified;
            }
            SaveChanges();
           
        }

        public IEnumerable<Meeting> SearchMeeting(int companyID,string search)
        {
            if (String.IsNullOrWhiteSpace(search))
            {
                search = "";
            }
            var meetings = (from p in context.Meetings
                            where p.Subject.Contains(search) && (p.IsDeleted == false) && (p.CompanyID == companyID)
                            select p).ToList();

            return meetings;
        }
    
        public IEnumerable<MeetingStatus> GetMeetingStatuses()
        {
            return context.MeetingStatuses.ToList();
        }


        //public int GetReminderTimesByMeetingID(long meetingID)
        //{
        //    int remindertimes =0;

        //    var query = from p in context.Meetings
        //                where (p.MeetingID == meetingID)
        //                select p.ReminderTime;

        //    if (query.Any())
        //    {
        //        foreach (var q in query)
        //        {
        //            remindertimes = (int) q.GetValueOrDefault();
        //        }
        //    }
        //    else
        //        remindertimes = 0;

        //    return remindertimes;
        //}


        //public DateTime GetMeetingDateStartDateByMeetingID(long meetingID)
        //{
        //    DateTime dateStart = new DateTime();

        //    var query = from p in context.Meetings
        //                where (p.MeetingID == meetingID)
        //                select p.StartDate;

        //    if (query.Any())
        //    {
        //        foreach (var q in query)
        //        {
        //            dateStart = q.GetValueOrDefault();
        //        }

        //        string fulldate = dateStart.ToString("MM-dd-yyyy HH:mm tt");
        //        string date = fulldate.Split(' ')[0];
        //        return Convert.ToDateTime(date);
        //    }
        //    else
        //        return DateTime.Now.Date;
        //}

        //public int GetMeetingDateStartHourByMeetingID(long meetingID)
        //{
        //    DateTime dateStartHour = new DateTime();

        //    var query = from p in context.Meetings
        //                where (p.MeetingID == meetingID)
        //                select p.StartDate;

        //    if (query.Any())
        //    {
        //        foreach (var q in query)
        //        {
        //            dateStartHour = q.GetValueOrDefault();
        //        }

        //        string fulldate = dateStartHour.ToString("MM-dd-yyyy hh:mm tt");
        //        string hourmin = fulldate.Split(' ')[1];
        //        string hours = hourmin.Split(':')[0];
        //        return Convert.ToInt32(hours);
        //    }
        //    else
        //       return DateTime.Now.Hour;
        //}

        //public int GetMeetingDateStartMinutesByMeetingID(long meetingID)
        //{
        //    DateTime dateStartMinutes = new DateTime();

        //    var query = from p in context.Meetings
        //                where (p.MeetingID == meetingID)
        //                select p.StartDate;

        //    if (query.Any())
        //    {
        //        foreach (var q in query)
        //        {
        //            dateStartMinutes = q.GetValueOrDefault();
        //        }

        //        string fulldate = dateStartMinutes.ToString("MM-dd-yyyy HH:mm tt");
        //        string hourmin = fulldate.Split(' ')[1];
        //        string minutes = hourmin.Split(':')[1];
        //        return Convert.ToInt32(minutes);
        //    }
        //    else
        //        return DateTime.Now.Minute;
        //}

        //public string GetMeetingDateStartPeriodByMeetingID(long meetingID)
        //{
        //    DateTime dateStartPeriod = new DateTime();

        //    var query = from p in context.Meetings
        //                where (p.MeetingID == meetingID)
        //                select p.StartDate;

        //    if (query.Any())
        //    {
        //        foreach (var q in query)
        //        {
        //            dateStartPeriod = q.GetValueOrDefault();
        //        }

        //        string fulldate = dateStartPeriod.ToString("MM-dd-yyyy HH:mm tt");
        //        string period = fulldate.Split(' ')[2];
        //        return period;
        //    }
        //    else
        //        return string.Empty;
        //}

        //public int GetDurationMinutesByMeetingID(long meetingID)
        //{
        //    int durationMinutes = 0;

        //    var query = from p in context.Meetings
        //                where (p.MeetingID == meetingID)
        //                select p.DurationMinutes;

        //    if (query.Any())
        //    {
        //        foreach (var q in query)
        //        {
        //            durationMinutes = q.GetValueOrDefault();
        //        }
        //        return durationMinutes;
        //    }
        //    else
        //        return DateTime.Now.Minute;
        //}

        //public int GetDurationHoursByMeetingID(long meetingID)
        //{
        //    int durationhours = 0;

        //    var Query = (from p in context.Meetings
        //                     where (p.MeetingID == meetingID)
        //                     select p.DurationHours).Cast<int>();

        //    if (Query.Any())
        //    {
        //        foreach (var q in Query)
        //        {
        //            durationhours = q;
        //        }
        //        return durationhours;
        //    }
        //    else
        //        return 0;
        //}

        public IEnumerable<Meeting> GetTodaysMeetings(int companyID)
        {
           var today = DateTime.Today;
            IEnumerable<Meeting> meetings = (from p in context.Meetings
                                             where p.IsDeleted == false && p.CompanyID==companyID && EntityFunctions.TruncateTime(p.StartDate)==today
                                            select p).ToList();
             return meetings;
        }

        public IEnumerable<Meeting> GetSelectedDaysMeeting(DateTime selectedDate, int companyID)
        {
            var selectedDay = selectedDate.Date;
            IEnumerable<Meeting> meetings = (from p in context.Meetings
                                             where p.IsDeleted == false && p.CompanyID==companyID && EntityFunctions.TruncateTime(p.StartDate) == selectedDay
                                             select p).ToList();
            return meetings;
        }

        public IEnumerable<Meeting> GetWeeklyMeetings(int companyID)
        {
            DateTime weekstartday = DateTime.Today.AddDays(6);
            IEnumerable<Meeting> weeklymeetings = (from p in context.Meetings
                                                   where p.IsDeleted == false && p.CompanyID==companyID && EntityFunctions.DiffDays(EntityFunctions.TruncateTime(p.StartDate), EntityFunctions.TruncateTime(weekstartday)) <= 7
                                                   orderby p.StartDate ascending 
                                                   select p).ToList();

            //IEnumerable<Meeting> weeklymeetings = (from p in context.Meetings
            //                                       where p.IsDeleted == false && p.StartDate.Value.Date<=p.StartDate.Value.Date.AddDays(6)
            //                                       select p).ToList();

            return weeklymeetings;
        }

        public IEnumerable<Meeting> GetSelectedWeekMeetings(DateTime selectedDate, int companyID)
        {
            var weekstartday = selectedDate.Date.AddDays(6);
            IEnumerable<Meeting> weeklymeetings = (from p in context.Meetings
                                                   where p.IsDeleted == false && p.CompanyID==companyID && EntityFunctions.DiffDays(EntityFunctions.TruncateTime(p.StartDate), EntityFunctions.TruncateTime(weekstartday)) <= 7
                                                   orderby p.StartDate ascending
                                                   select p).ToList();
            return weeklymeetings;
        }

        public void SaveMeetingInvitees(long meetingID, long inviteeID, string inviteeType)
        {
            try
            {
                MeetingInvitee meetingInvitee=new MeetingInvitee();
                meetingInvitee.MeetingID = meetingID;
                meetingInvitee.InviteeID = inviteeID;
                meetingInvitee.InviteeType = inviteeType;
                context.Entry(meetingInvitee).State = EntityState.Added;
                context.SaveChanges();
            }

            catch (OptimisticConcurrencyException e)
            {
                context.SaveChanges();
            }
        }

        //code start by jasim bhai
        public List<MeetingsInviteeSummary> GetContactByMeetingInvitee()
        {
            var result = (from contacts in context.Contacts
                          from meetings in context.Meetings
                          from meetingsInvitees in context.MeetingInvitees
                          where contacts.ContactID == meetingsInvitees.InviteeID && meetings.MeetingID == meetingsInvitees.MeetingID
                          orderby meetings.StartDate
                          select new
                          {
                              meetingSubject = meetings.Subject,
                              mettingStartDate = meetings.StartDate,
                              mettingEndDate = meetings.EndDate,
                              mettingContactName = contacts.FirstName,
                              meetingTargetType = meetingsInvitees.InviteeType

                          }).ToList()
                                  .Select(x =>
                                      new MeetingsInviteeSummary
                                      {
                                          meetingSubject = x.meetingSubject,
                                          mettingStartDate = Convert.ToDateTime(x.mettingStartDate),
                                          mettingEndDate = Convert.ToDateTime(x.mettingEndDate),
                                          mettingContactName = x.mettingContactName,
                                          meetingTargetType = x.meetingTargetType

                                      }).ToList();
            return result;
        }

        //code end by jasim bhai






        public long InsertOrUpdateMeeting(Meeting meeting)
        {
            context.Entry(meeting).State = meeting.MeetingID == 0 ? EntityState.Added : EntityState.Modified;
            SaveChanges();
            return meeting.MeetingID;
        }













    }

    public class MeetingsInviteeSummary
    {
        public string meetingSubject { get; set; }
        public DateTime mettingStartDate { get; set; }
        public DateTime mettingEndDate { get; set; }
        public string mettingContactName { get; set; }
        public string meetingTargetType { get; set; }

    }
}

