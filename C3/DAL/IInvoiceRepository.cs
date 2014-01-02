using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IInvoiceRepository
    {
        IEnumerable<Invoice> GetInvoices(int companyID);
        IEnumerable<Invoice> GetInvoiceByID(long invoiceID, int companyID);
        IEnumerable<Invoice> SearchInvoice(int companyID,string search);
        IEnumerable<PaymentTerm> GetPaymentTerms();
        IEnumerable<InvoiceStage> GetInvoiceStages();
        long InsertInvoice(Invoice invoice);
        void UpdateInvoice(Invoice invoice);
        void DeleteInvoice(int companyID,long invoiceID);
        IEnumerable<InvoicePayTerm> GetInvoicePaymentTerms();
        IEnumerable<Invoices.Invoices.CustomOrderDetails> GetCustomOrderDetails(long orderID);
        IEnumerable<Invoices.Invoices.BillingShippingDetails> GetBillingShippingDetails(long invoiceID, long orderID, int companyId);
        List<Invoice> GetInvoice(Invoice invoice);
        string GetInvoiceNumber(int companyID);
    }
}
