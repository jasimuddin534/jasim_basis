using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class LeadRepository:IDisposable,ILeadRepository
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

 
        public IEnumerable<Lead> GetLeads(int companyid)
        {
            //return context.Leads.ToList();
            var Leads = (context.Leads.Where(lead => lead.IsDeleted == false && lead.CompanyID == companyid).
                OrderBy(lead => lead.FirstName).Take(20));
            return Leads;
        }

        
        public long InsertLeads(Lead lead)
        {
            try
            {
                lead.CreatedTime = DateTime.Now;
                lead.ModifiedTime = DateTime.Now;
                context.Entry(lead).State = EntityState.Added;
                context.SaveChanges();
                return lead.LeadID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public long UpdateLeads(Lead lead)
        {
            try
            {
              // var Leads = (context.Leads.Where(lead1 => lead1.LeadID == lead.LeadID)).FirstOrDefault();
                var currentLead = context.Leads.Find(lead.LeadID);
               // currentLead.ModifiedTime = DateTime.Now;
                //context.Entry(Leads).State = EntityState.Modified;
                context.Entry(currentLead).CurrentValues.SetValues(lead);
                context.SaveChanges();
                return lead.LeadID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteLeads(Lead lead)
        {
            try
            {
                context.Leads.Attach(lead);
                context.Entry(lead).State = EntityState.Deleted;
                SaveChanges();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        public IEnumerable<LeadSource> GetLeadSources()
        {
            return context.LeadSources.ToList();
        }

     
        public IEnumerable<LeadStatus>GetLeadStatus()
        {
            return context.LeadStatuses.ToList();
        }


        public IEnumerable<Lead> SearchLeads(string search)
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            if (String.IsNullOrWhiteSpace(search))
            {
                search = "";
            }
            var leads = (context.Leads.Where(lead => lead.FirstName.Contains(search) && (lead.IsDeleted == false) && (lead.CompanyID == companyid))
                        ).ToList();
            return leads;
        }

        public IEnumerable<Lead> GetLeadByID(long LeadID, int companyid)
        {
            var Leads = (context.Leads.Where(lead => lead.LeadID == LeadID && lead.CompanyID == companyid)).ToList();
            return Leads;
        }

        public void UpdateConvertedLead(long leadId, long opportunityId, string name)
        {
            Lead lead = context.Leads.Single(q => q.LeadID == leadId);
            lead.OpportunityID = opportunityId;
            lead.OpportunityName = name;
            lead.Converted = true;
            lead.LeadStatusID = 4;
            context.SaveChanges();
        }

        public IEnumerable<Lead> CheckConvertedLeadById(long leadId)
        {
            var Leads = (context.Leads.Where(lead => lead.LeadID == leadId && lead.Converted == false)).ToList();
            return Leads;
        }

        public IEnumerable<Lead> GetLeadsByCompanyID()
        {
           return SearchLeads("");
        }

        public IEnumerable<Lead> GetLeadByContactID(long contactId, int companyid)
        {
            return context.Leads.Where(p => p.ContactID == contactId && p.CompanyID==companyid).ToList();

        }

        public IEnumerable<Lead> GetNewLeads(int companyid)
        {
            var Leads = (context.Leads.Where(lead => lead.LeadStatusID == 1 && lead.CompanyID == companyid)).ToList();

            return Leads;
            
        }

        public IEnumerable<Lead> GetAssignedLeads(int companyid)
        {
            var Leads = (context.Leads.Where(lead => lead.LeadStatusID == 2 && lead.CompanyID == companyid)).ToList();

            return Leads;
        }

        public IEnumerable<Lead> GetConvertedLeads(int companyid)
        {
            var Leads = (context.Leads.Where(lead => lead.LeadStatusID == 4 && lead.CompanyID == companyid)).ToList();

            return Leads;
            
        }

        public void DeleteLeadById(long leadId)
        {
            Lead leads = (context.Leads.Where(lead => lead.LeadID == leadId)
                         ).FirstOrDefault();
            leads.IsDeleted = true;
            try
            {
                context.Entry(leads).State = EntityState.Modified;
                SaveChanges();

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        public IEnumerable<Lead> GetLeadsByAssignedUserID(long assigneduserid, int companyid)
        {

            var Leads = (context.Leads.Where(
                lead => lead.AssignedUserID == assigneduserid && lead.CompanyID == companyid && lead.IsDeleted == false)).ToList();
            return Leads;
            
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



    }
}