using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Globalization;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class AccountRepository : IDisposable, IAccountRepository
    {
        private C3Entities context = new C3Entities();

        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }

            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }

        //get accounts by pavel
        public IEnumerable<Account> GetAccounts(int companyID)
        {
            //int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            var accounts = (context.Accounts.Where(p => (p.IsDeleted == false) && (p.CompanyID == companyID))).ToList();
            return accounts;
        }

        public IEnumerable<Account> GetAccountsByBankingIndustry(int companyID)
        {
            var accounts = (context.Accounts.Where(p => (p.CompanyID == companyID) && (p.IsDeleted == false) && (p.IndustryID == 2))).ToList();
            return accounts;
        }

        public IEnumerable<Account> GetAccountsByApparelIndustry(int companyID)
        {
            var accounts = (context.Accounts.Where(p => (p.CompanyID == companyID) && (p.IsDeleted == false) && (p.IndustryID == 1))).ToList();
            return accounts;
        }

        public IEnumerable<Account> GetAccountsByCustomerAccountType(int companyID)
        {
            var accounts = (context.Accounts.Where(p => (p.CompanyID == companyID) && (p.IsDeleted == false) && (p.AccountTypesID == 3))).ToList();
            return accounts;
        }

        //public IEnumerable<Account> GetAccountsByCompany(int companyID)
        //{
        //    var accounts = (from p in context.Accounts
        //                    where (p.IsDeleted == false) && (p.CompanyID == companyID)
        //                    select p).ToList();
        //    return accounts;
        //}

        public IEnumerable<Account> GetAccountsByAssignedUserID(int companyID,long assigneduserid)
        {
           var  accounts = (context.Accounts.Where(p => p.CompanyID == companyID && p.AssignedUserID == assigneduserid && p.IsDeleted == false));
            return accounts;
        }

        public long InsertAccount(Account account)
        {
            context.Entry(account).State = EntityState.Added;
            SaveChanges();
            return account.AccountID;
        }

        //public void DeleteAccount(Account account)
        //{
        //    try
        //    {
        //        context.Accounts.Attach(account);
        //        context.Entry(account).State = EntityState.Deleted;
        //        SaveChanges();
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        //new delete

        public void DeleteAccount(long accountID)
        {
            Account account = (from p in context.Accounts
                               where p.AccountID == accountID
                               select p).FirstOrDefault();
            try
            {
                if (account != null)
                {
                    account.IsDeleted = true;
                    context.Entry(account).State = EntityState.Modified;
                }
                SaveChanges();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }



        public void UpdateAccount(Account account)
        {
            try
            {
                var currentAccount = context.Accounts.Find(account.AccountID);
                context.Entry(currentAccount).CurrentValues.SetValues(account);
                SaveChanges();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void SaveChanges()
        {
            bool saveFailed;
            do
            {
                saveFailed = false;
                try
                {
                    context.SaveChanges();
                }
                catch (DbUpdateConcurrencyException ex)
                {
                    saveFailed = true;

                    // Update the values of the entity that failed to save from the store
                    ex.Entries.Single().Reload();

                    // Update original values from the database
                    //var entry = ex.Entries.Single();
                    //entry.OriginalValues.SetValues(entry.GetDatabaseValues());
                }
            } while (saveFailed);
        }

        public IEnumerable<AccountType> GetAccountTypes()
        {
            return context.AccountTypes.ToList();
        }

        public IEnumerable<CompanyType> GetIndustries()
        {
            return context.CompanyTypes.ToList();
        }

        public List<Account> GetAccount(Account account)
        {
            var accounts = (from p in context.Accounts
                            where p.Name == account.Name && p.CompanyID==account.CompanyID
                            select p).ToList();
            return accounts;
        }

        public IEnumerable<Account> SearchAccount(string search, int companyID)
        {
            if (String.IsNullOrWhiteSpace(search))
            {
                search = "";
            }
            try
            {
                //int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

                var accounts = (context.Accounts.Where(p =>(p.Name.Contains(search) || (p.PrimaryEmail.Contains(search))) && (p.IsDeleted == false) && (p.CompanyID == companyID))).ToList();

                return accounts;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }


        //public void DeleteAccountByID(long accountID)
        //{
        //    Account account = (from p in context.Accounts
        //                       where p.AccountID == accountID
        //                       select p).FirstOrDefault();
        //    try
        //    {
        //        if (account != null)
        //        {
        //            account.IsDeleted = true;
        //            context.Entry(account).State = EntityState.Modified;
        //        }
        //        SaveChanges();
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        public IEnumerable<Account> GetAccountByID(long accountID, int companyID)
        {
            try
            {
               // int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

                //if (accountID == 0)
                //{
                //    var accounts = (from p in context.Accounts
                //                    where (p.IsDeleted == false) && (p.CompanyID == companyID)
                //                    select p).ToList();
                //    return accounts;
                //}
                 IEnumerable<Account> accounts = (context.Accounts.Where(p => (p.AccountID == accountID) && (p.CompanyID == companyID) && (p.IsDeleted == false))).ToList();
                 return accounts;
                  
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Country> GetCountries()
        {
            var countries = (from p in context.Countries select p).ToList();
            return countries;
        }  

        //public string GetCountry(int country)
        //{
        //    string targetcountry = string.Empty;

        //    var query = from p in context.Countries
        //                where (p.CountryID == country)
        //                select p.CountryName;


        //    if (query.Any())
        //    {
        //        foreach (var q in query)
        //        {
        //            targetcountry = q;
        //        }
        //        return targetcountry;
        //    }
        //    else
        //        return "None"; 
        //}

        public string GetAccountName(long accountID)
        {
            string name = string.Empty;
            var query = (from p in context.Accounts where (p.AccountID == accountID) select p.Name);

            if (query.Any())
            {
                foreach (string q in query)
                {
                    name = q;
                }
                return name;
            }
            else
                return string.Empty;
        }

        //start of try vode for single selected account in edit mode 
        //public IEnumerable<Account> GetSingleAccountByID(Int64 accountID)
        //{
        //    try
        //    {
        //        IEnumerable<Account> accounts = from p in context.Accounts
        //                                        where (p.AccountID == accountID) && (p.IsDeleted == false)
        //                                        select p;
        //        return accounts;
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        //end of try vode for single selected account in edit mode 

        /// <summary>
        /// Added by Khaled
        /// </summary>
        /// <param name="companyID"></param>
        /// <param name="nameSearchString"></param>
        /// <returns></returns>
        public IEnumerable<Account> GetAccountsByName(int companyID, string nameSearchString)
        {
            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";
            }
            return context.Accounts.Where(a => a.Name.Contains(nameSearchString) && a.CompanyID == companyID && a.IsDeleted == false).ToList();

        }
    }
}