using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IEmailTemplateRepository
    {
        IEnumerable<EmailTemplate> GetEmailTemplateByID(int companyID, int emailTemplateID);
        void InsertOrUpdateEmailTemplate(EmailTemplate emailTemplate);
    }
}
