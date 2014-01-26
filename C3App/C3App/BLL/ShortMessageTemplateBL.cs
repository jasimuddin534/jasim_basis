using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class ShortMessageTemplateBL
    {
        private IShortMessageTemplateRepository shortMessageTemplateRepository;
        private int companyID;

        public ShortMessageTemplateBL()
        {
            this.shortMessageTemplateRepository = new ShortMessageTemplateRepository();
            this.companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
        }

        public void InsertOrUpdateShortMessageTemplateRepository(ShortMessageTemplate shortMessageTemplate)
        {
            shortMessageTemplate.CompanyID = this.companyID;
            shortMessageTemplateRepository.InsertOrUpdateShortMessageTemplate(shortMessageTemplate);
        }

        public IEnumerable<ShortMessageTemplate> GetShortMessageTemplateByID(int shortMessageTemplateID)
        {
            return shortMessageTemplateRepository.GetShortMessageTemplateByID(companyID, shortMessageTemplateID);
        }
    }
}