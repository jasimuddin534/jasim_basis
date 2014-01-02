using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using C3App.BLL;
using C3App.DAL;
using C3App.App_Code;

namespace C3App.Users
{
    public partial class Company : System.Web.UI.Page
    {
        private DropDownList countryDropDownList;
        private DropDownList languageDropDownList;
        private DropDownList currencyDropDownList;
        private DropDownList dateFormatDropDownList;
        private DropDownList timeFormatDropDownList;
        private DropDownList timeZoneDropDownList;
        private DropDownList companyTypesDropDownList;
        private DropDownList bankAccountTypeDropDownList;

        protected void Page_Init(object sender, EventArgs e)
        {
          //  CompanyDetailsView.EnableDynamicData(typeof(Company));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            UserBL userBL = new UserBL();

           int cc =  Convert.ToInt32(Session["CompanyID"]);

           try
           {
               if (Request.QueryString["ShowPanel"] != null)
               {
                   if ((!IsPostBack))
                   {
                       Session["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
                   }
               }

               if (Session["CompanyID"] != null)
               {

                   Int32 companyid = Convert.ToInt32(Session["CompanyID"]);

                   if (companyid == 0)
                   {

                       Response.Redirect("~/UserLogin.aspx");

                   }
                   else if (companyid > 0)
                   {
                       CompanyDetailsView.ChangeMode(DetailsViewMode.Edit);
                       //CompanyDetailsView.AutoGenerateEditButton = true;

                   }

                   var bank = userBL.GetBankAccountByCompanyID();
                   if (bank.Count() > 0)
                   {
                       int bankaccountid = bank.ElementAt(0).BankAccountID;
                       if (bankaccountid == 0)
                       {
                           BankAccountDetailsView.ChangeMode(DetailsViewMode.Insert);
                       }
                       else if (bankaccountid > 0)
                       {
                           BankAccountDetailsView.ChangeMode(DetailsViewMode.Edit);
                       }
                   }
                   else
                   {
                       BankAccountDetailsView.ChangeMode(DetailsViewMode.Insert);
                   }



               }
               else
               {

                   Response.Redirect("~/UserLogin.aspx");
               }
           }
           catch (Exception ex)
           {
               throw ex;
           }  
            
        }


        public void Page_Error(object sender, EventArgs e)
        {
            // Get last error from the server
            Exception exc = Server.GetLastError();

            //Development phase error messages
            Response.Write("<h2>Something wrong happend!</h2>");
            Response.Write("<b>Exception Type: </b>" + exc.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Exception: </b>" + exc.Message.ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception Type: </b>" + exc.InnerException.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception: </b>" + exc.InnerException.Message + "<br/><br/>");
            Response.Write("<b>Inner Source: </b>" + exc.InnerException.Source + "<br/><br/>");
            //Response.Write("<b>Stack Trace: </b>" + exc.StackTrace.ToString());

            //Log the exception and notify system operators
            ExceptionUtility.LogException(exc, "CompanyDetailsPage");
            ExceptionUtility.NotifySystemOps(exc, "CompanyDetailsPage");

            //Clear the error from the server
            Server.ClearError();
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
        }


        protected void CompanyEditButton_Click(object sender, EventArgs e)
        {
            CompanyDetailsView.ChangeMode(DetailsViewMode.Edit);
        }

        protected void CompanyDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            UserBL userBL = new UserBL();
            int bankid = 0;
            Int64 userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            var bank = userBL.GetBankAccountByCompanyID();
            if (bank.Count() > 0)
            {
                bankid = bank.ElementAt(0).BankAccountID;
            }
            if (bankid == 0)
            {
                bankid = Convert.ToInt32(Session["NewBankID"]);
          
            }
            

            e.NewValues["ModifiedBy"] = userid;
            e.NewValues["ModifiedTime"] = DateTime.Now;
            if (bankid == 0)
            {
                e.NewValues["BankAccount"] = null;
            }
            else if (bankid > 0)
            {
                e.NewValues["BankAccount"] = bankid;
            }
        

            if (Convert.ToInt32(countryDropDownList.SelectedValue) == 0) { e.NewValues["CountryID"] = null; }
            else { e.NewValues["CountryID"] = countryDropDownList.SelectedValue; }

            if (Convert.ToInt32(languageDropDownList.SelectedValue) == 0) { e.NewValues["LanguageID"] = null; }
            else { e.NewValues["LanguageID"] = languageDropDownList.SelectedValue; }

            if (Convert.ToInt32(currencyDropDownList.SelectedValue) == 0) { e.NewValues["CurrencyID"] = null; }
            else { e.NewValues["CurrencyID"] = currencyDropDownList.SelectedValue; }

            if (Convert.ToInt32(dateFormatDropDownList.SelectedValue) == 0) { e.NewValues["DateFormatID"] = null; }
            else { e.NewValues["DateFormatID"] = dateFormatDropDownList.SelectedValue; }

            if (Convert.ToInt32(timeFormatDropDownList.SelectedValue) == 0) { e.NewValues["TimeFormatID"] = null; }
            else { e.NewValues["TimeFormatID"] = timeFormatDropDownList.SelectedValue; }

            if (Convert.ToInt32(timeZoneDropDownList.SelectedValue) == 0) { e.NewValues["TimeZoneID"] = null; }
            else { e.NewValues["TimeZoneID"] = timeZoneDropDownList.SelectedValue; }

            if (Convert.ToInt32(companyTypesDropDownList.SelectedValue) == 0) { e.NewValues["CompanyTypeID"] = null; }
            else { e.NewValues["CompanyTypeID"] = companyTypesDropDownList.SelectedValue; }
         
        }

        protected void CompanyDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        { 
            long id = 0;
            string value = Convert.ToString(Session["NewCompany"]);
            if (value != "")
            id = int.Parse(value);


            if (id > 0)
            {
               // Literal1.Text = "Success";
               // Label1.Text = "<b>"+ name +"</b> company information has been saved successfully.";
                Literal1.Text = "Success !</br></br> <p>Company information has been updated successfully</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
            }
            else
            {
                //Literal1.Text = "Error";
                //Label1.Text = "<b>"+name + "</b> company information did not save.";
                Literal1.Text = "Error !</br></br> <p>Company information did not save.</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
            }


        }

        protected void CompanyDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                CompanyDetailsView.ChangeMode(DetailsViewMode.Edit);
            }

            if (e.CommandName == "Update")
            {
                CompanyDetailsView.ChangeMode(DetailsViewMode.Edit);
            }

            if (e.CommandName == "Cancel")
            {
                Literal1.Text = "Submission cancelled <br/> <p>Your changes have been discarded</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
            }
        }

        protected void LanguageDropDownList_Init(object sender, EventArgs e)
        {
            languageDropDownList = sender as DropDownList;
        }

        protected void CountryDropDownList_Init(object sender, EventArgs e)
        {
            countryDropDownList = sender as DropDownList;
        }

        protected void CurrencyDropDownList_Init(object sender, EventArgs e)
        {
            currencyDropDownList = sender as DropDownList;
        }

        protected void DateFormatDropDownList_Init(object sender, EventArgs e)
        {
            dateFormatDropDownList = sender as DropDownList;
        }

        protected void TimeFormatDropDownList_Init(object sender, EventArgs e)
        {
            timeFormatDropDownList = sender as DropDownList;
        }

        protected void TimeZoneDropDownList_Init(object sender, EventArgs e)
        {
            timeZoneDropDownList = sender as DropDownList;
        }

        protected void CompanyTypesDropDownList_Init(object sender, EventArgs e)
        {
            companyTypesDropDownList = sender as DropDownList;
        }

        protected void ModalPopButton2_Click(object sender, EventArgs e)
        {

        }

        protected void BankAccountTextBox_Load(object sender, EventArgs e)
        {
            UserBL userBL = new UserBL();
            string accountname = "";

            accountname = userBL.GetBankAccountName();

            if (accountname != null)
            {
                TextBox pe = (TextBox)CompanyDetailsView.FindControl("BankAccountTextBox");
                pe.Text = accountname;

            }
        }

        protected void SelectLinkButton1_Command(object sender, CommandEventArgs e)
        {
            UserBL userBL = new UserBL();
            string value = e.CommandArgument.ToString();

            int bankaccountid = Convert.ToInt32(value);
            int test = userBL.CompanySetBankAccountID(bankaccountid);

        }

       

        protected void BankInsertLinkButton_Click(object sender, EventArgs e)
        {
            UserBL userBL = new UserBL();
            int bankaccountid = 0;
           int bankid = userBL.CompanySetBankAccountID(bankaccountid);
        }

        protected void BankAccountDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {

            UserBL userBL = new UserBL();

            string accountname = userBL.GetBankAccountName();

            if (accountname != null)
            {
                TextBox pe = (TextBox)CompanyDetailsView.FindControl("BankAccountTextBox");
                pe.Text = accountname;

            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }

        protected void BankAccountDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            UserBL userBL = new UserBL();

            int bankaccountid = Convert.ToInt32(Session["NewBankID"]);
            int bankid = userBL.CompanySetBankAccountID(bankaccountid);

            string accountname = userBL.GetBankAccountName();

            if (accountname != null)
            {
                TextBox pe = (TextBox)CompanyDetailsView.FindControl("BankAccountTextBox");
                pe.Text = accountname;

            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModal('BodyContent_ModalPanel1');", true);
        }

        protected void BankAccountObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            int bankid = 0;
            bankid = Convert.ToInt32(e.ReturnValue);
            Session["NewBankID"] = bankid;
        }

        protected void CompanyObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            string value = "";
            value =  Convert.ToString(e.ReturnValue);
            Session["NewCompany"] = value;
        }



        protected void BankAccountTypeDropDownList_Init(object sender, EventArgs e)
        {
            bankAccountTypeDropDownList = sender as DropDownList;
            UserBL userBL = new UserBL();
            string value = userBL.CompanyBankAccountType();
            foreach (ListItem item in bankAccountTypeDropDownList.Items)
            {
                if (item.Value == value)
                {
                    item.Selected = true;
                    break;
                }
            }
        }

        protected void BankAccountDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["BankAccountType"] = bankAccountTypeDropDownList.SelectedValue;

        }

        protected void BankAccountDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            e.NewValues["BankAccountType"] = bankAccountTypeDropDownList.SelectedValue;
        }

      

 
       
    }
}