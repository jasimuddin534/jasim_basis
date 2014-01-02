using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class AccountBL
    {
        private IAccountRepository accountRepository;
        public int companyID;// 
      
        public AccountBL()
        {
            this.accountRepository = new AccountRepository();
            // this.companyID =Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
        }


        //find all accounts
        public IEnumerable<DAL.Account> GetAccounts()
        {
           int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
           return accountRepository.GetAccounts(companyID);
        }

        //public IEnumerable<DAL.Account> GetAccountsByCompany()
        //{
        //    int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
        //    return accountRepository.GetAccountsByCompany(companyID);
        //}

        public IEnumerable<DAL.Account> GetAccountsByAssignedUserID(long assigneduserid)
       {
          int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
          return accountRepository.GetAccountsByAssignedUserID(companyID,assigneduserid);
       }

        public long InsertAccount(DAL.Account account)
        {
            try
            {
                ValidateAccount(account);
                return accountRepository.InsertAccount(account);
            }

            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UpdateAccount(DAL.Account account)
        {
            try
            {
              ValidateAccount(account);
              accountRepository.UpdateAccount(account);
            }

            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteAccount(long accountID)
        {
            accountRepository.DeleteAccount(accountID);
        }

       
        public IEnumerable<AccountType> GetAccountTypes()
        {
            return accountRepository.GetAccountTypes();
        }

        public IEnumerable<CompanyType> GetIndustries()
        {
            return accountRepository.GetIndustries();
        }

        public IEnumerable<DAL.Account> SearchAccount(string search)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return accountRepository.SearchAccount(search, companyID);
        }

        //public void DeleteAccountByID(long accountID)
        //{
        //    accountRepository.DeleteAccountByID(accountID);
        //}

        public IEnumerable<DAL.Account> GetAccountByID(long accountID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return accountRepository.GetAccountByID(accountID, companyID);
        }

        //public IEnumerable<Country> GetCountries()
        //{
        //    return accountRepository.GetCountries();
        //}

        //public void UpdateAccountByID(Int64 accountID)
        //{           
        //    accountRepository.UpdateAccountByID(accountID);
        //}

        //public string GetCountry(int country)
        //{
        //    return accountRepository.GetCountry(country);
        //}

        public string GetAccountName(long accountID)
        {
            return accountRepository.GetAccountName(accountID);
        }
        //// code start single account info
        //public IEnumerable<DAL.Account> GetSingleAccountByID(long accountID)
        //{
        //    return accountRepository.GetSingleAccountByID(accountID);
        //}
        // code end single account info

        /// <summary>
        /// Added by Khaled
        /// </summary>
        /// <param name="companyID"></param>
        /// <param name="nameSearchString"></param>
        /// <returns></returns>
        public IEnumerable<DAL.Account> GetAccountsByName(string nameSearchString)
        {
            return accountRepository.GetAccountsByName(companyID, nameSearchString);
        }

        private void ValidateAccount(DAL.Account account)
        {
            if(account.AccountID!=null)
            {
                var duplicateAccount = accountRepository.GetAccount(account).FirstOrDefault();
                if (duplicateAccount != null && duplicateAccount.AccountID != account.AccountID)
                {
                    if (duplicateAccount.Name == account.Name)
                    {
                        throw new AccountException(String.Format("Account {0} already exists", duplicateAccount.Name));
                    }
                }
            }
        }

        public IEnumerable<DAL.Account> GetAccountsByBankingIndustry()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return accountRepository.GetAccountsByBankingIndustry(companyID);
        }

        public IEnumerable<DAL.Account> GetAccountsByApparelIndustry()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return accountRepository.GetAccountsByApparelIndustry(companyID);
        }

        public IEnumerable<DAL.Account> GetAccountsByCustomerAccountType()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return accountRepository.GetAccountsByCustomerAccountType(companyID);
        }

    }

    public partial class AccountException : Exception
    {
        public AccountException(string message)
            : base(message)
        {
        }
    }
}