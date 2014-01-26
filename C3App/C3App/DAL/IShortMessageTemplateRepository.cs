using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace C3App.DAL
{
    interface IShortMessageTemplateRepository
    {
        void InsertOrUpdateShortMessageTemplate(ShortMessageTemplate shortMessageTemplate);
        IEnumerable<ShortMessageTemplate> GetShortMessageTemplateByID(int companyID, int shortEmailTemplateID);
    }
}
