using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using C3App.DAL;

namespace C3App.BLL
{
    public class DocumentBL
    {
        private IDocumentRepository documentRepository;
        private ITeamRepository teamRepository;
        private IUserRepository userRepository;

        public DocumentBL()
        {
            this.documentRepository = new DocumentRepository();
            this.teamRepository = new TeamRepository();
            this.userRepository = new UserRepository();
        }

        public IEnumerable<Document> GetDocuments()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return documentRepository.GetDocuments(companyID);
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<Document> GetDocumentByName(string nameSearchString)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return documentRepository.GetDocumentByName(nameSearchString, companyID);
            }
            catch (Exception e)
            {
                throw e;
            }


        }

        public IEnumerable<Document> GetDocumentByID(long documentID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return documentRepository.GetDocumentByID(documentID, companyID);
            }
            catch (Exception e)
            {
                throw e;
            }


        }


        public IEnumerable<Document> GetMarketingDocuments()
        {
            try
            {
                int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                return documentRepository.GetMarketingDocuments(companyID);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        public IEnumerable<Document> GetSalesDocuments()
        {
            try
            {
                int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                return documentRepository.GetSalesDocuments(companyID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Document> GetOrderDocuments()
        {
            try
            {
                int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                return documentRepository.GetOrderDocuments(companyID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public long InsertDocument(Document document)
        {
            ValidateDocument(document);
            try
            {
                return documentRepository.InsertOrUpdateDocument(document);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public long UpdateDocument(Document document)
        {
            ValidateDocument(document);
            try
            {
                return documentRepository.InsertOrUpdateDocument(document);
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public void DeleteDocumentByID(long documentID)
        {
            try
            {
                documentRepository.DeleteDocumentByID(documentID);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<DocumentTemplate> GetDocumentTemplates()
        {
            try
            {
                return documentRepository.GetDocumentTemplates();
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
                return documentRepository.GetDocumentSubcategories();
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
                return documentRepository.GetDocumentStatuses();
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
                return documentRepository.GetDocumentCategories();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        private void ValidateDocument(Document document)
        {
            long companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            long documentid = document.DocumentID;
            string dName = document.Name;

            bool oneDocument = documentRepository.IsDocumentExists(companyid, documentid, dName);


            if (oneDocument == true)
            {
                throw new DuplicateDocumentException(String.Format("Document Name {0} already exists. Please try another one.", dName));
            }
            else if (document.FilePath == String.Empty)
            {
                throw new DuplicateDocumentException(String.Format("File Upload is Required , Please Select File and Upload it."));
            }
        }

    }

    public class DuplicateDocumentException : Exception
    {
        public DuplicateDocumentException(string message)
            : base(message)
        {
        }
    }
}