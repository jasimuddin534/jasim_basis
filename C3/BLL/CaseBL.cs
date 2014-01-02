using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class CaseBL
    {
        private ICaseRepository caseRepository;

        public CaseBL()
        {
            this.caseRepository = new CaseRepository();
        }


        public IEnumerable<Case> GetCases()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            try
            {
                return caseRepository.GetCases(companyID);
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<Case> GetNewCases()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            try
            {
                return caseRepository.GetNewCases(companyID);
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<Case> GetAssginedCases()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            try
            {
                return caseRepository.GetAssginedCases(companyID);
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<Case> GetCaseBySubject(string subjectSearch)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            try
            {
                return caseRepository.GetCaseBySubject(subjectSearch, companyID);
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public IEnumerable<Case> GetCaseByID(long caseID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            try
            {
                return caseRepository.GetCaseByID(caseID, companyID);
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
                return caseRepository.GetCasePriorities();
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
                return caseRepository.GetCaseStatuses();
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public string GetCaseNumber()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            return caseRepository.GetCaseNumber(companyID);
        }

        public void DeleteCaseByID(long caseID)
        {
            try
            {
                caseRepository.DeleteCaseByID(caseID);
            }
            catch (Exception e)
            {
                throw e;
            }

        }

        public long InsertCase(Case cas)
        {
            ValidateCase(cas);
            try
            {
                return caseRepository.InsertOrUpdateCase(cas);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public long UpdateCase(Case cas)
        {
            ValidateCase(cas);
            try
            {
                return caseRepository.InsertOrUpdateCase(cas);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        private void ValidateCase(Case cas)
        {
            long companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            long caseid = cas.CaseID;
            string cNumber = cas.CaseNumber;

            bool oneCase = caseRepository.IsCaseExists(companyid, caseid, cNumber);

            if (oneCase == true)
            {
                throw new DuplicateContactException(String.Format("Case Number {0} already exists. Please try another one", cNumber));
            }
        }

    }

    public class DuplicateCaseException : Exception
    {
        public DuplicateCaseException(string message)
            : base(message)
        {
        }
    }
}