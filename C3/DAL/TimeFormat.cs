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
    
    public partial class TimeFormat
    {
        public TimeFormat()
        {
            this.Companies = new HashSet<Company>();
        }
    
        public int TimeFormatID { get; set; }
        public string Value { get; set; }
    
        public virtual ICollection<Company> Companies { get; set; }
    }
}
