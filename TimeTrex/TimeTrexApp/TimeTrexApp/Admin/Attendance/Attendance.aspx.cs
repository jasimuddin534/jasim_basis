using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using TimeTrexApp.BLL;

namespace TimeTrexApp.Attendance
{
    public partial class Attendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            string userName = Page.User.Identity.Name;
            bool admin = Roles.IsUserInRole(userName, "Admin");
            if (userName != "")
            {
                if (Roles.IsUserInRole(userName, "General"))
                {
                    Response.Redirect("~/Attendance/Attendance.aspx");
                }
                else if (admin == true)
                {
                    if (!IsPostBack)
                    {
                        BindEmployeedropdown();
                    }
                }
                else
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
            else
            {
                // need to delete all session // logout
                Response.Redirect("~/Account/Login.aspx");
            }

        }

        protected void BindEmployeedropdown()
        {
            DataTable dropdown = new DataTable();
            OleDbConnection myDataConnection = new OleDbConnection(ConfigurationManager.ConnectionStrings["accessconnection"].ConnectionString);

            string sql = "Select id_name,card_no from p_person order by id_name asc";
            OleDbDataAdapter da = new OleDbDataAdapter(sql, myDataConnection);

            da.Fill(dropdown);


            EmployeeDropDownList.DataSource = dropdown;
            EmployeeDropDownList.DataTextField = "id_name";
            EmployeeDropDownList.DataValueField = "card_no";
            EmployeeDropDownList.DataBind();
        }

        protected void BindAttendanceDetails(string card_no, string dateselected)
        {

            AttendanceBL attendanceBLL = new AttendanceBL();
            EmployeeBL employeeBLL = new EmployeeBL();

            DataTable attendanceList = new DataTable();
            attendanceList = attendanceBLL.DailyAttendanceListByCardNo(card_no, dateselected);

            // new data table for the month 

            DataTable table1 = new DataTable("Attendance");
            table1.Columns.Add("Date");
            table1.Columns.Add("Card No");
            table1.Columns.Add("In Time");
            table1.Columns.Add("Out Time");
            table1.Columns.Add("Duration");
            table1.Columns.Add("in-outs");

            DataTable table2 = new DataTable("SortedAttendance");
            table2.Columns.Add("d_card");
            table2.Columns.Add("card_no");
            table2.Columns.Add("io");
            table2.Columns.Add("t_card");



            OleDbConnection myDataConnection = new OleDbConnection(ConfigurationManager.ConnectionStrings["accessconnection"].ConnectionString);
            DataTable dts = new DataTable();
            string sql = "";
            sql = " Select distinct d_card from data_card where d_card like '" + dateselected + "%' and card_no='" + card_no + "' order by d_card asc";
            OleDbDataAdapter da = new OleDbDataAdapter(sql, myDataConnection);
            da.Fill(dts);


            for (int u = 0; u < dts.Rows.Count; u++)
            {
                DataRow dr = table1.NewRow();


                for (int v = 0; v < dts.Columns.Count; v++)
                {
                    string selecteddate = dts.Rows[u][v].ToString();

                    DataTable dt = new DataTable();
                    dt = attendanceBLL.DailyAttendanceByCardNo(card_no, selecteddate);
                    int count = 0;
                    string io = "";
                    string intime = "";
                    string outtime = "";
                    string cardno = "";
                    string datetime = "";


                    for (int x = 0; x < dt.Rows.Count; x++)
                    {
                        DataRow dr2 = table2.NewRow();

                        for (int y = 0; y < dt.Columns.Count; y++)
                        {
                            string s = dt.Rows[x][y].ToString();

                            dr2[y] = s;


                            if (count == 0)
                            {
                                string year = s.Substring(0, 4);
                                string month = s.Substring(4, 2);
                                string day = s.Substring(6, 2);

                                string fdate = day + "/" + month + "/" + year;

                                dr["Date"] = fdate;

                                datetime = s;
                            }
                            if (count == 1)
                            {
                                dr["Card No"] = s;
                                cardno = s;
                            }

                            if (count == 2)
                                io = s;

                            if (count == 3 && io == "0")
                            {
                                string hour = s.Substring(0, 2);
                                string min = s.Substring(2, 2);
                                string sec = s.Substring(4, 2);
                                string fitime = hour + ":" + min + ":" + sec;

                                dr["In time"] = fitime;
                                intime = s;
                            }
                            else if (count == 3 && io == "1")
                            {
                                string hour = s.Substring(0, 2);
                                string min = s.Substring(2, 2);
                                string sec = s.Substring(4, 2);
                                string fotime = hour + ":" + min + ":" + sec;

                                dr["Out Time"] = fotime;
                                outtime = s;
                            }

                            if (count == 6)
                                io = s;

                            if (count == 7 && io == "1")
                            {
                                string hour = s.Substring(0, 2);
                                string min = s.Substring(2, 2);
                                string sec = s.Substring(4, 2);
                                string fotime = hour + ":" + min + ":" + sec;

                                dr["Out Time"] = fotime;
                                outtime = s;
                            }

                            count++;
                        }
                        table2.Rows.Add(dr2);
                    }

                    if (intime != "" && outtime != "")
                    {
                        int inhour = int.Parse(intime.Substring(0, 2));
                        int inmin = int.Parse(intime.Substring(2, 2));
                        int outhour = int.Parse(outtime.Substring(0, 2));
                        int outmin = int.Parse(outtime.Substring(2, 2));

                        int dhour = outhour - inhour;
                        int dmin = 0;
                        if (dhour > 0)
                        {
                            dmin = Math.Abs(outmin - inmin);
                        }
                        else
                        {
                            dmin = (outmin - inmin);
                        }
                        string duration = dhour + " hour " + dmin + " min";

                        dr["Duration"] = duration;
                    }



                    dr["in-outs"] = "inouts.aspx?cardno=" + cardno + "&intime=" + intime + "&outtime=" + outtime + "&datetime=" + datetime;
                    table1.Rows.Add(dr);


                }
            }

            //DailyAttendanceGridView.DataSource = table2;
            //DailyAttendanceGridView.DataBind();


            DailyAttendanceGridViewByCard.DataSource = table1;
            DailyAttendanceGridViewByCard.DataBind();




            //DailyAttendanceListGridView.DataSource = attendanceList;
            //DailyAttendanceListGridView.DataBind();






        }

        protected void EmployeeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            string s = EmployeeDropDownList.SelectedValue.ToString();
            BindMonth();
            BindYear();
        }


        //protected void BindMonth()
        //{

        //    DailyAttendanceGridViewByCard.DataSource = null;
        //    DailyAttendanceGridViewByCard.DataBind();

        //    MonthDropDownList.Items.Clear();

        //    MonthDropDownList.Items.Insert(0, new ListItem("--Select--", "0"));
        //    MonthDropDownList.Items.Insert(1, new ListItem("January", "201301"));
        //    MonthDropDownList.Items.Insert(2, new ListItem("February", "201302"));
        //    MonthDropDownList.Items.Insert(3, new ListItem("March", "201303"));
        //    MonthDropDownList.Items.Insert(4, new ListItem("April", "201304"));
        //    MonthDropDownList.Items.Insert(5, new ListItem("May", "201305"));
        //    MonthDropDownList.Items.Insert(6, new ListItem("June", "201306"));
        //    MonthDropDownList.Items.Insert(7, new ListItem("July", "201307"));
        //    MonthDropDownList.Items.Insert(8, new ListItem("August", "201308"));
        //    MonthDropDownList.Items.Insert(9, new ListItem("September", "201309"));
        //    MonthDropDownList.Items.Insert(10, new ListItem("October", "201310"));
        //    MonthDropDownList.Items.Insert(11, new ListItem("November", "201311"));
        //    MonthDropDownList.Items.Insert(12, new ListItem("December", "201312"));
        //}




        protected void BindMonth()
        {

            DailyAttendanceGridViewByCard.DataSource = null;
            DailyAttendanceGridViewByCard.DataBind();

            MonthDropDownList.Items.Clear();

            MonthDropDownList.Items.Insert(0, new ListItem("--Select--", "0"));
            MonthDropDownList.Items.Insert(1, new ListItem("January", "01"));
            MonthDropDownList.Items.Insert(2, new ListItem("February", "02"));
            MonthDropDownList.Items.Insert(3, new ListItem("March", "03"));
            MonthDropDownList.Items.Insert(4, new ListItem("April", "04"));
            MonthDropDownList.Items.Insert(5, new ListItem("May", "05"));
            MonthDropDownList.Items.Insert(6, new ListItem("June", "06"));
            MonthDropDownList.Items.Insert(7, new ListItem("July", "07"));
            MonthDropDownList.Items.Insert(8, new ListItem("August", "08"));
            MonthDropDownList.Items.Insert(9, new ListItem("September", "09"));
            MonthDropDownList.Items.Insert(10, new ListItem("October", "10"));
            MonthDropDownList.Items.Insert(11, new ListItem("November", "11"));
            MonthDropDownList.Items.Insert(12, new ListItem("December", "12"));
        }





        protected void BindYear()
        {

            DailyAttendanceGridViewByCard.DataSource = null;
            DailyAttendanceGridViewByCard.DataBind();

            YearDropDownList.Items.Clear();

            for (int i = 2000; i <= 2020; i++)
            {
                //ddlPicker1.items.add(new ListItem(i.toString(),i.toString());
                YearDropDownList.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }



            //YearDropDownList.Items.Insert(0, new ListItem("--Select--", "0"));
            //YearDropDownList.Items.Insert(1, new ListItem("2012", "2012"));
            //YearDropDownList.Items.Insert(2, new ListItem("2013", "2013"));
            //YearDropDownList.Items.Insert(3, new ListItem("2014", "2014"));
            //YearDropDownList.Items.Insert(4, new ListItem("2015", "2015"));
            //YearDropDownList.Items.Insert(5, new ListItem("2016", "2016"));
            //YearDropDownList.Items.Insert(6, new ListItem("2017", "2017"));
            //YearDropDownList.Items.Insert(7, new ListItem("2018", "2018"));
            //YearDropDownList.Items.Insert(8, new ListItem("2019", "2019"));
            //YearDropDownList.Items.Insert(9, new ListItem("2020", "2020"));
            //YearDropDownList.Items.Insert(10, new ListItem("2021", "2021"));
            //YearDropDownList.Items.Insert(11, new ListItem("2022", "2022"));
            //YearDropDownList.Items.Insert(12, new ListItem("2023", "2023"));
        }







        protected void MonthDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            string s = EmployeeDropDownList.SelectedValue.ToString();
            string selectedYear = YearDropDownList.SelectedValue.ToString();
            string selectedMonth = MonthDropDownList.SelectedValue.ToString();
            string selectedDate = selectedYear + selectedMonth;
            //string selectedDate = MonthDropDownList.SelectedValue.ToString();
            BindAttendanceDetails(s, selectedDate);
        }



        protected void DailyAttendanceGridViewByCard_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var firstCell = e.Row.Cells[5];
                firstCell.Controls.Clear();
                firstCell.Controls.Add(new HyperLink { NavigateUrl = System.Web.HttpUtility.HtmlDecode(firstCell.Text), Text = "in-outs" });

                firstCell.Attributes.Add("style", "text-decoration:underline;");

            }
        }

        protected void YearDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            string s = EmployeeDropDownList.SelectedValue.ToString();
            string selectedYear = YearDropDownList.SelectedValue.ToString();
            string selectedMonth = MonthDropDownList.SelectedValue.ToString();
            string selectedDate = selectedYear + selectedMonth;
            //string selectedDate = MonthDropDownList.SelectedValue.ToString();
            BindAttendanceDetails(s, selectedDate);
        }


    }
}