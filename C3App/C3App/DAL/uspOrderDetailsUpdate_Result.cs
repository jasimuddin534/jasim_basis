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
    
    public partial class uspOrderDetailsUpdate_Result
    {
        public long OrderLineID { get; set; }
        public long OrderID { get; set; }
        public Nullable<long> ProductID { get; set; }
        public Nullable<int> Quantity { get; set; }
        public Nullable<decimal> Cost { get; set; }
        public Nullable<decimal> ListPrice { get; set; }
        public Nullable<decimal> Discount { get; set; }
        public string Note { get; set; }
        public Nullable<int> RecordID { get; set; }
        public byte[] Timestamp { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public Nullable<long> ModifiedBy { get; set; }
        public System.DateTime ModifiedTime { get; set; }
    }
}
