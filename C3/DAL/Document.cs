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
    
    public partial class Document
    {
        public long DocumentID { get; set; }
        public int CompanyID { get; set; }
        public string Name { get; set; }
        public string FilePath { get; set; }
        public Nullable<System.DateTime> ActiveDate { get; set; }
        public Nullable<System.DateTime> ExpiryDate { get; set; }
        public Nullable<int> CategoryID { get; set; }
        public Nullable<int> SubcategoryID { get; set; }
        public Nullable<int> StatusID { get; set; }
        public string Revision { get; set; }
        public Nullable<int> TemplateID { get; set; }
        public string Description { get; set; }
        public Nullable<long> AssignedUserID { get; set; }
        public Nullable<long> TeamID { get; set; }
        public Nullable<int> RecordID { get; set; }
        public byte[] Timestamp { get; set; }
        public Nullable<bool> IsTemplate { get; set; }
        public bool IsDeleted { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
        public Nullable<long> ModifiedBy { get; set; }
        public System.DateTime ModifiedTime { get; set; }
    
        public virtual Company Company { get; set; }
        public virtual DocumentCategory DocumentCategory { get; set; }
        public virtual DocumentStatus DocumentStatus { get; set; }
        public virtual DocumentSubcategory DocumentSubcategory { get; set; }
        public virtual DocumentTemplate DocumentTemplate { get; set; }
        public virtual Team Team { get; set; }
        public virtual User User { get; set; }
    }
}
