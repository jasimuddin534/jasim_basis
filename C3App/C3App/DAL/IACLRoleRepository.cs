using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IACLRoleRepository
    {
        int InsertRole(string roleName, string description);
        Int32 SearchRoleID(string rolename, Int32 companyid);
        void InsertACLAction(int roleid,int companyid);
        IEnumerable<ACLRole> GetRolesByCompanyID();
        IEnumerable<ACLFunction> GetFunctionList();
        IEnumerable<CompanyModule> GetModuleListByCompanyID();

        string GetModuleNameByID(int moduleid);
        string SearchACLActionAccessID(int roleid, int moduleId, int functionId);
        string SearchRoleNameByID(int roleid);
        string SearchRoleDesByID(int roleid);
        void EditRole(string rolename, string description, int roleid);
         Int64 EditACLAction(int moduleId, int functionId, string access, int roleid);
        IEnumerable<ACLRole> GetRolesByName(string nameSearchString);
        void DeactivateRole(int roleid);

        IEnumerable<ACLAction> GetACLActionList();
        IEnumerable<User> GetUsersByRoleID(int roleid);
        IEnumerable<User> GetRoleUsers(int roleid, string nameSearchString);
        void UsersSetRoleID(long uid, int rid);
        string InsertCompanyModules(int companyid);
        IEnumerable<ACLRole> GetRolesByID(int roleid);

    }
}
