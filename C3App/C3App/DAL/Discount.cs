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
    
    public partial class Discount
    {
        public Discount()
        {
            this.Products = new HashSet<Product>();
        }
    
        public int DiscountID { get; set; }
        public Nullable<int> CompanyID { get; set; }
        public string Name { get; set; }
        public Nullable<int> PricingFormulaID { get; set; }
        public Nullable<decimal> PricingFactor { get; set; }
        public byte[] Timestamp { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public Nullable<long> ModifiedBy { get; set; }
        public System.DateTime ModifiedTime { get; set; }
    
        public virtual ICollection<Product> Products { get; set; }
    }
}