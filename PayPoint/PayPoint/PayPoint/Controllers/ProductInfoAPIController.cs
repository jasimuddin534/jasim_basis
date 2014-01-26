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
    //[Authorize(Roles = "Cashier")]
    //[Authorize(Roles = "Admins,Cashier")] 
    [Authorize]
    public class ProductInfoAPIController : ApiController
    {
        private PayPointContext db = new PayPointContext();

        public ProductInfoAPIController()
        {

            db.Configuration.ProxyCreationEnabled = false;
        }

        // GET api/ProductInfoAPI
        
        public IEnumerable<Product> GetProducts()
        {
            var products = db.Products.Where(b => b.Status == 0).AsEnumerable();
            return products;
        }

        // GET api/ProductInfoAPI/5
        public Product GetProduct(int id)
        {
            Product product = db.Products.Find(id);
            if (product == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return product;
        }

        public Product GetProduct(string sku)
        {
            Product product = db.Products.Where(b => b.SKU == sku).FirstOrDefault();
            if (product == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return product;
        }

        public int GetProductStock(string model, string brand, string category)
        {
            int stock = 0;
            var product = db.Products.Where(b => b.Model == model).ToList();
            if (product == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            stock = product.Count();
            return stock;
        }


        // PUT api/ProductInfoAPI/5
        public HttpResponseMessage PutProduct(int id, Product product)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (id != product.ProductId)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }

            product.CreatedBy = User.Identity.Name;
            db.Entry(product).State = EntityState.Modified;

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

        // POST api/ProductInfoAPI
        public HttpResponseMessage PostProduct(Product product)
        {
            if (ModelState.IsValid)
            {
                product.CreatedBy = User.Identity.Name;
                db.Products.Add(product);
                db.SaveChanges();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created, product);
                response.Headers.Location = new Uri(Url.Link("DefaultApi", new { id = product.ProductId }));
                return response;
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }

        // DELETE api/ProductInfoAPI/5
        public HttpResponseMessage DeleteProduct(int id)
        {
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }

            db.Products.Remove(product);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK, product);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}