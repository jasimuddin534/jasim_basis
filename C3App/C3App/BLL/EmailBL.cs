using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class EmailBL
    {
        private IEmailRepository emailRepository;
        private int companyID;
        public EmailBL()
        {
            this.emailRepository = new EmailRepository();
            this.companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
        }

        public void InsertEmail(Email email)
        {
            email.CompanyID = this.companyID;
            try
            {
                emailRepository.InsertEmail(email);
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first, 
                //and handle or log the error as appropriate in each. 
                //Include a generic catch block like this one last. 
                throw ex;
            }
        }
    }
}