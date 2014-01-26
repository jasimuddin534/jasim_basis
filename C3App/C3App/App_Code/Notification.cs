using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.IO;
using System.Text;
using C3App.BLL;
using C3App.DAL;
using System.Web.UI.WebControls;
using System.Collections.Specialized;
using System.Web.UI;
using System.Collections;


namespace C3App.App_Code
{
    public class Notification
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="parentType">Module name</param>
        /// <param name="parentID">Module primary key</param>
        /// <param name="notificationType">1.Email 2.SMS 3.Call</param>
        /// <param name="toUser">Receiver</param>
        /// <param name="templateID">1.Activation Email 2.Task assignment</param>
        /// <param name="templateValues">List of values to be replaced</param>
        public static void Notify(string parentType, long parentID, int notificationType, string toUser, int templateID, IDictionary templateValues)
        {
            NotificationBL notificationBL = new NotificationBL();
            C3App.DAL.Notification notification = new C3App.DAL.Notification();
            notification.Status = 1;
            notification.ParentType = parentType;
            notification.ParentID = parentID;
            notification.CreatedBy = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
            notification.CreatedTime = DateTime.Now;
            string body = String.Empty;
            long notificationID;
            switch (notificationType)
            {
                case 1:
                    notification.NotificationTypeID = 1;
                    notificationID = notificationBL.InsertNotification(notification);
                    Email email = new Email();
                    email.Subject = "System-generated Mail";
                    email.FromAddress = ConfigurationManager.AppSettings["FromEmail"].ToString();
                    email.FromName = "Panacea Systems Ltd";
                    email.ToAddress = toUser;
                    email.Status = true;
                    email.DateStart = DateTime.Now;
                    email.ParentType = parentType;
                    email.ParentID = parentID;
                    email.AssignedUserID = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
                    email.NotificationID = notificationID;
                    email.CreatedBy = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
                    email.CreatedTime = DateTime.Now;
                    EmailTemplateBL emailTemplateBL = new EmailTemplateBL();
                    EmailTemplate emailTemplate = new EmailTemplate();
                    emailTemplate = emailTemplateBL.GetEmailTemplateByID(templateID).FirstOrDefault();
                    body = emailTemplate.BodyHTML;

                    foreach (DictionaryEntry de in templateValues)
                    {
                        body = body.Replace(de.Key.ToString(), de.Value.ToString());
                    }
                   
                    email.BodyHTML = body;
                    EmailBL emailBL = new EmailBL();
                    emailBL.InsertEmail(email);
                    SendEmail(toUser,emailTemplate.Subject, body);
                    break;
                case 2:
                    notification.NotificationTypeID = 2;
                    notificationID = notificationBL.InsertNotification(notification);
                    ShortMessage shortMessage = new ShortMessage();
                    shortMessage.FromNumber = "Panacea";
                    shortMessage.ToNumber = toUser;
                    shortMessage.Type = "General";
                    shortMessage.Status = 1;
                    shortMessage.ParentType = parentType;
                    shortMessage.ParentID = parentID;
                    shortMessage.NotificationID = notificationID;
                    shortMessage.CreatedBy = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
                    shortMessage.CreatedTime = DateTime.Now;
                    ShortMessageTemplateBL shortMessageTemplateBL = new ShortMessageTemplateBL();
                    ShortMessageTemplate shortMessageTemplate = new ShortMessageTemplate();
                    shortMessageTemplate = shortMessageTemplateBL.GetShortMessageTemplateByID(templateID).FirstOrDefault();
                    body = shortMessageTemplate.Message;

                    foreach (DictionaryEntry de in templateValues)
                    {
                        body = body.Replace(de.Key.ToString(), de.Value.ToString());
                    }
                    shortMessage.Body = body;
                    ShortMessageBL shortMessageBL = new ShortMessageBL();
                    shortMessageBL.InsertOrUpdateShortMessage(shortMessage);
                    SendSMS(toUser, shortMessage.Body);
                    break;
                case 3:
                    notification.NotificationTypeID = 3;
                    break;
                default:
                    break;
            }
            

        }


        /// <summary>
        /// Send email by Parameters
        /// </summary>
        /// <param name="toUser"></param>
        /// <param name="subject"></param>
        /// <param name="body"></param>
        public static void SendEmail(string toUser, string subject, string body)
        {
            string fromEmail = ConfigurationManager.AppSettings["FromEmail"].ToString();
            string emailPassword = ConfigurationManager.AppSettings["EmailPassword"].ToString();
            string displayName = "Panacea Systems Ltd";
            NetworkCredential basicCredential = new NetworkCredential(fromEmail, emailPassword);

            MailMessage message = new MailMessage();
            message.From = new MailAddress(fromEmail, displayName);

            if (toUser.Contains(';'))
            {
                //send multiple email
                string[] emails = toUser.Split(';');
                foreach (string email in emails)
                {
                    message.To.Add(new MailAddress(email));
                }
            }
            else
            {
                //send single email
                message.To.Add(new MailAddress(toUser));
            }
            //message.To.Add(new MailAddress(toUser));
            message.Subject = subject;
            message.Body = body;
            message.IsBodyHtml = true;
            message.Priority = MailPriority.High;

            SmtpClient smtpClient = new SmtpClient();
            smtpClient.EnableSsl = false;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = basicCredential;
            //smtpClient.Send(message);
        }

        /// <summary>
        /// Send email by MailMessage
        /// </summary>
        /// <param name="message"></param>
        public static void SendEmail(MailMessage message)
        {
            string fromEmail = ConfigurationManager.AppSettings["FromEmail"].ToString();
            string emailPassword = ConfigurationManager.AppSettings["EmailPassword"].ToString();
            string displayName = "Panacea Systems Ltd";
            NetworkCredential basicCredential = new NetworkCredential(fromEmail, emailPassword);

            message.From = new MailAddress(fromEmail, displayName);
            SmtpClient smtpClient = new SmtpClient();
            smtpClient.EnableSsl = true;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = basicCredential;
            smtpClient.Send(message);

        }

        /// <summary>
        /// Send sms by parameters
        /// </summary>
        /// <param name="toUser"></param>
        /// <param name="message"></param>
        /// <returns></returns>
        public static string SendSMS(string toUser, string message)
        {
            string username = "panacea";
            string password = "pana@123";
            string from = "Panacea";
            string sURL = "http://hypertagsolutions.com/cmp/sendsms.php?" + "username=" + username + "&password=" + password + "&destination="
                + toUser + "&source=" + from + "&message=" + " " + message + ".";

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(sURL);
            request.MaximumAutomaticRedirections = 4;
            request.Credentials = CredentialCache.DefaultCredentials;
            try
            {
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                Stream receiveStream = response.GetResponseStream();
                StreamReader readStream = new StreamReader(receiveStream, Encoding.UTF8);
                string sResponse = readStream.ReadToEnd();
                response.Close();
                readStream.Close();
                return sResponse;
            }
            catch
            {
                return "";
            }
        }
    }
}