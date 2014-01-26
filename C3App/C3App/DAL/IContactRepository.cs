using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IContactRepository
    {
        IEnumerable<Contact> GetContacts(int companyID);
        IEnumerable<Contact> GetContactByID(int companyID, long contactID);
        IEnumerable<Contact> GetContactByName(int companyID, string nameSearchString);
        long InsertOrUpdateContact(Contact contact);
        void DeleteContactByID(long contactID);
        bool IsContactExists(long companyid, long cid, string fName, string lName, string pEmail);
        List<DAL.Contact> GetContactByCampaignTargets(string campaignType, long campaignID);
        List<DAL.Contact> GetContactByMeetingInvitee(long meetingID);
    }
}
