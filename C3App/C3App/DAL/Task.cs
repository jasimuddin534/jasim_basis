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
    
    public partial class Task
    {
        public long TaskID { get; set; }
        public int CompanyID { get; set; }
        public string Subject { get; set; }
        public Nullable<int> StatusID { get; set; }
        public string Priority { get; set; }
        public Nullable<System.DateTime> DueDate { get; set; }
        public Nullable<System.DateTime> StartDate { get; set; }
        public string ParentType { get; set; }
        public Nullable<long> ParentID { get; set; }
        public Nullable<long> ContactID { get; set; }
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
    
        public virtual Company Company { get; set; }
        public virtual Contact Contact { get; set; }
        public virtual User User { get; set; }
        public virtual User User1 { get; set; }
        public virtual User User2 { get; set; }
        public virtual TaskStatus TaskStatus { get; set; }
        public virtual Team Team { get; set; }
    }
}
