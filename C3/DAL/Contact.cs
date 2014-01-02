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
    using System.Collections.Generic;
    
    public partial class Contact
    {
        public Contact()
        {
            this.Contacts1 = new HashSet<Contact>();
            this.Leads = new HashSet<Lead>();
            this.Opportunities = new HashSet<Opportunity>();
            this.Orders = new HashSet<Order>();
            this.Orders1 = new HashSet<Order>();
            this.Tasks = new HashSet<Task>();
            this.Quotes = new HashSet<Quote>();
            this.Quotes1 = new HashSet<Quote>();
        }
    
        public long ContactID { get; set; }
        public int CompanyID { get; set; }
        public string Salutation { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public Nullable<long> AccountID { get; set; }
        public Nullable<int> LeadSourcesID { get; set; }
        public string Department { get; set; }
        public string Designation { get; set; }
        public Nullable<System.DateTime> BirthDate { get; set; }
        public Nullable<long> ReportsTo { get; set; }
        public string OfficePhone { get; set; }
        public string MobilePhone { get; set; }
        public string HomePhone { get; set; }
        public string OtherPhone { get; set; }
        public string Fax { get; set; }
        public string PrimaryEmail { get; set; }
        public string AlternateEmail { get; set; }
        public string AssistantName { get; set; }
        public string AssistantPhone { get; set; }
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
        public string Description { get; set; }
        public Nullable<long> AssignedTo { get; set; }
        public Nullable<long> TeamID { get; set; }
        public Nullable<bool> InvalidEmail { get; set; }
        public Nullable<bool> EmailOptOut { get; set; }
        public Nullable<bool> DoNotCall { get; set; }
        public Nullable<int> RecordID { get; set; }
        public byte[] Timestamp { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public Nullable<long> ModifiedBy { get; set; }
        public System.DateTime ModifiedTime { get; set; }
    
        public virtual Account Account { get; set; }
        public virtual Company Company { get; set; }
        public virtual User User { get; set; }
        public virtual LeadSource LeadSource { get; set; }
        public virtual Team Team { get; set; }
        public virtual Country Country { get; set; }
        public virtual ICollection<Contact> Contacts1 { get; set; }
        public virtual Contact Contact1 { get; set; }
        public virtual Country Country1 { get; set; }
        public virtual ICollection<Lead> Leads { get; set; }
        public virtual ICollection<Opportunity> Opportunities { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Order> Orders1 { get; set; }
        public virtual ICollection<Task> Tasks { get; set; }
        public virtual ICollection<Quote> Quotes { get; set; }
        public virtual ICollection<Quote> Quotes1 { get; set; }
    }
}
