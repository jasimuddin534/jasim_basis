//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace C3App.DAL
{
    using System;
    
    public partial class uspLeadInsert_Result
    {
        public long LeadID { get; set; }
        public int CompanyID { get; set; }
        public long ContactID { get; set; }
        public string Salutation { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public Nullable<System.DateTime> BirthDate { get; set; }
        public string Title { get; set; }
        public Nullable<int> LeadStatusID { get; set; }
        public string StatusDescription { get; set; }
        public string Department { get; set; }
        public Nullable<int> LeadSourceID { get; set; }
        public string LeadSourceDescripsion { get; set; }
        public string ReferredBy { get; set; }
        public string PhoneHome { get; set; }
        public string PhoneMobile { get; set; }
        public string PhoneWork { get; set; }
        public string PhoneOther { get; set; }
        public string Fax { get; set; }
        public string PrimaryEmail { get; set; }
        public string AlternateEmail { get; set; }
        public string PrimaryStreet { get; set; }
        public string PrimaryCity { get; set; }
        public string PrimaryState { get; set; }
        public string PrimaryPostalCode { get; set; }
        public Nullable<int> PrimaryCountry { get; set; }
        public string AlternateStreet { get; set; }
        public string AlternateCity { get; set; }
        public string AlternateState { get; set; }
        public string AlternatePostalCode { get; set; }
        public Nullable<int> AlternateCountry { get; set; }
        public Nullable<long> AccountID { get; set; }
        public string AccountName { get; set; }
        public string AccountDescription { get; set; }
        public string Description { get; set; }
        public string AssistantName { get; set; }
        public string AssistantPhone { get; set; }
        public string Website { get; set; }
        public Nullable<bool> EmailOptOut { get; set; }
        public Nullable<bool> InvalidEmail { get; set; }
        public Nullable<bool> DoNotCall { get; set; }
        public Nullable<long> TeamID { get; set; }
        public Nullable<int> TeamSetID { get; set; }
        public Nullable<long> ReportsToID { get; set; }
        public Nullable<long> CampaignID { get; set; }
        public Nullable<long> OpportunityID { get; set; }
        public string OpportunityName { get; set; }
        public string OpportunityAmount { get; set; }
        public Nullable<long> AssignedUserID { get; set; }
        public bool Converted { get; set; }
        public Nullable<int> RecordID { get; set; }
        public byte[] Timestamp { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public Nullable<long> ModifiedBy { get; set; }
        public System.DateTime ModifiedTime { get; set; }
    }
}
