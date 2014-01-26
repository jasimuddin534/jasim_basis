using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace C3App.App_Code
{
    public class MailHelper
    {
        /// <summary>
        /// Sends an mail message
        /// </summary>
        /// <param name="from">Sender address</param>
        /// <param name="to">Recepient address</param>
        /// <param name="bcc">Bcc recepient</param>
        /// <param name="cc">Cc recepient</param>
        /// <param name="subject">Subject of mail message</param>
        /// <param name="body">Body of mail message</param>
        public static void SendEmail(string from, string displayName, string touser, string bcc, string cc, string subject, string body, string attachementName)
        {
            //Code added by Khaled
            string fromEmail = ConfigurationManager.AppSettings["FromEmail"].ToString();
            string emailPassword = ConfigurationManager.AppSettings["EmailPassword"].ToString();
            //string toEmail = PrimaryEmailTextBox.Text;
            //MailMessage message = new MailMessage(fromEmail, toEmail);
            //message.Subject = "Activate Your Account";
            //message.Body = emailBody;
            //message.IsBodyHtml = true;

            //SmtpClient smtp = new SmtpClient();
            NetworkCredential basicCredential = new NetworkCredential(fromEmail, emailPassword);
            //smtp.UseDefaultCredentials = false;
            //smtp.Credentials = basicCredential;
            //smtp.EnableSsl = true;
            //smtp.Send(message);

            // Instantiate a new instance of MailMessage
            MailMessage mMailMessage = new MailMessage();
            // Set the sender address of the mail message
            mMailMessage.From = new MailAddress(from, displayName);


            // Set the recepient address of the mail message
            mMailMessage.To.Add(new MailAddress(touser));

            if (String.IsNullOrEmpty(attachementName) == false)
            {
                mMailMessage.Attachments.Add(new Attachment(attachementName));
            }

            // Check if the bcc value is null or an empty string
            if ((bcc != null) && (bcc != string.Empty))
            {
                // Set the Bcc address of the mail message
                mMailMessage.Bcc.Add(new MailAddress(bcc));
            }
            // Check if the cc value is null or an empty value
            if ((cc != null) && (cc != string.Empty))
            {
                // Set the CC address of the mail message
                mMailMessage.CC.Add(new MailAddress(cc));
            }       // Set the subject of the mail message
            mMailMessage.Subject = subject;
            // Set the body of the mail message
            mMailMessage.Body = body;

            // Set the format of the mail message body as HTML
            mMailMessage.IsBodyHtml = true;
            // Set the priority of the mail message to normal
            mMailMessage.Priority = MailPriority.High;

            // Instantiate a new instance of SmtpClient
            SmtpClient mSmtpClient = new SmtpClient();
            mSmtpClient.EnableSsl = true;
            mSmtpClient.UseDefaultCredentials = false;
            mSmtpClient.Credentials = basicCredential;
            // Send the mail message
            mSmtpClient.Send(mMailMessage);
        }

        /// <summary>
        /// Send email by Khaled
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
            message.Subject = subject;
            message.Body = body;
            message.IsBodyHtml = true;
            message.Priority = MailPriority.High;

            SmtpClient smtpClient = new SmtpClient();
            smtpClient.EnableSsl = true;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = basicCredential;
            smtpClient.Send(message);
        } 
    }
}