using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class ShortMessageRepository: IDisposable, IShortMessageRepository
    {
        C3Entities context = new C3Entities();

        public void InsertOrUpdateShortMessage(ShortMessage shortMessage)
        {
            context.Entry(shortMessage).State = shortMessage.ShortMessageID == 0 ? EntityState.Added : EntityState.Modified;
            SaveChanges();
        }

        public IEnumerable<ShortMessage> GetShortMessageByID(int companyID, int shortMessageID)
        {
            return context.ShortMessages.Where(s => s.CompanyID == companyID && s.ShortMessageID == shortMessageID && s.IsDeleted == false).ToList();
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