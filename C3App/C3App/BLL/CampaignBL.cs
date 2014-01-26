using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using C3App.DAL;
using System.ComponentModel.DataAnnotations;


namespace C3App.BLL
{
    public class CampaignBL
    {
        private ICampaignRepository campaignRepository;

        public CampaignBL()
        {
            this.campaignRepository = new CampaignRepository();
        }

        public IEnumerable<Campaign> GetCampaigns()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return campaignRepository.GetCampaigns(companyID);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Campaign> GetActiveCampaigns()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return campaignRepository.GetActiveCampaigns(companyID);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Campaign> GetCampaignByName(string nameSearchString)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            try
            {
                return campaignRepository.GetCampaignByName(nameSearchString, companyID);
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<DAL.Campaign> GetCampaignByID(long campaignID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            try
            {
                return campaignRepository.GetCampaignByID(campaignID, companyID);
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
                return campaignRepository.GetCampaignTypes();
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
                return campaignRepository.GetCampaignStatus();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public long InsertOrUpdateCampaign(Campaign campaign)
        {
            ValidateCampaign(campaign);
            try
            {
                return campaignRepository.InsertOrUpdateCampaign(campaign);
            }
            catch (Exception ex) { throw ex; }
        }

        public void DeleteCampaignByID(long campaignID)
        {
            try
            {
                campaignRepository.DeleteCampaignByID(campaignID);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void InsertCampaignTarget(long campaignID, long targetID, string targetType)
        {
            try
            {
                campaignRepository.InsertCampaignTarget(campaignID, targetID, targetType);
            }

            catch (Exception ex)
            {
                throw ex;
            }
        }


        private void ValidateCampaign(Campaign campaign)
        {
            long companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            long campaignid = campaign.CampaignID;
            string cName = campaign.Name;

            bool oneCampaign = campaignRepository.IsCampaignExists(companyid, campaignid, cName);

            if (oneCampaign == true)
            {
                throw new DuplicateCampaignException(String.Format("Campaign name {0} already exists. Please try another one.", cName));
            }
        }

    }

    public class DuplicateCampaignException : Exception
    {
        public DuplicateCampaignException(string message)
            : base(message)
        {
        }
    }

}