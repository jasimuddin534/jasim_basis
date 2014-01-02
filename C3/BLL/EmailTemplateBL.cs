using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class EmailTemplateBL
    {
        private IEmailTemplateRepository emailTemplateRepository;
        private int companyID;

        public EmailTemplateBL()
        {
            this.emailTemplateRepository = new EmailTemplateRepository();
            this.companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
        }

        public IEnumerable<EmailTemplate> GetEmailTemplateByID(int emailTemplateID)
        {
            return emailTemplateRepository.GetEmailTemplateByID(companyID, emailTemplateID);
        }

        public void InsertOrUpdateEmailTemplate(EmailTemplate emailTemplate)
        {
            emailTemplate.CompanyID = this.companyID;
            emailTemplateRepository.InsertOrUpdateEmailTemplate(emailTemplate);
        }
    }
}