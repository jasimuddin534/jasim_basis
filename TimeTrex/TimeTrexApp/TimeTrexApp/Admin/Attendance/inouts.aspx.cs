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

namespace TimeTrexApp.Admin.Attendance
{
    public partial class inouts : System.Web.UI.Page
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
                        BindList();
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

        protected void BindList()
        {
           
            OleDbConnection myDataConnection = new OleDbConnection(ConfigurationManager.ConnectionStrings["accessconnection"].ConnectionString);

            string cardno = "" ;
            string intime = "" ;
            string outtime = "";
            string dateselected = "" ;

            EmployeeBL employeeBLL = new EmployeeBL();
            string userName = Page.User.Identity.Name;
            string owncard = employeeBLL.GetCardNoBySecName(userName);
            bool general = Roles.IsUserInRole(userName, "General");
            bool admin = Roles.IsUserInRole(userName, "Admin");

            if ((Request.QueryString["cardno"] != null && Request.QueryString["cardno"] != "") && (Request.QueryString["datetime"] != null && Request.QueryString["datetime"] != ""))
            {
                cardno = Request.QueryString["cardno"];
                intime = Request.QueryString["intime"];
                outtime = Request.QueryString["outtime"];
                dateselected = Request.QueryString["datetime"];

                string all = cardno + intime + outtime;

                if ((general == true && owncard == cardno)|| admin == true)
                {

                    string name = employeeBLL.GetNameByCardNo(cardno);

                    DateTime MyDateTime;
                    MyDateTime = new DateTime();
                    MyDateTime = DateTime.ParseExact(dateselected, "yyyyMMdd", null);

                    string datef = String.Format("{0:dd, MMMM}", MyDateTime);


                    pagetitle.Text = "In-Out List for <span style='font-weight:bold'>" + name + "</span> on <span style='font-weight:bold'>" + datef + "</span>";


                    DataTable dt = new DataTable();
                    string sql = " Select d_card,card_no,io,t_card from data_card where d_card like '" + dateselected + "%' and card_no='" + cardno + "'  order by t_card asc";


                    OleDbDataAdapter da = new OleDbDataAdapter(sql, myDataConnection);
                    da.Fill(dt);

                    //inoutsGridView.DataSource = dt;
                    //inoutsGridView.DataBind();


                    DataTable table1 = new DataTable("Attendance");
                    table1.Columns.Add("In/Out");
                    table1.Columns.Add("Time");



                    for (int u = 0; u < dt.Rows.Count; u++)
                    {
                        int count = 0;
                        DataRow dr = table1.NewRow();

                        for (int v = 0; v < dt.Columns.Count; v++)
                        {
                            string s = dt.Rows[u][v].ToString();

                            if (count == 2)
                            {
                                string val = "";
                                if (s == "0") { val = "IN"; }
                                if (s == "1") { val = "OUT"; }
                                dr["In/Out"] = val;
                            }

                            if (count == 3)
                            {
                                string hour = s.Substring(0, 2);
                                string min = s.Substring(2, 2);
                                string sec = s.Substring(4, 2);
                                string fotime = hour + ":" + min + ":" + sec;

                                dr["Time"] = fotime;
                            }

                            count++;
                        }
                        table1.Rows.Add(dr);


                    }

                    inoutsGridView.DataSource = table1;
                    inoutsGridView.DataBind();

                    Label1.Text = "";
                    Panel1.Visible = true;

                }
                else
                {

                    Label1.Text = "You have no privilege to see this information.";
                    Panel1.Visible = false;
                }
            }
            else
            {
                Label1.Text = "Insufficient Information!";
                Panel1.Visible = false;
            }
        }
    }
}