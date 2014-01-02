using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using C3App.DAL;
using C3App.BLL;
using System.IO;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using C3App.App_Code;
using System.Text;
using AjaxControlToolkit;
using System.Globalization;
using System.Data.SqlClient;

using System.Net;
using System.ComponentModel;
using System.Diagnostics;



namespace C3App.Documents
{
    public partial class Documents : PageBase
    {
        
        #region Initializing...........
        private DropDownList CategoryDropDownList;
        private DropDownList TemplateDropDownList;
        private DropDownList SubcategoriDropDownList;
        private DropDownList StatuseDropDownList;
        private DropDownList AssignedUserDropDownList;
        private DropDownList TeamDropDownList;
        private DocumentBL documentBL = new DocumentBL();
        private long documentID = 0;
        private long companyID;

        #endregion

        #region Page Function.............
        protected void Page_Load(object sender, EventArgs e)
        {
            companyID = Convert.ToInt32(Session["CompanyID"]);
            try
            {
                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        Session["EditDocumentID"] = 0;
                    }
                }
                if (Session["EditDocumentID"] != null)
                {
                    documentID = Convert.ToInt64(Session["EditDocumentID"]);
                    if (documentID == 0)
                    {
                        DocumentDetailsView.ChangeMode(DetailsViewMode.Insert);
                        FileFormat.Visible = true;
                        DocumentUpload.Visible = true;
                        DownloadLinkButton.Visible = false;


                        EditLinkButton.Visible = false;
                        DeleteLinkButton.Visible = false;
                        DocumentDownloadLinkButton.Visible = false;
                    }
                    else if (documentID > 0)
                    {
                        DocumentDetailsView.ChangeMode(DetailsViewMode.Edit);
                        FileFormat.Visible = false;
                        DocumentUpload.Visible = false;
                        DownloadLinkButton.Visible = true;

                        DocumentDownloadLinkButton.Visible = true;
                        if (CheckEdit() != false)
                            EditLinkButton.Visible = true;
                        if (CheckDelete() != false)
                            DeleteLinkButton.Visible = true;
                    }
                }
                else
                {
                    DocumentDetailsView.ChangeMode(DetailsViewMode.Insert);
                    FileFormat.Visible = true;
                    DocumentUpload.Visible = true;
                    DownloadLinkButton.Visible = false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        protected void Page_Error(object sender, EventArgs e)
        {
            Exception exc = Server.GetLastError();
            Response.Write("<h2>Something wrong happend!</h2>");
            Response.Write("<b>Exception Type: </b>" + exc.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Exception: </b>" + exc.Message.ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception Type: </b>" + exc.InnerException.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception: </b>" + exc.InnerException.Message + "<br/><br/>");
            Response.Write("<b>Inner Source: </b>" + exc.InnerException.Source + "<br/><br/>");
            ExceptionUtility.LogException(exc, "DocumentsPage");
            ExceptionUtility.NotifySystemOps(exc, "DocumentPage");
            Server.ClearError();
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            DocumentDetailsView.EnableDynamicData(typeof(Document));
        }
        #endregion


        #region select and Command Function of Documents...
        protected void SelectDocumentListLinkButton_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandArgument != null)
            {
                Session["EditDocumentID"] = e.CommandArgument.ToString();
                documentID = Convert.ToInt64(Session["EditDocumentID"]);

                //selected List
                int gindex = Convert.ToInt32(DocumentsGridView.SelectedIndex);
                if (gindex > -1)
                {
                    LinkButton nlbtn = DocumentsGridView.Rows[gindex].FindControl("SelectDocumentListLinkButton") as LinkButton;
                    nlbtn.CssClass = "";
                }
                LinkButton lbtn = sender as LinkButton;
                lbtn.CssClass = "active";

                DocumentDownloadLinkButton.Visible = true;
                if (CheckEdit() != false)
                    EditLinkButton.Visible = true;
                if (CheckDelete() != false)
                    DeleteLinkButton.Visible = true;

                IEnumerable<Document> documents = documentBL.GetDocumentByID(documentID);
                foreach (var document in documents)
                {
                    if (document.FilePath != null)
                    {
                        Session["DocPath"] = document.FilePath;
                    }
                }
                DocumentsListUpdatePanel.Update();
                DocumetnsMiniDetailsUpdatePanel.Update();
                MiniDocumentFormView.DataBind();
                MiniMoreDetailsView.DataBind();

            }
            else
            {
                Session["EditContactID"] = 0;
            }

        }

        protected void DocumentDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                documentID = 0;

                MessageHeaderLiteral.Text = "Changes Discarded";
                MessageBodyLabel.Text = " Your changes have been discarded.";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ShowAlertModal();", true);

                Session["EditDocumentID"] = 0;
                Session["DocPath"] = "";

                if (documentID == 0)
                {
                    DownloadLinkButton.Visible = false;
                    DocumentUpload.Visible = true;
                    FileFormat.Visible = true;

                }

                DocumentDetailsView.DataBind();
                DocumentDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }

        #endregion


        #region Document Tab Function.....
        protected void DocumentDetailLinkButton_Click(object sender, EventArgs e)
        {
            documentID = 0;
            Session["EditDocumentID"] = 0;
            Session["DocPath"] = "";
            DocumentDetailsView.ChangeMode(DetailsViewMode.Insert);
            DocumentDetailsView.DataBind();

            if (documentID == 0)
            {
                FileFormat.Visible = true;
                DocumentUpload.Visible = true;
                DownloadLinkButton.Visible = false;
            }


        }

        protected void ViewDocumentLinkButton_Click(object sender, EventArgs e)
        {
            DocumentsGridView.DataSourceID = DocumentListObjectDataSource.ID;
            DocumentsGridView.SelectedIndex = -1;
            DocumentsGridView.DataBind();
            DocumentsListUpdatePanel.Update();
            DocumetnsMiniDetailsUpdatePanel.Update();
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            DocumentDownloadLinkButton.Visible = false;
            DownloadLinkButton.Visible = false;
            DocumentUpload.Visible = false;
            FileFormat.Visible = false;


            Session["EditDocumentID"] = 0;
            Session["DocPath"] = "";
        }

        #endregion


        #region Insert Function of Documents...

        protected void DocumentDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            long userid;
            e.Values["FilePath"] = Session["DocPath"].ToString();
            if (String.IsNullOrEmpty(Session["CompanyID"].ToString())) { return; }
            else
            {
                e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            }
            if (String.IsNullOrEmpty(Session["UserID"].ToString())) { return; }
            else
            {
                userid = Convert.ToInt64(Session["UserID"]);
            }
            if (Convert.ToInt32(CategoryDropDownList.SelectedValue) == 0) { e.Values["CategoryID"] = null; }
            else { e.Values["CategoryID"] = CategoryDropDownList.SelectedValue; }

            if (Convert.ToInt32(SubcategoriDropDownList.SelectedValue) == 0) { e.Values["SubcategoryID"] = null; }
            else { e.Values["SubcategoryID"] = SubcategoriDropDownList.SelectedValue; }

            if (Convert.ToInt32(StatuseDropDownList.SelectedValue) == 0) { e.Values["StatusID"] = null; }
            else { e.Values["StatusID"] = StatuseDropDownList.SelectedValue; }

            if (Convert.ToInt32(TemplateDropDownList.SelectedValue) == 0) { e.Values["TemplateID"] = null; }
            else { e.Values["TemplateID"] = TemplateDropDownList.SelectedValue; }

            if (Convert.ToInt32(AssignedUserDropDownList.SelectedValue) == 0) { e.Values["AssignedUserID"] = null; }
            else { e.Values["AssignedUserID"] = AssignedUserDropDownList.SelectedValue; }

            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.Values["TeamID"] = null; }
            else { e.Values["TeamID"] = TeamDropDownList.SelectedValue; }

            e.Values["CreatedBy"] = userid;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;
        }

        protected void DocumentObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Insert failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;
            }
            else
            {
                this.DocumentsGridView.DataBind();
                this.MiniDocumentFormView.DataBind();
                this.MiniMoreDetailsView.DataBind();

                DocumentDetailsView.DataBind();
                DetailsPanel.Visible = true;
                MessageHeaderLiteral.Text = "Success";
                MessageBodyLabel.Text = " Document has been successfully saved";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ShowAlertModal();", true);
                DocumentDetailsView.ChangeMode(DetailsViewMode.Insert);

                Session["EditDocumentID"] = 0;
                Session["DocPath"] = "";
            }
        }
        #endregion


        #region Update Function of Documents...

        protected void DocumentDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            long userid = Convert.ToInt64(Session["UserID"]);

            if (Convert.ToInt32(CategoryDropDownList.SelectedValue) == 0) { e.NewValues["CategoryID"] = null; }
            else { e.NewValues["CategoryID"] = CategoryDropDownList.SelectedValue; }

            if (Convert.ToInt32(SubcategoriDropDownList.SelectedValue) == 0) { e.NewValues["SubcategoryID"] = null; }
            else { e.NewValues["SubcategoryID"] = SubcategoriDropDownList.SelectedValue; }

            if (Convert.ToInt32(StatuseDropDownList.SelectedValue) == 0) { e.NewValues["StatusID"] = null; }
            else { e.NewValues["StatusID"] = StatuseDropDownList.SelectedValue; }

            if (Convert.ToInt32(TemplateDropDownList.SelectedValue) == 0) { e.NewValues["TemplateID"] = null; }
            else { e.NewValues["TemplateID"] = TemplateDropDownList.SelectedValue; }

            if (Convert.ToInt32(AssignedUserDropDownList.SelectedValue) == 0) { e.NewValues["AssignedUserID"] = null; }
            else { e.NewValues["AssignedUserID"] = AssignedUserDropDownList.SelectedValue; }

            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.NewValues["TeamID"] = null; }
            else { e.NewValues["TeamID"] = TeamDropDownList.SelectedValue; }

            e.NewValues["ModifiedBy"] = userid;
            e.NewValues["ModifiedTime"] = DateTime.Now;
        }

        protected void DocumentObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Update failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;
            }
            else
            {
                documentID = 0;

                MessageHeaderLiteral.Text = "Success";
                MessageBodyLabel.Text = " Document has been successfully updeated";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "ShowAlertModal();", true);
                DocumentDetailsView.ChangeMode(DetailsViewMode.Insert);
                Session["EditDocumentID"] = 0;
                DocumentDetailsView.DataBind();
                this.DocumentsGridView.DataBind();
                this.MiniDocumentFormView.DataBind();
                this.MiniMoreDetailsView.DataBind();

                Session["DocPath"] = "";

                if (documentID == 0)
                {
                    FileFormat.Visible = true;
                    DocumentUpload.Visible = true;
                    DownloadLinkButton.Visible = false;
                }


            }
        }
        #endregion


        #region Dropdown List Initialization....

        protected void CategoryDropDownList_Init(object sender, EventArgs e)
        {
            CategoryDropDownList = sender as DropDownList;
        }

        protected void AssignedUserDropDownList_Init(object sender, EventArgs e)
        {
            AssignedUserDropDownList = sender as DropDownList;
        }

        protected void TeamNameDropDownList_Init(object sender, EventArgs e)
        {
            TeamDropDownList = sender as DropDownList;
        }

        protected void SubcategoryDropDownList_Init(object sender, EventArgs e)
        {
            SubcategoriDropDownList = sender as DropDownList;

        }

        protected void StatusDropDownList_Init(object sender, EventArgs e)
        {
            StatuseDropDownList = sender as DropDownList;
        }

        protected void TemplateDropDownList_Init(object sender, EventArgs e)
        {
            TemplateDropDownList = sender as DropDownList;
        }

        #endregion


        #region Documents Edit, Delete, Search Function.......


        protected void EditLinkButton_Click(object sender, EventArgs e)
        {

            if (documentID == 0)
            {
                DocumentDetailsView.ChangeMode(DetailsViewMode.Insert);
                DownloadLinkButton.Visible = false;
                DocumentUpload.Visible = true;
                FileFormat.Visible = true;

            }
            else if (documentID > 0)
            {
                DocumentDetailsView.ChangeMode(DetailsViewMode.Edit);
                FileFormat.Visible = false;
                DocumentUpload.Visible = false;
                DownloadLinkButton.Visible = true;
            }
        }

        protected void DeleteLinkButton_Click(object sender, EventArgs e)
        {
            documentID = Convert.ToInt64(Session["EditDocumentID"]);
            DocumentBL documentBL = new DocumentBL();
            documentBL.DeleteDocumentByID(documentID);
            Session["EditDocumentID"] = 0;
            this.DocumentsGridView.DataBind();
            this.DocumentsGridView.SelectedIndex = -1;
            this.MiniDocumentFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            DocumentsListUpdatePanel.Update();
            DocumetnsMiniDetailsUpdatePanel.Update();
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            DocumentDownloadLinkButton.Visible = false;

        }

        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            DocumentDownloadLinkButton.Visible = false;

            DocumentsGridView.DataSourceID = DocumentListObjectDataSource.ID;
            this.DocumentsGridView.DataBind();
            this.DocumentsGridView.SelectedIndex = -1;
            this.MiniDocumentFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            DocumentsListUpdatePanel.Update();
            DocumetnsMiniDetailsUpdatePanel.Update();
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            DocumentDownloadLinkButton.Visible = false;

            DocumentsGridView.DataSourceID = DocumentSearchObjectDataSource.ID;
            this.DocumentsGridView.DataBind();
            this.DocumentsGridView.SelectedIndex = -1;
            this.MiniDocumentFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            DocumentsListUpdatePanel.Update();
            DocumetnsMiniDetailsUpdatePanel.Update();
        }

        protected void SearchMarketingDocumentsLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            DocumentDownloadLinkButton.Visible = false;

            DocumentsGridView.DataSourceID = MarketingDocumentsObjectDataSource.ID;
            this.DocumentsGridView.DataBind();
            this.DocumentsGridView.SelectedIndex = -1;
            this.MiniDocumentFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            DocumentsListUpdatePanel.Update();
            DocumetnsMiniDetailsUpdatePanel.Update();
        }

        protected void SearchSalesDocumentsLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            DocumentDownloadLinkButton.Visible = false;

            DocumentsGridView.DataSourceID = SalesDocumentsObjectDataSource.ID;
            this.DocumentsGridView.DataBind();
            this.DocumentsGridView.SelectedIndex = -1;
            this.MiniDocumentFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            DocumentsListUpdatePanel.Update();
            DocumetnsMiniDetailsUpdatePanel.Update();
        }

        protected void SearchOrderDocumentsLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            DocumentDownloadLinkButton.Visible = false;

            DocumentsGridView.DataSourceID = OrderDocumentsObjectDataSource.ID;
            this.DocumentsGridView.DataBind();
            this.DocumentsGridView.SelectedIndex = -1;
            this.MiniDocumentFormView.DataBind();
            this.MiniMoreDetailsView.DataBind();
            DocumentsListUpdatePanel.Update();
            DocumetnsMiniDetailsUpdatePanel.Update();
        }
        #endregion


        #region Document Upload Function.....

        protected void DocumentDownloadLinkButton_Click(object sender, EventArgs e)
        {
            DocumetnsMiniDetailsUpdatePanel.Update();

           string filePath = Session["DocPath"].ToString();
           if (filePath != "")
           {
               string path = Server.MapPath(filePath);
               System.IO.FileInfo file = new System.IO.FileInfo(path);
               if (file.Exists)
               {
                   Response.Clear();
                   Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);
                   Response.AddHeader("Content-Length", file.Length.ToString());
                   Response.ContentType = "application/octet-stream";
                   Response.WriteFile(file.FullName);
                   Response.End();
               }
               else
               {
                   Response.Write("This file does not exist.");
               }

           }
        }

        protected void DocumentUpload_UploadComplete(object sender, AjaxControlToolkit.AjaxFileUploadEventArgs e)
        {
            Session["DocPath"] = "";

            string year = DateTime.Today.Year.ToString(CultureInfo.InvariantCulture);
            string month = DateTime.Today.Month.ToString(CultureInfo.InvariantCulture);
            if (month.Length != 2) { month = "0" + month; }

            string date = DateTime.Today.Day.ToString(CultureInfo.InvariantCulture);
            if (date.Length != 2) { date = "0" + date; }
            string hour = DateTime.Now.Hour.ToString(CultureInfo.InvariantCulture);
            if (hour.Length != 2) { hour = "0" + hour; }
            string minute = DateTime.Now.Minute.ToString(CultureInfo.InvariantCulture);
            if (minute.Length != 2) { minute = "0" + minute; }
            string secound = DateTime.Now.Second.ToString(CultureInfo.InvariantCulture);
            if (secound.Length != 2) { secound = "0" + secound; }


            var test = companyID.ToString();
            int i = test.Length;
            int append = 10 - i;
            string serial = "";
            for (int j = 0; j < append; j++)
            {
                serial += "0";
            }
            serial = serial + companyID;

            string fileUploadDirectory = "~/UserData/Docs/" + companyID + "/";

            var PhysicalFileUploadDirectory = Server.MapPath(fileUploadDirectory);

            if (!Directory.Exists(PhysicalFileUploadDirectory))
            {
                Directory.CreateDirectory(PhysicalFileUploadDirectory);
            }

            string fileName = e.FileName;
            string extension = System.IO.Path.GetExtension(fileName);
            string fileNameWithoutExtension = System.IO.Path.GetFileNameWithoutExtension(fileName);

            //string imagefilename = "D" + serial + "-" + year + month + "-";
            string imagefilename = "D" + serial + "-" + year + month + date + hour + minute + secound + "";

            //string encodedImageName = Encryptdata(fileName);
            //string documentPath = string.Concat(fileUploadDirectory + imagefilename + encodedImageName + extension);
            string documentPath = string.Concat(fileUploadDirectory + imagefilename + extension);
            DocumentUpload.SaveAs(Server.MapPath(documentPath));
            Session["DocPath"] = documentPath;
        }

        public string Encryptdata(string filename)
        {
            string strmsg = string.Empty;
            byte[] encode = new byte[filename.Length];
            encode = Encoding.UTF8.GetBytes(filename);
            strmsg = Convert.ToBase64String(encode);
            return strmsg;
        }

        protected void DocumentDetailsView_DataBound(object sender, EventArgs e)
        {
            if (documentID > 0)
            {
                FileFormat.Visible = false;
                DocumentUpload.Visible = false;
                DownloadLinkButton.Visible = true;
            }
            else if (documentID == 0)
            {
                DownloadLinkButton.Visible = false;
                DocumentUpload.Visible = true;
                FileFormat.Visible = true;

            }

        }


        //protected void DocumentNameText_TextChanged(object sender, EventArgs e)
        //{
        //    string fp = Session["DocPath"].ToString();

        //    if (fp == String.Empty && documentID == 0)
        //    {
        //        TextBox documentName = DocumentDetailsView.FindControl("DocumentNameText") as TextBox;
        //        documentName.Text = null;
        //        string script = string.Format("alert('{0}');", "Please select file and upload it");
        //        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "key_name", script, true);
        //    }

        //}

        #endregion


    }
}


//Hhh5Nz26














