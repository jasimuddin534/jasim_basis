using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;

namespace C3App.Reports
{
    public partial class Reports : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Data Source=203.202.241.236;Initial Catalog=C3New;Persist Security Info=True;User ID=c3dev;Password=Panacea123");
        ArrayList arraylist1 = new ArrayList();
        ArrayList arraylist2 = new ArrayList();
        static ArrayList newlistbox1 = new ArrayList();

        protected void Page_Load(object sender, EventArgs e)
        {       

        }

        public bool CheckColumnName(string tablename)
        {
            bool output = false;
            string command = " select column_name from information_schema.columns where column_name = 'Name' and table_name = '"+tablename+"' ";
            SqlCommand cmd = new SqlCommand(command, con);
            string result = (string)cmd.ExecuteScalar();
            if (!string.IsNullOrEmpty(result))
            {
                output = true;
            }
            else
            {
                output = false;
            }

            return output;
        }

        public string AllColumnName(string tablename)
        {
            string result = "";
            string command = "";
        

            command = " SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME ='" + tablename + "' " +
      " and COLUMN_NAME!='CompanyID' and COLUMN_NAME!='RecordID' and COLUMN_NAME!='Timestamp' and COLUMN_NAME!='IsDeleted' " +
      " and COLUMN_NAME!='CreatedBy' and COLUMN_NAME!='CreatedTime' and COLUMN_NAME!='ModifiedBy' and COLUMN_NAME!='ModifiedTime' " +
      " and COLUMN_NAME!='TemplateID' and COLUMN_NAME!='TemplateType' and COLUMN_NAME!='ParentID' and COLUMN_NAME!='IsTemplate'" +
      " and DATA_TYPE!='bit' and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') != 1 ";


            SqlCommand cmd = new SqlCommand(command, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            int rows = ds.Tables[0].Rows.Count;
            for (int i = 0; i < rows; i++)
            {
                result += ds.Tables[0].Rows[i].ItemArray[0].ToString() + ",";
            }

            result = result.TrimEnd(',');

            return result;
        }

        public string CheckColumnCondition(bool output,string mod, string col, string op, string tablename)
        {
            string command1 = "";
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            if (output == false)
            {
                command1 = "select " + col + ", value from " + tablename + " order by value desc ";
            }
            if (output == true)
            {
                command1 = "select " + col + ", Name from " + tablename + " where CompanyID = " + companyid + " order by name desc ";
            }
            if ((col == "AssignedUserID" || col == "AssignedTo" || col == "ReportsTo" || col == "ReportsToID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "select  UserID, FirstName from Users where CompanyID = " + companyid + " order by FirstName desc ";
            }
            if ((col == "BillingAccoutId" || col == "ShippingAccountID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "Select AccountID, Name from Accounts where CompanyID = " + companyid + " order by Name desc";
            }
            if ((col == "BillingContactId" || col == "ShippingContactID" || col == "ContactID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "Select ContactID, FirstName from Contacts where CompanyID = " + companyid + " order by FirstName desc " ;
            }
            if ((col == "AccountTypesID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = " Select AccountTypeID, Value from AccountTypes order by Value desc ";
            }
            if ((col == "TeamSetID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "Select TeamSetId, TeamSetName from TeamSets where CompanyID = " + companyid + " order by TeamSetName desc " ;
            }
            if ((col == "LeadSourcesID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "Select LeadSourceID, Value from LeadSources order by Value desc ";
            }
            if ((col == "CategoryID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = " select DocumentCategoryID, Value from DocumentCategories order by Value desc ";
            }
            if ((col == "SubCategoryID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = " select DocumentSubCategoryID, Value from DocumentSubCategories order by Value desc ";
            }
            if ((col == "TypeID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "select ProductTypeID, Value from ProductTypes order by Value desc ";
            }
            if ((col == "IndustryID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "select CompanyTypeID, Value from CompanyTypes order by Value desc ";
            }
            if ((col == "SalesStageID") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "select OpportunitySalesStageID, Value from OpportunitySalesStages order by Value desc ";
            }
            if ((col == "StatusID") && (mod == "Cases") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "Select CaseStatusId,Value from CaseStatuses order by Value desc ";
            }
            if ((col == "StatusID") && (mod == "Documents") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "Select DocumentStatusID,Value from DocumentStatuses order by Value desc ";
            }
            if ((col == "StatusID") && (mod == "Meetings") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "Select MeetingStatusID,Value from MeetingStatuses order by Value desc ";
            }
            if ((col == "StatusID") && (mod == "Products") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "Select ProductStatusID,Value from ProductStatuses  order by Value desc ";
            }
            if ((col == "StatusID") && (mod == "Tasks") && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "Select TaskStatusID,Value from TaskStatuses order by Value desc ";
            }
            if (((col.Contains("Countries")) || (col.Contains("Country"))) && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "select CountryID, CountryName from Countries order by CountryName desc ";
            }
            if (((col.Contains("Currencies")) || (col.Contains("Currency"))) && (op != "Total" && op != "Max" && op != "Min"))
            {
                command1 = "select CurrencyId, Name from Currencies order by Name desc ";
            }

            return command1;
        }

        public Hashtable GetDropDownList()
        {
            //con.Open();
            string command = "";
            command = "select COLUMN_NAME,Table_name  from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA = 'dbo' and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') = 1 ";

            SqlCommand cmd = new SqlCommand(command, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            int rows = ds.Tables[0].Rows.Count;
            Hashtable hashtable = new Hashtable();

            for (int i = 0; i < rows; i++)
            {
                string key = ds.Tables[0].Rows[i].ItemArray[0].ToString();
                string name = ds.Tables[0].Rows[i].ItemArray[1].ToString();
                hashtable.Add(key, name);
            }
            //con.Close();

            return hashtable;
        }

        public string GetDropDownValue(int val, string tablename, string col)
        {
            string value = "";
            string command1 = "";
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            string mod = modulename.SelectedValue;

            string command = " select column_name from information_schema.columns where column_name = 'Name' and table_name = '" + tablename + "' ";
            SqlCommand cmd = new SqlCommand(command, con);
            string result = (string)cmd.ExecuteScalar();
            if (!string.IsNullOrEmpty(result))
            {
                command1 = "select name from " + tablename + " where " + col + " = " + val;
            }
            if (string.IsNullOrEmpty(result))
            {
                command1 = "select value from " + tablename + " where " + col + " = " + val;
            }
            if (col == "AccountTypesID")
            {
                command1 = " Select Value from AccountTypes where AccountTypeID = " + val;
            }
            if (col == "IndustryID")
            {
                command1 = "select Value from CompanyTypes where CompanyTypeID = " + val;
            }
            if (col == "AssignedUserID" || col == "AssignedTo" || col == "ReportsTo" || col == "ReportsToID")
            {
                command1 = "select FirstName from Users where CompanyID = " + companyid + " and UserID = " + val;
            }

            if (((col.Contains("Countries")) || (col.Contains("Country"))))
            {
                command1 = "select CountryName from Countries where CountryID = " + val;
            }
            if (((col.Contains("Currencies")) || (col.Contains("Currency"))))
            {
                command1 = "select Name from Currencies where CurrencyID = " + val;
            }
            if (col == "BillingAccoutId" || col == "ShippingAccountID")
            {
                command1 = "Select Name from Accounts where CompanyID = " + companyid + " and AccountID = " + val;
            }
            if (col == "BillingContactId" || col == "ShippingContactID" || col == "ContactID")
            {
                command1 = "Select FirstName from Contacts where CompanyID = " + companyid + " and ContactID = " + val;
            }

            if (col == "TeamSetID")
            {
                command1 = "Select TeamSetName from TeamSets where CompanyID = " + companyid + " and TeamSetID = " + val;
            }
            if (col == "LeadSourcesID")
            {
                command1 = "Select Value from LeadSources where LeadSourceID =  " + val;
            }
            if (col == "CategoryID")
            {
                command1 = " select Value from DocumentCategories where DocumentCategoryID = " + val;
            }
            if (col == "SubCategoryID")
            {
                command1 = " select Value from DocumentSubCategories where DocumentSubCategoryID = " + val;
            }
            if (col == "TypeID")
            {
                command1 = "select Value from ProductTypes where ProductTypeID = " + val;
            }

            if (col == "SalesStageID")
            {
                command1 = "select Value from OpportunitySalesStages where OpportunitySalesStageID = " + val;
            }
            if ((col == "StatusID") && (mod == "Cases"))
            {
                command1 = "Select Value from CaseStatuses where CaseStatusId =  " + val;
            }
            if ((col == "StatusID") && (mod == "Documents"))
            {
                command1 = "Select Value from DocumentStatuses where DocumentStatusID = " + val;
            }
            if ((col == "StatusID") && (mod == "Meetings"))
            {
                command1 = "Select MeetingStatusID,Value from MeetingStatuses where MeetingStatusID = " + val;
            }
            if ((col == "StatusID") && (mod == "Products"))
            {
                command1 = "Select Value from ProductStatuses where ProductStatusID = " + val;
            }
            if ((col == "StatusID") && (mod == "Tasks"))
            {
                command1 = "Select Value from TaskStatuses where TaskStatusID = " + val;
            }


            SqlCommand cmd1 = new SqlCommand(command1, con);
            SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
            DataSet ds1 = new DataSet();
            da1.Fill(ds1);
            int rows1 = ds1.Tables[0].Rows.Count;

            for (int i = 0; i < rows1; i++)
            {
                value = ds1.Tables[0].Rows[i].ItemArray[0].ToString();
            }


            return value;
        }
        
        protected void modulename_SelectedIndexChanged(object sender, EventArgs e)
        {
            string command = "";
            ModuleNameHiddenField.Value = modulename.SelectedValue;
            string module = ModuleNameHiddenField.Value;

            colname.Items.Clear();
            newlistbox1.Clear();

            con.Open();
            command = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns where TABLE_NAME ='" + module + "' " +
            " and COLUMN_NAME!='CompanyID' and COLUMN_NAME!='RecordID' and COLUMN_NAME!='Timestamp' and COLUMN_NAME!='IsDeleted' " +
            " and COLUMN_NAME!='CreatedBy' and COLUMN_NAME!='CreatedTime' and COLUMN_NAME!='ModifiedBy' and COLUMN_NAME!='ModifiedTime' " +
            " and COLUMN_NAME!='TemplateID' and COLUMN_NAME!='TemplateType' and COLUMN_NAME!='ParentID' and COLUMN_NAME!='IsTemplate'" +
            " and DATA_TYPE!='bit' and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') != 1 ";

            if (command != "")
            {
               
                SqlCommand cmd = new SqlCommand(command, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                //colname.DataSource = ds;
                //colname.DataTextField = "COLUMN_NAME";
                //colname.DataValueField = "COLUMN_NAME";
                //colname.DataBind();
                colname.Items.Insert(0, new ListItem("--Select--", "0"));

                int rows = ds.Tables[0].Rows.Count;
                ListBox1.Items.Clear();
                ListBox2.Items.Clear();

                for (int i = 0; i < rows; i++)
                {
                    string listval = ds.Tables[0].Rows[i].ItemArray[0].ToString();
                    int icount = i + 1;
                    if (listval.Contains("ID"))
                    {
                        string beforechange = listval;
                        listval = listval.Replace("ID", "");
                        colname.Items.Insert(icount, new ListItem(listval, beforechange));
                        newlistbox1.Add(listval);
                    }
                    else
                    {
                        colname.Items.Insert(icount, new ListItem(listval, listval));
                    }

                    string output = "";
                    foreach (char caracter in listval)
                    {
                        if (caracter <= 90 && caracter >= 65)
                        {
                            output += " ";
                        }
                        output += caracter;
                    }

                    ListBox1.Items.Add(new ListItem(output));
                }

                KeywordDropDownList.Items.Clear();
                KeywordDropDownList.Visible = false;
                KeywordTextBox.Visible = true;

                string col = colname.SelectedValue;
                string op = OperatorDropdown.SelectedValue;
                if ((op == "Total" || op == "Max" || op == "Min") && col != "0")
                {
                    KeywordTextBox.Text = col;
                    KeywordTextBox.ReadOnly = true;
                }
                else
                {
                    KeywordTextBox.Text = "";
                    KeywordTextBox.ReadOnly = false;
                }

                ListBox1.DataBind();
                upListView.Update();
            }
            con.Close();



        }
        
        protected void colname_SelectedIndexChanged(object sender, EventArgs e)
        {
            string col = colname.SelectedValue;
            string op = OperatorDropdown.SelectedValue;
            string mod = modulename.SelectedValue;
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            KeywordDropDownList.Items.Clear();
            KeywordDropDownList.Visible = false;
            KeywordTextBox.Visible = true;

            
            /* START For DropdownList */
                
                string command = "";
                command = "select COLUMN_NAME,Table_name  from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA = 'dbo' and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') = 1 ";

                SqlCommand cmd = new SqlCommand(command, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                int rows = ds.Tables[0].Rows.Count;
                Hashtable hashtable = new Hashtable();

                for (int i = 0; i < rows;i++ )
                {
                    string key = ds.Tables[0].Rows[i].ItemArray[0].ToString();
                    string name = ds.Tables[0].Rows[i].ItemArray[1].ToString();
                    hashtable.Add(key, name);
                }
                
                bool colsearch = false;
                colsearch = hashtable.ContainsKey(col);
                if ((colsearch == true && (op != "Total" && op != "Max" && op != "Min"))||
                    (col == "AssignedUserID" || col == "AssignedTo" || col == "ReportsTo" || col == "ReportsToID") ||
                    (col == "BillingAccoutId" || col == "ShippingAccountID") || (col == "BillingContactId" || col=="ShippingContactID") ||
                    (col == "AccountTypesID") || (col == "TeamSetID") || (col == "LeadSourcesID") || (col == "CategoryID") || (col == "SubCategoryID")||
                    (col == "TypeID") ||(col == "IndustryID") || (col == "SalesStageID") || (col=="StatusID") || (col.Contains("Currencies")) ||
                    (col.Contains("Countries")) || (col.Contains("Country"))  || (col.Contains("Currency"))
                    )
                {
                    string tablename = "";
                    if (colsearch == true)
                    {
                        tablename = hashtable[col].ToString();
                    }
                    KeywordTextBox.Visible = false;
                    KeywordDropDownList.Visible = true;
                    con.Open();
                    string command1 = "";
                    bool output = false;
                    output = CheckColumnName(tablename);

                    command1= CheckColumnCondition(output,mod,col,op,tablename);

                    if(op != "Total" && op != "Max" && op != "Min")
                    {
                        SqlCommand cmd1 = new SqlCommand(command1, con);
                        SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                        DataSet ds1 = new DataSet();
                        da1.Fill(ds1);
                        int rows1 = ds1.Tables[0].Rows.Count;
            
                        for (int i = 0; i < rows1; i++)
                        {
                            string key = ds1.Tables[0].Rows[i].ItemArray[0].ToString();
                            string val = ds1.Tables[0].Rows[i].ItemArray[1].ToString();
                            //KeywordDropDownList.Items.Insert(0, key);
                           KeywordDropDownList.Items.Insert(0, new ListItem(val, key));
                      
                        }
                    }
                    if (op == "Total" || op == "Max" || op == "Min")
                    {
                        KeywordTextBox.Visible = true;
                        KeywordTextBox.Text = col;
                        KeywordTextBox.ReadOnly = true;
                        KeywordDropDownList.Visible = false;
                    }


                    con.Close();

                }
            
            /* END */

                /* START For Total, Max, Min */

                else if (op == "Total" || op == "Max" || op == "Min")
                {
                    KeywordTextBox.Text = col;
                    KeywordTextBox.ReadOnly = true;
                    KeywordDropDownList.Visible = false;
                }
                else
                {
                    KeywordTextBox.Text = "";
                    KeywordTextBox.ReadOnly = false;
                    KeywordDropDownList.Visible = false;
                }

                /* END */


            upListView.Update();
        }
       
        protected void OperatorDropdown_SelectedIndexChanged(object sender, EventArgs e)
        {
            string col = colname.SelectedValue;
            string op = OperatorDropdown.SelectedValue;
            string mod = modulename.SelectedValue;
            KeywordDropDownList.Items.Clear();
            KeywordDropDownList.Visible = false;
            KeywordTextBox.Visible = true;
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            /* START For DropdownList */

            string command = "";
            command = "select COLUMN_NAME,Table_name  from INFORMATION_SCHEMA.COLUMNS where TABLE_SCHEMA = 'dbo' and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, 'IsIdentity') = 1 ";

            SqlCommand cmd = new SqlCommand(command, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            int rows = ds.Tables[0].Rows.Count;
            Hashtable hashtable = new Hashtable();

            for (int i = 0; i < rows; i++)
            {
                string key = ds.Tables[0].Rows[i].ItemArray[0].ToString();
                string name = ds.Tables[0].Rows[i].ItemArray[1].ToString();
                hashtable.Add(key, name);
            }

            bool colsearch = false;
            colsearch = hashtable.ContainsKey(col);
            if ((colsearch == true && (op != "Total" && op != "Max" && op != "Min")) ||
                    (col == "AssignedUserID" || col == "AssignedTo" || col == "ReportsTo" || col == "ReportsToID") ||
                    (col == "BillingAccoutId" || col == "ShippingAccountID") || (col == "BillingContactId" || col == "ShippingContactID") ||
                    (col == "AccountTypesID") || (col == "TeamSetID") || (col == "LeadSourcesID") || (col == "CategoryID") || (col == "SubCategoryID") ||
                    (col == "TypeID") || (col == "IndustryID") || (col == "SalesStageID") || (col == "StatusID") || (col.Contains("Currencies")) ||
                    (col.Contains("Countries")) || (col.Contains("Country")) || (col.Contains("Currency"))
                    )
            {
                string tablename = "";
                if (colsearch == true)
                {
                    tablename = hashtable[col].ToString();
                }
                KeywordTextBox.Visible = false;
                KeywordDropDownList.Visible = true;
                con.Open();
                string command1 = "";
                bool output = false;
                output = CheckColumnName(tablename);

                command1 = CheckColumnCondition(output, mod, col, op, tablename);

                if (op != "Total" && op != "Max" && op != "Min")
                {
                    SqlCommand cmd1 = new SqlCommand(command1, con);
                    SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
                    DataSet ds1 = new DataSet();
                    da1.Fill(ds1);
                    int rows1 = ds1.Tables[0].Rows.Count;

                    for (int i = 0; i < rows1; i++)
                    {
                        string key = ds1.Tables[0].Rows[i].ItemArray[0].ToString();
                        string val = ds1.Tables[0].Rows[i].ItemArray[1].ToString();
                        //KeywordDropDownList.Items.Insert(0, key);
                        KeywordDropDownList.Items.Insert(0, new ListItem(val, key));

                    }
                }
                if (op == "Total" || op == "Max" || op == "Min")
                {
                    KeywordTextBox.Visible = true;
                    KeywordTextBox.Text = col;
                    KeywordTextBox.ReadOnly = true;
                    KeywordDropDownList.Visible = false;
                }


                con.Close();

            }

            /* END */

            /* START For Total, Max, Min */
            else if (op == "Total" || op == "Max" || op == "Min")
            {
                KeywordTextBox.Text = col;
                KeywordTextBox.ReadOnly = true;
                KeywordDropDownList.Visible = false;
            }
            else
            {
                KeywordTextBox.Text = "";
                KeywordTextBox.ReadOnly = false;
                KeywordDropDownList.Visible = false;
            }
            /* END */

            upListView.Update();

        }

        protected void UpdateLinkButton_Click(object sender, EventArgs e)
        {
            string module = ModuleNameHiddenField.Value;
            string col = colname.SelectedValue;
            string op = OperatorDropdown.SelectedValue;
            string key = "";
            if (KeywordTextBox.Visible == true)
            {
                key = KeywordTextBox.Text;
            }
            if(KeywordDropDownList.Visible == true)
            {
                key = KeywordDropDownList.SelectedValue;
            }


            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            string discol = "";
            string command = "";
            string operation = "";
        

            if (ListBox2.Items.Count > 0)
            {
                foreach (ListItem item in ListBox2.Items)
                {
                    string newval = item.Text.Replace(" ", "");

                    if (newlistbox1.Contains(newval))
                    {
                       string  val = newval + "ID";
                        discol += val + ",";
                    }
                    else
                    {
                        discol += item.Text.Replace(" ","") + ",";
                    }

                }
                discol = discol.TrimEnd(',');
            }
            else
            {
                discol = AllColumnName(module);
            }
                

            //SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Laptop' AND COLUMN_NAME NOT IN ('code');

            if (op == "Equals")
            {
                operation = "Select " + discol + " FROM " + module + " where " + col + " = '" + key + "' and CompanyID =  " + companyid ;
            }
            else if (op == "Not Equal")
            {
                operation = "Select " + discol + " FROM " + module + " where " + col + " != '" + key + "' and CompanyID = " + companyid ;
            }
            else if (op == "Contains")
            {
                operation = "Select " + discol + " FROM " + module + " where " + col + " like '%" + key + "%' and CompanyID = " + companyid ;
            }
            else if (op == "Not Contains")
            {
                operation = "Select " + discol + " FROM " + module + " where " + col + " not like '%" + key + "%' and CompanyID =  " + companyid ;
            }
            else if (op == "Total")
            {
                operation = " Select count(" + col + ")" + " from " + module + " where CompanyID =  " + companyid ;
            }
            else if (op == "Max")
            {
                operation = " Select Max(" + col + ")" + " from " + module + " where CompanyID = " + companyid ;
            }
            else if (op == "Min")
            {
                operation = " Select Min(" + col + ")" + " from " + module + " where CompanyID = " + companyid ;
            }

            else if (op == "Greater than Equal")
            {
                operation = " Select " + discol + " from " + module + " where " + col + " >= " + key + " and CompanyID =  " + companyid ;
            }

            else if (op == "Less than Equal")
            {
                operation = " Select " + discol + " from " + module + " where " + col + " <= " + key + " and CompanyID = " + companyid ;
            }

            int rowcount = 0;
            ReportGridView.DataSource = null;
            ReportGridView.DataBind();

            con.Open();
            command = operation;
   

            if (command != "" && key != "")
            {
                SqlCommand cmd = new SqlCommand(command, con);
               // SqlDataReader dr = cmd.ExecuteReader();
               // ReportGridView.DataSource = dr;
               // ReportGridView.DataBind();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                DataTable dt2 = new DataTable();
                da.Fill(dt);
                int ii = 0;
                 Hashtable hashtable = GetDropDownList();
                bool colsearch = false;

                foreach (DataRow dr in dt.Rows)
                {
                    DataRow dr2;
                    dr2 = dt2.NewRow();      
                    foreach(DataColumn dc in dt.Columns)
                    {
                        string dd = dc.ColumnName.ToString();

                        string identity = dc.DataType.ToString();
                        string value = dr[dc].ToString();
                         
                        colsearch = hashtable.ContainsKey(dd);
          
                        //if (colsearch == true )

                   if ((colsearch == true) ||
                    (dd == "AssignedUserID" || dd == "AssignedTo" || dd == "ReportsTo" || dd == "ReportsToID") ||
                    (dd == "BillingAccoutId" || dd == "ShippingAccountID") || (dd == "BillingContactId" || dd == "ShippingContactID") ||
                    (dd == "AccountTypesID") || (dd == "TeamSetID") || (dd == "LeadSourcesID") || (dd == "CategoryID") || (dd == "SubCategoryID") ||
                    (dd == "TypeID") || (dd == "IndustryID") || (dd == "SalesStageID") || (dd == "StatusID") || (dd.Contains("Currencies")) ||
                    (dd.Contains("Countries")) || (dd.Contains("Country")) || (dd.Contains("Currency"))
                    )
                   {
                            string tablename = "";
                            if (colsearch == true)
                            {
                                tablename = hashtable[dd].ToString();
                            }    
                       
                             int val = 0;
                             if (value != "")
                            val = int.Parse(value);
                            if (ii == 0)
                            {
                                DataColumn dc2 = new DataColumn();
                                dc2.DataType = Type.GetType("System.String");

                                if (dd.Contains("ID"))
                                {
                                    string colval = dd.Replace("ID", "");
                                    dc2.ColumnName = colval;
                                    dt2.Columns.Add(dc2);
                                }
                                else
                                {
                                    dc2.ColumnName = dd;
                                    dt2.Columns.Add(dc2);
                                }
                                 

                            }
                            if (value != "")
                            {
                                string colindex = dd;
                                if (dd.Contains("ID"))
                                {colindex = dd.Replace("ID", "");}
                                else { colindex = dd; }
                                dr2[colindex] = GetDropDownValue(val, tablename, dd);
                            }
                            else
                            {
                                string colindex = dd;
                                if (dd.Contains("ID"))
                                { colindex = dd.Replace("ID", ""); }
                                else { colindex = dd; }
                                dr2[colindex] = DBNull.Value;
                            }
                        }
                        else
                        {
                           
                            if (ii == 0)
                            {
                                DataColumn dc2 = new DataColumn();
                                dc2.DataType = Type.GetType(identity);
                                dc2.ColumnName = dd;
                                dt2.Columns.Add(dc2);
                                
                            }
                            if (identity != "System.String" && value == "")
                            {
                                dr2[dd] = DBNull.Value;
                            }
                            else if (identity == "System.Byte[]")
                            {
                                dr2[dd] = null;
                            }
                            else
                            {
                                dr2[dd] = value;
                            }
                             
                        }

                      
                    }
                    dt2.Rows.Add(dr2);
                    ii++;
                }

                 ReportGridView.DataSource = dt2;
                 ReportGridView.DataBind();
                 Button1.Visible = true;
            }


            rowcount = ReportGridView.Rows.Count;
            if (rowcount == 0)
            {
                ReportGridView.DataSource = null;
                ReportGridView.DataBind();
            }
            upGridView.Update();
            con.Close();


        }

        protected void SelectLinkButton_Click(object sender, EventArgs e)
        {
            lbltxt.Visible = false;
            if (ListBox1.SelectedIndex >= 0)
            {
                for (int i = 0; i < ListBox1.Items.Count; i++)
                {
                    if (ListBox1.Items[i].Selected)
                    {
                        if (!arraylist1.Contains(ListBox1.Items[i]))
                        {
                            arraylist1.Add(ListBox1.Items[i]);

                        }
                    }
                }

                for (int i = 0; i < arraylist1.Count; i++)
                {
                    if (!ListBox2.Items.Contains(((ListItem)arraylist1[i])))
                    {
                        ListBox2.Items.Add(((ListItem)arraylist1[i]));
                    }
                    ListBox1.Items.Remove(((ListItem)arraylist1[i]));
                }
                ListBox2.SelectedIndex = -1;
            }
            else
            {
                lbltxt.Visible = true;
                lbltxt.Text = "Please select atleast one from Available Listbox to move";
            }
            upListView.Update();

            int acount = 0;
            acount = arraylist1.Count;
            int dcount = arraylist2.Count;

        }

        protected void DeselectLinkButton_Click(object sender, EventArgs e)
        {
            lbltxt.Visible = false;
            if (ListBox2.SelectedIndex >= 0)
            {
                for (int i = 0; i < ListBox2.Items.Count; i++)
                {
                    if (ListBox2.Items[i].Selected)
                    {
                        if (!arraylist2.Contains(ListBox2.Items[i]))
                        {
                            arraylist2.Add(ListBox2.Items[i]);
                        }
                    }
                }
                for (int i = 0; i < arraylist2.Count; i++)
                {
                    if (!ListBox1.Items.Contains(((ListItem)arraylist2[i])))
                    {
                        ListBox1.Items.Add(((ListItem)arraylist2[i]));
                    }
                    ListBox2.Items.Remove(((ListItem)arraylist2[i]));
                }
                ListBox1.SelectedIndex = -1;
            }
            else
            {
                lbltxt.Visible = true;
                lbltxt.Text = "Please select atleast one from Display Listbox to move";
            }
           
            upListView.Update();
            int acount = 0;
            acount = arraylist1.Count;
            int dcount = arraylist2.Count;
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            /* Verifies that the control is rendered */
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            Response.ClearContent();
            Response.AddHeader("content-disposition", "attachment; filename=Report.xls");
            Response.ContentType = "application/excel";
            System.IO.StringWriter sw = new System.IO.StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            ReportGridView.RenderControl(htw);
            Response.Write(sw.ToString());
            Response.End();

        }

    

    }
}