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
    public class BrandInfoAPIController : ApiController
    {
        private PayPointContext db = new PayPointContext();

        // GET api/BrandInfoAPI
        public IEnumerable<Brand> GetBrands()
        {
            return db.Brands.AsEnumerable();
        }

        // GET api/BrandInfoAPI/5
        public Brand GetBrand(int id)
        {
            Brand brand = db.Brands.Find(id);
            if (brand == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return brand;
        }

        // PUT api/BrandInfoAPI/5
        public HttpResponseMessage PutBrand(int id, Brand brand)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (id != brand.BrandId)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }

            db.Entry(brand).State = EntityState.Modified;

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

        // POST api/BrandInfoAPI
        public HttpResponseMessage PostBrand(Brand brand)
        {
            if (ModelState.IsValid)
            {
                db.Brands.Add(brand);
                db.SaveChanges();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created, brand);
                response.Headers.Location = new Uri(Url.Link("DefaultApi", new { id = brand.BrandId }));
                return response;
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }

        // DELETE api/BrandInfoAPI/5
        public HttpResponseMessage DeleteBrand(int id)
        {
            Brand brand = db.Brands.Find(id);
            if (brand == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }

            db.Brands.Remove(brand);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK, brand);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}