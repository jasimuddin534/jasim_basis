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
    
    public partial class uspOpportunityUpdate_Result
    {
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
    }
}
