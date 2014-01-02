using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.Entity.Infrastructure;
using System.Data.Objects;
using C3App.App_Code;

namespace C3App.DAL
{
    public class UserRepository : IUserRepository,IDisposable
    {

        private C3Entities context = new C3Entities();


        public string GetColumnName()
        {
              string name = "";
            
            //var query = from p in context.ACLFunctions
            //            where (p.FunctionID == functionid)
            //            select p.FunctionName;

              var query = from t in typeof(Company).GetProperties()
                          where ((!t.PropertyType.Name.Contains("ICollection")) && (!t.PropertyType.Name.Contains("BankAccountsInfo")))
                          select t.Name;
            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                   name += q+"<br>";
                }
            }
            else
            {
                name = "";
            }


            return name;

            
        }

        public string GetHostName()
        {
            string hName = "";
            System.Net.IPHostEntry host = new System.Net.IPHostEntry();
            host = System.Net.Dns.GetHostEntry(HttpContext.Current.Request.ServerVariables["REMOTE_HOST"]);
            //Split out the host name from the FQDN
            if (host.HostName.Contains("."))
            {
            string[] sSplit = host.HostName.Split('.');
            hName = sSplit[0].ToString();
            }
            else
            {
            hName = host.HostName.ToString();
            }
            return hName;
        }

        public string GetFunctionName(int functionid)
        {
            string name = "";

            var query = from p in context.ACLFunctions
                        where (p.FunctionID == functionid)
                        select p.FunctionName;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                   name = q;
                }
            }
            else
            {
                name = "";
            }


            return name;
        }
        public int GetModuleID(string modulename)
        {
            int moduleid = 0;

            var query = (from p in context.Modules
                        where (p.DisplayName.Contains(modulename) && (p.ParentID!=0))
                        select p.ModuleID).FirstOrDefault();

            //if (query.Count() > 0)
            //{
            //    foreach (var q in query)
            //    {
            //        moduleid = q;
            //    }
            //}
            //else
            //{
            //    moduleid = 0;
            //}


            return query;
        }

        public string PageAccess(string modulename)
        {
            string functions = "";
            int functionid = 0;
            string name = "";
            int moduleid = GetModuleID(modulename);
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            Int32 roleid = Convert.ToInt32(HttpContext.Current.Session["RoleID"]);

            var query = from p in context.ACLActions
                        join x in context.ACLRoles on p.RoleID equals x.RoleID
                        where ((p.ModuleID == moduleid) && (x.CompanyID == companyid)&& (x.RoleID==roleid))
                        orderby p.FunctionID ascending
                        select p;
   
            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    functionid = Convert.ToInt32(q.FunctionID);
                    name = GetFunctionName(functionid); 
                    functions += name +"#" +q.Access+":";
                }
            }
            else
            {
                functions = "";
            }

            string aid = functions.TrimEnd(':');

            return aid;

        }


        public bool IsCompanyExists(string name)
        {
            bool exists = false;

            var query = from p in context.Companies
                        where (p.Name==name)
                        select p;

            if (query.Count() > 0)
            {
                exists = true;
            }
            else
                exists = false;

            return exists;
        }

        public int GetTeamSetID(Int64 teamid)
        {
            int id = 0;

            var query = from p in context.Teams
                        where ((p.TeamID == teamid))
                        select p.TeamSetID;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {

                    id = q;
                   
                }
            }

            return id;
        }

        public string GetRoleName(int roleid)
        {
            string name = "";

            var query = from p in context.ACLRoles
                        where ((p.RoleID == roleid))
                        select p.Name;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {

                    name = q;

                }
            }

            return name;
        }

        public bool IsEmailExists(string email)
        {
            bool exists = false;

            var query = from p in context.Users
                        where (p.PrimaryEmail == email)
                        select p;

            if (query.Count() > 0)
            {
                exists = true;
            }
            else
                exists = false;

            return exists;
        }

        public IEnumerable<Language> GetLanguages()
        {

            return context.Languages.ToList();

        }

        public IEnumerable<DateFormat> GetDateFormats()
        {

            return context.DateFormats.ToList();

        }

        public IEnumerable<TimeFormat> GetTimeFormats()
        {

            return context.TimeFormats.ToList();

        }

        public IEnumerable<TimeZone> GetTimeZones()
        {

            return context.TimeZones.ToList();

        }

        public IEnumerable<Currency> GetCurrencies()
        {

                return context.Currencies.ToList();
            
        }

        public IEnumerable<CompanyType> GetCompanyTypes()
        {

            return context.CompanyTypes.ToList();

        }

        public IEnumerable<BankAccountsInfo> GetBankAccountsInfo(string nameSearchString)
        {

            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";
            }


            IEnumerable<BankAccountsInfo> bank = from p in context.BankAccountsInfoes
                                                 join x in context.Companies on p.BankAccountID equals x.BankAccount
                                                 where ((p.BankAccountName.Contains(nameSearchString)) && (x.CompanyID == companyid))
                                                 select p;
            return bank;

            //return context.BankAccountsInfoes.ToList();

        }

        public void DeactivateUser(long uid)
        {
            User user = context.Users.Single(q => q.UserID == uid);
            user.IsDeleted = true;
            context.SaveChanges();
            
        }

        public int UserLockOut(string email)
        {
            int lockoutnumber = 0;

            var users = GetUserByEmail(email);

            if(users.Count()>0)
            {
                int failedattemp = 0;
                DateTime now = DateTime.Now;
                long userid = users.ElementAt(0).UserID;
                DateTime lastlockdate = Convert.ToDateTime(users.ElementAt(0).LastLockoutDate);
                int hours = (now-lastlockdate).Hours;
                
                User user = context.Users.Single(q => q.UserID == userid);

                if (hours > 1)
                {
                    failedattemp = 0;
                }
                if (hours < 1)
                {
                    failedattemp = Convert.ToInt32(user.FailedPasswordAttemptCount);
                }

                user.FailedPasswordAttemptCount = failedattemp + 1;
                user.LastLockoutDate = DateTime.Now;
                int lockout = Convert.ToInt32(user.FailedPasswordAttemptCount);

                if (lockout >= 5)
                {
                    user.IsLockedOut = true;
                }
                else
                {
                    user.IsLockedOut = null;
                }

               context.SaveChanges();
               lockoutnumber = Convert.ToInt32(user.FailedPasswordAttemptCount);

            }


            return lockoutnumber;

        }

        public void FirstLoginSetToZero(long uid)
        {
            User user = context.Users.Single(q => q.UserID == uid);
            user.IsFirstLogin = false;
            context.SaveChanges();

        }

        public long UserImagePathInsert(long uid, string image)
        {
            User user = context.Users.Single(q => q.UserID == uid);
            user.Image = image;
            context.SaveChanges();
            long id = user.UserID;
            return id;
        }

        public void SetPassword(string password)
        {
            Int64 userid = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
            string fullhash = Authentication.CreateHash(password);
            string[] split = fullhash.Split(':');
            string salt = split[1];
            string hash = split[2];

            User user = context.Users.Single(q => q.UserID == userid);
            user.Password = hash;
            user.PasswordSalt = salt;
            context.SaveChanges();

        }

        public void SetUserPassword(string password,long userid)
        {
            string fullhash = Authentication.CreateHash(password);
            string[] split = fullhash.Split(':');
            string salt = split[1];
            string hash = split[2];

            User user = context.Users.Single(q => q.UserID == userid);
            user.Password = hash;
            user.PasswordSalt = salt;
            context.SaveChanges();

        }

        public int CompanySetBankAccountID(int bankaccountid)
        {
            int id = 0;
       

            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            Company company = context.Companies.Single(q => q.CompanyID == companyid);
            company.BankAccount = bankaccountid;
            context.SaveChanges();
            id = Convert.ToInt32(company.BankAccount);
            return id;
        }
      
        public Int32 GetCompanyID(string companyname,int countryid)
        {
            Int32 companyid = -1;

            companyid = SearchCompanyID(companyname);

            if (companyid > 0)
            {
                return companyid;
            }
            else
            {
                var company = new Company { Name = companyname, CountryID=countryid, CreatedTime = DateTime.Now, ModifiedTime = DateTime.Now };
                context.Companies.Add(company);
                context.SaveChanges();
                companyid = SearchCompanyID(companyname);

                return companyid;
            }

        }

        public Int32 GetRoleID(string rolename, Int32 companyid)
        {
            Int32 roleid = -1;

            roleid = SearchRoleID(rolename, companyid);

            if (roleid > 0)
            {
                return roleid;
            }
            else
            {
                var role = new ACLRole { Name = rolename, Description="Admin Role", CompanyID = companyid, CreatedTime = DateTime.Now, ModifiedTime = DateTime.Now, IsDeleted=false };
                context.ACLRoles.Add(role);
                context.SaveChanges();
                roleid = role.RoleID;//SearchRoleID(rolename, companyid);

                return roleid;
            }

        }

        public long InsertUserLogin(int companyId, long userId, string sessionid,string status,string target)
        {
            long id = 0;
            string ipAddress;
            ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(ipAddress))
            {
                ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

           // string serverhost = GetHostName();
            var userlogin = new UserLogin { CompanyID = companyId, UserID = userId, ASPNETSessionID = sessionid, LoginStatus = status, LoginDate = DateTime.Now, Target = target, Hostname = ipAddress };
            context.UserLogins.Add(userlogin);
            context.SaveChanges();
            id = userlogin.UserLoginID;

            return id;

        }

        public long InsertUserLogout(int companyId, long userId, string sessionid, string status, string target)
        {
            long id = 0;
            string ipAddress;
            ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(ipAddress))
            {
                ipAddress = System.Web.HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            // string serverhost = GetHostName();
            var userlogin = new UserLogin { CompanyID = companyId, UserID = userId, ASPNETSessionID = sessionid, LoginStatus = status, LogoutDate=DateTime.Now, Target = target, Hostname = ipAddress };
            context.UserLogins.Add(userlogin);
            context.SaveChanges();
            id = userlogin.UserLoginID;

            return id;

        }

/// <summary>
/// Code by Pavel for Activation User
/// </summary>
/// <param name="emailID"></param>
/// <returns></returns>

        public Guid? GetActivationID(string emailID)
        {


            var activationID = from p in context.Users
                               where p.PrimaryEmail == emailID
                               select p.ActivationID;

            return activationID.FirstOrDefault();



            //return (from p in context.Users
            //        where (p.PrimaryEmail == emailID)
            //        select p.ActivationID);
        }

       


/// <summary>
/// Code by Riyad for forgot password
/// </summary>
/// <param name="email"></param>
/// <returns></returns>

        public IEnumerable<User> GetUserByEmail(string email)
        {

            return (from user in context.Users
                    where user.PrimaryEmail == email
                    select user).ToList();
        }


        /// <summary>
        /// code by Riyad for forgot password
        /// </summary>
        /// <param name="randomPasswod"></param>
        /// <param name="primaryEmail"></param>

        public void SetRandomPassword(string randomPasswod, string primaryEmail)
        {
            string fullhash = Authentication.CreateHash(randomPasswod);
            string[] split = fullhash.Split(':');
            string salt = split[1];
            string hash = split[2];

            try
            {
                var users = (from user in context.Users
                             where user.PrimaryEmail == primaryEmail
                             select user).FirstOrDefault();
                users.Password = hash;
                users.PasswordSalt = salt;
                int num = context.SaveChanges();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

         public int createDefaultTeamSet(int comapanyid)
        {
            var teamset = new TeamSet { CompanyID = comapanyid, TeamSetName = "Global",  IsDeleted = false, CreatedTime = DateTime.Now, ModifiedTime = DateTime.Now };
            context.TeamSets.Add(teamset);
            context.SaveChanges();
             int id = teamset.TeamSetID;
            
            return id;
        }

        public Int64 createDefaultTeam(int comapanyid, int teamsetid)
        {
            var team = new Team { TeamSetID = teamsetid, Name = "Global", Description="Global", CompanyID = comapanyid, IsDeleted = false, CreatedTime = DateTime.Now, ModifiedTime = DateTime.Now };
            context.Teams.Add(team);
           context.SaveChanges();
             Int64 id = team.TeamID;
            
            return id;
        }

        public Int64 RegisterUser(object [] RegisterUser)
        {
    
            int companyid = Convert.ToInt32(RegisterUser[9]);
            int teamsetid = createDefaultTeamSet(companyid);
            Int64 teamid = createDefaultTeam(companyid, teamsetid);
            string password = Convert.ToString(RegisterUser[11]);
            string fullhash = Authentication.CreateHash(password);
            string[] split = fullhash.Split(':');
            string salt = split[1];
            string hash = split[2];


            try
           {
                var user = new User
                {
                    FirstName = RegisterUser[0].ToString(),
                    LastName = RegisterUser[1].ToString(),
                    Designation = RegisterUser[2].ToString(),
                    Street = RegisterUser[3].ToString(),
                    City = RegisterUser[4].ToString(),
                    PostalCode = RegisterUser[5].ToString(),
                    CountryID = Convert.ToInt32(RegisterUser[6]),
                    MobilePhone = RegisterUser[7].ToString(),
                    PrimaryEmail = RegisterUser[8].ToString(),
                    CompanyID = Convert.ToInt32(RegisterUser[9]),
                    RoleID = Convert.ToInt32(RegisterUser[10]),
                    CreatedTime = DateTime.Now,
                    ModifiedTime = DateTime.Now,
                    ActivationID = Guid.NewGuid(),
                    Password = hash,
                    PasswordSalt = salt,
                    IsActive = true,
                    IsEmployee = true,
                    IsApproved = false,
                    IsFirstLogin = true,
                    TeamID = teamid,
                    TeamSetID = teamsetid,
                    IsAdmin = true


                };
                context.Users.Add(user);
               context.SaveChanges();
                Int64 id = user.UserID;

                User user1 = context.Users.Single(q => q.UserID == id);
                user1.CreatedBy = id;
                user1.ModifiedBy = id;
                context.SaveChanges();
                return id;
         }
            catch (Exception ex)
            {
                throw ex;
            }
           
        }


        public Int32 SearchRoleID(string rolename, Int32 companyid)
        {
            Int32 roleid = -1;

            var query = from p in context.ACLRoles
                        where (p.Name == rolename && p.CompanyID == companyid)
                        select p.RoleID;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    roleid = q;
                }
            }
            else
                roleid = -1;

            return roleid;
        }

        public Int32 SearchCompanyID(string companyname)
        {
            Int32 companyid = -1;

            var query = from p in context.Companies
                        where (p.Name == companyname)
                        select p.CompanyID;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    companyid = q;
                }
            }
            else
                companyid = -1;

            return companyid;


        }


        public string GetCompanyNameByID(int companyid)
        {

            string companyname = "";

            var query = from p in context.Companies
                        where (p.CompanyID == companyid)
                        select p.Name;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    companyname = q;
                }
            }
            else
                companyname = "";

            return companyname;
        }



        public IEnumerable<User> GetUsersByID(long uid)
        {

            //if (uid == 0)
            //{

            //    return context.Users.ToList();

            //}
            //else
            //{
                IEnumerable<User> user = from p in context.Users
                                         where (p.UserID == uid)
                                         select p;
                return user;
           // }
        }


        public IEnumerable<Company> GetCompanyByID()
        {

            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

                IEnumerable<Company> company = from p in context.Companies
                                               where (p.CompanyID == companyid)
                                         select p;
                return company;
            
        }

        public IEnumerable<BankAccountsInfo> GetBankAccountByCompanyID()
        {

            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            IEnumerable<BankAccountsInfo> bank = from t in context.BankAccountsInfoes
                                                 join x in context.Companies on t.BankAccountID equals x.BankAccount
                                                 where (x.CompanyID == companyid)
                                                 select t;
            return bank;

        }

        public string GetUserPassword()
        {
            string password = "";
            Int64 userid = Convert.ToInt64(HttpContext.Current.Session["UserID"]);

            var query = from p in context.Users
                        where (p.UserID == userid)
                        select p.Password;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    password = q;
                }
            }
            else
                password = "";

            return password; 

        }

        public IEnumerable<BankAccountsInfo> SetBankAccountID(string name, string number, string type)
        {
            int id = 0;
            string accountname = "";

            var bank = new BankAccountsInfo {  BankAccountName = name,  BankAccountNumber = number,  BankAccountType = type };
            context.BankAccountsInfoes.Add(bank);
           context.SaveChanges();

            id = bank.BankAccountID;
            accountname = bank.BankAccountName;

            //Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            //Company company = context.Companies.Single(q => q.CompanyID == companyid);
            //company.BankAccount = id;
            //context.SaveChanges();

         
            return context.BankAccountsInfoes.Where(q => q.BankAccountID == id).ToList();
        }

        public string GetBankAccountName()
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            string bankaccountname = "";

            //var query = from t in context.BankAccountsInfoes
            //            where (t.BankAccountID == id)
            //            select t.BankAccountName;

            var query = from t in context.Companies
                        join x in context.BankAccountsInfoes on t.BankAccount equals x.BankAccountID
                        where (t.CompanyID == companyid)
                        select x.BankAccountName;



            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    bankaccountname = q;
                }
            }
            else
            bankaccountname = "";

            return bankaccountname;
        }

 


        public IEnumerable<User> GetUsersByFirstName(string nameSearchString)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";
            }

            IEnumerable<User> user = (from p in context.Users
                                     where ((p.FirstName.Contains(nameSearchString)) && (p.CompanyID == companyid) && (p.IsDeleted == false))
                                     orderby p.FirstName ascending
                                     select p).Take(20);
            return user;


            // return context.Users.Where(d => d.UserName.Contains(nameSearchString)).ToList();
        }


        public IEnumerable<User> GetUsersByCompanyID()
        {
            return GetUsersByFirstName("");
        }


        public IEnumerable<User> GetUsers()
        {
            return GetUsersByFirstName("");
        }

        public IEnumerable<User> GetUserList()
        {
            return context.Users.ToList();
        }

        public IEnumerable<User> VerifyLogIn(string UserNameString, string PasswordString)
        {

            IEnumerable<User> user = null ;
            string salt = null;
            string hash = null;
            string goodHash = null;
            var targetuser = GetUserByEmail(UserNameString);
            if(targetuser.Count() > 0)
            {
                 salt = targetuser.ElementAt(0).PasswordSalt;
                 hash = targetuser.ElementAt(0).Password;
                 goodHash = "1000:" + salt + ":" + hash;
            }
           

           
            if(salt != null && hash != null)
            {
                bool chk =  Authentication.ValidatePassword(PasswordString,goodHash);

                // return context.Users.Where(d => d.UserName.Contains(UserNameString) && d.Password.Contains(PasswordString)).ToList();

                if(chk == true)
                {

                                  user = from p in context.Users
                                         where ((p.PrimaryEmail == UserNameString) && (p.Password == hash) && (p.PasswordSalt == salt) && (p.IsDeleted == false))
                                         select p;
                }
            }
            return user;

        }



        public Int64 InsertOrUpdate(User user)
        {
            string pemail = user.PrimaryEmail;
            bool emailaddress = true;
            emailaddress = IsEmailExists(pemail);

            if (user.UserID == 0 && emailaddress == false)
            {
                string password = user.Password;
                string fullhash = Authentication.CreateHash(password);
                string[] split = fullhash.Split(':');
                string salt = split[1];
                string hash = split[2];
                user.Password = hash;
                user.PasswordSalt = salt;
                user.IsApproved = true;
                user.IsFirstLogin = true;
                context.Entry(user).State = EntityState.Added;
                context.SaveChanges();

            }
            else if (user.UserID > 0)
            {
                user.IsApproved = true;
                user.IsFirstLogin = false;
                context.Entry(user).State =  EntityState.Modified;
                context.SaveChanges();
            }
                
           
             Int64 id = user.UserID;
     
             return id;
           
        }


        public int CompanyUpdate(Company company)
        {
            int id = 0;
                context.Entry(company).State = EntityState.Modified;
                context.SaveChanges();
                id = company.CompanyID;

            return id;
        }


        public void InsertUser(User user)
        {

            try
            {
                context.Entry(user).State = EntityState.Added;
                context.SaveChanges();
            }
            catch (Exception ex)
            {

                throw ex;

            }

        }

        public int InsertBankAccount(BankAccountsInfo bank)
        {

            try
            {
                context.Entry(bank).State = EntityState.Added;
               context.SaveChanges();
            }
            catch (Exception ex)
            {
                throw ex;
            }
      

            return bank.BankAccountID;

        }


        public void UpdateUser(User user)
        {
            try
            {
                //context.Users.Attach(user);
                context.Entry(user).State = EntityState.Modified;
                context.SaveChanges();
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
                //context.Users.Attach(user);
                context.Entry(bank).State = EntityState.Modified;
                 context.SaveChanges();
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
                context.Users.Attach(user);
                context.Users.Remove(user);
                //context.Entry(user).State = EntityState.Deleted; 
                context.SaveChanges();
            }

            catch (Exception ex)
            {

                throw ex;

            }
        }


        public IEnumerable<Country> GetCountries()
        {
          
            return context.Countries.ToList();

        }



        public IEnumerable<Company> GetCompaniesByCompanyID()
        {


            //var query = from t in context.Companies
            //            join x in context.BankAccountsInfoes on t.BankAccount equals x.BankAccountID
            //            where (t.CompanyID == companyid)
            //            select x.BankAccountName;

            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            IEnumerable<Company> company = from p in context.Companies
                                           where ((p.CompanyID == companyid) && (p.IsDeleted == false))
                                           select p;
            return company;

        }

        public IEnumerable<Company> GetCompanies()
        {
            return context.Companies.ToList();

        }

        public string GetGender( Int64 uid)
        {

            string gender = "";

            var query = from p in context.Users
                        where (p.UserID == uid)
                        select p.Gender;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    gender = q;
                }
            }
            else
            gender = "";


            return gender;

        }

        //public string GetMaritalStatus(Int64 uid)
        //{

        //    string maritalStatus = "";

        //    var query = from p in context.Users
        //                where (p.UserID == uid)
        //                select p.MaritalStatus;

        //    if (query.Count() > 0)
        //    {
        //        foreach (var q in query)
        //        {
        //            maritalStatus = q;
        //        }
        //    }
        //    else
        //        maritalStatus = "";


        //    return maritalStatus;

        //}

        public string GetMessengerType(Int64 uid)
        {

            string MessengerType = "";

            var query = from p in context.Users
                        where (p.UserID == uid)
                        select p.MessengerType;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    MessengerType = q;
                }
            }
            else
                MessengerType = "";


            return MessengerType;

        }

        public string GetsecurityQuestion(Int64 uid)
        {

            string SecurityQuestion = "";

            var query = from p in context.Users
                        where (p.UserID == uid)
                        select p.SecurityQuestion;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    SecurityQuestion = q;
                }
            }
            else
                SecurityQuestion = "";


            return SecurityQuestion;

        }

        public string IsActive(Int64 uid)
        {

            string isactive = "false";

            var query = from p in context.Users
                        where (p.UserID == uid)
                        select p.IsActive;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    isactive = Convert.ToString(q);
                }
            }
            else
            isactive = "false";


            return isactive;

        }


        public string CompanyBankAccountType()
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            string accounttype = "";

            var query = from p in context.BankAccountsInfoes
                        join x in context.Companies on p.BankAccountID equals x.BankAccount
                        where ((p.BankAccountID == x.BankAccount) && (x.CompanyID == companyid))
                        select p.BankAccountType;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    accounttype = q;
                }
            }
            else
                accounttype = "";


            return accounttype;

        }

        //public void SaveChanges()
        //{
        //    try
        //    {
        //        context.SaveChanges();
        //    }
        //    catch (DbUpdateConcurrencyException ex)
        //    {
        //        var objContext = ((IObjectContextAdapter)context).ObjectContext;
        //        // Get failed entry
        //        var entry = ex.Entries.Single();
        //        // Now call refresh on ObjectContext
        //        objContext.Refresh(RefreshMode.ClientWins, entry.Entity);
        //    }
        //}


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
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }



    }
}