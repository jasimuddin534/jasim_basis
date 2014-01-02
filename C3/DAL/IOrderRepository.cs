using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IOrderRepository:IDisposable
    {
         IEnumerable<Order> GetOrders(int companyId);
         IEnumerable<OrderStage> GetOrderStages();
         IEnumerable<PaymentTerm> GetPaymentTerms();
         long InsertOrder(Order order);
         long UpdateOrder(Order order);
         void DeleteOrder(Order order);
         IEnumerable<Order> OrderByID(long OrderID);
         IEnumerable<Order> SearchOrders(string search, int companyId);
         void DeleteById(long orderId);
         IEnumerable<OrderDetail> GetOrderDetails();
         void InsertOrderDetails(OrderDetail orderDetail);
         void UpdateOrderDetails(OrderDetail orderDetail);
         DataRow ProductsOrderDetail(IEnumerable<Product> products);
         IEnumerable<Orders.Orders.CustomOrderDetails> GetOrderDetailsByID(long orderid);
         void SaveChanges();
         bool ProductRowDelete(long orderLineId);
         IEnumerable<Order> GetLeadByContactID(string orderNumber, int companyid);
         IEnumerable<Order> ConvertOrderByID(long orderId);
         void UpdateConvertOrder(long orderId);
         string GetOrderNumber(int companyId);
         bool ApproveOrder(long orderId);
         IEnumerable<OrderDetail> GetOrderDetailsByOrderID(long orderId);
         IEnumerable<Order> SearchInvoiceOrders(int companyID, string search);
        IEnumerable<Order> GetApprovedOrders(int companyId);
        IEnumerable<Order> GetUnApprovedOrders(int companyId);
    }
}
