using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.App_Code;
using C3App.BLL;


namespace C3App.Products
{
    public partial class Products : PageBase
    {
        readonly ProductBL productBL=new ProductBL();
        public int companyID;
        private DropDownList productStatusDropDownList;
        private DropDownList supportTermDropDownList;
        private DropDownList productCategoryDropDownList;
        private DropDownList pricingFormulasDropDownList;
        private DropDownList manufacturersDropDownList;
        private DropDownList productTyepDropDownList;
        private DropDownList discountNameDropDownList;


        protected void Page_Load(object sender, EventArgs e)
        {
          companyID = Convert.ToInt32(Session["CompanyID"]);

            try
            {
                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        EditLinkButton.Visible = false;
                       // ModalPopButton2.Visible = false;
                        DeleteLinkButton.Visible = false;
                        Session.Remove("EditProductID");
                    }
                }
                if (Session["EditProductID"] != null)
                {
                    long productID = Convert.ToInt64(Session["EditProductID"]);

                    if (productID == 0)
                    {
                        ProductDetailsView.ChangeMode(DetailsViewMode.Insert);
                    }
                    else if (productID > 0)
                    {
                        ProductDetailsView.ChangeMode(DetailsViewMode.Edit);
                    }
                }
                else
                {
                    ProductDetailsView.ChangeMode(DetailsViewMode.Insert);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            } 
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            ProductDetailsView.EnableDynamicData(typeof(DAL.Product));
        }


        //catch page error
        protected void Page_Error(object sender, EventArgs e)
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
            ExceptionUtility.LogException(exc, "ProductPage");
            ExceptionUtility.NotifySystemOps(exc, "ProductPage");

            //Clear the error from the server
            Server.ClearError();
        }

        //start dropdownlist initialization
        protected void ProductStatusDropDownList_Init(object sender, EventArgs e)
        {
            productStatusDropDownList = sender as System.Web.UI.WebControls.DropDownList;
        }
        protected void ProductCategoryDropDownList_Init(object sender, EventArgs e)
        {
            productCategoryDropDownList = sender as System.Web.UI.WebControls.DropDownList;
        }
        protected void PricingFormulaDropDownList_Init(object sender, EventArgs e)
        {
            pricingFormulasDropDownList = sender as System.Web.UI.WebControls.DropDownList;
        }
        protected void DiscountNameDropDownList_Init(object sender, EventArgs e)
        {
            discountNameDropDownList = sender as System.Web.UI.WebControls.DropDownList;
        }
        protected void ProductTypeDropDownList_Init(object sender, EventArgs e)
        {
            productTyepDropDownList = sender as System.Web.UI.WebControls.DropDownList;
        }
        protected void ManufacturerDropDownList_Init(object sender, EventArgs e)
        {
            manufacturersDropDownList = sender as System.Web.UI.WebControls.DropDownList;
        }
        protected void SupportTermDropDownList_Init(object sender, EventArgs e)
        {
            supportTermDropDownList = sender as DropDownList;
            long productID = Convert.ToInt64(Session["EditProductID"]);
            if (productID > 0)
            {
                string supportTerm = productBL.GetSupportTermByProductID(productID);
                if (supportTermDropDownList != null)
                    foreach (ListItem item in supportTermDropDownList.Items)
                    {
                        if (item.Text == supportTerm)
                        {
                            item.Selected = true;
                            break;
                        }
                    }
                else
                {
                    if (supportTermDropDownList != null) supportTermDropDownList.SelectedItem.Text = "None";
                }
            }
        }
        //end dropdownlist initialization

        // clears & update panels
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            Session["EditProductID"] = 0;
            ViewProductsGridView.DataBind();
            ViewProductsGridView.SelectedIndex = -1;
            ViewProductsUpdatepanel.Update();
            MiniProductsFormView.DataBind();
            miniProductDetailsUpdatePanel.Update();
            // ModalPopButton2.Visible = false;
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
        }


        //cancel command
        protected void ProductDetailsView_ItemCommand(Object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                //code to stay in current tab
                MsgLiteral.Text = "Submission cancelled";
                alertLabel.Text = "Your changes have been discarded";
                ProductDetailsView.DataBind();
                ProductDetailsView.ChangeMode(DetailsViewMode.Insert);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                //Code to move to ViewProducts Tab
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
            }
            //if (e.CommandName == "Edit")
            //{
            //    ProductDetailsView.ChangeMode(DetailsViewMode.Edit);
            //}

            //if (e.CommandName == "Update")
            //{
            //    ProductDetailsView.ChangeMode(DetailsViewMode.Edit);
            //}
        }


        //select product from list
        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            if (CheckEdit() != false)
                EditLinkButton.Visible = true;
            if (CheckDelete() != false)
                DeleteLinkButton.Visible = true;
            //highlight selected row start
            int gindex = Convert.ToInt32(ViewProductsGridView.SelectedIndex);
            if (gindex > -1)
            {

                LinkButton nlbtn = ViewProductsGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                nlbtn.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            if (lbtn != null) lbtn.CssClass = "active";
            //highlight selected row end

           Session["EditProductID"] = e.CommandArgument.ToString();
           miniProductDetailsUpdatePanel.Update();
        }


        //Code for showing changed searching products of the company
        protected void SearchTextBox_TextChanged(object sender, EventArgs e)
        {
            string search = SearchTextBox.Text;
            productBL.SearchProduct(search);
        }


        //Code for showing searching products of the company
        protected void SearchButton_Click(object sender, EventArgs e)
        {
            ViewProductsGridView.DataSourceID = SearchObjectDataSource.ID;
            ViewProductsGridView.DataBind();
            ViewProductsUpdatepanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }


        //Search all products of the company
        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            ViewProductsGridView.DataSourceID = ProductsViewObjectDataSource.ID;
            ViewProductsGridView.DataBind();
            ViewProductsUpdatepanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }

        protected void MobileLinkButton_Click(object sender, EventArgs e)
        {
            ViewProductsGridView.DataSourceID = MobileObjectDataSource.ID;
            ViewProductsGridView.DataBind();
            ViewProductsUpdatepanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }

        protected void CarLinkButton_Click(object sender, EventArgs e)
        {
            ViewProductsGridView.DataSourceID = CarObjectDataSource.ID;
            ViewProductsGridView.DataBind();
            ViewProductsUpdatepanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }

        protected void AvailableLinkButton_Click(object sender, EventArgs e)
        {
            ViewProductsGridView.DataSourceID = AvailableProductsObjectDataSource.ID;
            ViewProductsGridView.DataBind();
            ViewProductsUpdatepanel.Update();
            //string search = SearchTextBox.Text;
            //accountBL.SearchAccount(search);
        }

       //edit product info
        protected void ProductEditButton_Click(object sender, EventArgs e)
        {
            //ProductInsertLinkButton.Text = "Product Details";
            long productID = Convert.ToInt64(Session["EditProductID"]);
            if (productID == 0)
            {
                ProductDetailsView.DataSource = null;
                ProductDetailsView.DataBind();
            }
            ProductDetailsView.ChangeMode(DetailsViewMode.Edit);
        }


        //inserting new product
        protected void ProductDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.Values["CreatedBy"] = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
            e.Values["ModifiedBy"] = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
            e.Values["SupportTerm"] = supportTermDropDownList.SelectedItem.Text;

            if (Convert.ToInt32(productStatusDropDownList.SelectedValue) == 0)
            {
                e.Values["StatusID"] = null;
            }
            else
            {
                e.Values["StatusID"] = productStatusDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(productCategoryDropDownList.SelectedValue) == 0)
            {
                e.Values["CategoryID"] = null;
            }
            else
            {
                e.Values["CategoryID"] = productCategoryDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(productTyepDropDownList.SelectedValue) == 0)
            {
                e.Values["TypeID"] = null;
            }
            else
            {
                e.Values["TypeID"] = productTyepDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(pricingFormulasDropDownList.SelectedValue) == 0)
            {
                e.Values["PricingFormulaID"] = null;
            }
            else
            {
                e.Values["PricingFormulaID"] = pricingFormulasDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(discountNameDropDownList.SelectedValue) == 0)
            {
                e.Values["DiscountID"] = null;
            }
            else
            {
                e.Values["DiscountID"] = discountNameDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(manufacturersDropDownList.SelectedValue) == 0)
            {
                e.Values["ManufacturerID"] = null;
            }
            else
            {
                e.Values["ManufacturerID"] = manufacturersDropDownList.SelectedValue;
            }
        }


        //Updating old product
        protected void ProductDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            e.NewValues["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            e.NewValues["ModifiedTime"] = DateTime.Now;
            e.NewValues["ModifiedBy"] = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
            e.NewValues["SupportTerm"] = supportTermDropDownList.SelectedItem.Text;

            if (Convert.ToInt32(productStatusDropDownList.SelectedValue) == 0)
            {
                e.NewValues["StatusID"] = null;
            }
            else
            {
                e.NewValues["StatusID"] = productStatusDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(productCategoryDropDownList.SelectedValue) == 0)
            {
                e.NewValues["CategoryID"] = null;
            }
            else
            {
                e.NewValues["CategoryID"] = productCategoryDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(productTyepDropDownList.SelectedValue) == 0)
            {
                e.NewValues["TypeID"] = null;
            }
            else
            {
                e.NewValues["TypeID"] = productTyepDropDownList.SelectedValue;
            }
            if (Convert.ToInt32(pricingFormulasDropDownList.SelectedValue) == 0)
            {
                e.NewValues["PricingFormulaID"] = null;
            }
            else
            {
                e.NewValues["PricingFormulaID"] = pricingFormulasDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(discountNameDropDownList.SelectedValue) == 0)
            {
                e.NewValues["DiscountID"] = null;
            }
            else
            {
                e.NewValues["DiscountID"] = discountNameDropDownList.SelectedValue;
            }

            if (Convert.ToInt32(manufacturersDropDownList.SelectedValue) == 0)
            {
                e.NewValues["ManufacturerID"] = null;
            }
            else
            {
                e.NewValues["ManufacturerID"] = manufacturersDropDownList.SelectedValue;
            }
        }


        //after inserting a product
        protected void ProductDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Save failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;
            }
            else
            {
                int rowcount = e.AffectedRows;
                if (rowcount == -1)
                {
                    string name = e.Values["Name"].ToString();
                    MsgLiteral.Text = "Success";
                    alertLabel.Text = "This Product " + name + " has been saved";
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                }
                //else
                //{
                //    MsgLiteral.Text = "Sorry,Save failed";
                //    alertLabel.Text = "Please try again";
                //}
            }
            
            MiniProductsFormView.DataBind();
            miniProductDetailsView.DataBind();
            ViewProductsGridView.DataBind();
            miniProductDetailsUpdatePanel.Update();
            Session["EditProductID"] = 0;
            ProductDetailsView.DataBind();
        }


        //after Updating a product
        protected void ProductDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
           
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Save failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;
            }
            else
            {
                int rowcount = e.AffectedRows;
                if (rowcount == -1)
                {
                    string name = e.NewValues["Name"].ToString();
                    MsgLiteral.Text = "Success";
                    alertLabel.Text = "This Product " + name + " has been saved";
                    //ShowAlertModal();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                }
                //else
                //{
                //    MsgLiteral.Text = "Sorry,Save failed";
                //    alertLabel.Text = "Please try again";
                //}
                MiniProductsFormView.DataBind();
                miniProductDetailsView.DataBind();
                ViewProductsGridView.DataBind();
                miniProductDetailsUpdatePanel.Update();
                Session["EditProductID"] = 0;
                ProductDetailsView.DataBind();
            }
        }


        //delete a product
        protected void DeleteButton_Click(object sender, EventArgs e)
        {
            long productID = Convert.ToInt64(Session["EditProductID"]);
            productBL.DeleteProduct(productID);
            this.ViewProductsGridView.DataBind();
            this.MiniProductsFormView.DataBind();
            this.miniProductDetailsView.DataBind();
            ViewProductsUpdatepanel.Update();
            miniProductDetailsUpdatePanel.Update();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);
        }


        //CreateProduct button click
        protected void ProductInsertLinkButton_Click(object sender, EventArgs e)
        {
            Session["EditProductID"] = 0;
            ProductDetailsView.ChangeMode(DetailsViewMode.Insert);
        }
    }
}