using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;
using System.Data;

using System.Data.SqlClient;
using System.Configuration;
using System.Data.Entity.Infrastructure;
using System.Data.Objects;
using C3App.App_Code;



namespace C3App.DAL
{
    public class CaseRepository : IDisposable, ICaseRepository
    {

        public C3Entities context = new C3Entities();
        private bool disposevalue = false;

        public CaseRepository()
        {

        }

        public IEnumerable<Case> GetCases(int companyID)
        {
            //return context.Cases.AsNoTracking().Where(c => c.CompanyID == companyID && c.IsDeleted == false).Take(20).ToList();

            var cases = (from cas in context.Cases
                         where cas.IsDeleted == false && cas.CompanyID == companyID
                         select cas).Take(20).ToList();
            try
            {
                return cases;
            }
            catch (Exception e)
            {
                throw e;
            }
        }



        public IEnumerable<Case> GetNewCases(int companyID)
        {
            var cases = (from cas in context.Cases
                         where cas.IsDeleted == false && cas.CompanyID == companyID && cas.StatusID==1
                         select cas).ToList();
            try
            {
                return cases;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public IEnumerable<Case> GetAssginedCases(int companyID)
        {
            var cases = (from cas in context.Cases
                         where cas.IsDeleted == false && cas.CompanyID == companyID && cas.StatusID == 2
                         select cas).ToList();
            try
            {
                return cases;
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public IEnumerable<CasePriority> GetCasePriorities()
        {
            try
            {
                return context.CasePriorities.ToList();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<CaseStatus> GetCaseStatuses()
        {
            try
            {
                return context.CaseStatuses.ToList();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<Case> GetCaseBySubject(string subjectSearch, int companyID)
        {
            if (String.IsNullOrWhiteSpace(subjectSearch))
            {
                subjectSearch = "";
            }

            try
            {
                return context.Cases.Where(c => c.IsDeleted == false && c.CompanyID == companyID && c.Subject.Contains(subjectSearch)).ToList();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<Case> GetCaseByNumber(string caseNumner, int companyID)
        {
            try
            {
                return context.Cases.Where(c => c.IsDeleted == false && c.CompanyID == companyID && c.CaseNumber.Contains(caseNumner)).ToList();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<Case> GetCaseByID(long caseID, int companyID)
        {
            var cases = (from cas in context.Cases
                         where cas.CaseID == caseID && cas.IsDeleted == false && cas.CompanyID == companyID
                         select cas).ToList();
            try
            {
                return cases;
            }
            catch (Exception e)
            {
                throw e;
            }


        }

        public void DeleteCaseByID(long caseID)
        {
            Case cases = (from cas in context.Cases
                          where cas.CaseID == caseID
                          select cas).FirstOrDefault();

            try
            {
                cases.IsDeleted = true;
                context.Entry(cases).State = EntityState.Modified;
                SaveChanges();

            }
            catch (OptimisticConcurrencyException e)
            {
                SaveChanges();
            }

        }

        public long InsertOrUpdateCase(Case cas)
        {
            try
            {
                context.Entry(cas).State = cas.CaseID == 0 ? EntityState.Added : EntityState.Modified;
                SaveChanges();
                return cas.CaseID;
            }
            catch (Exception ex) { throw ex; }
        }

        public string GetCaseNumber(int companyId)
        {
            var caseNumber = (from cas in context.Cases
                              where cas.CompanyID == companyId
                              orderby cas.CaseID descending
                              select cas.CaseNumber).FirstOrDefault();
            return caseNumber;
        }


        public bool IsCaseExists(long companyid, long caseid, string cNumber)
        {
            bool found = false;
            long cid = -1;

            var cases = (from c in context.Cases
                         where ((c.CaseNumber == cNumber) && (c.CompanyID == companyid) && (c.CaseID != caseid))
                         select c).FirstOrDefault();

            if (cases != null)
                cid = cases.CaseID;

            if (cid != -1)
                found = true;

            return found;
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

                    // Update original values from the database
                    //var entry = ex.Entries.Single();
                    //entry.OriginalValues.SetValues(entry.GetDatabaseValues());
                }
            } while (saveFailed);
        }

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
    }
}