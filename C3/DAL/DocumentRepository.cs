using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using C3App.DAL;

using System.Data.SqlClient;
using System.Configuration;
using System.Data.Entity.Infrastructure;
using System.Data.Objects;
using C3App.App_Code;


namespace C3App.DAL
{
    public class DocumentRepository : IDisposable, IDocumentRepository
    {
        public C3Entities context = new C3Entities();

        private bool disposevalue = false;

        public DocumentRepository()
        {

        }

        public IEnumerable<Document> GetDocuments(int companyID)
        {
            //return context.Documents.AsNoTracking().Where(c => c.CompanyID == companyID && c.IsDeleted == false).Take(20).ToList();

            var documents = (from document in context.Documents
                             where document.IsDeleted == false && document.CompanyID == companyID
                             select document).Take(20).ToList();
            try
            {
                return documents;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Document> GetDocumentByID(long documentID, int companyID)
        {
            var documents = (from document in context.Documents
                             where document.DocumentID == documentID && document.CompanyID == companyID
                             select document).ToList();
            try
            {
                return documents;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Document> GetDocumentByName(string nameSearchString, int companyID)
        {
            if (String.IsNullOrWhiteSpace(nameSearchString))
            {
                nameSearchString = "";
            }
            IEnumerable<Document> document = from d in context.Documents
                                             where ((d.Name.Contains(nameSearchString) && (d.CompanyID == companyID) && (d.IsDeleted == false)))
                                             select d;
            return document;
        }



        public IEnumerable<Document> GetMarketingDocuments(int companyID)
        {
            try
            {
                var documents = (from doc in context.Documents
                                 where doc.IsDeleted == false && doc.CompanyID == companyID && doc.CategoryID == 1
                                 select doc).ToList();
                return documents;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        

        public IEnumerable<Document> GetSalesDocuments(int companyID)
        {
            try
            {
                var documents = (from doc in context.Documents
                                 where doc.IsDeleted == false && doc.CompanyID == companyID && doc.CategoryID == 2
                                 select doc).ToList();
                return documents;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Document> GetOrderDocuments(int companyID)
        {
            try
            {
                var documents = (from doc in context.Documents
                                 where doc.IsDeleted == false && doc.CompanyID == companyID && doc.CategoryID == 3
                                 select doc).ToList();
                return documents;
            }
            catch (Exception ex) 
            {
                throw ex;
            }        
        }



        public IEnumerable<DocumentTemplate> GetDocumentTemplates()
        {
            try
            {
                return context.DocumentTemplates.ToList();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<DocumentSubcategory> GetDocumentSubcategories()
        {
            try
            {
                return context.DocumentSubcategories.ToList();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<DocumentStatus> GetDocumentStatuses()
        {
            try
            {
                return context.DocumentStatuses.ToList();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<DocumentCategory> GetDocumentCategories()
        {
            try
            {
                return context.DocumentCategories.ToList();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public long InsertOrUpdateDocument(Document document)
        {
            try
            {
                context.Entry(document).State = document.DocumentID == 0 ? EntityState.Added : EntityState.Modified;
                SaveChanges();
                return document.DocumentID;
            }
            catch (Exception ex) { throw ex; }
        }

        public void DeleteDocumentByID(long documentID)
        {

            Document document = context.Documents.Single(doc => doc.DocumentID == documentID);
            try
            {
                document.IsDeleted = true;
                SaveChanges();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public bool IsDocumentExists(long companyid, long documentid, string dName)
        {
            bool found = false;
            long docid = -1;

            var document = (from d in context.Documents
                            where ((d.Name == dName) && (d.CompanyID == companyid) && (d.DocumentID != documentid))
                            select d).FirstOrDefault();

            if (document != null)
                docid = document.DocumentID;

            if (docid != -1)
                found = true;

            return found;
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

    }
}