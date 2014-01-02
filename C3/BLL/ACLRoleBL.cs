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
    public class ACLRoleBL
    {
       private IACLRoleRepository aclRoleRepository;

       public ACLRoleBL()
        {
            this.aclRoleRepository = new ACLRoleRepository();
        }

       public IEnumerable<ACLRole> GetRolesByName(string nameSearchString)
       {
           return aclRoleRepository.GetRolesByName(nameSearchString);
       }


       public string GetModuleNameByID(int moduleid)
       {
           return aclRoleRepository.GetModuleNameByID(moduleid);
       }

       public IEnumerable<ACLAction> GetACLActionList()
       {
           return aclRoleRepository.GetACLActionList();
       }

       public int InsertRole(string roleName, string description)
       {
           return aclRoleRepository.InsertRole(roleName,description);

       }
       public IEnumerable<ACLRole> GetRolesByID(int roleid)
       {
           return aclRoleRepository.GetRolesByID(roleid);
       }

       public void DeactivateRole(int roleid)
       {
           try
           {
               aclRoleRepository.DeactivateRole(roleid);
           }
           catch (Exception ex)
           {
               throw ex;
           }

       }

       public Int32 SearchRoleID(string rolename, Int32 companyid)
       {
           return aclRoleRepository.SearchRoleID(rolename, companyid);

       }
       public void InsertACLAction(int roleid,int companyid)
       {

           try
           {
               aclRoleRepository.InsertACLAction(roleid,companyid);
           }
           catch (Exception ex)
           {
               throw ex;
           }


       }
       public IEnumerable<ACLRole> GetRolesByCompanyID()
       {
           return aclRoleRepository.GetRolesByCompanyID();
       }
       public IEnumerable<ACLFunction> GetFunctionList()
       {
           return aclRoleRepository.GetFunctionList();
       }
       public IEnumerable<CompanyModule> GetModuleListByCompanyID()
       {
           return aclRoleRepository.GetModuleListByCompanyID();
       }


       public string SearchACLActionAccessID(int roleid, int moduleId, int functionId)
       {
           return aclRoleRepository.SearchACLActionAccessID(roleid, moduleId, functionId);
       }


       public string SearchRoleNameByID(int roleid)
       {
           return aclRoleRepository.SearchRoleNameByID(roleid);
       }

       public string SearchRoleDesByID(int roleid)
       {
           return aclRoleRepository.SearchRoleDesByID(roleid);
       }

       public void EditRole(string rolename, string description, int roleid)
       {
           try
           {
               aclRoleRepository.EditRole(rolename, description, roleid);

           }
           catch (Exception ex)
           {
               throw ex;
           }

       }

       public void UsersSetRoleID(long uid, int rid)
       {
           try
           {
               aclRoleRepository.UsersSetRoleID(uid,rid);

           }
           catch (Exception ex)
           {
               throw ex;
           }
       }

       public  Int64 EditACLAction(int moduleId, int functionId, string access, int roleid)
       {
           return aclRoleRepository.EditACLAction(moduleId,functionId,access,roleid);
       }


       public IEnumerable<User> GetUsersByRoleID(int roleid)
       {
           return aclRoleRepository.GetUsersByRoleID(roleid);
       }

       public IEnumerable<User> GetRoleUsers(int roleid, string nameSearchString)
       {
           return aclRoleRepository.GetRoleUsers(roleid,nameSearchString);
       }

       public string InsertCompanyModules(int companyid)
       {
           return aclRoleRepository.InsertCompanyModules(companyid);
       }


    }
}