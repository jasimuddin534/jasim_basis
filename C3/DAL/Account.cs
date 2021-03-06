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
    
    public partial class Account
    {
        public Account()
        {
            this.Cases = new HashSet<Case>();
            this.Contacts = new HashSet<Contact>();
            this.Leads = new HashSet<Lead>();
            this.Opportunities = new HashSet<Opportunity>();
            this.Orders = new HashSet<Order>();
            this.Orders1 = new HashSet<Order>();
            this.Payments = new HashSet<Payment>();
            this.Quotes = new HashSet<Quote>();
            this.Quotes1 = new HashSet<Quote>();
        }
    
        public long AccountID { get; set; }
        public int CompanyID { get; set; }
        public string Name { get; set; }
        public Nullable<int> AccountTypesID { get; set; }
        public Nullable<long> ParentID { get; set; }
        public Nullable<int> IndustryID { get; set; }
        public Nullable<int> Rating { get; set; }
        public Nullable<decimal> AnnualRevenue { get; set; }
        public string OfficePhone { get; set; }
        public string AlternatePhone { get; set; }
        public string PrimaryEmail { get; set; }
        public string AlternateEmail { get; set; }
        public string Fax { get; set; }
        public string Website { get; set; }
        public string Ownership { get; set; }
        public string Employees { get; set; }
        public string SICCode { get; set; }
        public string BillingStreet { get; set; }
        public string BillingCity { get; set; }
        public string BillingState { get; set; }
        public string BillingPost { get; set; }
        public Nullable<int> BillingCountry { get; set; }
        public string ShippingStreet { get; set; }
        public string ShippingCity { get; set; }
        public string ShippingState { get; set; }
        public string ShippingPost { get; set; }
        public Nullable<int> ShippingCountry { get; set; }
        public string Description { get; set; }
        public Nullable<long> AssignedUserID { get; set; }
        public Nullable<long> TeamID { get; set; }
        public Nullable<int> RecordID { get; set; }
        public byte[] Timestamp { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public Nullable<long> ModifiedBy { get; set; }
        public System.DateTime ModifiedTime { get; set; }
    
        public virtual AccountType AccountType { get; set; }
        public virtual User User { get; set; }
        public virtual Country Country { get; set; }
        public virtual Company Company { get; set; }
        public virtual CompanyType CompanyType { get; set; }
        public virtual Country Country1 { get; set; }
        public virtual Team Team { get; set; }
        public virtual ICollection<Case> Cases { get; set; }
        public virtual ICollection<Contact> Contacts { get; set; }
        public virtual ICollection<Lead> Leads { get; set; }
        public virtual ICollection<Opportunity> Opportunities { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Order> Orders1 { get; set; }
        public virtual ICollection<Payment> Payments { get; set; }
        public virtual ICollection<Quote> Quotes { get; set; }
        public virtual ICollection<Quote> Quotes1 { get; set; }
    }
}
