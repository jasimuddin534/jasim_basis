using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using TimeTrexApp.DAL;

namespace TimeTrexApp.BLL
{
    public class EmployeeBL
    {
        DAL.Employee employeeDAL = new DAL.Employee();

        public DataTable EmployeeList(object[] objEmployeeDetails)
        {
            try
            {

                return employeeDAL.SelectEmployeeInformation(objEmployeeDetails);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            
        }

        public string GetCardNoBySecName(string sec_name)
        {
            try
            {

                return employeeDAL.GetCardNoBySecName(sec_name);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public string GetNameByCardNo(string card_no)
        {
            try
            {

                return employeeDAL.GetNameByCardNo(card_no);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}