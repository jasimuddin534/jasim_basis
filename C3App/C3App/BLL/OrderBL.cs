using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class OrderBL
    {
        private readonly IOrderRepository orderRepository;
        InvoiceRepository invoiceRepository = new InvoiceRepository();

        public OrderBL()
        {
           this.orderRepository = new OrderRepository();
        }

        public IEnumerable<Order> GetOrders()
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return orderRepository.GetOrders(companyid);
        }

        public IEnumerable<OrderStage> GetOrderStages()
        {
            return orderRepository.GetOrderStages();
        }
        public IEnumerable<PaymentTerm> GetPaymentTerms()
        {
            return orderRepository.GetPaymentTerms();
        }

        public long InsertOrder(Order order)
        {
            ValidateOrder(order);
            try
            {
                return orderRepository.InsertOrder(order);

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void ValidateOrder(Order order)
        {
            if (order.OrderNumber != null)
            {
                int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                var duplicateOrder = orderRepository.GetLeadByContactID(order.OrderNumber, companyid).FirstOrDefault();
                if (duplicateOrder != null && duplicateOrder.OrderID != order.OrderID)
                {
                    if (duplicateOrder.OrderNumber == order.OrderNumber)
                    {
                        throw new DuplicateLeadException(String.Format(
                        "Order Number {0} is already exist",
                        duplicateOrder.OrderNumber
                        ));
                    }
                    //else if(order.Name==null && order.OrderNumber==null) 

                    //{
                    //    throw new DuplicateLeadException(String.Format(
                    //   "A Order can't create without a product, Select a product"

                    //   ));
                    //}

                }
            }
            else
            {
                throw new DuplicateLeadException(String.Format(
                    "A Order can't create without a product, Select a product"
                                                     ));
            }
        }

        public long UpdateOrder(Order order)
        {
            ValidateOrder(order);
            try
            {
                return orderRepository.UpdateOrder(order);

            }
            catch (Exception ec)
            {

                throw ec;
            }
        }
        public void DeleteOrder(Order order)
        {
            orderRepository.DeleteOrder(order);
        }
        public IEnumerable<Order> OrderByID(long OrderID)
        {
            return orderRepository.OrderByID(OrderID);
        }
        public IEnumerable<Order> SearchOrders(string search)
        {
            int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return orderRepository.SearchOrders(search, companyId);
        }

        public void DeleteById(long orderId)
        {
            orderRepository.DeleteById(orderId);
        }
        public IEnumerable<OrderDetail> GetOrderDetails()
        {
            return orderRepository.GetOrderDetails();
        }
        public void InsertOrderDetails(OrderDetail orderDetail)
        {
            orderRepository.InsertOrderDetails(orderDetail);
        }
        public void UpdateOrderDetails(OrderDetail orderDetail)
        {
            orderRepository.UpdateOrderDetails(orderDetail);
        }

        public DataRow ProductsOrderDetail(IEnumerable<Product> products)
        {
            return orderRepository.ProductsOrderDetail(products);
        }

        public IEnumerable<Orders.Orders.CustomOrderDetails> GetOrderDetailsByID(long orderid)
        {
            return orderRepository.GetOrderDetailsByID(orderid);
        }

        public bool ProductRowDelete(long orderLineId)
        {
            return orderRepository.ProductRowDelete(orderLineId);

        }


        public IEnumerable<Order> ConvertOrderByID(long orderId)
        {
            return orderRepository.ConvertOrderByID(orderId);
        }

        public long OrderToInvoiceInsert(Invoice invoice)
        {
            return invoiceRepository.InsertInvoice(invoice);

        }

        public void UpdateConvertOrder(long orderId)
        {
            orderRepository.UpdateConvertOrder(orderId);

        }

        //public string GetInvoiceNumber()
        //{
        //    return invoiceRepository.GetInvoiceNumber();
        //}

        public string GetOrderNumber()
        {
            int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return orderRepository.GetOrderNumber(companyId);
        }

        public bool ApproveOrder(long orderId)
        {
            return orderRepository.ApproveOrder(orderId);
        }
        public IEnumerable<OrderDetail> GetOrderDetailsByOrderID(long OrderID)
        {
            return orderRepository.GetOrderDetailsByOrderID(OrderID);
        }
        //public IEnumerable<Order>  GetUnconvertedOrders()
        //{
        //    int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
        //    return orderRepository.GetUnconvertedOrders(companyId);
        //}
        public IEnumerable<Order> SearchInvoiceOrders(string search)
        {
            int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return orderRepository.SearchInvoiceOrders(companyId, search);
        }

        public IEnumerable<Order> GetApprovedOrders()
        {
            int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return orderRepository.GetApprovedOrders(companyId);
        }
        public IEnumerable<Order> GetUnApprovedOrders()
        {
            int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return orderRepository.GetUnApprovedOrders(companyId);
        }


    }
    public class DuplicateOrderException : Exception
    {
        public DuplicateOrderException(string message)
            : base(message)
        {
        }
    }
}