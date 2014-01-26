using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Web;
using System.Data;
using C3App.DAL;

namespace C3App.DAL
{
    public class InvoiceRepository : IInvoiceRepository
    {
        public C3Entities context = new C3Entities();

        //get invoice by yasin pavel
        public IEnumerable<Invoice> GetInvoices(int companyid)
        {
           var invoices = (context.Invoices.Where(
               invoice => invoice.CompanyID == companyid && invoice.IsDeleted == false).OrderBy(invoice => invoice.Name)).ToList();
           return invoices;
        }

        public IEnumerable<Invoice> GetInvoiceByID(long invoiceID, int companyID)
        {
            var invoices = from invoice in context.Invoices
                            where invoice.InvoiceID == invoiceID && invoice.IsDeleted == false && invoice.CompanyID == companyID
                            select invoice;
            return invoices;
        }

        public IEnumerable<Invoice> SearchInvoice(int companyID,string search)
        {
            if (String.IsNullOrWhiteSpace(search))
            {
                search = "";
            }
            
           return context.Invoices.Where(i => i.IsDeleted == false && i.CompanyID == companyID && i.Name.Contains(search)).ToList();
           
        }

        public long InsertInvoice(Invoice invoice)
        {
            try
            {
                context.Entry(invoice).State = EntityState.Added;
                SaveChanges();
                return invoice.InvoiceID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void UpdateInvoice(Invoice invoice)
        {
            try
            {
                var currentInvoice = context.Invoices.Find(invoice.InvoiceID);
                context.Entry(currentInvoice).CurrentValues.SetValues(invoice);
                SaveChanges();
            }
            catch (Exception ex)
            {
                throw ex;
            }
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

        public List<Invoice> GetInvoice(Invoice invoice)
        {
            var invoices = (from p in context.Invoices
                               where p.InvoiceNumber == invoice.InvoiceNumber && p.CompanyID==invoice.CompanyID
                               select p).ToList();
            return invoices;
        }

        public IEnumerable<InvoiceStage> GetInvoiceStages()
        {
            var invoiceStages = (from p in context.InvoiceStages select p).ToList();
            return invoiceStages;
        }

        public void DeleteInvoice(int companyID,long invoiceID)
        {
            Invoice invoices = (context.Invoices.Where(invoice => invoice.InvoiceID == invoiceID && invoice.CompanyID == companyID)).FirstOrDefault();
            try
            {
                if (invoices != null)
                {
                    invoices.IsDeleted = true;
                    context.Entry(invoices).State = EntityState.Modified;
                }
                SaveChanges();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<PaymentTerm> GetPaymentTerms()
        {
            var paymentTerms = (from paymentTerm in context.PaymentTerms select paymentTerm).ToList();
            try
            {
                return paymentTerms;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        private const bool disposevalue = false;

        public virtual void Dispose(bool disposing)
        {
            if (!disposevalue)
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

        public IEnumerable<InvoicePayTerm> GetInvoicePaymentTerms()
        {
            var query = (from p in context.InvoicePayTerms select p).ToList();
            return query;
        }

        public IEnumerable<Invoices.Invoices.CustomOrderDetails> GetCustomOrderDetails(long orderID)
        {
            List<Invoices.Invoices.CustomOrderDetails> customOrders=new List<Invoices.Invoices.CustomOrderDetails>();
            var orders = (from p in context.OrderDetails
                          where (p.OrderID == orderID) && (p.IsDeleted==false)
                          select new 
                                     {
                                        cost=p.Cost,
                                        listprice=p.ListPrice,
                                        discount=p.Discount,
                                        note=p.Note,
                                        quantity=p.Quantity,
                                        mftpartNum=p.Product.MFTPartNumber,
                                        productname=p.Product.Name
                                     }).ToList();

            foreach (var order in orders)
            {
                Invoices.Invoices.CustomOrderDetails customOrderDetails = new Invoices.Invoices.CustomOrderDetails();
                customOrderDetails.Cost = order.cost;
                customOrderDetails.Listprice = order.listprice;
                customOrderDetails.Discount = order.discount;
                customOrderDetails.Quantity = order.quantity;
                customOrderDetails.Note = order.note;
                customOrderDetails.Name = order.productname;
                customOrderDetails.MftPartNum = order.mftpartNum;
                customOrders.Add(customOrderDetails);
            }
            return customOrders;
        }

        public IEnumerable<Invoices.Invoices.BillingShippingDetails> GetBillingShippingDetails(long invoiceID, long orderID, int companyId)
        {
            List<Invoices.Invoices.BillingShippingDetails> billShipDetails = new List<Invoices.Invoices.BillingShippingDetails>();
            var invoices = GetInvoiceByID(invoiceID,companyId);
            var orders = (from p in context.Orders
                          where (p.OrderID == orderID) && (p.IsDeleted == false)
                          select new
                          {
                              billaccountname = p.Account.Name,
                              billcontactname = p.Contact.FirstName,
                              billstreet = p.BillingStreet,
                              billcity = p.BillingCity,
                              billstate = p.BillingState,
                              billpostal=p.BillingZip,
                              billcountry = p.BillingCountry,
                              shipaccountname = p.Account1.Name,
                              shipcontactname = p.Contact.FirstName,
                              shipstreet = p.ShippingStreet,
                              shipcity = p.BillingCity,
                              shipstate = p.ShippingState,
                              shippostal = p.ShippingZip,
                              shipcountry = p.ShippingCountry,
                              total=p.Total,
                              subtotal=p.Subtotal,
                              tax=p.Tax,
                              taxrate=p.TaxRate,
                              conversionrate=p.ConversionRate,
                              shipper=p.Shipper,
                              description=p.Description,
                              currency=p.CurrencyID,
                              shipping=p.Shipping,
                              discount=p.Discount
                          }).ToList();

            foreach (var order in orders)
            {
                Invoices.Invoices.BillingShippingDetails billingShippingDetails = new Invoices.Invoices.BillingShippingDetails();
                billingShippingDetails.BillingAccountName = order.billaccountname;
                billingShippingDetails.BillingContactName = order.billcontactname;
                billingShippingDetails.BillingStreet = order.billstreet;
                billingShippingDetails.BillingCity = order.billcity;
                billingShippingDetails.BillingState = order.billstate;
                billingShippingDetails.BillingPostalCode = order.billpostal;
                int billcountryID =Convert.ToInt16(order.billcountry);
                string bilcountryname=GetCountry(billcountryID);
                billingShippingDetails.BillingCountry = bilcountryname;
                billingShippingDetails.ShipingAccountName = order.shipaccountname;
                billingShippingDetails.ShipingContactName = order.shipcontactname;
                billingShippingDetails.ShipingStreet = order.shipstreet;
                billingShippingDetails.ShipingCity = order.shipcity;
                billingShippingDetails.ShipingState = order.shipstate;
                billingShippingDetails.ShipingPostalCode = order.shippostal;
                int shipcountryID =Convert.ToInt16(order.shipcountry);
                string shipcountryname=GetCountry(shipcountryID);
                billingShippingDetails.ShipingCountry = shipcountryname;
                int currencyID =Convert.ToInt16(order.currency);
                string currencyname = GetCurrencyName(currencyID);
                billingShippingDetails.Currency =currencyname;
                billingShippingDetails.Tax = order.tax;
                foreach (var invoice in invoices)
                {
                    billingShippingDetails.AmountDue = invoice.AmountDue;
                    if (billingShippingDetails.AmountDue==null)
                    {
                        billingShippingDetails.AmountDue = 0;
                    }
                }
                billingShippingDetails.TaxRate = order.taxrate;
                billingShippingDetails.SubTotal = order.subtotal;
                billingShippingDetails.Total = order.total;
                billingShippingDetails.Description = order.description;
                billingShippingDetails.Shipping = order.shipping;
                if (order.discount == null)
                {
                    billingShippingDetails.Discount = "0";
                }
                else
                {
                    billingShippingDetails.Discount = order.discount.ToString();
                }
                billingShippingDetails.AmountPaid = billingShippingDetails.Total - billingShippingDetails.AmountDue;
                billShipDetails.Add(billingShippingDetails);
            }
            return billShipDetails;
        }


        public string GetCountry(int country)
        {
            string targetcountry = string.Empty;

            var query = from p in context.Countries
                        where (p.CountryID == country)
                        select p.CountryName;

            if (query.Any())
            {
                foreach (var q in query)
                {
                    targetcountry = q;
                }
                return targetcountry;
            }
            else
                return "None";
        }

        public string GetCurrencyName(int currencyID)
        {
            string name = string.Empty;

            var query = (from p in context.Currencies where (p.CurrencyID == currencyID) select p.Name);

            if (query.Any())
            {
                foreach (string q in query)
                {
                    name = q;
                }
                return name;
            }
            else
                return string.Empty;
        }

        // get last invoice number
        public string GetInvoiceNumber(int companyID)
        {
            var invoicenumber = (from invoice in context.Invoices
                                where invoice.CompanyID == companyID && invoice.IsDeleted == false
                                orderby invoice.InvoiceID descending
                                select invoice.InvoiceNumber).FirstOrDefault();
            return invoicenumber; 
        }
    }
}