using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using C3App.DAL;

namespace C3App.BLL
{
    public class InvoiceBL
    {
        private IInvoiceRepository invoiceRepository;
        private ITeamRepository teamRepository;
        private IUserRepository userRepository;
        private IOpportunityRepository opportunityRepository;
        private IOrderRepository orderRepository;

        public InvoiceBL()
        {
            this.invoiceRepository = new InvoiceRepository();
            this.teamRepository = new TeamRepository();
            this.userRepository = new UserRepository();
            this.opportunityRepository = new OpportunityRepository();
            this.orderRepository = new OrderRepository();
        }

        //get invoice by pavel
        public IEnumerable<Invoice> GetInvoices()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return invoiceRepository.GetInvoices(companyID);
        }

        public IEnumerable<Invoice> SearchInvoice(string search)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return invoiceRepository.SearchInvoice(companyID,search);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public IEnumerable<Invoice> GetInvoiceByID(long invoiceID)
        {
            try
            {
                int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
                return invoiceRepository.GetInvoiceByID(invoiceID, companyID);
            }
            catch (Exception e) 
            {
                throw e; 
            }
            
        }


        public long InsertInvoice(Invoice invoice)
        {
            try
            {
                ValidateInvoice(invoice);
               return invoiceRepository.InsertInvoice(invoice);
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
                //ValidateInvoice(invoice);
               // invoiceRepository.UpdateInvoice(invoice);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        public void DeleteInvoice(long invoiceID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            invoiceRepository.DeleteInvoice(companyID,invoiceID);
        }

        //public void DeleteInvoiceByID(long invoiceID)
        //{
        //    try
        //    {
        //        invoiceRepository.DeleteInvoiceByID(invoiceID);
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}


        //public IEnumerable<Team> GetTeams()
        //{
        //    try
        //    {
        //        return teamRepository.GetTeams();
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}
       
        //public IEnumerable<User> GetUsers()
        //{
        //    try
        //    {
        //        return userRepository.GetUsers();
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        //public void InsertUser(User user)
        //{
        //    try
        //    {
        //        userRepository.InsertUser(user);
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }
        //}

        //public IEnumerable<User> GetUsersByFirstName(string nameSearchString)
        //{
        //    try
        //    {
        //        return userRepository.GetUsersByFirstName(nameSearchString);
        //    }
        //    catch (Exception e) 
        //    {
        //        throw e; 
        //    }
        //}

        public IEnumerable<PaymentTerm> GetPaymentTerms()
        {
           return orderRepository.GetPaymentTerms();
        }

        public IEnumerable<Order> GetOrders()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return orderRepository.GetOrders(companyID);
        }

        public IEnumerable<InvoiceStage> GetInvoiceStages()
        {
            return invoiceRepository.GetInvoiceStages();
        }

        public IEnumerable<InvoicePayTerm> GetInvoicePaymentTerms()
        {
            return invoiceRepository.GetInvoicePaymentTerms();
        }

        public IEnumerable<Invoices.Invoices.CustomOrderDetails> GetCustomOrderDetails(long orderID)
        {
            return invoiceRepository.GetCustomOrderDetails(orderID);
        }

        public IEnumerable<Invoices.Invoices.BillingShippingDetails> GetBillingShippingDetails(long invoiceID, long orderID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            return invoiceRepository.GetBillingShippingDetails(invoiceID, orderID, companyID);
        }

        public string GetInvoiceNumber()
       {
           int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
           return invoiceRepository.GetInvoiceNumber(companyID);
       }

        private void ValidateInvoice(Invoice invoice)
        {
            if(invoice.InvoiceID!=null)
            {
                var duplicateInvoice = invoiceRepository.GetInvoice(invoice).FirstOrDefault();
                if (duplicateInvoice != null && duplicateInvoice.InvoiceID != invoice.InvoiceID)
                {
                    if (duplicateInvoice.InvoiceNumber == invoice.InvoiceNumber)
                    {
                        throw new InvoiceException(String.Format("Invoice {0} already exists",duplicateInvoice.Name, duplicateInvoice.InvoiceNumber));
                    }
                }
            }
        }
       
    }

    public partial class InvoiceException : Exception
    {
        public InvoiceException(string message)
            : base(message)
        {
        }
    }
}