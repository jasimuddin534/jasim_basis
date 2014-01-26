using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using C3App.DAL;
using System.ComponentModel.DataAnnotations;

namespace C3App.BLL
{
    public class ContactBL
    {
        private IContactRepository contactRepository;

        public ContactBL()
        {
            this.contactRepository = new ContactRepository();
        }

        public IEnumerable<DAL.Contact> GetContacts()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return contactRepository.GetContacts(companyID);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<DAL.Contact> GetContactByName(string nameSearchString)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return contactRepository.GetContactByName(companyID, nameSearchString);
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<DAL.Contact> GetContactByID(long contactID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return contactRepository.GetContactByID(companyID, contactID);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public List<DAL.Contact> GetContactByCampaignTargets(string campaignType, long campaignID)
        {

            return contactRepository.GetContactByCampaignTargets(campaignType, campaignID);
        }

        public List<DAL.Contact> GetContactByMeetingInvitee(long meetingID)
        {
            return contactRepository.GetContactByMeetingInvitee(meetingID);
        }

        public long InsertContact(DAL.Contact contact)
        {
            ValidateContact(contact);
            try
            {
                return contactRepository.InsertOrUpdateContact(contact);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public long UpdateContact(DAL.Contact contact)
        {
            ValidateContact(contact);
            try
            {
                return contactRepository.InsertOrUpdateContact(contact);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public void DeleteContactByID(long contactId)
        {
            try
            {
                contactRepository.DeleteContactByID(contactId);
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        private void ValidateContact(DAL.Contact contact)
        {
            long companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            long cid = contact.ContactID;
            string fName = contact.FirstName;
            string lName = contact.LastName;
            string pEmail = contact.PrimaryEmail;

            bool oneContact = contactRepository.IsContactExists(companyid, cid, fName, lName, pEmail);

            if (oneContact == true)
            {
                //throw new DuplicateContactException(String.Format("Contact Name : {0} {1} Email Address : {2} already exists. Please try another one.", fName,lName,pEmail));
                throw new DuplicateContactException(String.Format("Contact name {0} {1} already exists. Please try another one.", fName, lName));

            }
        }


    }

    public class DuplicateContactException : Exception
    {
        public DuplicateContactException(string message)
            : base(message)
        {
        }
    }
}