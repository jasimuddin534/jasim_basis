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
    
    public partial class uspNotificationInsert_Result
    {
        public long NotificationID { get; set; }
        public int CompanyID { get; set; }
        public Nullable<int> NotificationTypeID { get; set; }
        public Nullable<int> Status { get; set; }
        public string ParentType { get; set; }
        public Nullable<long> ParentID { get; set; }
        public byte[] Timestamp { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
    }
}
