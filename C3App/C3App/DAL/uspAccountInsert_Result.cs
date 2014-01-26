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
    
    public partial class uspAccountInsert_Result
    {
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
    }
}
