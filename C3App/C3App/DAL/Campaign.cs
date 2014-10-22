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
    
    public partial class Campaign
    {
        public Campaign()
        {
            this.CampaignTargets = new HashSet<CampaignTarget>();
            this.Leads = new HashSet<Lead>();
            this.Opportunities = new HashSet<Opportunity>();
        }
    
        public long CampaignID { get; set; }
        public int CompanyID { get; set; }
        public string Name { get; set; }
        public Nullable<int> CampaignTypeID { get; set; }
        public Nullable<int> CampaignStatusID { get; set; }
        public string ReferURL { get; set; }
        public Nullable<System.DateTime> StartDate { get; set; }
        public Nullable<System.DateTime> EndDate { get; set; }
        public Nullable<decimal> Budget { get; set; }
        public Nullable<decimal> ActualCost { get; set; }
        public Nullable<decimal> ExpectedCost { get; set; }
        public Nullable<decimal> ExpectedRevenue { get; set; }
        public Nullable<int> Impressions { get; set; }
        public string Frequency { get; set; }
        public string Objective { get; set; }
        public string TemplateType { get; set; }
        public Nullable<int> TemplateID { get; set; }
        public string Content { get; set; }
        public Nullable<int> CurrencyID { get; set; }
        public Nullable<long> AssignedUserID { get; set; }
        public Nullable<long> TeamID { get; set; }
        public Nullable<int> TeamSetID { get; set; }
        public Nullable<int> RecordID { get; set; }
        public byte[] Timestamp { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public Nullable<long> ModifiedBy { get; set; }
        public System.DateTime ModifiedTime { get; set; }
    
        public virtual ICollection<CampaignTarget> CampaignTargets { get; set; }
        public virtual CampaignStatus CampaignStatus { get; set; }
        public virtual CampaignType CampaignType { get; set; }
        public virtual Company Company { get; set; }
        public virtual Currency Currency { get; set; }
        public virtual Team Team { get; set; }
        public virtual TeamSet TeamSet { get; set; }
        public virtual User User { get; set; }
        public virtual ICollection<Lead> Leads { get; set; }
        public virtual ICollection<Opportunity> Opportunities { get; set; }
    }
}