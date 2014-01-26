using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class ShortMessageTemplateRepository : IDisposable, IShortMessageTemplateRepository
    {
        C3Entities context = new C3Entities();

        public void InsertOrUpdateShortMessageTemplate(ShortMessageTemplate shortMessageTemplate)
        {
            context.Entry(shortMessageTemplate).State = shortMessageTemplate.ShortMessageTemplateID == 0 ? EntityState.Added : EntityState.Modified;
            SaveChanges();
        }

        public IEnumerable<ShortMessageTemplate> GetShortMessageTemplateByID(int companyID, int shortEmailTemplateID)
        {
            return context.ShortMessageTemplates.Where(s => s.ShortMessageTemplateID == shortEmailTemplateID && s.IsDeleted == false).ToList();
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