using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class TemporaryDB : IDisposable
    {

        public DataTable GetCurrencies()
        {
            DataTable myDataTable = new DataTable();
            DataColumn myDataColumn = new DataColumn();
            myDataColumn.AllowDBNull = false;
            myDataColumn.AutoIncrement = true;
            myDataColumn.AutoIncrementSeed = 1;
            myDataColumn.AutoIncrementStep = 1;
            myDataColumn.ColumnName = "ID";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataColumn.Unique = true;
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Currency_Name";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);
            DataRow dataRow = myDataTable.NewRow();
            dataRow["Currency_Name"] = "U.S Dollar:$";
            myDataTable.Rows.Add(dataRow);
            dataRow = myDataTable.NewRow();
            dataRow["Currency_Name"] = "Taka";
            myDataTable.Rows.Add(dataRow);

            return myDataTable;


        }
        public DataTable GetSalesStages()
        {
            DataTable myDataTable = new DataTable();
            DataColumn myDataColumn = new DataColumn();
            myDataColumn.AllowDBNull = false;
            myDataColumn.AutoIncrement = true;
            myDataColumn.AutoIncrementSeed = 1;
            myDataColumn.AutoIncrementStep = 1;
            myDataColumn.ColumnName = "ID";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataColumn.Unique = true;
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Sales_stage";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);
            DataRow dataRow = myDataTable.NewRow();
            dataRow["Sales_stage"] = "Prospective";
            myDataTable.Rows.Add(dataRow);
            dataRow = myDataTable.NewRow();
            dataRow["Sales_stage"] = "Negotiable";
            myDataTable.Rows.Add(dataRow);
            return myDataTable;
        }
        public DataTable GetLeadSources()
        {
            DataTable myDataTable = new DataTable();
            DataColumn myDataColumn = new DataColumn();
            myDataColumn.AllowDBNull = false;
            myDataColumn.AutoIncrement = true;
            myDataColumn.AutoIncrementSeed = 1;
            myDataColumn.AutoIncrementStep = 1;
            myDataColumn.ColumnName = "ID";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataColumn.Unique = true;
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "LeadSource";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);
            DataRow dataRow = myDataTable.NewRow();
            dataRow["LeadSource"] = "Direct Meeting";
            myDataTable.Rows.Add(dataRow);
            dataRow = myDataTable.NewRow();
            dataRow["LeadSource"] = "Advertisement";
            myDataTable.Rows.Add(dataRow);
            return myDataTable;
        }
        public DataTable GetCampaignnames()
        {
            DataTable myDataTable = new DataTable();
            DataColumn myDataColumn = new DataColumn();
            myDataColumn.AllowDBNull = false;
            myDataColumn.AutoIncrement = true;
            myDataColumn.AutoIncrementSeed = 1;
            myDataColumn.AutoIncrementStep = 1;
            myDataColumn.ColumnName = "ID";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataColumn.Unique = true;
            myDataTable.Columns.Add(myDataColumn);
            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Campaign_Name";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);
            DataRow dataRow = myDataTable.NewRow();
            dataRow["Campaign_Name"] = "Marketing Campaign 1";
            myDataTable.Rows.Add(dataRow);
            dataRow = myDataTable.NewRow();
            dataRow["Campaign_Name"] = "Sales Campaign 2";
            myDataTable.Rows.Add(dataRow);
            return myDataTable;
        }
        public DataTable GetUsers()
        {
            DataTable myDataTable = new DataTable();
            DataColumn myDataColumn = new DataColumn();
            myDataColumn.AllowDBNull = false;
            myDataColumn.AutoIncrement = true;
            myDataColumn.AutoIncrementSeed = 1;
            myDataColumn.AutoIncrementStep = 1;
            
            myDataColumn.ColumnName = "UserID";
            myDataColumn.DataType = System.Type.GetType("System.Int64");
            myDataColumn.Unique = true;
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "FirstName";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "LastName";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "UserName";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Email";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "PhoneNumber";
            myDataColumn.DataType = System.Type.GetType("System.Int64");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Address";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "CompanyName";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);


            DataRow dataRow = myDataTable.NewRow();
            dataRow["UserID"] = "1";
            dataRow["FirstName"] = "Bob";
            dataRow["LastName"] = "Willson";
            dataRow["UserName"] = "bob.wilson";
            dataRow["Email"] = "wilson@yahoo.com";
            dataRow["PhoneNumber"] = "0112332667";
            dataRow["Address"] = "Dhaka";
            dataRow["CompanyName"] = "Panacea";
            myDataTable.Rows.Add(dataRow);

             dataRow = myDataTable.NewRow();
            dataRow["UserID"] = "2";
            dataRow["FirstName"] = "Tawsif";
            dataRow["LastName"] = "Akib";

            dataRow["UserName"] = "Tawsif.Akib";

            dataRow["Email"] = "tawsif@yahoo.com";
            dataRow["PhoneNumber"] = "017172332667";
            dataRow["Address"] = "Rajshahi";
            dataRow["CompanyName"] = "RoyalIT";


            myDataTable.Rows.Add(dataRow);
            
            //dataRow = myDataTable.NewRow();
            //dataRow["FirstName"] = "Bob";
            //myDataTable.Rows.Add(dataRow);
            //dataRow = myDataTable.NewRow();
            //dataRow["FirstName"] = "Tawsif";
            //myDataTable.Rows.Add(dataRow);


            // dataRow = myDataTable.NewRow();
            // dataRow["LastName"] = "Willson";
            //myDataTable.Rows.Add(dataRow);
            //dataRow = myDataTable.NewRow();
            //dataRow["LastName"] = "Akib";
            //myDataTable.Rows.Add(dataRow);



            // dataRow = myDataTable.NewRow();
            // dataRow["UserName"] = "bob.wilson";
            //myDataTable.Rows.Add(dataRow);
            //dataRow = myDataTable.NewRow();
            //dataRow["UserName"] = "Tawsif.Akib";
            //myDataTable.Rows.Add(dataRow);

            // dataRow = myDataTable.NewRow();
            // dataRow["Email"] = "wilson@yahoo.com";
            //myDataTable.Rows.Add(dataRow);
            //dataRow = myDataTable.NewRow();
            //dataRow["Email"] = "tawsif@yahoo.com";
            //myDataTable.Rows.Add(dataRow);


            // dataRow = myDataTable.NewRow();
            // dataRow["PhoneNumber"] = "0112332667";
            //myDataTable.Rows.Add(dataRow);
            //dataRow = myDataTable.NewRow();
            //dataRow["PhoneNumber"] = "017172332667";
            //myDataTable.Rows.Add(dataRow);

            //dataRow["PhoneNumber"] = "017172332667";
            //dataRow["Address"] = "Rajshahi";
            //dataRow["CompanyName"] = "RoyalIT";



            // dataRow = myDataTable.NewRow();
            // dataRow["Address"] = "Dhaka";
            //myDataTable.Rows.Add(dataRow);
            //dataRow = myDataTable.NewRow();
            //dataRow["Address"] = "Rajshahi";
            //myDataTable.Rows.Add(dataRow);


            //dataRow = myDataTable.NewRow();
            //dataRow["CompanyName"] = "Panacea";
            //myDataTable.Rows.Add(dataRow);
            //dataRow = myDataTable.NewRow();
            //dataRow["CompanyName"] = "RoyalIT";
            //myDataTable.Rows.Add(dataRow);
                

            return myDataTable;
        }

        public void Dispose()
        {

        }
    }
}