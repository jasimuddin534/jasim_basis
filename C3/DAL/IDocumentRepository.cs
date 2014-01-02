using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IDocumentRepository : IDisposable
    {
        IEnumerable<Document> GetDocuments(int companyID);
        IEnumerable<Document> GetDocumentByName(string nameSearchString, int companyID);
        IEnumerable<Document> GetDocumentByID(long documentID, int companyID);

        IEnumerable<Document> GetMarketingDocuments(int companyID);
        IEnumerable<Document> GetSalesDocuments(int companyID);
        IEnumerable<Document> GetOrderDocuments(int companyID);

        long InsertOrUpdateDocument(Document document);
        void DeleteDocumentByID(long documentID);
        bool IsDocumentExists(long companyid, long documentid, string dName);


        IEnumerable<DocumentTemplate> GetDocumentTemplates();
        IEnumerable<DocumentSubcategory> GetDocumentSubcategories();
        IEnumerable<DocumentStatus> GetDocumentStatuses();
        IEnumerable<DocumentCategory> GetDocumentCategories();
    }
}
