using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using C3App.DAL;

namespace C3App.BLL
{
    public class NotificationBL
    {
        private INotificationRepository notificationRepository;
        private int companyID;
        public NotificationBL()
        {
            this.notificationRepository = new NotificationRepository();
            this.companyID = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
        }

        public long InsertNotification(Notification notification)
        {
            notification.CompanyID = this.companyID;
            try
            {
                return notificationRepository.InsertNotification(notification);
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