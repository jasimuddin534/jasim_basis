using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Objects;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class PaymentRepository : IDisposable, IPaymentRepository
    {
        private C3Entities context = new C3Entities();

        public PaymentRepository()
        {
            //context.Payments
            
        }

        public void InsertOrUpdatePayment(Payment payment)
        {
            context.Entry(payment).State = payment.PaymentID == 0 ? EntityState.Added : EntityState.Modified;
            SaveChanges();
        }

        public void DeletePaymentByID(int paymentID)
        {
            var payment = context.Payments.Find(paymentID);
            payment.IsDeleted = true;
            context.Entry(payment).State = EntityState.Modified;
            context.SaveChanges();
        }

        public IEnumerable<Payment> GetPayments(int companyID)
        {
            return context.Payments.AsNoTracking().Where(p => p.CompanyID == companyID && p.IsDeleted == false).ToList();
        }

        public IEnumerable<Payment> GetPaymentByID(int companyID, int paymentID)
        {
            return context.Payments.AsNoTracking().Where(p => p.CompanyID == companyID && p.PaymentID == paymentID && p.IsDeleted == false).ToList();
        }

        public IEnumerable<Payment> GetPaymentByAccountID(long accountID)
        {
            return context.Payments.AsNoTracking().Where(p => p.AccountID == accountID).ToList();
        }

        public IEnumerable<Payment> SearchPaymentsByName(int companyID, string nameSearchString)
        {
            return context.Payments.AsNoTracking().Where(p => p.CompanyID == companyID && p.PaymentNumber.Contains(nameSearchString) && p.IsDeleted == false);
        }

        public IEnumerable<PaymentType> GetPaymentTypes()
        {
            return GetPaymentTypes("");
        }

        public IEnumerable<PaymentType> GetPaymentTypes(string sortExpression)
        {
            if (String.IsNullOrWhiteSpace(sortExpression))
            {
                sortExpression = "Name";
            }
            return context.PaymentTypes.ToList();
            //return context.PaymentTypes.Include("Person").OrderBy("it." + sortExpression).ToList();
        }

        public void SaveChanges()
        {
            try
            {
                context.SaveChanges();
            }
            catch (OptimisticConcurrencyException ocex)
            {
                //context.Refresh(RefreshMode.StoreWins, ocex.StateEntries[0].Entity);
                throw ocex;
            }
        }

        private bool disposedValue = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposedValue)
            {
                if (disposing)
                {
                    context.Dispose();
                }
            }
            this.disposedValue = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}