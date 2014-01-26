using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class QuoteBL
    {
        private readonly IQuoteRepository quoteRepository;
        InvoiceRepository invoiceRepository = new InvoiceRepository();

        public QuoteBL()
        {
            this.quoteRepository = new QuoteRepository();
        }

        public IEnumerable<Quote> GetQuotes()
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return quoteRepository.GetQuotes(companyid);
        }

        public IEnumerable<QuoteStage> GetQuoteStages()
        {
            return quoteRepository.GetQuoteStages();
        }
        public IEnumerable<PaymentTerm> GetPaymentTerms()
        {
            return quoteRepository.GetPaymentTerms();
        }

        public long InsertQuote(Quote Quote)
        {
            ValidateQuote(Quote);
            try
            {
                return quoteRepository.InsertQuote(Quote);

            }
            catch (Exception ex)
            {

                throw ex;
            }
        }

        private void ValidateQuote(Quote Quote)
        {
            if (Quote.QuoteNumber != null)
            {
                int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                var duplicateQuote = quoteRepository.GetLeadByContactID(Quote.QuoteNumber, companyid).FirstOrDefault();
                if (duplicateQuote != null && duplicateQuote.QuoteID != Quote.QuoteID)
                {
                    if (duplicateQuote.QuoteNumber == Quote.QuoteNumber)
                    {
                        throw new DuplicateLeadException(String.Format(
                        "Quote Number {0} is already exist",
                        duplicateQuote.QuoteNumber
                        ));
                    }
                    //else if(Quote.Name==null && Quote.QuoteNumber==null) 

                    //{
                    //    throw new DuplicateLeadException(String.Format(
                    //   "A Quote can't create without a product, Select a product"

                    //   ));
                    //}

                }
            }
            else
            {
                throw new DuplicateLeadException(String.Format(
                    "A Quote can't create without a product, Select a product"
                                                     ));
            }
        }

        public long UpdateQuote(Quote Quote)
        {
            ValidateQuote(Quote);
            try
            {
                return quoteRepository.UpdateQuote(Quote);

            }
            catch (Exception ec)
            {

                throw ec;
            }
        }
        public void DeleteQuote(Quote Quote)
        {
            quoteRepository.DeleteQuote(Quote);
        }
        public IEnumerable<Quote> QuoteByID(long QuoteID)
        {
            return quoteRepository.QuoteByID(QuoteID);
        }
        public IEnumerable<Quote> SearchQuotes(string search)
        {
            int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return quoteRepository.SearchQuotes(search, companyId);
        }

        public void DeleteById(long QuoteId)
        {
            quoteRepository.DeleteById(QuoteId);
        }
        public IEnumerable<QuoteDetail> GetQuoteDetails()
        {
            return quoteRepository.GetQuoteDetails();
        }
        public void InsertQuoteDetails(QuoteDetail QuoteDetail)
        {
            quoteRepository.InsertQuoteDetails(QuoteDetail);
        }
        public void UpdateQuoteDetails(QuoteDetail QuoteDetail)
        {
            quoteRepository.UpdateQuoteDetails(QuoteDetail);
        }

        public DataRow ProductsQuoteDetail(IEnumerable<Product> products)
        {
            return quoteRepository.ProductsQuoteDetail(products);
        }

        public IEnumerable<Quotes.Quotes.CustomQuoteDetails> GetQuoteDetailsByID(long Quoteid)
        {
            return quoteRepository.GetQuoteDetailsByID(Quoteid);
        }

        public bool ProductRowDelete(long QuoteLineId)
        {
            return quoteRepository.ProductRowDelete(QuoteLineId);

        }


        public IEnumerable<Quote> ConvertQuoteByID(long QuoteId)
        {
            return quoteRepository.ConvertQuoteByID(QuoteId);
        }

        public long QuoteToInvoiceInsert(Invoice invoice)
        {
            return invoiceRepository.InsertInvoice(invoice);

        }

        public void UpdateConvertQuote(long QuoteId)
        {
            quoteRepository.UpdateConvertQuote(QuoteId);

        }

        //public string GetInvoiceNumber()
        //{
        //    return invoiceRepository.GetInvoiceNumber();
        //}

        public string GetQuoteNumber()
        {
            int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return quoteRepository.GetQuoteNumber(companyId);
        }

        public bool ApproveQuote(long QuoteId)
        {
            return quoteRepository.ApproveQuote(QuoteId);
        }
        public IEnumerable<QuoteDetail> GetQuoteDetailsByQuoteID(long QuoteID)
        {
            return quoteRepository.GetQuoteDetailsByQuoteID(QuoteID);
        }
        //public IEnumerable<Quote>  GetUnconvertedQuotes()
        //{
        //    int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
        //    return QuoteRepository.GetUnconvertedQuotes(companyId);
        //}
        public IEnumerable<Quote> SearchInvoiceQuotes(string search)
        {
            int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return quoteRepository.SearchInvoiceQuotes(companyId, search);
        }

        public IEnumerable<Quote> GetApprovedQuotes()
        {
            int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return quoteRepository.GetApprovedQuotes(companyId);
        }
        public IEnumerable<Quote> GetUnApprovedQuotes()
        {
            int companyId = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return quoteRepository.GetUnApprovedQuotes(companyId);
        }


    }
    public class DuplicateQuoteException : Exception
    {
        public DuplicateQuoteException(string message)
            : base(message)
        {
        }
    }
}