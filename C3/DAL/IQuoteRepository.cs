using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IQuoteRepository
    {
        IEnumerable<Quote> GetQuotes(int companyId);
        IEnumerable<QuoteStage> GetQuoteStages();
        IEnumerable<PaymentTerm> GetPaymentTerms();
        long InsertQuote(Quote quote);
        long UpdateQuote(Quote quote);
        void DeleteQuote(Quote quote);
        IEnumerable<Quote> QuoteByID(long quoteID);
        IEnumerable<Quote> SearchQuotes(string search, int companyId);
        void DeleteById(long quoteId);
        IEnumerable<QuoteDetail> GetQuoteDetails();
        void InsertQuoteDetails(QuoteDetail quoteDetail);
        void UpdateQuoteDetails(QuoteDetail quoteDetail);
        DataRow ProductsQuoteDetail(IEnumerable<Product> products);
        IEnumerable<Quotes.Quotes.CustomQuoteDetails> GetQuoteDetailsByID(long quoteid);
        void SaveChanges();
        bool ProductRowDelete(long quoteLineId);
        IEnumerable<Quote> GetLeadByContactID(string quoteNumber, int companyid);
        IEnumerable<Quote> ConvertQuoteByID(long quoteId);
        void UpdateConvertQuote(long quoteId);
        string GetQuoteNumber(int companyId);
        bool ApproveQuote(long quoteId);
        IEnumerable<QuoteDetail> GetQuoteDetailsByQuoteID(long quoteId);
        IEnumerable<Quote> SearchInvoiceQuotes(int companyID, string search);
        IEnumerable<Quote> GetApprovedQuotes(int companyId);
        IEnumerable<Quote> GetUnApprovedQuotes(int companyId);
    }
}
