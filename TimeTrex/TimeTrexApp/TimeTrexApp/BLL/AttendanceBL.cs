using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TimeTrexApp.DAL;

namespace TimeTrexApp.BLL
{
    public class AttendanceBL
    {
        DAL.Attendance attendanceDAL = new DAL.Attendance();

        public DataTable DailyAttendanceByCardNo(string card_no, string selectedDate)
        {
            try
            {

                return attendanceDAL.SelectDailyAttendanceInformationByCardNo(card_no, selectedDate);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            

        }

        public DataTable DailyAttendanceListByCardNo(string card_no,string dateselected)
        {
            try
            {

                return attendanceDAL.DailyAttendanceByCardNo(card_no,dateselected);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }


    }
}