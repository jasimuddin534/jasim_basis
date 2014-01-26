using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PayPoint.Models
{
    public class Product
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public string SKU { get; set; }
        public string Category { get; set; }
        public string Brand { get; set; }
        public string Model { get; set; }
        public string SerialNumber { get; set; }
        public string IMEI1 { get; set; }
        public string IMEI2 { get; set; }
        public string BarCode { get; set; }
        public string ProductCode { get; set; }
        public string ProductType { get; set; }
        public decimal? CostPrice { get; set; }
        public decimal? UnitPrice { get; set; }
        public decimal? Quantity { get; set; }
        public int? Status { get; set; }
        public DateTime? StockUpdate { get; set; }
        public DateTime? StockSold { get; set; } 
        public string CreatedBy { get; set; }
       
    }
}