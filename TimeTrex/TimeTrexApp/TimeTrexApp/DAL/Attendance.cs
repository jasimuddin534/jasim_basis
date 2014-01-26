using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;

namespace TimeTrexApp.DAL
{
    public class Attendance
    {
        OleDbConnection myDataConnection = new OleDbConnection(ConfigurationManager.ConnectionStrings["accessconnection"].ConnectionString);

        public DataTable SelectDailyAttendanceInformation(string selectedDate)
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            DataSet ds2 = new DataSet();
            string sql = "";
            string s = "";

            string query = "Select distinct card_no from data_card where d_card = '20130325'";
            OleDbDataAdapter dab = new OleDbDataAdapter(query, myDataConnection);
            dab.Fill(ds);

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
                {
                    s = ds.Tables[0].Rows[i][j].ToString();
                    //Response.Write(@"<script language='javascript'>alert('The following errors have occurred: \n" + s + " .');</script>");

                    sql = " Select top 1  d_card,card_no,io,t_card from data_card where d_card='20130325' and card_no='" + s + "' and io='1' order by t_card desc" +
                        " union select top 1 d_card,card_no,io,t_card from data_card where d_card='20130325' and card_no='" + s + "' and io='0' order by t_card asc";

                    OleDbDataAdapter da = new OleDbDataAdapter(sql, myDataConnection);
                    da.Fill(dt);
                }
            }



            return dt;
            
        }


        public DataTable SelectDailyAttendanceInformationByCardNo(string selectedCardNo,string selectedDate)
        {
            DataTable dt = new DataTable();
            string sql = "";
            string query = "";

           

            sql = " Select top 1  d_card,card_no,io,t_card from data_card where d_card='" + selectedDate + "' and card_no='" + selectedCardNo + "' and io='0' order by t_card asc";

           
            OleDbDataAdapter da = new OleDbDataAdapter(sql, myDataConnection);

            query = " Select top 1  d_card,card_no,io,t_card from data_card where d_card='" + selectedDate + "' and card_no='" + selectedCardNo + "' and io='1' order by t_card desc";

            OleDbDataAdapter da1 = new OleDbDataAdapter(query, myDataConnection);

            
            da.Fill(dt);
            da1.Fill(dt);
           

          return dt;

        }


        public DataTable DailyAttendanceByCardNo(string selectedCardNo,string dateselected)
        {
            DataTable dt = new DataTable();
            string sql = "";

            sql = " Select d_card,card_no,io,t_card from data_card where d_card like '"+dateselected+"%' and card_no='" + selectedCardNo + "' order by d_card asc";


            OleDbDataAdapter da = new OleDbDataAdapter(sql, myDataConnection);
            da.Fill(dt);


            return dt;

        }


    }
}