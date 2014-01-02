using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;


namespace C3App.BLL
{
    public class CallBL
    {
        private ICallRepository callRepository;

        public CallBL()
        {
            this.callRepository = new CallRepository();
        }

        public IEnumerable<Call> GetCalls()
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return callRepository.GetCalls(companyID);
            }
            catch (Exception e)
            {
                throw e;
            }

        }
        public IEnumerable<Call> GetCallByID(long callID)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return callRepository.GetCallByID(callID, companyID);
            }
            catch (Exception e)
            {
                throw e;
            }
        }
        public IEnumerable<Call> GetCallsBySubject(string callSubject)
        {
            int companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            try
            {
                return callRepository.GetCallsBySubject(callSubject, companyID);

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public long InsertOrUpdateCall(Call call)
        {
            StartDataEndDateValidate(call);
            try
            {
                callRepository.InsertOrUpdateCall(call);
                return call.CallID;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public void DeleteCallByID(long callID)
        {
            try
            {
                callRepository.DeleteCallByID(callID);
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }





        private void StartDataEndDateValidate(Call call)
        {
            if (call.DateStart > call.DateEnd)
            {
                throw new InvelidDateException(String.Format("End Date and Time must be greater than Start Date and Time "));
            }
        }

    }


    public class InvelidDateException : Exception
    {
        public InvelidDateException(string message)
            : base(message)
        {

        }
    }

}