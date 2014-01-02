using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IAccountRepository :IDisposable
    {
        //IEnumerable<Account> GetAccounts();
        //IEnumerable<Account> GetAccountsByCompany(int companyID);
        //IEnumerable<Account> GetAccountsByAssignedUserID(long assigneduserid);
        //long InsertAccount(Account account);
        //void UpdateAccount(Account account);
        //IEnumerable<AccountType> GetTypes();
        //IEnumerable<CompanyType> GetIndustries();
        //void DeleteAccountByID(long accountID);
        //IEnumerable<DAL.Account> SearchAccount(string search);
        //IEnumerable<Account> GetAccountByID(long accountID);
        //IEnumerable<Country> GetCountries();
        ////void UpdateAccountByID(Int64 accountID);
        //string GetCountry(int country);
        //string GetAccountName(long accountID);
        //IEnumerable<Account> GetSingleAccountByID(long accountID);
        //IEnumerable<Account> GetAccountsByName(int companyID, string nameSearchString);
        //List<Account> GetAccountByName(Account account);


        // modify

        IEnumerable<Account> GetAccounts(int companyID);
        //IEnumerable<Account> GetAccountsByCompany(int companyID);
        IEnumerable<Account> GetAccountsByAssignedUserID(int companyID,long assigneduserid);
        long InsertAccount(Account account);
        void UpdateAccount(Account account);
        IEnumerable<AccountType> GetAccountTypes();
        IEnumerable<CompanyType> GetIndustries();
       // void DeleteAccountByID(long accountID);
        void DeleteAccount(long accountID);
        IEnumerable<DAL.Account> SearchAccount(string search, int companyID);
        IEnumerable<Account> GetAccountByID(long accountID, int companyID);
       // IEnumerable<Country> GetCountries();
        //void UpdateAccountByID(Int64 accountID);
        //string GetCountry(int country);
        string GetAccountName(long accountID);
        //IEnumerable<Account> GetSingleAccountByID(long accountID);
        IEnumerable<Account> GetAccountsByName(int companyID, string nameSearchString);
        List<Account> GetAccount(Account account);
        IEnumerable<Account> GetAccountsByBankingIndustry(int companyID);
        IEnumerable<Account> GetAccountsByApparelIndustry(int companyID);
        IEnumerable<Account> GetAccountsByCustomerAccountType(int companyID);
    }
}
