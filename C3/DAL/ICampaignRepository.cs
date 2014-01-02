using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface ICampaignRepository
    {
        IEnumerable<Campaign> GetCampaigns(int companyID);

        IEnumerable<Campaign> GetActiveCampaigns(int companyID);

        IEnumerable<Campaign> GetCampaignByName(string nameSearchString, int companyID);
        IEnumerable<Campaign> GetCampaignByID(long campaignID, int companyID);
        IEnumerable<CampaignStatus> GetCampaignStatus();
        IEnumerable<CampaignType> GetCampaignTypes();

        void DeleteCampaignByID(long campaignID);
        long InsertOrUpdateCampaign(Campaign campaign);
        void InsertCampaignTarget(long campaignID, long targetID, string targetType);
        bool IsCampaignExists(long companyid, long campaignid, string cName);
    }
}
