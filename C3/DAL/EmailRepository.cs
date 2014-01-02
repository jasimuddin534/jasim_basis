using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class EmailRepository: IDisposable, IEmailRepository
    {
        private C3Entities context = new C3Entities();

        public EmailRepository()
        {

        }

        public void InsertEmail(Email email)
        {
            context.Entry(email).State = EntityState.Added;
            SaveChanges();
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