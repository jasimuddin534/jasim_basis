using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class ShortMessageBL
    {
        private IShortMessageRepository shortMessageRepository;
        private int companyID;

        public ShortMessageBL()
        {
            this.shortMessageRepository = new ShortMessageRepository();
            this.companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
        }

        public void InsertOrUpdateShortMessage(ShortMessage shortMessage)
        {
            shortMessage.CompanyID = this.companyID;
            shortMessageRepository.InsertOrUpdateShortMessage(shortMessage);
        }

        public IEnumerable<ShortMessage> GetShortMessageByID(int shortMessageID)
        {
            return shortMessageRepository.GetShortMessageByID(companyID, shortMessageID);
        }
    }
}