using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class OrderRepository : IDisposable, IOrderRepository
    {
        private C3Entities context = new C3Entities();



        //public void InitalizeDataColumns()
        //{


        //}

        public IEnumerable<Order> GetOrders(int companyId)
        {
            var Orders = (context.Orders.Where(order => order.CompanyID == companyId && order.IsDeleted == false).
                OrderBy(order => order.Name)).Take(20);
            return Orders;
        }

        public IEnumerable<OrderStage> GetOrderStages()
        {
            return context.OrderStages.ToList();
        }
        public IEnumerable<PaymentTerm> GetPaymentTerms()
        {
            return context.PaymentTerms.ToList();
        }

        private bool disposevalue = false;
        public virtual void Dispose(bool disposing)
        {
            if (!this.disposevalue)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }
        }
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }


        public long InsertOrder(Order order)
        {
            try
            {


                order.CreatedTime = DateTime.Now;
                order.ModifiedTime = DateTime.Now;
                context.Entry(order).State = EntityState.Added;
                context.SaveChanges();
                return order.OrderID;
            }
            catch (OptimisticConcurrencyException ex)
            {

                throw ex;
            }
        }
        public long UpdateOrder(Order order)
        {
            try
            {

                var currentOrder = context.Orders.Find(order.OrderID);
                context.Entry(currentOrder).CurrentValues.SetValues(order);
                //order.ModifiedTime = DateTime.Now;
                // context.Entry(order).State=EntityState.Modified;

                SaveChanges();
                return order.OrderID;
            }
            catch (OptimisticConcurrencyException ex)
            {

                throw ex;
            }
        }
        public void DeleteOrder(Order order)
        {
            try
            {
                context.Orders.Attach(order);
                context.Entry(order).State = EntityState.Deleted;
                SaveChanges();
            }
            catch (OptimisticConcurrencyException ex)
            {

                throw ex;
            }
        }
        public IEnumerable<Order> OrderByID(long OrderID)
        {

            var Orders = (context.Orders.Where(order => order.OrderID == OrderID)).ToList();
            return Orders;

        }
        public IEnumerable<Order> SearchOrders(string search, int companyId)
        {
            if (String.IsNullOrWhiteSpace(search))
            {
                search = "";
            }

            var Orders = (context.Orders.Where(order => order.Name.Contains(search) && (order.IsDeleted == false) && (order.CompanyID == companyId))
                         ).ToList();

            return Orders;
        }

        public void DeleteById(long orderId)
        {
            Order orders = (context.Orders.Where(order => order.OrderID == orderId)
                           ).FirstOrDefault();
            orders.IsDeleted = true;
            try
            {
                context.Entry(orders).State = EntityState.Modified;
                SaveChanges();

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }



        public IEnumerable<OrderDetail> GetOrderDetails()
        {
            var Orders = (context.OrderDetails.Where(order => order.IsDeleted == false)).ToList();

            return Orders;

        }

        public void InsertOrderDetails(OrderDetail orderDetail)
        {
            try
            {
                orderDetail.CreatedTime = DateTime.Now;
                orderDetail.ModifiedTime = DateTime.Now;
                //context.Entry(orderDetail).State = EntityState.Added;
                //context.SaveChanges();
                context.Entry(orderDetail).State = orderDetail.OrderLineID == 0 ? EntityState.Added : EntityState.Modified;
                context.SaveChanges();
            }


            catch (OptimisticConcurrencyException ex)
            {

                throw ex;
            }

        }

        public void UpdateOrderDetails(OrderDetail orderDetail)
        {
            try
            {

                orderDetail.ModifiedTime = DateTime.Now;
                context.Entry(orderDetail).State = EntityState.Modified;
                SaveChanges();

            }
            catch (OptimisticConcurrencyException ex)
            {

                throw ex;
            }

        }

        public DataRow ProductsOrderDetail(IEnumerable<Product> products)
        {
            // this.InitalizeDataColumns();
            DataTable myDataTable = new DataTable();
            DataColumn myDataColumn = new DataColumn();
            myDataColumn.AllowDBNull = false;
            myDataColumn.AutoIncrement = true;
            myDataColumn.AutoIncrementSeed = 1;
            myDataColumn.AutoIncrementStep = 1;

            myDataColumn.ColumnName = "Quantity";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataColumn.Unique = true;
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Name";
            myDataColumn.DataType = System.Type.GetType("System.String");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "MftPartNum";
            myDataColumn.DataType = System.Type.GetType("System.Int32");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "CostPrice";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "ListPrice";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "UnitPrice";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "ExtendedPrice";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            myDataColumn = new DataColumn();
            myDataColumn.ColumnName = "Discount";
            myDataColumn.DataType = System.Type.GetType("System.Decimal");
            myDataTable.Columns.Add(myDataColumn);

            DataRow dataRow = myDataTable.NewRow();

            foreach (var product in products)
            {

                dataRow["Quantity"] = product.Quantity;
                dataRow["Name"] = product.Name;
                dataRow["MftPartNum"] = product.MFTPartNumber;
                dataRow["CostPrice"] = product.Cost;
                dataRow["ListPrice"] = product.ListPrice;
                //dataRow["UnitPrice"] = product.UnitPrice;
                dataRow["ExtendedPrice"] = "34";
                dataRow["Discount"] = "344";
                myDataTable.Rows.Add(dataRow);
            }
            return myDataTable.Rows[0];

        }

        public IEnumerable<Orders.Orders.CustomOrderDetails> GetOrderDetailsByID(long orderid)
        {
            //Orders.Orders.CustomOrderDetails customOrderDetails=new Orders.Orders.CustomOrderDetails();
            List<Orders.Orders.CustomOrderDetails> customOrderDetailses = new List<Orders.Orders.CustomOrderDetails>();
            var orderdetails = (context.OrderDetails.Where(orderDetail => orderDetail.OrderID == orderid && orderDetail.IsDeleted == false).
               Select(orderDetail => new
                                       {
                                           quantity = orderDetail.Quantity,
                                           productname = orderDetail.Product.Name,
                                           MftPartNum = orderDetail.Product.MFTPartNumber,
                                           cost = orderDetail.Cost,
                                           list = orderDetail.ListPrice,
                                           discount = orderDetail.Discount,
                                           note = orderDetail.Note,
                                           productid = orderDetail.ProductID,
                                           orderLineID = orderDetail.OrderLineID
                                       })).ToList();
            foreach (var od in orderdetails)
            {
                Orders.Orders.CustomOrderDetails customOrderDetails = new Orders.Orders.CustomOrderDetails();
                customOrderDetails.Quantity = od.quantity;
                customOrderDetails.MftPartNum = od.MftPartNum;
                customOrderDetails.Name = od.productname;
                customOrderDetails.Cost = od.cost;
                customOrderDetails.List = od.list;
                customOrderDetails.Discount = od.discount;
                customOrderDetails.Note = od.note;
                customOrderDetails.ProductID = od.productid;
                customOrderDetails.OrderLineID = od.orderLineID;
                customOrderDetailses.Add(customOrderDetails);

            }

            return customOrderDetailses;
        }
        public void SaveChanges()
        {

            bool saveFailed;

            do
            {

                saveFailed = false;

                try
                {

                    context.SaveChanges();

                }

                catch (DbUpdateConcurrencyException ex)
                {

                    saveFailed = true;



                    // Update the values of the entity that failed to save from the store

                    ex.Entries.Single().Reload();



                    // Update original values from the database

                    //var entry = ex.Entries.Single();

                    //entry.OriginalValues.SetValues(entry.GetDatabaseValues());

                }

            } while (saveFailed);

        }

        public bool ProductRowDelete(long orderLineId)
        {
            Int64 userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);

            var OrderDetails = (context.OrderDetails.Where(orderDetail => orderDetail.OrderLineID == orderLineId)).ToList();

            if (OrderDetails.Count() > 0)
            {
                OrderDetail orderDetail = (context.OrderDetails.Where(orderDetails => orderDetails.OrderLineID == orderLineId)).FirstOrDefault();
                orderDetail.IsDeleted = true;
                orderDetail.CreatedTime = DateTime.Now;
                orderDetail.ModifiedTime = DateTime.Now;
                orderDetail.ModifiedBy = userid;
                try
                {
                    context.Entry(orderDetail).State = EntityState.Modified;
                    SaveChanges();
                    return true;
                }
                catch (Exception ex)
                {

                    throw ex;
                }

            }
            else
            {
                return false;
            }





        }


        public IEnumerable<Order> GetLeadByContactID(string orderNumber, int companyid)
        {
            return context.Orders.Where(p => p.OrderNumber == orderNumber && p.CompanyID == companyid).ToList();

        }


        public IEnumerable<Order> ConvertOrderByID(long orderId)
        {
            var orders = (context.Orders.Where(order => order.OrderID == orderId && order.Converted == false)).ToList();
            return orders;
        }

        public void UpdateConvertOrder(long orderId)
        {
            Order order1 = (context.Orders.Single(order => order.OrderID == orderId));
            order1.Converted = true;
            context.SaveChanges();
        }

        public string GetOrderNumber(int companyId)
        {
            var Ordernumber = (context.Orders.Where(order => order.CompanyID == companyId).OrderByDescending(order => order.OrderID).Select(order => order.OrderNumber)).FirstOrDefault();
            return Ordernumber;
        }

        public bool ApproveOrder(long orderId)
        {
            bool msg = false;
            try
            {
                var order = (context.Orders.Where(order1 => order1.OrderID == orderId && order1.IsApproved == false)).FirstOrDefault();
                if (order != null)
                {
                    order.IsApproved = true;
                    context.SaveChanges();
                    msg = true;
                }

            }
            catch (Exception ec)
            {
                throw ec;
            }
            return msg;
        }

        public IEnumerable<OrderDetail> GetOrderDetailsByOrderID(long orderId)
        {
            var Orderdetails = (context.OrderDetails.Where(
                orderDetail => orderDetail.OrderID == orderId && orderDetail.IsDeleted == false)).ToList();
            return Orderdetails;
        }

        public IEnumerable<Order> SearchInvoiceOrders(int companyID, string search)
        {
            if (String.IsNullOrWhiteSpace(search))
            {
                search = "";
            }

            var Orders = (context.Orders.Where(order =>order.Name.Contains(search) && (order.IsDeleted == false) && order.Converted == false &&
                         order.CompanyID == companyID)).ToList();
            return Orders;

        }

        public IEnumerable<Order> GetApprovedOrders(int companyId)
        {
            var Orders = (context.Orders.Where(order => order.IsApproved == true && order.CompanyID == companyId && order.IsDeleted == false)).ToList();
            return Orders;
        }

        public IEnumerable<Order> GetUnApprovedOrders(int companyId)
        {
            var Orders = (context.Orders.Where(order => order.IsApproved == false && order.CompanyID == companyId && order.IsDeleted == false)).ToList();
            return Orders;
        }
    }
}
