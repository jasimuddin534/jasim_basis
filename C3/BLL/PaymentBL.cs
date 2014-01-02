using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using C3App.DAL;
using System.ComponentModel.DataAnnotations;

namespace C3App.BLL
{
    public class PaymentBL
    {
        private IPaymentRepository paymentRepository;
        private int companyID;

        public PaymentBL()
        {
            this.paymentRepository = new PaymentRepository();
            this.companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
        }

        //public PaymentBL(IPaymentRepository paymentRepository)
        //{
        //    this.paymentRepository = paymentRepository;
        //}

        public void InsertOrUpdatePayment(Payment payment)
        {
            payment.CompanyID = this.companyID;
            ValidatePayment(payment);
            try
            {
                paymentRepository.InsertOrUpdatePayment(payment);
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first, 
                //and handle or log the error as appropriate in each. 
                //Include a generic catch block like this one last. 
                throw ex;
            }
        }

        public void DeletePaymentByID(int paymentID)
        {
            try
            {
                paymentRepository.DeletePaymentByID(paymentID);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public IEnumerable<Payment> GetPayments()
        {
            return paymentRepository.GetPayments(companyID);
        }

        public IEnumerable<Payment> GetPaymentByID(int paymentID)
        {
            return paymentRepository.GetPaymentByID(companyID, paymentID);
        }

        public IEnumerable<Payment> SearchPaymentsByName(string nameSearchString)
        {
            return paymentRepository.SearchPaymentsByName(companyID, nameSearchString);
        }

        public IEnumerable<PaymentType> GetPaymentTypes()
        {
            return paymentRepository.GetPaymentTypes();
        }

        private void ValidatePayment(Payment payment)
        {
            if (payment.AccountID != null)
            {
                var duplicatePayment = paymentRepository.GetPaymentByAccountID(payment.AccountID.GetValueOrDefault()).FirstOrDefault();
                if (duplicatePayment != null && duplicatePayment.PaymentID != payment.PaymentID)
                {
                    if (duplicatePayment.AccountID == payment.AccountID)
                    {
                        throw new PaymentException(String.Format(
                            "Account {0} is already exist",
                            duplicatePayment.Account.Name,
                            duplicatePayment.Amount,
                            duplicatePayment.PaymentNumber));
                    }
                    
                }
            }
        }

        [WebMethod]
        public static string CheckPayment(long accountID)
        {
            IPaymentRepository paymentRepository = new PaymentRepository();
            string returnValue = String.Empty;
            var duplicatePayment = paymentRepository.GetPaymentByAccountID(accountID).FirstOrDefault();
            if (duplicatePayment != null && duplicatePayment.AccountID == accountID)
            {
                returnValue = "error";
                return returnValue;
            }
            else
            {
                returnValue = "success";
                return returnValue;
            }
        }
    }

    public class PaymentException : Exception
    {
        public PaymentException(string message)
            : base(message)
        {
        }
    }
}