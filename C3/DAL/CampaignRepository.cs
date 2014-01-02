using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using C3App.DAL;

using System.Configuration;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Data.Objects;
using C3App.App_Code;


namespace C3App.DAL
{
    public class CampaignRepository : IDisposable, ICampaignRepository
    {
        public C3Entities context = new C3Entities();

        public CampaignRepository()
        {

        }

        public IEnumerable<Campaign> GetCampaigns(int companyID)
        {

            return context.Campaigns.AsNoTracking().Where(c => c.CompanyID == companyID && c.IsDeleted == false).Take(20).ToList();

            //var campaigns = (from campaign in context.Campaigns
            //                 where campaign.IsDeleted == false && campaign.CompanyID == companyID
            //                 select campaign).ToList();

            //try
            //{
            //    return campaigns;
            //}
            //catch (Exception e)
            //{
            //    throw e;
            //}

        }

        public IEnumerable<Campaign> GetActiveCampaigns(int companyID)
        {
            var campaigns = (from campaign in context.Campaigns
                             where campaign.IsDeleted == false && campaign.CompanyID == companyID && campaign.CampaignStatusID == 2
                             select campaign).ToList();
            try
            {
                return campaigns;
            }
            catch (Exception ex) 
            {
                throw ex;
            }
        }

        public IEnumerable<Campaign> GetCampaignByName(string nameSearchString, int companyID)
        {
            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";
            }
            try
            {
                return context.Campaigns.Where(camp => camp.IsDeleted == false && camp.CompanyID == companyID && camp.Name.Contains(nameSearchString)).ToList();
            }
            catch (Exception e)
            {
                throw e;
            }


        }

        public IEnumerable<Campaign> GetCampaignByID(long campaignID, int companyID)
        {
            var campaigns = (from campaign in context.Campaigns
                             where campaign.CampaignID == campaignID && campaign.CompanyID == companyID
                             select campaign).ToList();
            try
            {
                return campaigns;
            }
            catch (Exception e)
            {
                throw e;
            }


        }

        public void DeleteCampaignByID(long campaignID)
        {

            Campaign campaign = context.Campaigns.Single(c => c.CampaignID == campaignID);
            try
            {
                campaign.IsDeleted = true;
                SaveChanges();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<CampaignStatus> GetCampaignStatus()
        {
            try
            {
                return context.CampaignStatuses.ToList();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<CampaignType> GetCampaignTypes()
        {
            try
            {
                return context.CampaignTypes.ToList();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public long InsertOrUpdateCampaign(Campaign campaign)
        {
            try
            {
                context.Entry(campaign).State = campaign.CampaignID == 0 ? EntityState.Added : EntityState.Modified;
                SaveChanges();
                return campaign.CampaignID;
            }
            catch (Exception ex) { throw ex; }
        }

        public void InsertCampaignTarget(long campaignID, long targetID, string targetType)
        {
            try
            {
                CampaignTarget campaignTarget = new CampaignTarget();
                campaignTarget.CampaignID = campaignID;
                campaignTarget.TargetID = targetID;
                campaignTarget.TargetType = targetType;
                context.Entry(campaignTarget).State = EntityState.Added;
                SaveChanges();
            }

            catch (OptimisticConcurrencyException e)
            {
                SaveChanges();
            }
        }

        public bool IsCampaignExists(long companyid, long campaignid, string cName)
        {
            bool found = false;
            long campid = -1;

            var campaign = (from c in context.Campaigns
                            where ((c.Name == cName) && (c.CompanyID == companyid) && (c.CampaignID != campaignid))
                            select c).FirstOrDefault();

            if (campaign != null)
                campid = campaign.CampaignID;

            if (campid != -1)
                found = true;

            return found;
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

    }

}


