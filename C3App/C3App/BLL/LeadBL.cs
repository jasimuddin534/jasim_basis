using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class LeadBL
    {
        // LeadRepository leadrepository = new LeadRepository();


        private readonly ILeadRepository leadrepository;


        public LeadBL()
        {
            this.leadrepository = new LeadRepository();
        }

        public IEnumerable<Lead> GetLeadsByCompanyID()
        {
            return leadrepository.GetLeadsByCompanyID();
        }

        public IEnumerable<Lead> GetNewLeads()
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return leadrepository.GetNewLeads(companyid);
        }
        public IEnumerable<Lead> GetAssignedLeads()
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return leadrepository.GetAssignedLeads(companyid);
        }
        public IEnumerable<Lead> GetConvertedLeads()
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return leadrepository.GetConvertedLeads(companyid);
        }

        public IEnumerable<LeadSource> GetLeadSources()
        {
            return leadrepository.GetLeadSources();

        }
        public IEnumerable<Lead> GetLeads()
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return leadrepository.GetLeads(companyid);

        }
        public long InsertLeads(Lead lead)
        {
            ValidateLead(lead);
            try
            {
                return leadrepository.InsertLeads(lead);

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        private void ValidateLead(Lead lead)
        {
            if (lead.ContactID != null)
            {
                int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                var duplicateLead = leadrepository.GetLeadByContactID(lead.ContactID, companyid).FirstOrDefault();
                if (duplicateLead != null && duplicateLead.LeadID != lead.LeadID)
                {
                    if (duplicateLead.ContactID == lead.ContactID)
                    {
                        throw new DuplicateLeadException(String.Format(
                           "Contact Name {0} is already exist",
                        duplicateLead.Contact.FirstName + " " + duplicateLead.Contact.LastName
                        ));

                    }
                }
            }
        }
        public long UpdateLeads(Lead lead)
        {
            ValidateLead(lead);
            try
            {
                return leadrepository.UpdateLeads(lead);

            }
            catch (Exception ce)
            {
                
                throw ce;
            }
        }
        public void DeleteLeads(Lead lead)
        {
            leadrepository.DeleteLeads(lead);
        }
        public IEnumerable<LeadStatus> GetLeadStatus()
        {
            return leadrepository.GetLeadStatus();
        }
        public IEnumerable<Lead> SearchLeads(string search)
        {
            return leadrepository.SearchLeads(search);
        }
        
        public IEnumerable<Lead> GetLeadByID(long LeadID)
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return leadrepository.GetLeadByID(LeadID,companyid);

        }
        public void DeleteLeadById(long leadId)
        {
            leadrepository.DeleteLeadById(leadId);

        }
        public IEnumerable<Lead> GetLeadsByAssignedUserID(long assigneduserid)
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return leadrepository.GetLeadsByAssignedUserID(assigneduserid, companyid);

        }
        public void UpdateConvertedLead(long leadId, long opportunityId, string name)
        {
            leadrepository.UpdateConvertedLead(leadId, opportunityId, name);
        }
        public IEnumerable<Lead> CheckConvertedLeadById(long leadId)
        {
            return leadrepository.CheckConvertedLeadById(leadId);
        }

    }
    public class DuplicateLeadException : Exception
    {
        public DuplicateLeadException(string message)
            : base(message)
        {
        }
    }

}