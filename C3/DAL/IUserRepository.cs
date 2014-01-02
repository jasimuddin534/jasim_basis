using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IUserRepository
    {
        IEnumerable<User> GetUsers();
        IEnumerable<User> GetUsersByCompanyID();
        IEnumerable<User> GetUsersByID(long uid);
        IEnumerable<User> GetUsersByFirstName(string nameSearchString);
        IEnumerable<User> VerifyLogIn(string UserNameString, string PasswordString);
        void FirstLoginSetToZero(long uid);

        void InsertUser(User user);
        void DeleteUser(User user);
        void UpdateUser(User user);
        Int64 InsertOrUpdate(User user);
        void DeactivateUser(long uid);
        string GetColumnName();
        long UserImagePathInsert(long uid, string image);
        /// <summary>
        /// for Registration
        /// 1. create company + save country into company table
        /// 2. create role
        /// 3. create user
        /// 4. Role based page access function
        /// </summary>
        /* Strat */  

        Int32 GetCompanyID(string companyname,int countryid);
        Int32 GetRoleID(string rolename, Int32 companyid);
        Int32 SearchRoleID(string rolename, Int32 companyid);
        Int32 SearchCompanyID(string companyname);
        Int64 RegisterUser(object[] RegisterUser);
        string PageAccess(string modulename);
        
        /*End*/

        /// <summary>
        /// 1. for dropdown list
        /// </summary>
        /* Strat */ 

        IEnumerable<Country> GetCountries();
        IEnumerable<Currency> GetCurrencies();
        IEnumerable<Language> GetLanguages();
        IEnumerable<DateFormat> GetDateFormats();
        IEnumerable<TimeFormat> GetTimeFormats();
        IEnumerable<TimeZone> GetTimeZones();
        IEnumerable<CompanyType> GetCompanyTypes();

        /*End*/
        

        /// <summary>
        /// 1. for getting dropdown value
        /// </summary>
        /* Strat */ 

        string GetGender(Int64 uid);
       // string GetMaritalStatus(Int64 uid);
        string GetsecurityQuestion(Int64 uid);
        string GetMessengerType(Int64 uid);
        string IsActive(Int64 uid);
        string CompanyBankAccountType();

        /*End*/


        /// <summary>
        /// 1. for Activation registered user
        /// 2. Forgot Password
        /// </summary>
        /* Strat */  

        IEnumerable<User> GetUserByEmail(string email);
        void SetRandomPassword(string randomPasswod, string primaryEmail);
        Guid? GetActivationID(string emailID);
        
        /*End*/

        IEnumerable<Company> GetCompanies();
        string GetCompanyNameByID(int companyid);
        int CompanyUpdate(Company company);
        IEnumerable<Company> GetCompaniesByCompanyID();
        IEnumerable<Company> GetCompanyByID();


        int InsertBankAccount(BankAccountsInfo bank);
        IEnumerable<BankAccountsInfo> GetBankAccountsInfo(string nameSearchString);
        string GetBankAccountName();
        IEnumerable<BankAccountsInfo> SetBankAccountID(string name, string number, string type);
        int CompanySetBankAccountID(int bankaccountid);
        IEnumerable<BankAccountsInfo> GetBankAccountByCompanyID();
        void UpdateBankAccount(BankAccountsInfo bank);

        bool IsCompanyExists(string name);
        bool IsEmailExists(string email);
        string GetUserPassword();
        void SetPassword(string password);
        int GetTeamSetID(Int64 teamid);
        string GetRoleName(int roleid);
        string GetHostName();
        long InsertUserLogin(int companyId, long userId, string sessionid, string status, string target);
        void SetUserPassword(string password, long userid);
        long InsertUserLogout(int companyId, long userId, string sessionid, string status, string target);
        int UserLockOut(string email);

    }

}
