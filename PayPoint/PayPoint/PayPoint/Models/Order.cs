using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PayPoint.Models
{
    public class Order
    {
        public int OrderId { get; set; }
        public string OrderNumber { get; set; }
        public string Item { get; set; }
        public string BarCode { get; set; }
        public decimal? Quantity { get; set; }
        public decimal? VAT { get; set; }
        public decimal? Discount { get; set; }
        public decimal? Price { get; set; }
        public decimal? AmountReceived { get; set; }
        public string Status { get; set; }
        public string PaymentType { get; set; }
        public DateTime? CreatedTime { get; set; }
        public string CreatedBy { get; set; }
    }
}