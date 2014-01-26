using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface ILeadRepository :IDisposable
    {
        IEnumerable<Lead> GetLeads(int companyid);
        long InsertLeads(Lead lead);
        long UpdateLeads(Lead lead);
        void DeleteLeads(Lead lead);
        IEnumerable<Lead> SearchLeads(string search);
        IEnumerable<LeadStatus> GetLeadStatus();
        IEnumerable<LeadSource> GetLeadSources();
        void DeleteLeadById(long leadId);
        IEnumerable<Lead> GetLeadsByAssignedUserID(long assigneduserid, int companyid);
        IEnumerable<Lead> GetLeadByID(long leadId, int companyid);
        void UpdateConvertedLead(long leadId, long opportunityId, string name);
        IEnumerable<Lead> CheckConvertedLeadById(long leadId);
        IEnumerable<Lead> GetLeadsByCompanyID();
        IEnumerable<Lead> GetLeadByContactID(long contactId, int companyid);
        IEnumerable<Lead> GetNewLeads(int companyid);
        IEnumerable<Lead> GetAssignedLeads(int companyid);
        IEnumerable<Lead> GetConvertedLeads(int companyid);
    }
}
