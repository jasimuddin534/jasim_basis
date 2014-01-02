using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.Entity.Infrastructure;
using System.Data.Objects;
using C3App.App_Code;


namespace C3App.DAL
{
    public class ContactRepository : IDisposable, IContactRepository
    {
        public C3Entities context = new C3Entities();

        private bool disposevalue = false;

        public ContactRepository()
        {
        }

        public IEnumerable<Contact> GetContacts(int companyID)
        {

            try
            {
                //var contacts = (from contact in context.Contacts
                //                where contact.IsDeleted == false && contact.CompanyID == companyID
                //                select contact).Take(20).ToList();

                return context.Contacts.AsNoTracking().Where(c => c.CompanyID == companyID && c.IsDeleted == false).Take(20).ToList();
                //return contacts;
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<Contact> GetContactByName(int companyID, string nameSearchString)
        {
            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";
            }
            IEnumerable<Contact> contact = from c in context.Contacts
                                           where ((c.FirstName.Contains(nameSearchString) || c.LastName.Contains(nameSearchString) || c.PrimaryEmail.Contains(nameSearchString)) && (c.CompanyID == companyID) && (c.IsDeleted == false))
                                           select c;
            return contact;
        }

        public IEnumerable<Contact> GetContactByID(int companyID, long contactID)
        {
            var contacts = (from contact in context.Contacts
                            where contact.ContactID == contactID && contact.IsDeleted == false && contact.CompanyID == companyID
                            select contact).ToList();
            try
            {
                return contacts;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void DeleteContactByID(long contactID)
        {
            Contact contacts = (from contact in context.Contacts
                                where contact.ContactID == contactID
                                select contact).FirstOrDefault();
            try
            {
                contacts.IsDeleted = true;
                context.Entry(contacts).State = EntityState.Modified;
                SaveChanges();

            }
            catch (OptimisticConcurrencyException opex)
            {
                throw opex;
            }
        }

        public long InsertOrUpdateContact(Contact contact)
        {
            context.Entry(contact).State = contact.ContactID == 0 ? EntityState.Added : EntityState.Modified;
            SaveChanges();
            return contact.ContactID;
        }

        public bool IsContactExists(long companyid, long cid, string fName, string lName, string pEmail)
        {
            bool found = false;
            long contactid = -1;

            var contact = (from c in context.Contacts
                           where ((c.FirstName == fName) && (c.LastName == lName) && (c.PrimaryEmail == pEmail) && (c.CompanyID == companyid) && (c.ContactID != cid))
                           select c).FirstOrDefault();


            if (contact != null)
            {
                contactid = contact.ContactID;
                if (contactid != -1)
                {
                    found = true;
                }
            }    

            return found;
        }

        public List<DAL.Contact> GetContactByCampaignTargets(string campaignType, long campaignID)
        {
            List<DAL.Contact> contact = new List<Contact>();

            List<CampaignTarget> campaignTarget = (from ct in context.CampaignTargets
                                                   where ct.TargetType == campaignType && ct.CampaignID == campaignID
                                                   select ct).ToList();

            foreach (var camptarget in campaignTarget)
            {
                List<DAL.Contact> result = (from mee in context.Contacts
                                            where mee.ContactID == camptarget.TargetID
                                            select mee).ToList();
                contact.AddRange(result);
            }

            return contact;
        }

        public List<DAL.Contact> GetContactByMeetingInvitee(long meetingID)
        {
            List<DAL.Contact> contact = new List<Contact>();

            List<MeetingInvitee> meetingInvitee = (from me in context.MeetingInvitees
                                                   where me.MeetingID == meetingID
                                                   select me).ToList();

            foreach (var contacts in meetingInvitee)
            {
                List<DAL.Contact> result = (from mee in context.Contacts
                                            where mee.ContactID == contacts.InviteeID
                                            select mee).ToList();
                contact.AddRange(result);
            }

            return contact;
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
                    ex.Entries.Single().Reload();
                }
            } while (saveFailed);
        }

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
