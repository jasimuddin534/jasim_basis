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
    
    public partial class uspProductUpdate_Result
    {
        public long ProductID { get; set; }
        public int CompanyID { get; set; }
        public string SKU { get; set; }
        public string Name { get; set; }
        public Nullable<int> StatusID { get; set; }
        public Nullable<int> CategoryID { get; set; }
        public string Website { get; set; }
        public Nullable<System.DateTime> DateAvailable { get; set; }
        public Nullable<int> Quantity { get; set; }
        public Nullable<int> ManufacturerID { get; set; }
        public string Weight { get; set; }
        public string Color { get; set; }
        public string Location { get; set; }
        public string MFTPartNumber { get; set; }
        public string VendorPartNumber { get; set; }
        public Nullable<int> TypeID { get; set; }
        public Nullable<int> MinimumOptions { get; set; }
        public Nullable<int> MaximumOptions { get; set; }
        public Nullable<decimal> Cost { get; set; }
        public Nullable<decimal> ListPrice { get; set; }
        public Nullable<int> DiscountID { get; set; }
        public Nullable<decimal> DiscountPrice { get; set; }
        public Nullable<int> PricingFormulaID { get; set; }
        public string PricingFactor { get; set; }
        public string SupportName { get; set; }
        public string SupportContact { get; set; }
        public string SupportTerm { get; set; }
        public string SupportDescription { get; set; }
        public string Description { get; set; }
        public Nullable<int> RecordID { get; set; }
        public byte[] Timestamp { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public Nullable<long> ModifiedBy { get; set; }
        public System.DateTime ModifiedTime { get; set; }
    }
}
