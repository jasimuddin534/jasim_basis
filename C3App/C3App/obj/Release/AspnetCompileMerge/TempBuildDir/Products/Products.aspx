<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="C3App.Products.Products" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    
  <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">
        
        <asp:LinkButton ID="ProductInsertLinkButton" SkinID="TabTitle"  runat="server"  CommandArgument="Insert" Text="Create Product" OnClientClick="GoToTab(1, 'Create Product');" OnClick="ProductInsertLinkButton_Click" />
        <asp:Label ID="MsgLabel" runat="server"  Text=""></asp:Label>
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">

            <asp:UpdatePanel runat="server" ID="ProductDetailsUpdatePanel">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ProductInsertLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                </Triggers>

                <ContentTemplate>
                  <asp:ValidationSummary ID="ProductValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="sum" ShowValidationErrors="True"/>
                    <asp:ObjectDataSource ID="ProductDetailsObjectDataSource" runat="server"
                        TypeName="C3App.BLL.ProductBL" DataObjectTypeName="C3App.DAL.Product"
                        InsertMethod="InsertProduct" UpdateMethod="UpdateProduct" SelectMethod="GetProductByID">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditProductID" Name="productID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>

                    <asp:DetailsView ID="ProductDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="field-label" 
                        DataSourceID="ProductDetailsObjectDataSource" AutoGenerateRows="False" DefaultMode="Insert"
                        DataKeyNames="Name,ProductID,CreatedTime,CreatedBy"
                        OnItemCommand="ProductDetailsView_ItemCommand"
                        OnItemInserting="ProductDetailsView_ItemInserting"
                        OnItemUpdating="ProductDetailsView_ItemUpdating"
                        OnItemUpdated="ProductDetailsView_ItemUpdated"
                        OnItemInserted="ProductDetailsView_ItemInserted">
                         <EmptyDataTemplate>
                            <p>
                                No data found.<br/>Please select a product from list to edit..
                            </p>
                        </EmptyDataTemplate>
                        <Fields>
                           <asp:DynamicField DataField="Name" HeaderText="Product Name" ValidationGroup="sum" />
                            <asp:DynamicField DataField="SKU" HeaderText="SKU" ValidationGroup="sum" />
                              <asp:TemplateField HeaderText="Product Category">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource runat="server" ID="ProductCategoryObjectDataSource" DataObjectTypeName="C3App.DAL.ProductCategory" TypeName="C3App.BLL.ProductBL" SelectMethod="GetProductCategories"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="ProductCategoryDropDownList" runat="server" AutoPostBack="False" AppendDataBoundItems="true"
                                        DataSourceID="ProductCategoryObjectDataSource" DataTextField="Value" DataValueField="ProductCategoryID"
                                        OnInit="ProductCategoryDropDownList_Init" SelectedValue='<%# Eval("CategoryID")==null ? "0" : Eval("CategoryID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Product Type">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource runat="server" ID="ProductTypeObjectDataSource" DataObjectTypeName="C3App.DAL.ProductType" SelectMethod="GetProductTypes" TypeName="C3App.BLL.ProductBL"></asp:ObjectDataSource>
                                    <asp:DropDownList runat="server" ID="ProductTypeDropDownList" DataSourceID="ProductTypeObjectDataSource" DataTextField="Value"
                                        DataValueField="ProductTypeID" AppendDataBoundItems="true"
                                        OnInit="ProductTypeDropDownList_Init" SelectedValue='<%# Eval("TypeID")==null ? "0" : Eval("TypeID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Product Status">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource runat="server" ID="ProductStatusObjectDataSource" DataObjectTypeName="C3App.DAL.ProductStatus" SelectMethod="GetProductStatuses" TypeName="C3App.BLL.ProductBL"></asp:ObjectDataSource>
                                    <asp:DropDownList runat="server" ID="ProductStatusDropDownList" DataSourceID="ProductStatusObjectDataSource" DataTextField="Value"
                                        DataValueField="ProductStatusID" AppendDataBoundItems="true"
                                        OnInit="ProductStatusDropDownList_Init" SelectedValue='<%# Eval("StatusID")==null ? "0" : Eval("StatusID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="Color" HeaderText="Color" ValidationGroup="sum" />
                            <asp:DynamicField DataField="Weight" HeaderText="Weight" ValidationGroup="sum" />
                             <asp:DynamicField DataField="Quantity" HeaderText="Quantity" ValidationGroup="sum" />
                            <asp:TemplateField HeaderText="Date Available" SortExpression="DateAvailable">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="DateAvailableTextBox" CssClass="datepicker" runat="server" Text='<%# Bind("DateAvailable","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                    </EditItemTemplate>
                              </asp:TemplateField>
                              <asp:TemplateField HeaderText="Manufacturer">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource runat="server" ID="ManufacturerObjectDataSource" DataObjectTypeName="C3App.DAL.Manufacturer" SelectMethod="GetManufacturers" TypeName="C3App.BLL.ProductBL"></asp:ObjectDataSource>
                                    <asp:DropDownList runat="server" ID="ManufacturerDropDownList" DataSourceID="ManufacturerObjectDataSource" DataTextField="Name"
                                        DataValueField="ManufacturerID" AppendDataBoundItems="true"
                                        OnInit="ManufacturerDropDownList_Init" SelectedValue='<%# Eval("ManufacturerID")==null ? "0" : Eval("ManufacturerID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Minimum Options">
                                <EditItemTemplate>
                                    <asp:CompareValidator runat="server" CssClass="input-validate" ID="MinQuantityCompare" ControlToValidate="MinimumOptionsTextBox" Operator="DataTypeCheck" Type="Integer" Display="None" ErrorMessage="Minimum Options must be Integer" ValidationGroup="sum" />
                                    <asp:TextBox ID="MinimumOptionsTextBox" runat="server" Text='<%# Bind("MinimumOptions") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                              <asp:TemplateField HeaderText="Maximum Options">
                                <EditItemTemplate>
                                    <asp:CompareValidator ID="MaxQuantityCompare" CssClass="input-validate" runat="server" Type="Integer" ControlToCompare="MinimumOptionsTextBox"
                                        ControlToValidate="MaximumOptionsTextBox" Operator="GreaterThanEqual" ErrorMessage="Max Option must be greater or equals Min Options *" ValidationGroup="sum" Display="Dynamic"></asp:CompareValidator>
                                    <asp:TextBox ID="MaximumOptionsTextBox" runat="server" Text='<%# Bind("MaximumOptions") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="Location" HeaderText="Location" ValidationGroup="sum" />
                            <asp:DynamicField DataField="Website" HeaderText="Website" ValidationGroup="sum" />
                            <asp:DynamicField DataField="MFTPartNumber" HeaderText="MFT Part Number" ValidationGroup="sum" />
                           <asp:DynamicField DataField="VendorPartNumber" HeaderText="Vendor Part Number" ValidationGroup="sum" />
                           <asp:DynamicField DataField="Cost" HeaderText="Cost" ValidationGroup="sum" />
                            <asp:DynamicField DataField="ListPrice" HeaderText="List Price" ValidationGroup="sum" />
                            <asp:DynamicField DataField="DiscountPrice" HeaderText="Discount Price" ValidationGroup="sum" />
                            <asp:TemplateField HeaderText="Pricing formula">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource runat="server" ID="PricingFormulaObjectDataSource" DataObjectTypeName="C3App.DAL.PricingFormula" SelectMethod="GetPricingFormulas" TypeName="C3App.BLL.ProductBL"></asp:ObjectDataSource>
                                    <asp:DropDownList runat="server" ID="PricingFormulaDropDownList" DataSourceID="PricingFormulaObjectDataSource" DataTextField="Value"
                                        DataValueField="PricingFormulaID" AppendDataBoundItems="true"
                                        OnInit="PricingFormulaDropDownList_Init" SelectedValue='<%# Eval("PricingFormulaID")==null ? "0" : Eval("PricingFormulaID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="PricingFactor" HeaderText="Pricing Factor" ValidationGroup="sum" />
                             <asp:TemplateField HeaderText="Discount Name">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource runat="server" ID="DiscountNameObjectDataSource" DataObjectTypeName="C3App.DAL.Discount" TypeName="C3App.BLL.ProductBL" SelectMethod="GetDiscounts"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="DiscountNameDropDownList" runat="server" AutoPostBack="False" AppendDataBoundItems="true"
                                        DataSourceID="DiscountNameObjectDataSource" DataTextField="Name" DataValueField="DiscountID"
                                        OnInit="DiscountNameDropDownList_Init" SelectedValue='<%# Eval("DiscountID")==null ? "0" : Eval("DiscountID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Support Term">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="SupportTermDropDownList" runat="server" OnInit="SupportTermDropDownList_Init" >
                                        <asp:ListItem Value="N/A" Text="None" />
                                        <asp:ListItem Value="Sixmonths">Six months</asp:ListItem>
                                        <asp:ListItem Value="One">One year</asp:ListItem>
                                        <asp:ListItem Value="Two">Two years</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="SupportName" HeaderText="Support Name" ValidationGroup="sum" />
                            <asp:DynamicField DataField="SupportContact" HeaderText="Support Contact" ValidationGroup="sum" />
                            <asp:DynamicField DataField="SupportDescription" HeaderText="Support Description" ValidationGroup="sum" />
                            <asp:DynamicField DataField="Description" HeaderText="Description" ValidationGroup="sum" />
                            
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                <asp:LinkButton ID="CancelLinkButton1" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Update" ValidationGroup="sum" Text="Save"></asp:LinkButton>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                  <asp:LinkButton ID="CancelLinkButton2" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                  <asp:LinkButton ID="InsertLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" ValidationGroup="sum" Text="Save"></asp:LinkButton>
                                </InsertItemTemplate>
                            </asp:TemplateField>

                            <%-- end dynamic --%>
                            <%--<asp:TemplateField HeaderText="Product Name">
                                <EditItemTemplate>
                                     <asp:RequiredFieldValidator CssClass="input-validate" ID="NameRequiredValidator" runat="server"
                                        ControlToValidate="NameTextBox" ValidationGroup="sum" ErrorMessage="Product name required"  Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="NameTextBox" CssClass="required-field" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
                            
                              

                           <%--  <asp:TemplateField HeaderText="Quantity">
                                <EditItemTemplate>
                                     <asp:RequiredFieldValidator CssClass="input-validate" ID="QuantityRequiredValidator" runat="server"
                                        ControlToValidate="QuantityTextBox" ValidationGroup="sum" ErrorMessage="Quantity required"  Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator runat="server" CssClass="input-validate" ID="QuantityCompare" ControlToValidate="QuantityTextBox" Operator="DataTypeCheck" Type="Integer" Display="None" ErrorMessage="Quantity must be Integer" ValidationGroup="sum" />
                                    <asp:TextBox ID="QuantityTextBox" CssClass="required-field" runat="server" Text='<%# Bind("Quantity") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
                           
                           <%-- <asp:TemplateField HeaderText="SKU">
                                <EditItemTemplate>
                                     <asp:RequiredFieldValidator CssClass="input-validate" ID="SKURequiredValidator" runat="server"
                                        ControlToValidate="SKUTextBox" ValidationGroup="sum" ErrorMessage="SKU required"  Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="SKUTextBox" CssClass="required-field" runat="server" Text='<%# Bind("SKU") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Color">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ColorTextBox" runat="server" Text='<%# Bind("Color") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                             <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight" />--%>
                             <%-- <asp:TemplateField HeaderText="Location">
                                <EditItemTemplate>
                                    <asp:TextBox ID="LocationTextBox" runat="server" Text='<%# Bind("Location") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
                          <%--  <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website" />
                             <asp:BoundField DataField="MFTPartNumber" HeaderText="MFT Part Number" SortExpression="MFTPartNumber" />
                            <asp:BoundField DataField="VendorPartNumber" HeaderText="Vendor Part Number" SortExpression="VendorPartNumber" />
                             <asp:TemplateField HeaderText="Cost">
                                <EditItemTemplate>
                                     <asp:RegularExpressionValidator ID="CostValidator" CssClass="input-validate" runat="server" ControlToValidate="CostTextBox" Text="*"
                                        Display="Dynamic" ErrorMessage="Cost must be decimal number" ValidationGroup="sum" ValidationExpression="^\d{1,15}(?:\.\d\d)?$" SetFocusOnError="True">
                                    </asp:RegularExpressionValidator>
                                     <asp:RequiredFieldValidator CssClass="input-validate" ID="CostPriceRequiredValidator" runat="server"
                                        ControlToValidate="CostTextBox" ValidationGroup="sum" Text="*" ErrorMessage="Cost required" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="CostTextBox" CssClass="required-field" runat="server" Text='<%# Bind("Cost") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="List Price">
                                <EditItemTemplate>
                                     <asp:RequiredFieldValidator CssClass="input-validate" ID="ListPriceRequiredValidator" runat="server" 
                                        ControlToValidate="ListPriceTextBox" ValidationGroup="sum" ErrorMessage="List price required"  Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="ListPriceValidator" CssClass="input-validate" runat="server" ControlToValidate="ListPriceTextBox" Text="*"
                                        Display="Dynamic" ErrorMessage="List Price must be decimal number" ValidationGroup="sum" ValidationExpression="^\d{1,15}(?:\.\d\d)?$" SetFocusOnError="True">
                                    </asp:RegularExpressionValidator>
                                    <asp:TextBox ID="ListPriceTextBox" CssClass="required-field" runat="server" Text='<%# Bind("ListPrice") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Discount Price">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DiscountPriceTextBox" runat="server" Text='<%# Bind("DiscountPrice") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
                            <%--<asp:BoundField DataField="PricingFactor" HeaderText="Pricing Factor" SortExpression="PricingFactor" />--%>
                            <%-- <asp:BoundField DataField="SupportName" HeaderText="Support Name" SortExpression="SupportName"></asp:BoundField>
                            <asp:BoundField DataField="SupportContact" HeaderText="Support Contact" SortExpression="SupportContact"></asp:BoundField>
                            <asp:TemplateField HeaderText="Support Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="SupportDescriptionTextBox" runat="server" Text='<%# Bind("SupportDescription") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DescriptionTextBox" runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
                        </Fields>
                    </asp:DetailsView>

                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="ProductDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="ProductDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </asp:Panel>
    </asp:Panel>
    
     <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">
        <asp:LinkButton runat="server" ID="UpdateTab2" SkinID="TabTitle" OnClick="UpdateButton_Click" OnClientClick="GoToTab(2, 'Create Product');" Text="View Products"/>
        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">
            
              <asp:ObjectDataSource ID="SearchObjectDataSource" runat="server" SelectMethod="SearchProduct" TypeName="C3App.BLL.ProductBL" DataObjectTypeName="C3App.DAL.Product">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
            
            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="Panel5" runat="server" CssClass="filter">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="SearchAllLinkButton" CssClass="search-label active"  OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                    <asp:LinkButton runat="server" ID="MobileLinkButton" CssClass="search-label active"  OnClick="MobileLinkButton_Click">Mobile</asp:LinkButton>
                    <asp:LinkButton runat="server" ID="CarLinkButton" CssClass="search-label active"  OnClick="CarLinkButton_Click">Car</asp:LinkButton>
                    <asp:LinkButton runat="server" ID="AvailableLinkButton" CssClass="search-label active"  OnClick="AvailableLinkButton_Click">Available</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="SearchPanel2" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server" OnTextChanged="SearchTextBox_TextChanged"></asp:TextBox>
                    <asp:LinkButton CssClass="search-btn" ID="SearchButton" runat="server" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>

                    <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">
                        
                        <asp:UpdatePanel ID="ViewProductsUpdatepanel" runat="server" UpdateMode="Conditional">
                            
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="UpdateTab2" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="MobileLinkButton" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="CarLinkButton" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="AvailableLinkButton" EventName="Click" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:ObjectDataSource ID="ProductsViewObjectDataSource" runat="server"
                                    TypeName="C3App.BLL.ProductBL" DataObjectTypeName="C3App.DAL.Product" SelectMethod="GetProducts"></asp:ObjectDataSource>
                                
                                 <asp:ObjectDataSource ID="MobileObjectDataSource" runat="server"
                                    TypeName="C3App.BLL.ProductBL" DataObjectTypeName="C3App.DAL.Product" SelectMethod="GetProductsByMobileCategory"></asp:ObjectDataSource>
                                 <asp:ObjectDataSource ID="CarObjectDataSource" runat="server"
                                    TypeName="C3App.BLL.ProductBL" DataObjectTypeName="C3App.DAL.Product" SelectMethod="GetProductsByCarCategory"></asp:ObjectDataSource>
                                 <asp:ObjectDataSource ID="AvailableProductsObjectDataSource" runat="server"
                                    TypeName="C3App.BLL.ProductBL" DataObjectTypeName="C3App.DAL.Product" SelectMethod="GetAvailableProducts"></asp:ObjectDataSource>

                                <asp:GridView ID="ViewProductsGridView" DataSourceID="ProductsViewObjectDataSource"
                                    runat="server" CssClass="list-form" AutoGenerateColumns="False" GridLines="None"
                                    DataKeyNames="ProductID" ShowHeader="false" >
                                     <EmptyDataTemplate>
                                        <p>
                                            No Product found...
                                        </p>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="Image" runat="server" ImageUrl="~/Content/images/c3/product.jpg" />
                                                <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("ProductID") %>' CommandName="Select" CausesValidation="False" OnCommand="SelectLinkButton_Command">                                                    
                                                    <%# Eval("Name") %> 
                                                    <asp:Label ID="MFTPartNumberLabel" runat="server" Text='<%# Eval("MFTPartNumber") %>'></asp:Label>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                         <asp:UpdateProgress ID="ProductsUpdateProgress" runat="server" AssociatedUpdatePanelID="ViewProductsUpdatepanel" DynamicLayout="true" DisplayAfter="0">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                    </asp:Panel>
            

                        <asp:UpdatePanel ID="miniProductDetailsUpdatePanel" runat="server" UpdateMode="Conditional">
                       
                            <ContentTemplate>
                                  <asp:Panel ID="MiniDetailBasicPanel" SkinID="MiniDetailBasicPanel" runat="server">
                                 <asp:ObjectDataSource ID="MiniProductObjectDataSource" runat="server"
                            SelectMethod="GetProductByID" TypeName="C3App.BLL.ProductBL" DataObjectTypeName="C3App.DAL.Product">
                            <SelectParameters>
                                <%--<asp:ControlParameter ControlID="ViewProductsGridView" Type="String" Name="search" PropertyName="SelectedValue" />--%>
                                <asp:ControlParameter ControlID="ViewProductsGridView" Type="Int64" Name="productID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                                <asp:FormView ID="MiniProductsFormView" CssClass="mini-details-form"
                                      DataKeyNames="ProductID" runat="server" DataSourceID="MiniProductObjectDataSource">
                                     <EmptyDataTemplate>
                                        <p>
                                            No Product selected...
                                        </p>
                                    </EmptyDataTemplate>
                                     <ItemTemplate>
                                        <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/product.jpg" />
                                         <asp:Panel ID="Panel3" runat="server">
                                             <asp:Label ID="NameLabel" CssClass="fullname" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                             <asp:Label ID="VendorPartNumberLabel" runat="server" CssClass="box-number" Text='<%# Bind("VendorPartNumber") %>'></asp:Label>
                                             <asp:Label ID="ProductCategoryLabel" runat="Server" CssClass="quantity" Text='<%# Eval("ProductCategory.Value") %>'></asp:Label>
                                             <asp:Label ID="CostLabel" runat="server" CssClass="amount" Text='<%# Bind("Cost") %>'></asp:Label>
                                             <asp:Label ID="QuantityLabel" runat="server" CssClass="quantity" Text='<%# Bind("Quantity") %>'></asp:Label>
                                             <%--<asp:Label ID="ListPriceLabel" runat="server" CssClass="listprice" Text='<%# Bind("ListPrice") %>'></asp:Label> --%>
                                         </asp:Panel>
                                    </ItemTemplate>
                                   
                                </asp:FormView>

                                <asp:Panel ID="ButtonPanel" runat="server" CssClass="mini-detail-control-panel two-controls">
                                    <ul>
                                       <%-- <li>
                                            <asp:LinkButton ID="ModalPopButton2" CssClass="control-btn" runat="server" OnClientClick="OpenModal('BodyContent_ModalPanel2')">
                                            <i class="icon-calendar"></i>
                                            </asp:LinkButton>
                                        </li>--%>
                                        <li>
                                            <asp:LinkButton ID="EditLinkButton" runat="server" Text="Edit" CssClass="control-btn" CommandArgument="" OnClientClick="GoToTab(1,'Product Details');" OnClick="ProductEditButton_Click">
                                            <i class="icon-edit"></i>
                                            </asp:LinkButton>
                                        </li>
                                        <li>
                                            <asp:Panel ID="DeletePanel" runat="server" CssClass="slide-confirm">
                                            <asp:LinkButton ID="DeleteLinkButton" runat="server" CssClass="control-btn has-confirm" Text="Delete">
                                            <i class="icon-trash"></i>
                                            </asp:LinkButton>
                                                <asp:LinkButton ID="DeleteConfirmButton" runat="server" OnClick="DeleteButton_Click">Confirm</asp:LinkButton>
                                                <asp:LinkButton ID="DeleteCancelButton" runat="server" CssClass="slide-cancel">Cancel</asp:LinkButton>
                                            </asp:Panel>
                                        </li>
                                        </ul>
                                </asp:Panel>
                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <asp:DetailsView ID="miniProductDetailsView" DataSourceID="MiniProductObjectDataSource" AutoGenerateRows="False" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label">
                            <EmptyDataTemplate>
                                <p>
                                    No Product selected...
                                </p>
                            </EmptyDataTemplate>
                            <Fields>
                                  <asp:TemplateField HeaderText="Product Status">
                                    <ItemTemplate>
                                        <asp:Label ID="ProductStatusLabel" runat="Server" Text='<%# Eval("ProductStatus.Value") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Product Category">
                                    <ItemTemplate>
                                        <asp:Label ID="ProductCategoryLabel" runat="Server" Text='<%# Eval("ProductCategory.Value") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                     <asp:TemplateField HeaderText="Product Type">
                                    <ItemTemplate>
                                        <asp:Label ID="ProductTypeLabel" runat="Server" Text='<%# Eval("ProductType.Value") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                   <asp:TemplateField HeaderText="Date Available" SortExpression="DateAvailable">
                                    <ItemTemplate>
                                        <asp:Label ID="DateAvailableLabel" runat="server"  Text='<%# Bind("DateAvailable","{0:d}") %>' ></asp:Label>
                                    </ItemTemplate>
                                  </asp:TemplateField>
                                <asp:BoundField DataField="SKU" HeaderText="SKU" SortExpression="SKU"></asp:BoundField>
                                <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website"></asp:BoundField>
                                <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity"></asp:BoundField>
                                <asp:BoundField DataField="Weight" HeaderText="Weight" SortExpression="Weight"></asp:BoundField>
                               <asp:BoundField DataField="Color" HeaderText="Color" SortExpression="Color"></asp:BoundField>
                                <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location"></asp:BoundField>
                                 <asp:BoundField DataField="MFTPartNumber" HeaderText="MFT PartNumber" SortExpression="MFTPartNumber"></asp:BoundField>
                                <asp:BoundField DataField="VendorPartNumber" HeaderText="Vendor PartNumber" SortExpression="VendorPartNumber"></asp:BoundField>
                               <asp:TemplateField HeaderText="Manufacturer Name">
                                    <ItemTemplate>
                                        <asp:Label ID="ManufacturerNameLabel" runat="Server" Text='<%# Eval("Manufacturer.Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="MinimumOptions" HeaderText="Minimum Options" SortExpression="MinimumOptions"></asp:BoundField>
                                <asp:BoundField DataField="MaximumOptions" HeaderText="Maximum Options" SortExpression="MaximumOptions"></asp:BoundField>
                                <asp:BoundField DataField="Cost" HeaderText="Cost" SortExpression="Cost"></asp:BoundField>
                                <asp:BoundField DataField="ListPrice" HeaderText="List Price" SortExpression="ListPrice"></asp:BoundField>
                                <asp:BoundField DataField="DiscountPrice" HeaderText="Discount Price" SortExpression="DiscountPrice"></asp:BoundField>
                               
                                  <asp:TemplateField HeaderText="Discount Name">
                                    <ItemTemplate>
                                        <asp:Label ID="DiscountNameLabel" runat="Server" Text='<%# Eval("Discount.Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Pricing Formula">
                                    <ItemTemplate>
                                        <asp:Label ID="PricingFormulaLabel" runat="Server" Text='<%# Eval("PricingFormula.Value") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="PricingFactor" HeaderText="Pricing Factor" SortExpression="PricingFactor"></asp:BoundField>
                                <asp:BoundField DataField="SupportName" HeaderText="Support Name" SortExpression="SupportName"></asp:BoundField>
                                <asp:BoundField DataField="SupportContact" HeaderText="Support Contact" SortExpression="SupportContact"></asp:BoundField>
                                <asp:BoundField DataField="SupportDescription" HeaderText="Support Description" SortExpression="SupportDescription"></asp:BoundField>
                                <asp:BoundField DataField="SupportTerm" HeaderText="Support Term" SortExpression="SupportTerm"></asp:BoundField>
                                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                                
                            </Fields>
                        </asp:DetailsView>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
    </asp:Panel>
    
    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="mymodalUpdatePanel" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="MsgLiteral" runat="server" Text=""></asp:Literal>
                </h4>
                <!-- Edit this for the alert title -->
                <a class="close-reveal-modal">&#215;</a>
                 <asp:Label ID="alertLabel" runat="server" Text=""></asp:Label>
                <!-- Place your Content Here -->
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
