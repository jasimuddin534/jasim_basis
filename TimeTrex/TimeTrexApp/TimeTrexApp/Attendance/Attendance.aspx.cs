using System;
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
    public partial class Attendance1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string userName = Page.User.Identity.Name;
            bool admin = Roles.IsUserInRole(userName, "Admin");
            bool general = Roles.IsUserInRole(userName, "General");
            if (userName != "")
            {
                if (general == true || admin == true)
                {
                    if (!IsPostBack)
                    {
                        BindMonth();
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

        protected void BindMonth()
        {

            DailyAttendanceGridViewByCard.DataSource = null;
            DailyAttendanceGridViewByCard.DataBind();

            MonthDropDownList.Items.Clear();

            MonthDropDownList.Items.Insert(0, new ListItem("--Select--", "0"));
            MonthDropDownList.Items.Insert(1, new ListItem("January", "201301"));
            MonthDropDownList.Items.Insert(2, new ListItem("February", "201302"));
            MonthDropDownList.Items.Insert(3, new ListItem("March", "201303"));
            MonthDropDownList.Items.Insert(4, new ListItem("April", "201304"));
            MonthDropDownList.Items.Insert(5, new ListItem("May", "201305"));
            MonthDropDownList.Items.Insert(6, new ListItem("June", "201306"));
            MonthDropDownList.Items.Insert(7, new ListItem("July", "201307"));
            MonthDropDownList.Items.Insert(8, new ListItem("August", "201308"));
            MonthDropDownList.Items.Insert(9, new ListItem("September", "201309"));
            MonthDropDownList.Items.Insert(10, new ListItem("October", "201310"));
            MonthDropDownList.Items.Insert(11, new ListItem("November", "201311"));
            MonthDropDownList.Items.Insert(12, new ListItem("December", "201312"));
        }

        protected void MonthDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            EmployeeBL employeeBLL = new EmployeeBL();
            string userName = Page.User.Identity.Name;
            string card_no = employeeBLL.GetCardNoBySecName(userName); //"0007091651";
            string selectedDate = MonthDropDownList.SelectedValue.ToString();
            BindAttendanceDetails(card_no, selectedDate);
        }

        protected void BindAttendanceDetails(string card_no, string dateselected)
        {

            AttendanceBL attendanceBLL = new AttendanceBL();
    
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
                        int dmin = Math.Abs(outmin - inmin);

                        string duration = dhour + " hour " + dmin + " min";

                        dr["Duration"] = duration;
                    }

         
                    dr["in-outs"] = "~/Admin/Attendance/inouts.aspx?cardno=" + cardno + "&intime=" + intime + "&outtime=" + outtime + "&datetime=" + datetime;
                    table1.Rows.Add(dr);

                }
            }

            DailyAttendanceGridViewByCard.DataSource = table1;
            DailyAttendanceGridViewByCard.DataBind();

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

    }
}