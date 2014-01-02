using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class OpportunityBL
    {

        private readonly IOpportunityRepository opportunitiesRepository;

        public OpportunityBL()
        {
            this.opportunitiesRepository = new OpportunityRepository();
        }

        public IEnumerable<Opportunity> GetOpportunities()
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return opportunitiesRepository.GetOpportunities(companyid);
        }

        public IEnumerable<Opportunity> GetTopOpportunities()
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return opportunitiesRepository.GetTopOpportunities(companyid);
        }

        public IEnumerable<Opportunity> GetProspectingOpportunities()
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return opportunitiesRepository.GetProspectingOpportunities(companyid);
        }

        //public IEnumerable<Opportunity> GetOpportunitiessByCompanyID()
        //{
        //    return opportunitiesRepository.GetOpportunitiessByCompanyID();
        //}

        public long InsertOpportunity(Opportunity opportunity)
        {
            ValidateOpportunity(opportunity);
            try
            {
                return opportunitiesRepository.InsertOpportunity(opportunity);

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void ValidateOpportunity(Opportunity opportunity)
        {
            if (opportunity.Name != null)
            {
                int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                var duplicateOpportunity =
                    opportunitiesRepository.GetOpportunityByName(opportunity.Name, companyid).FirstOrDefault();
                if (duplicateOpportunity != null && duplicateOpportunity.OpportunityID != opportunity.OpportunityID)
                {
                    if (duplicateOpportunity.Name == opportunity.Name)
                    {
                        throw new DuplicateLeadException(String.Format(
                            "Opportunity Name {0} is already exist",
                            duplicateOpportunity.Name
                                                             ));

                    }
                }
            }
        }

        public long UpdateOpportunity(Opportunity opportunity)
        {
            ValidateOpportunity(opportunity);
            try
            {
                return opportunitiesRepository.UpdateOpportunity(opportunity);

            }
            catch (Exception ce)
            {

                throw ce;
            }
        }

        public void DeleteOpportunity(Opportunity opportunity)
        {

            opportunitiesRepository.DeleteOpportunity(opportunity);
        }

        public IEnumerable<OpportunityType> GetOpportunityTypes()
        {
            return opportunitiesRepository.GetOpportunityTypes();

        }

        public IEnumerable<Opportunity> SearchOpportunities(string search)
        {
            Int32 companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);


            return opportunitiesRepository.SearchOpportunities(search, companyId);
        }

        public void DeleteById(long OpportunityID)
        {
            opportunitiesRepository.DeletedById(OpportunityID);
        }

        public IEnumerable<OpportunitySalesStage> GetOpportunitySalesStages()
        {
            return opportunitiesRepository.GetOpportunitySalesStages();
        }

        public IEnumerable<Opportunity> OpportunityByID(long opportunityId)
        {
            return opportunitiesRepository.OpportunityByID(opportunityId);

        }

        public IEnumerable<Opportunity> GetOppotunitiesByAssignedUserID(long assigneduserid)
        {
            Int32 companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return opportunitiesRepository.GetOppotunitiesByAssignedUserID(assigneduserid, companyId);
        }


        public long leadToOpportunityInsert(Opportunity opportunity)
        {

            ValidateOpportunity(opportunity);
            return opportunitiesRepository.leadToOpportunityInsert(opportunity);
        }


        public bool CheckOppportintyName(Opportunity opportunity)
        {
            bool msg = false;
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            var duplicateOpportunity =
                opportunitiesRepository.GetOpportunityByName(opportunity.Name, companyid).FirstOrDefault();
            if (duplicateOpportunity != null )
            {
                if (duplicateOpportunity.Name == opportunity.Name)
                {
                    msg = true;
                }
            }
            return msg;
        }
    }

    public class DuplicateOpportunityException : Exception
    {
        public DuplicateOpportunityException(string message)
            : base(message)
        {
        }
    }

}