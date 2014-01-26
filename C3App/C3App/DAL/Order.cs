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
    
    public partial class Order
    {
        public Order()
        {
            this.Invoices = new HashSet<Invoice>();
            this.OrderDetails = new HashSet<OrderDetail>();
        }
    
        public long OrderID { get; set; }
        public int CompanyID { get; set; }
        public string Name { get; set; }
        public Nullable<long> OpportunityID { get; set; }
        public string OrderNumber { get; set; }
        public Nullable<int> OrderStageID { get; set; }
        public Nullable<decimal> PurchaseOrderNumber { get; set; }
        public Nullable<int> PaymentTermID { get; set; }
        public Nullable<System.DateTime> OrderDueDate { get; set; }
        public Nullable<System.DateTime> OrderShippedDate { get; set; }
        public Nullable<long> BillingAccountID { get; set; }
        public Nullable<long> BillingContactID { get; set; }
        public string BillingStreet { get; set; }
        public string BillingCity { get; set; }
        public string BillingState { get; set; }
        public string BillingZip { get; set; }
        public Nullable<int> BillingCountry { get; set; }
        public Nullable<long> ShippingAccountID { get; set; }
        public Nullable<long> ShippingContactID { get; set; }
        public string ShippingStreet { get; set; }
        public string ShippingCity { get; set; }
        public string ShippingState { get; set; }
        public string ShippingZip { get; set; }
        public Nullable<int> ShippingCountry { get; set; }
        public Nullable<int> CurrencyID { get; set; }
        public Nullable<decimal> ConversionRate { get; set; }
        public Nullable<decimal> TaxRate { get; set; }
        public string Shipper { get; set; }
        public Nullable<decimal> Subtotal { get; set; }
        public Nullable<decimal> Discount { get; set; }
        public Nullable<decimal> Shipping { get; set; }
        public Nullable<decimal> Tax { get; set; }
        public Nullable<decimal> Total { get; set; }
        public Nullable<bool> IsApproved { get; set; }
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
        public Nullable<bool> Converted { get; set; }
    
        public virtual Account Account { get; set; }
        public virtual Account Account1 { get; set; }
        public virtual Company Company { get; set; }
        public virtual Contact Contact { get; set; }
        public virtual Contact Contact1 { get; set; }
        public virtual Country Country { get; set; }
        public virtual Country Country1 { get; set; }
        public virtual Currency Currency { get; set; }
        public virtual ICollection<Invoice> Invoices { get; set; }
        public virtual Opportunity Opportunity { get; set; }
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
        public virtual OrderStage OrderStage { get; set; }
        public virtual PaymentTerm PaymentTerm { get; set; }
        public virtual Team Team { get; set; }
        public virtual User User { get; set; }
    }
}
