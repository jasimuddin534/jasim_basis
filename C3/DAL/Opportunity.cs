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
    
    public partial class Opportunity
    {
        public Opportunity()
        {
            this.Invoices = new HashSet<Invoice>();
            this.Leads = new HashSet<Lead>();
            this.Orders = new HashSet<Order>();
            this.Quotes = new HashSet<Quote>();
        }
    
        public long OpportunityID { get; set; }
        public int CompanyID { get; set; }
        public string Name { get; set; }
        public Nullable<long> AccountID { get; set; }
        public Nullable<long> ContactID { get; set; }
        public Nullable<int> OpportunityTypeID { get; set; }
        public Nullable<int> LeadSourceID { get; set; }
        public Nullable<long> CampaignID { get; set; }
        public Nullable<int> SalesStageID { get; set; }
        public Nullable<int> CurrencyID { get; set; }
        public Nullable<decimal> Amount { get; set; }
        public string NextStep { get; set; }
        public Nullable<double> Probability { get; set; }
        public Nullable<System.DateTime> DateEnclosed { get; set; }
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
    
        public virtual Account Account { get; set; }
        public virtual Campaign Campaign { get; set; }
        public virtual Company Company { get; set; }
        public virtual Contact Contact { get; set; }
        public virtual Currency Currency { get; set; }
        public virtual ICollection<Invoice> Invoices { get; set; }
        public virtual ICollection<Lead> Leads { get; set; }
        public virtual LeadSource LeadSource { get; set; }
        public virtual User User { get; set; }
        public virtual OpportunityType OpportunityType { get; set; }
        public virtual OpportunitySalesStage OpportunitySalesStage { get; set; }
        public virtual Team Team { get; set; }
        public virtual ICollection<Order> Orders { get; set; }
        public virtual ICollection<Quote> Quotes { get; set; }
    }
}
