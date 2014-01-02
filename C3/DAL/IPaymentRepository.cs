using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IPaymentRepository
    {
        void InsertOrUpdatePayment(Payment payment);
        void DeletePaymentByID(int paymentID);
        IEnumerable<Payment> GetPayments(int companyID);
        IEnumerable<Payment> GetPaymentByID(int companyID, int paymentID);
        IEnumerable<Payment> GetPaymentByAccountID(long accountID);
        IEnumerable<Payment> SearchPaymentsByName(int companyID, string nameSearchString);
        IEnumerable<PaymentType> GetPaymentTypes();
    }
}
