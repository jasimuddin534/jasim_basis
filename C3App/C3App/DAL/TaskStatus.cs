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
    
    public partial class TaskStatus
    {
        public TaskStatus()
        {
            this.Tasks = new HashSet<Task>();
        }
    
        public int TaskStatusID { get; set; }
        public string Value { get; set; }
        public Nullable<int> ExtensionID { get; set; }
    
        public virtual ICollection<Task> Tasks { get; set; }
    }
}
