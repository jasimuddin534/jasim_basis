using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class ACLRoleRepository : IACLRoleRepository,IDisposable
    {

        private C3Entities context = new C3Entities();


        public IEnumerable<User> GetRoleUsers(int roleid, string nameSearchString)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";

            }

            IEnumerable<User> user = (from p in context.Users
                                     where (((p.FirstName.Contains(nameSearchString)) && (p.CompanyID == companyid) && (p.IsDeleted == false) && (p.RoleID != roleid)) || (p.RoleID == null))
                                     orderby p.FirstName ascending
                                     select p).Take(10);

            return user;

        }

        public void UsersSetRoleID(long uid, int rid)
        {
            string name = SearchRoleNameByID(rid);

            User user = context.Users.Single(q => q.UserID == uid);
            user.RoleID = rid;
            if (name == "Administrator" || name == "Admin")
            {
                user.IsAdmin = true;
            }
            else
            {
                user.IsAdmin = false;
            }
            context.SaveChanges();

        }

        public IEnumerable<ACLAction> GetACLActionList()
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            Int32 roleid = Convert.ToInt32(HttpContext.Current.Session["RoleID"]);
        
              IEnumerable<ACLAction> aclaction = from t in context.ACLActions
                        join x in context.ACLRoles on t.RoleID equals x.RoleID
                        where (x.CompanyID == companyid && t.RoleID == roleid)
                        select t;

            return aclaction;
        }

        

        public IEnumerable<User> GetUsersByRoleID(int roleid)
        {
            //int roleid = 0;
            //IEnumerable<ACLRole> roles = GetRolesByName(name);
            //if(roles.Count() > 0)
            //{
            //    roleid = roles.ElementAt(0).RoleID;
            //}
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            IEnumerable<User> user = from p in context.Users
                                     where ((p.CompanyID == companyid) && (p.IsDeleted == false) && (p.RoleID == roleid))
                                     select p;
            return user;
        }


        public IEnumerable<ACLRole> GetRolesByName(string nameSearchString)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";
            }

            IEnumerable<ACLRole> role = from p in context.ACLRoles
                                     where ((p.Name.Contains(nameSearchString)) && (p.CompanyID == companyid) && (p.IsDeleted == false))
                                     select p;
            return role;

        }

        public IEnumerable<ACLRole> GetRolesByID(int roleid)
        {

          
            IEnumerable<ACLRole> role = from p in context.ACLRoles
                                     where (p.RoleID == roleid)
                                     select p;
            return role;
            
        }


        public void DeactivateRole(int roleid)
        {
            ACLRole role = context.ACLRoles.Single(q => q.RoleID == roleid && q.Name != "Administrator");
            role.IsDeleted = true;
            context.SaveChanges();

        }

        public string SearchACLActionAccessID(int roleid, int moduleId, int functionId)
        {
            string accessid = "-1";
            // var accesstype ;

            var query = from p in context.ACLActions
                        where (p.RoleID == roleid && p.ModuleID == moduleId && p.FunctionID == functionId)
                        select p.Access;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    var accesstype = q;
                    if (accesstype == true) { accessid = "1"; }
                    else if (accesstype == false) { accessid = "0"; }


                }
            }
            else
                accessid = "n/a";

            return accessid;


        }



        public int InsertRole(string roleName, string description)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            int roleid = 0;

            var role = new ACLRole
            {
                CompanyID = companyid,
                Name = roleName,
                Description = description,
                CreatedTime = DateTime.Now,
                ModifiedTime = DateTime.Now,
                IsDeleted = false
            };

            context.ACLRoles.Add(role);
            context.SaveChanges();
            roleid = role.RoleID;
            return roleid;

        }


        public void EditRole(string rolename, string description, int roleid)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            ACLRole role = context.ACLRoles.Single(q => q.RoleID == roleid);
            role.Name = rolename;
            role.Description = description;
            context.SaveChanges();

        }

        public  Int64 EditACLAction(int moduleId, int functionId, string access, int roleid)
        {
            bool baccess = false;

            if (access == "1")
                baccess = true;
            if (access == "0")
                baccess = false;

            var query = (from q in context.ACLActions
                         where (
                         (q.RoleID == roleid)
                         &&
                         (q.ModuleID == moduleId)
                         &&
                         (q.FunctionID == functionId)
                         )
                         select q).Single();

            query.Access = baccess;
            context.SaveChanges();

            Int64 test = query.ACLID;

            return test;


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

        public string SearchRoleNameByID(int roleid)
        {

            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            string rolename = "";

            var query = from p in context.ACLRoles
                        where (p.RoleID == roleid && p.CompanyID == companyid)
                        select p.Name;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    rolename = q;
                }
            }
            else
                rolename = "";

            return rolename;
        }

        public string SearchRoleDesByID(int roleid)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            string roledes = "";

            var query = from p in context.ACLRoles
                        where (p.RoleID == roleid && p.CompanyID == companyid)
                        select p.Description;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    roledes = q;
                }
            }
            else
                roledes = "";

            return roledes;
        }

        public string GetModuleNameByID(int moduleid)
        {
           
            string name = "";

            
            var query = from p in context.Modules
                        where (p.ModuleID == moduleid && p.IsActive == true && p.IsDeleted == false)
                        select p.DisplayName;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                  name = q;
                }
            }
            else
                name = "";

            return name;
        }


        public void InsertACLAction(int roleid,int companyid)
        {
            //var acs = false;

            //if (access == "1")
            //    acs = true;
            //if (access == "0")
            //    acs = false;

            //var aclaction = new ACLAction
            //{
            //    ModuleID = moduleId,
            //    FunctionID = functionId,
            //    CreatedTime = DateTime.Now,
            //    Access = acs,
            //    RoleID = roleid


            //};

            //context.ACLActions.Add(aclaction);
            //SaveChanges();

            if (companyid == 0)
            {
                companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            }

       
            C3Entities context = new C3Entities();

            int moduleid = 0;
            int functionid = 0;
            int[] menus = { 0 };
            int[] functions = { 0 };
            int i = 0;
            int j = 0;

            var query = from t in context.CompanyModules
                        where (t.CompanyID == companyid)
                        orderby t.ModuleID ascending
                        select t.ModuleID;

            if (query.Count() > 0)
            {
                menus = new int[query.Count()];
                foreach (var q in query)
                {
                    moduleid = q;
                    menus[i] = q;
                    i++;
                }

            }

            var query1 = from t in context.ACLFunctions
                         orderby t.FunctionOrder ascending
                         select t.FunctionID;

            if (query1.Count() > 0)
            {
                functions = new int[query1.Count()];
                foreach (var q1 in query1)
                {
                    functionid = q1;
                    functions[j] = q1;
                    j++;

                }
            }


            foreach (int x in menus)
            {
                foreach (int y in functions)
                {
                    var aclaction = new ACLAction { ModuleID = x, FunctionID = y, Access = true, RoleID = roleid, CreatedTime = DateTime.Now };
                    context.ACLActions.Add(aclaction);
                    context.SaveChanges();
                    //SaveChanges();

                }
            }



        }


        public string InsertCompanyModules(int companyid)
        {
   
            C3Entities context = new C3Entities();

            int moduleid = 0;
            int[] menus = { 0 };
            string m = "";
            int i = 0;

            var query = from t in context.Modules
                        where (t.ParentID!=0 && t.RelativePath == null)
                        orderby t.ModuleID ascending
                        select t.ModuleID;

            if (query.Count() > 0)
            {
                menus = new int[query.Count()];
                foreach (var q in query)
                {
                    moduleid = q;
                    m += q + ",";
                    menus[i] = q;
                    i++;
                }

            }


            foreach(int j in menus)
            {

                var companymodules = new CompanyModule { CompanyID=companyid, ModuleID = j, IsDeleted=false, CreatedTime = DateTime.Now, ModifiedTime = DateTime.Now };
                context.CompanyModules.Add(companymodules);
                context.SaveChanges();

            }


            return m;

        }


        public IEnumerable<ACLRole> GetRolesByCompanyID()
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);


            IEnumerable<ACLRole> role = (from p in context.ACLRoles
                                        where ((p.CompanyID == companyid && p.IsDeleted==false))
                                        orderby p.Name ascending
                                        select p).Take(20);
            return role;
        }



        public IEnumerable<ACLFunction> GetFunctionList()
        {
            IEnumerable<ACLFunction> function = from p in context.ACLFunctions
                                                orderby p.FunctionOrder
                                                select p;

            return function;

            //return context.ACLFunctions.OrderBy(FunctionID).ToList();
        }

        public IEnumerable<CompanyModule> GetModuleListByCompanyID()
        {

            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            IEnumerable<CompanyModule> module = from p in context.CompanyModules
                                                join x in context.Modules on p.ModuleID equals x.ModuleID
                                                where (p.CompanyID == companyid && x.IsActive == true && x.IsDeleted == false && x.IsAdmin == false)
                                                select p;
            return module;

            //return context.Modules.ToList();
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