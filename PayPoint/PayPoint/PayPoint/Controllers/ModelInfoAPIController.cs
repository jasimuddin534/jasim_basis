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
    public class ModelInfoAPIController : ApiController
    {
        private PayPointContext db = new PayPointContext();

        // GET api/ModelInfoAPI
        public IEnumerable<Model> GetModels()
        {
            return db.Models.AsEnumerable();
        }

        // GET api/ModelInfoAPI/5
        public Model GetModel(int id)
        {
            Model model = db.Models.Find(id);
            if (model == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return model;
        }

        // PUT api/ModelInfoAPI/5
        public HttpResponseMessage PutModel(int id, Model model)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (id != model.ModelId)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }

            db.Entry(model).State = EntityState.Modified;

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

        // POST api/ModelInfoAPI
        public HttpResponseMessage PostModel(Model model)
        {
            if (ModelState.IsValid)
            {
                db.Models.Add(model);
                db.SaveChanges();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created, model);
                response.Headers.Location = new Uri(Url.Link("DefaultApi", new { id = model.ModelId }));
                return response;
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }

        // DELETE api/ModelInfoAPI/5
        public HttpResponseMessage DeleteModel(int id)
        {
            Model model = db.Models.Find(id);
            if (model == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }

            db.Models.Remove(model);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK, model);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}