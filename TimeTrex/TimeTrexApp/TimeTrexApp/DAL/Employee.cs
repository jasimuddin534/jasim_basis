using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;

namespace TimeTrexApp.DAL
{
    public class Employee
    {
        OleDbConnection myDataConnection = new OleDbConnection(ConfigurationManager.ConnectionStrings["accessconnection"].ConnectionString);

        public DataTable SelectEmployeeInformation(object[] objBELEmployeeDetails)
        {
            string sql = "Select work_no,id_no,id_name,first_name,last_name,dep_no,title_no,card_no from p_person order by id_name asc";
            OleDbDataAdapter da = new OleDbDataAdapter(sql, myDataConnection);
            DataTable dt = new DataTable();
            da.Fill(dt);
            return dt;
        }

        public string GetCardNoBySecName(string sec_name)
        {
            string card_no = "";
            string id_no = "";
            string sql = "Select id_no from security where sec_name='"+sec_name+"'";

            myDataConnection.Open();
            OleDbCommand command = new OleDbCommand();
            command.Connection = myDataConnection;
            command.CommandText = sql;
            OleDbDataReader dataReader;
            dataReader = command.ExecuteReader(CommandBehavior.CloseConnection);
                while (dataReader.Read())
                {
                    id_no = dataReader["id_no"].ToString();
                }
            dataReader.Close();
            myDataConnection.Close();


            string sql2 = "Select card_no from p_person where id_no='" + id_no + "'";

            myDataConnection.Open();
            OleDbCommand command2 = new OleDbCommand();
            command2.Connection = myDataConnection;
            command2.CommandText = sql2;
            OleDbDataReader dataReader2;
            dataReader2 = command2.ExecuteReader(CommandBehavior.CloseConnection);
            while (dataReader2.Read())
            {
                card_no = dataReader2["card_no"].ToString();
            }
            dataReader2.Close();
            myDataConnection.Close();


            return card_no;

        }


        public string GetNameByCardNo(string card_no)
        {
            string name = "";
   
            string sql = "Select id_name from p_person where card_no='" + card_no + "'";

            myDataConnection.Open();
            OleDbCommand command = new OleDbCommand();
            command.Connection = myDataConnection;
            command.CommandText = sql;
            OleDbDataReader dataReader;
            dataReader = command.ExecuteReader(CommandBehavior.CloseConnection);
            while (dataReader.Read())
            {
                name = dataReader["id_name"].ToString();
            }
            dataReader.Close();
            myDataConnection.Close();


            return name;

        }


    }
}