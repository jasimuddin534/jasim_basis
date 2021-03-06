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
    
    public partial class ACLAction
    {
        public long ACLID { get; set; }
        public Nullable<int> ModuleID { get; set; }
        public Nullable<int> FunctionID { get; set; }
        public Nullable<long> UserID { get; set; }
        public Nullable<int> RoleID { get; set; }
        public Nullable<bool> Access { get; set; }
        public Nullable<long> CreatedBy { get; set; }
        public System.DateTime CreatedTime { get; set; }
    
        public virtual ACLFunction ACLFunction { get; set; }
        public virtual Module Module { get; set; }
        public virtual ACLRole ACLRole { get; set; }
        public virtual User User { get; set; }
    }
}
