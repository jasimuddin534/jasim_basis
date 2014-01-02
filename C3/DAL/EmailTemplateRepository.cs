using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace C3App.DAL
{
    public class EmailTemplateRepository: IDisposable, IEmailTemplateRepository
    {
        C3Entities context = new C3Entities();

        public void InsertOrUpdateEmailTemplate(EmailTemplate emailTemplate)
        {
            context.Entry(emailTemplate).State = emailTemplate.EmailTemplateID == 0 ? EntityState.Added : EntityState.Modified;
            SaveChanges();
        }

        public IEnumerable<EmailTemplate> GetEmailTemplateByID(int companyID, int emailTemplateID)
        {
            return context.EmailTemplates.Where(e => e.EmailTemplateID == emailTemplateID && e.IsDeleted==false).ToList();
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