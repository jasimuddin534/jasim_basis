using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using PayPoint.Models;

namespace PayPoint.Controllers
{
    [Authorize]
    public class OrderInfoAPIController : ApiController
    {
        private PayPointContext db = new PayPointContext();

        public OrderInfoAPIController()
        {

            db.Configuration.ProxyCreationEnabled = false;
        }

        // GET api/OrderInfoAPI
        public IEnumerable<Order> GetOrders()
        {
            return db.Orders.AsEnumerable();
        }

        // GET api/OrderInfoAPI/5
        public Order GetOrder(int id)
        {
            Order order = db.Orders.Find(id);
            if (order == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return order;
        }



        // GET api/OrderInfoAPI/distinct
        public IQueryable<string> GetOrder(string distinct)
        {
            var order = db.Orders.OrderByDescending(o => o.OrderId).Select(o => o.OrderNumber);
            if (order == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return order;
        }


        public List<Order> GetOrderList(string ordername)
        {
            var order = db.Orders.Where(b => b.OrderNumber == ordername).ToList();
            if (order == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return order;
        }


        public int GetUnqID(string ordernum)
        {

            int id = db.Orders.Select(o => o.OrderNumber).Distinct().Count();
            //if (id == null)
            //{
            //    throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            //}

            return id;


        }


        // PUT api/OrderInfoAPI/5
        public HttpResponseMessage PutOrder(int id, Order order)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (id != order.OrderId)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }

            db.Entry(order).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        // POST api/OrderInfoAPI
        public HttpResponseMessage PostOrder(Order order)
        {
            if (ModelState.IsValid)
            {
                order.CreatedBy = User.Identity.Name;
                db.Orders.Add(order);
                db.SaveChanges();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created, order);
                response.Headers.Location = new Uri(Url.Link("DefaultApi", new { id = order.OrderId }));
                return response;
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }

        // DELETE api/OrderInfoAPI/5
        public HttpResponseMessage DeleteOrder(int id)
        {
            Order order = db.Orders.Find(id);
            if (order == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }

            db.Orders.Remove(order);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK, order);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}