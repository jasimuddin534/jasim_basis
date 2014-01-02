using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.DAL
{
    public class OpportunityRepository : IDisposable, IOpportunityRepository
    {

        private C3Entities context = new C3Entities();

        public IEnumerable<Opportunity> GetOpportunities(int companyId)
        {
            var opportunities = (context.Opportunities.Where(opportunity => opportunity.CompanyID == companyId && opportunity.IsDeleted == false).OrderByDescending
                                           (opportunity => opportunity.Amount)).Take(20); 
            return opportunities;
        }
        private bool disposevalue = false;
        public virtual void Dispose(bool disposing)
        {
            if (!this.disposevalue)
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
        public long InsertOpportunity(Opportunity opportunity)
        {
            try
            {
                opportunity.CreatedTime = DateTime.Now;
                opportunity.ModifiedTime = DateTime.Now;
                context.Entry(opportunity).State = EntityState.Added;
                context.SaveChanges();
                return opportunity.OpportunityID;
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public long UpdateOpportunity(Opportunity opportunity)
        {
            try
            {
                var currentOpportunity = context.Opportunities.Find(opportunity.OpportunityID);
                context.Entry(currentOpportunity).CurrentValues.SetValues(opportunity);
                SaveChanges();
                return opportunity.OpportunityID;

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public void DeleteOpportunity(Opportunity opportunity)
        {
            try
            {
                context.Opportunities.Attach(opportunity);
                context.Entry(opportunity).State = EntityState.Deleted;
                SaveChanges();
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public IEnumerable<OpportunityType> GetOpportunityTypes()
        {
            return context.OpportunityTypes.ToList();

        }
        public IEnumerable<Opportunity> SearchOpportunities(string search, int companyId1)
        {
            Int32 companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            if (String.IsNullOrWhiteSpace(search))
            {
                search = "";
            }

            var opportunities = (context.Opportunities.Where(opportunity =>opportunity.Name.Contains(search) 
                                 && (opportunity.IsDeleted == false) &&(opportunity.CompanyID == companyId))).ToList();

            return opportunities;
        }
        //public IEnumerable<Opportunity> GetOpportunitiessByCompanyID()
        //{
        //    return SearchOpportunities("", TODO);
        //}
        public IEnumerable<Opportunity> GetOpportunityByName(string name, int companyid)
        {
            return context.Opportunities.Where(p => p.Name == name && p.CompanyID == companyid).ToList();

        }
        //SearchFilteredItems(string filterKeyword)
        //{
        //    switch (@enum)
        //    {
        //        case "":
        //            break;
        //        case "":
        //    }
        //}
        public IEnumerable<Opportunity> GetTopOpportunities(int companyid)
        {
            var opportunities = (context.Opportunities.Where(opportunity => opportunity.CompanyID == companyid && opportunity.IsDeleted == false).OrderByDescending
                                (opportunity => opportunity.Amount)).Take(10);
            return opportunities;
        }
        public IEnumerable<Opportunity> GetProspectingOpportunities(int companyid)
        {
            var opportunities = (context.Opportunities.Where(opportunity =>(opportunity.SalesStageID == 1) && 
                                opportunity.CompanyID == companyid && opportunity.IsDeleted == false)).ToList();

            return opportunities;
        }
        public void DeletedById(long OpportunityID)
        {
            Opportunity opportunities = (context.Opportunities.Where(opportunity => opportunity.OpportunityID == OpportunityID)
                                        ).FirstOrDefault();
            opportunities.IsDeleted = true;
            try
            {
                context.Entry(opportunities).State = EntityState.Modified;
                SaveChanges();

            }
            catch (Exception ex)
            {

                throw ex;
            }

        }
        public IEnumerable<OpportunitySalesStage> GetOpportunitySalesStages()
        {
            return context.OpportunitySalesStages.ToList();
        }
        public IEnumerable<Opportunity> OpportunityByID(long opportunityId)
        {
            var opportunities = (context.Opportunities.Where(opportunity => opportunity.OpportunityID == opportunityId)).ToList();
            return opportunities;

        }
        public IEnumerable<Opportunity> GetOppotunitiesByAssignedUserID(long assigneduserid, int companyId)
        {
            var opportunities = (context.Opportunities.Where(opportunity =>opportunity.AssignedUserID == assigneduserid && opportunity.CompanyID == companyId &&
                                 opportunity.IsDeleted == false).OrderByDescending(opportunity => opportunity.Amount)).ToList();

            return opportunities;
        }
        public long leadToOpportunityInsert(Opportunity opportunity)
        {

            try
            {
                context.Entry(opportunity).State = EntityState.Added;
                context.SaveChanges();
            }
            catch (Exception ex)
            {

                throw ex;
            }
            return opportunity.OpportunityID;
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