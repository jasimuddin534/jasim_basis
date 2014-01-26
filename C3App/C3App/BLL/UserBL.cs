using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace C3App.BLL
{
    public class UserBL
    {

        private IUserRepository userRepository;

        public UserBL()
        {
            this.userRepository = new UserRepository();
        }

        public string GetColumnName()
        {
           return userRepository.GetColumnName();
        }
        public long UserImagePathInsert(long uid, string image)
        {
            return userRepository.UserImagePathInsert(uid,image);
        }

        public string GetHostName()
        {
            return userRepository.GetHostName();
        }
        public long InsertUserLogin(int companyId, long userId, string sessionid, string status, string target)
        {
            return userRepository.InsertUserLogin(companyId,userId,sessionid,status,target);
        }

        public long InsertUserLogout(int companyId, long userId, string sessionid, string status, string target)
        {
            return userRepository.InsertUserLogout(companyId,userId,sessionid,status,target);
        }
        public int UserLockOut(string email)
        {
            return userRepository.UserLockOut(email);
        }

        public int GetTeamSetID(Int64 teamid)
        {
            return userRepository.GetTeamSetID(teamid);
        }

        public string GetRoleName(int roleid)
        {
            return userRepository.GetRoleName(roleid);
        }

        public string GetUserPassword()
        {
            return userRepository.GetUserPassword();
        }
        public bool IsCompanyExists(string name)
        {
            return userRepository.IsCompanyExists(name);
        }

        public IEnumerable<BankAccountsInfo> GetBankAccountByCompanyID()
        {
            return userRepository.GetBankAccountByCompanyID();
        }

        public bool IsEmailExists(string email)
        {
            return userRepository.IsEmailExists(email);
        }

        public string PageAccess(string modulename)
        {
            return userRepository.PageAccess(modulename);
        }

        public void DeactivateUser(long uid)
        {
            try
            {
                userRepository.DeactivateUser(uid);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void SetPassword(string password)
        {
            try
            {
                userRepository.SetPassword(password);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void FirstLoginSetToZero(long uid)
        {
            userRepository.FirstLoginSetToZero(uid);
        }

        public void SetUserPassword(string password, long userid)
        {
            try
            {
                userRepository.SetUserPassword(password,userid);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
   
        public void UpdateBankAccount(BankAccountsInfo bank)
        {
            try
            {
                userRepository.UpdateBankAccount(bank);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int CompanySetBankAccountID(int bankaccountid)
        {

            return userRepository.CompanySetBankAccountID(bankaccountid);
            //try
            //{
            //    userRepository.CompanySetBankAccountID(bankaccountid);
            //}
            //catch (Exception ex)
            //{
            //    throw ex;
            //}

        }

        public string GetBankAccountName()
        {
            return userRepository.GetBankAccountName();
        }

        public IEnumerable<BankAccountsInfo> SetBankAccountID(string name, string number, string type)
        {
            return userRepository.SetBankAccountID(name,number, type);
        }

        public IEnumerable<User> GetUsersByCompanyID()
        {
            return userRepository.GetUsersByFirstName("");
        }

        public IEnumerable<User> VerifyLogIn(string UserNameString, string PasswordString)
        {
            return userRepository.VerifyLogIn(UserNameString, PasswordString);

        }

        public IEnumerable<BankAccountsInfo> GetBankAccountsInfo(string nameSearchString)
        {
            return userRepository.GetBankAccountsInfo(nameSearchString);
        }

        public string GetCompanyNameByID(int companyid)
        {
            return GetCompanyNameByID(companyid);
        }

        public Int32 GetCompanyID(string companyname,int countryid)
        {
            return userRepository.GetCompanyID(companyname,countryid);
        }

        public Int32 GetRoleID(string rolename, Int32 companyid)
        {
            return userRepository.GetRoleID(rolename, companyid);
        }

        public IEnumerable<User> GetUsersByID(long uid)
        {
            return userRepository.GetUsersByID(uid);
        }


        public IEnumerable<User> GetUsersByFirstName(string nameSearchString)
        {
            return userRepository.GetUsersByFirstName(nameSearchString);
        }

        public IEnumerable<User> GetUsers()
        {
            return userRepository.GetUsers();
        }

        public Int64 RegisterUser(object[] RegisterUser)
        {

            
            return  userRepository.RegisterUser(RegisterUser);
            
            
            
        }

        public long InsertOrUpdate(User user)
        {
              try
              {
                  ValidateUser(user);
                  return userRepository.InsertOrUpdate(user);
              }

              catch (Exception ex)
              {
                  throw ex;
              }
        }



        public int InsertBankAccount(BankAccountsInfo bank)
        {
            return userRepository.InsertBankAccount(bank);
        }


        public int CompanyUpdate(Company company)
        {
           
              return  userRepository.CompanyUpdate(company);
            
        }

        public void InsertUser(User user)
        {
            try
            {
                userRepository.InsertUser(user);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteUser(User user)
        {
            try
            {
                userRepository.DeleteUser(user);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UpdateUser(User user)
        {
            try
            {
                userRepository.UpdateUser(user);

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public IEnumerable<Country> GetCountries()
        {
            return userRepository.GetCountries();
        }

        public IEnumerable<Company> GetCompanies()
        {
            return userRepository.GetCompanies();
        }


        public IEnumerable<Currency> GetCurrencies()
        {
            return userRepository.GetCurrencies();
        }

        public IEnumerable<Language> GetLanguages()
        {
            return userRepository.GetLanguages();
        }

        public IEnumerable<DateFormat> GetDateFormats()
        {
            return userRepository.GetDateFormats();
        }

        public IEnumerable<TimeFormat> GetTimeFormats()
        {
            return userRepository.GetTimeFormats();
        }

        public IEnumerable<DAL.TimeZone> GetTimeZones()
        {
            return userRepository.GetTimeZones();
        }

        public IEnumerable<CompanyType> GetCompanyTypes()
        {
            return userRepository.GetCompanyTypes();
        }

        public string GetGender(Int64 uid)
        {
            return userRepository.GetGender(uid);
        }

        //public string GetMaritalStatus(Int64 uid)
        //{
        //    return userRepository.GetMaritalStatus(uid);
        //}

        public string IsActive(Int64 uid)
        {
            return userRepository.IsActive(uid);
        }

        public string CompanyBankAccountType()
        {
            return userRepository.CompanyBankAccountType();
        }

/// <summary>
/// Code by Pavel for Activation User
/// </summary>
/// <param name="emailID"></param>
/// <returns></returns>

        public Guid? GetActivationID(string emailID)
        {
            return userRepository.GetActivationID(emailID);
        }


/// <summary>
/// Code by Riyad for forgot password
/// </summary>
/// <param name="email"></param>
/// <returns></returns>
        public IEnumerable<User> GetUserByEmail(string email)
        {
            return userRepository.GetUserByEmail(email);
        }

        public string GenerateRandomPassword()
        {
           //return System.Web.Security.Membership.GeneratePassword(8, 0);

            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".ToCharArray();
            var random = new Random();

            string output = "";
            for (int i = 0; i < 8; i++)
            {
                output += chars[random.Next(chars.Length)];
            }

            return output;
        }


        public void SetRandomPassword(string randomPasswod, string primaryEmail)
        {
            try
            {
                userRepository.SetRandomPassword(randomPasswod, primaryEmail);

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public IEnumerable<Company> GetCompaniesByCompanyID()
        {
            return userRepository.GetCompaniesByCompanyID();
        }

        public IEnumerable<Company> GetCompanyByID()
        {
            return userRepository.GetCompanyByID();
        }

        public string GetMessengerType(Int64 uid)
        {
            return userRepository.GetMessengerType(uid);
        }

        public string GetsecurityQuestion(Int64 uid)
        {
            return userRepository.GetsecurityQuestion(uid);
        }


        private void ValidateUser(User user)
        {
                string pemail = user.PrimaryEmail;
                var emailaddress = userRepository.IsEmailExists(pemail);
                if (emailaddress == true && user.UserID==0)
                {
                        throw new UserException(String.Format("Primary Email Address already exists. Please try another one.", pemail));   
                }   
        }
    

    public partial class UserException : Exception
    {
        public UserException(string message)
            : base(message)
        {
        }
    }


    }
}