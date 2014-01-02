using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;
using C3App.App_Code;
using System.Data;
using System.Data.SqlClient;
using System.Data.Entity.Infrastructure;



namespace C3App.DAL
{
    public class CallRepository : IDisposable, ICallRepository
    {
        C3Entities context = new C3Entities();
        private bool disposevalue = false;
        public CallRepository() { }
        public virtual void Dispose(bool disposing)
        {
            if (!this.disposevalue)
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
                    ex.Entries.Single().Reload();
                }
            } while (saveFailed);
        }


        public IEnumerable<Call> GetCalls(int companyID)
        {
            // return context.Calls.AsNoTracking().Where(c => c.CompanyID == companyID && c.IsDeleted == false).Take(20).ToList();
            var calls = (from call in context.Calls
                         where call.IsDeleted == false && call.CompanyID == companyID
                         select call).Take(20).ToList();
            try
            {
                return calls;
            }
            catch (Exception e)
            {
                throw e;
            }


        }
        public IEnumerable<Call> GetCallByID(long callID, int companyID)
        {
            var calls = (from call in context.Calls
                         where call.CompanyID == companyID && call.CallID == callID && call.IsDeleted == false
                         select call).ToList();
            try
            {
                return calls;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public IEnumerable<Call> GetCallsBySubject(string callSubject, int companyID)
        {
            if (String.IsNullOrWhiteSpace(callSubject))
            {
                callSubject = "";
            }

            try
            {
                return context.Calls.Where(c => c.IsDeleted == false && c.CompanyID == companyID && c.Subject.Contains(callSubject)).ToList();
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public long InsertOrUpdateCall(Call call)
        {
            try
            {
                context.Entry(call).State = call.CallID == 0 ? EntityState.Added : EntityState.Modified;
                SaveChanges();
                return call.CallID;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public void DeleteCallByID(long callID)
        {
            Call calls = (from call in context.Calls
                          where call.CallID == callID
                          select call).FirstOrDefault();
            try
            {
                calls.IsDeleted = true;
                context.Entry(calls).State = EntityState.Modified;
                SaveChanges();
            }
            catch (OptimisticConcurrencyException ex)
            {
                SaveChanges();
            }

        }

    }
}