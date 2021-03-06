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
    
    public partial class Invoice
    {
        public Invoice()
        {
            this.Payments = new HashSet<Payment>();
        }
    
        public long InvoiceID { get; set; }
        public int CompanyID { get; set; }
        public string Name { get; set; }
        public Nullable<long> OpportunityID { get; set; }
        public string InvoiceNumber { get; set; }
        public Nullable<int> InvoiceStageID { get; set; }
        public Nullable<long> OrderID { get; set; }
        public Nullable<decimal> AmountDue { get; set; }
        public string PurchaseOrderNum { get; set; }
        public Nullable<System.DateTime> DueDate { get; set; }
        public Nullable<int> PaymentTermID { get; set; }
        public Nullable<long> AssignedUserID { get; set; }
        public Nullable<long> TeamID { get; set; }
        public Nullable<int> RecordID { get; set; }
        public byte[] Timestamp { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public Nullable<long> ModifiedBy { get; set; }
        public System.DateTime ModifiedTime { get; set; }
    
        public virtual Company Company { get; set; }
        public virtual InvoicePayTerm InvoicePayTerm { get; set; }
        public virtual InvoiceStage InvoiceStage { get; set; }
        public virtual Opportunity Opportunity { get; set; }
        public virtual Order Order { get; set; }
        public virtual Team Team { get; set; }
        public virtual User User { get; set; }
        public virtual ICollection<Payment> Payments { get; set; }
    }
}
