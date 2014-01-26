using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IOpportunityRepository:IDisposable
    {

         IEnumerable<Opportunity> GetOpportunities(int companyId);
         long InsertOpportunity(Opportunity opportunity);
         long UpdateOpportunity(Opportunity opportunity);
         void DeleteOpportunity(Opportunity opportunity);
         IEnumerable<OpportunityType> GetOpportunityTypes();
         IEnumerable<Opportunity> SearchOpportunities(string search, int companyId);
         void DeletedById(long opportunityId);
         IEnumerable<OpportunitySalesStage> GetOpportunitySalesStages();
         IEnumerable<Opportunity> OpportunityByID(long opportunityId);
         IEnumerable<Opportunity> GetOppotunitiesByAssignedUserID(long assigneduserid, int companyId);
         long leadToOpportunityInsert(Opportunity opportunity);
         //IEnumerable<Opportunity> GetOpportunitiessByCompanyID();

         IEnumerable<Opportunity> GetOpportunityByName(string name, int companyid);
        IEnumerable<Opportunity> GetTopOpportunities(int companyid);
        IEnumerable<Opportunity> GetProspectingOpportunities(int companyid);
    }
}
