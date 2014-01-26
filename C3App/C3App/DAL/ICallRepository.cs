using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface ICallRepository
    {
        IEnumerable<Call> GetCalls(int companyID);
        IEnumerable<Call> GetCallByID(long callID, int companyID);
        IEnumerable<Call> GetCallsBySubject(string callSubject, int companyID);
        long InsertOrUpdateCall(Call call);
        void DeleteCallByID(long callID);
    }
}
