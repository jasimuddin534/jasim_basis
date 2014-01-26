using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface ICaseRepository
    {

        IEnumerable<Case> GetCases(int companyID);

        IEnumerable<Case> GetNewCases(int companyID);

        IEnumerable<Case> GetAssginedCases(int companyID);

        IEnumerable<Case> GetCaseBySubject(string subjectSearch, int companyID);

        IEnumerable<Case> GetCaseByNumber(string caseNumner, int companyID);

        IEnumerable<Case> GetCaseByID(long caseID, int companyID);

        IEnumerable<CasePriority> GetCasePriorities();

        IEnumerable<CaseStatus> GetCaseStatuses();

        bool IsCaseExists(long companyid, long caseid, string cNumber);

        string GetCaseNumber(int companyId);

        void DeleteCaseByID(long caseID);

        long InsertOrUpdateCase(Case cas);

    }
}
