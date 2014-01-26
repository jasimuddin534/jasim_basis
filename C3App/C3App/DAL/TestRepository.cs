using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace C3App.DAL
{
    public class TestRepository
    {
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


            //myDataTable.Rows.Add(dataRow);
            myDataTable.Rows.Add(dataRow);

            return myDataTable;
        }
    }
}