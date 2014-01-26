<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Quotes.aspx.cs" Inherits="C3App.Quotes.Quotes" %>
<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">
        function subTotal() {
            var sub_total = 0;

            function setDefault(variable) {
                if (variable == '') {
                    variable = 0;
                } else {
                    variable = parseFloat(variable);
                }
            }

            $.each($("input[id*='BodyContent_QuoteDetailsGridView_ListPriceTextBox']"), function () {
                var listPrice = $(this).val();
                var quantity = $(this).parents('tr').find(("input[id*='BodyContent_QuoteDetailsGridView_QuantityTextBox']")).val();
                var discount = $(this).parents('tr').find(("input[id*='BodyContent_QuoteDetailsGridView_DiscountTextBox']")).val();

                setDefault(listPrice);
                setDefault(quantity);
                setDefault(discount);

                sub_total = sub_total + (listPrice * quantity); // without discount
                sub_total = parseInt(sub_total - (sub_total * (discount / 100))); // with discount

            })
            $("input[title='Subtotal']").attr('value', sub_total);
            var bigDiscount = $("input[title='Discount']").val();
            var shipping = $("input[title='Shipping']").val();
            var tax = $("input[title='Tax']").attr('value');

            setDefault(bigDiscount);
            setDefault(shipping);
            setDefault(tax);

            var total = sub_total - (sub_total * (bigDiscount / 100)); // with discount        
            total = parseInt(total + (total * (tax / 100))); // with tax
            if (parseInt(shipping) > 0) {
                total = parseInt(total) + parseInt(shipping); // with shipping
            }
            $("input[title='Total']").attr('value', total);
        }
    </script>
</asp:Content>

<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">

    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">
        <%--<asp:LinkButton   ID="QuoteInsertButton" runat="server" SkinID="TabTitle" Text="Quote Details" CommandArgument="Insert" OnClientClick="GoToTab(1);" OnClick="QuoteInsertButton_Click"  >--%>
        <asp:LinkButton ID="QuoteInsertButton" runat="server" SkinID="TabTitle" Text="" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Quotation');" OnClick="QuoteInsertButton_Click">Create Quotation</asp:LinkButton>
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">

            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <%--                    <asp:AsyncPostBackTrigger ControlID="UpdateTab1"  EventName="Click" />--%>
                    <asp:AsyncPostBackTrigger ControlID="QuoteInsertButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="QuoteEditLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <asp:ValidationSummary ID="QuotesValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                    <%-- 
                        Place your DetialsPanel Content Here 
                    --%>
                    <asp:Label ID="message" runat="server" Visible="False" Text="AccountLabel"></asp:Label>
                    <asp:ObjectDataSource ID="QuotesObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Quote" InsertMethod="InsertQuote" SelectMethod="QuoteByID" TypeName="C3App.BLL.QuoteBL" DeleteMethod="DeleteQuote" UpdateMethod="UpdateQuote" OnInserted="QuotesObjectDataSource_Inserted" OnUpdated="QuotesObjectDataSource_Updated">

                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditQuoteID" Name="QuoteID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:DetailsView ID="QuotesDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="field-label" AutoGenerateRows="False"
                        DataSourceID="QuotesObjectDataSource" OnItemInserted="QuotesDetailsView_ItemInserted" OnItemInserting="QuotesDetailsView_ItemInserting"
                        OnItemUpdated="QuotesDetailsView_ItemUpdated" OnItemUpdating="QuotesDetailsView_ItemUpdating"
                        DataKeyNames="QuoteID,Name,CreatedTime,CompanyID,CreatedBy,ShippingAccountID,BillingAccountID,ShippingContactID,
                        BillingContactID,OpportunityID,QuoteNumber"
                        OnItemCommand="QuotesDetailsView_ItemCommand" DefaultMode="Insert">
                        <Fields>
                            <asp:DynamicField DataField="Name" HeaderText="Name" SortExpression="Name" ValidationGroup="sum" />
                            <%-- <EditItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("Name") %>' ID="QuoteNameTextBox"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="NameRequiredValidator" runat="server"  ControlToValidate="QuoteNameTextBox" Display="Static" ErrorMessage="Quote Name Required" Text="*" ForeColor="Red" ValidationGroup="sum" />

                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox runat="server" CssClass="required-field" Text='<%# Bind("Name") %>' ID="QuoteNameTextBox"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="NameRequiredValidator" runat="server" ControlToValidate="QuoteNameTextBox" Display="Static" ErrorMessage="Quote Name Required" Text="*" ForeColor="Red" ValidationGroup="sum" />
                                </InsertItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Quote Number" SortExpression="QuoteNumber">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("QuoteNumber") %>' ID="QuoteNumberTextBox" ReadOnly="True"></asp:TextBox>
                                    <%--                                    <asp:RequiredFieldValidator ID="QuoteNumberRequiredValidator" runat="server" ControlToValidate="QuoteNumberTextBox" Display="Static" ErrorMessage="Quote Number Required" Text="*" ForeColor="Red" ValidationGroup="sum" />--%>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox runat="server" CssClass="required-field" Text='<%# Bind("QuoteNumber") %>' ID="QuoteNumberTextBox" ReadOnly="True"></asp:TextBox>
                                    <%--                                    <asp:RequiredFieldValidator ID="QuoteNumberRequiredValidator" runat="server" ControlToValidate="QuoteNumberTextBox" Display="Static" ErrorMessage="Quote Number Required" Text="*" ForeColor="Red" ValidationGroup="sum" />--%>
                                </InsertItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Payment Terms" SortExpression="PaymentTermID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="PaymentTermsDataSource" runat="server" DataObjectTypeName="C3App.DAL.PaymentTerm" SelectMethod="GetPaymentTerms" TypeName="C3App.BLL.QuoteBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="PaymentTermsDropDownList" runat="server" DataSourceID="PaymentTermsDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("PaymentTermID")==null ? "-1" : Eval("PaymentTermID") %>'
                                        DataTextField="Value" DataValueField="PaymentTermID" OnInit="PaymentTermsDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="PaymentTermsDataSource" runat="server" DataObjectTypeName="C3App.DAL.PaymentTerm" SelectMethod="GetPaymentTerms" TypeName="C3App.BLL.QuoteBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="PaymentTermsDropDownList" runat="server" DataSourceID="PaymentTermsDataSource" AppendDataBoundItems="True"
                                        DataTextField="Value" DataValueField="PaymentTermID" OnInit="PaymentTermsDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Opportunity Name" SortExpression="OpportunityID">
                                <EditItemTemplate>
                                    <asp:TextBox ID="OpportunityNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("Opportunity.Name") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton9" runat="server" CommandArgument="Opportunities" OnClick="SelectButton_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="OpportunityNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("OpportunityID") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton8" runat="server" CommandArgument="Opportunities" OnClick="SelectButton_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="OpportunityID" runat="server" Text='<%# Eval("Opportunity.Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Quote Stage" SortExpression="QuoteStageID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="QuoteStagesDataSource" runat="server" DataObjectTypeName="C3App.DAL.QuoteStage" SelectMethod="GetQuoteStages" TypeName="C3App.BLL.QuoteBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="QuoteStagesDropDownList" runat="server" DataSourceID="QuoteStagesDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("QuoteStageID")==null ? "-1" : Eval("QuoteStageID") %>'
                                        DataTextField="Value" DataValueField="QuoteStageID" OnInit="QuoteStagesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="QuoteStagesDataSource" runat="server" DataObjectTypeName="C3App.DAL.QuoteStage" SelectMethod="GetQuoteStages" TypeName="C3App.BLL.QuoteBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="QuoteStagesDropDownList" runat="server" DataSourceID="QuoteStagesDataSource" AppendDataBoundItems="True"
                                        DataTextField="Value" DataValueField="QuoteStageID" OnInit="QuoteStagesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Date Valid Until" SortExpression="ExpireDate">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("ExpireDate", "{0:d}") %>' CssClass="datepicker" ID="TextBox4"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("ExpireDate") %>' CssClass="datepicker" ID="TextBox4"></asp:TextBox>
                                </InsertItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Original P.O. Date" SortExpression="PurchaseDate">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("PurchaseDate", "{0:d}") %>' CssClass="datepicker" ID="TextBox3"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("PurchaseDate") %>' CssClass="datepicker" ID="TextBox3"></asp:TextBox>
                                </InsertItemTemplate>

                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Billing Account" SortExpression="BillingAccountID">
                                <EditItemTemplate>
                                    <asp:TextBox ID="BillingAccountNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("Account.Name") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton109" runat="server" CommandArgument="BillingAccounts" OnClick="BillingAccountsSelectButton_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="BillingAccountNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("BillingAccountID") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton4" runat="server" CommandArgument="BillingAccounts" OnClick="BillingAccountsSelectButton_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="AccountID" runat="server" Text='<%# Eval("Account.Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Billing Contact" SortExpression="BillingContactID">
                                <EditItemTemplate>

                                    <asp:TextBox ID="BillingContactNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("Contact.FirstName") +" "+   Eval("Contact.LastName")%>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button runat="server" ID="ModalPopButton101" SkinID="ButtonWithTextBox" CommandArgument="BillingContacts" OnClick="BillingContactsSelectButton_Click"
                                        Text="Select" OnClientClick="OpenModal('BodyContent_ModalPanel1')" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="BillingContactNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("BillingContactID")%>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button runat="server" ID="ModalPopButton1" SkinID="ButtonWithTextBox" CommandArgument="BillingContacts" OnClick="BillingContactsSelectButton_Click"
                                        Text="Select" OnClientClick="OpenModal('BodyContent_ModalPanel1')" />
                                    <%--                                    <asp:RequiredFieldValidator CssClass="input-validate" ID="FirstNameRequiredValidator" runat="server" ControlToValidate="BillingContactNameTextBox" ValidationGroup="sum" ForeColor="Red" ErrorMessage="Name is required"></asp:RequiredFieldValidator>--%>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="BillingContactNameTextBox" runat="server" Text='<%# Eval("Contact.FirstName") +" "+   Eval("Contact.LastName")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Billing Street" SortExpression="BillingStreet">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" TextMode="MultiLine" Text='<%# Bind("BillingStreet") %>' ID="TextBox6"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox runat="server" TextMode="MultiLine" Text='<%# Bind("BillingStreet") %>' ID="TextBox6"></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" TextMode="MultiLine" Text='<%# Bind("BillingStreet") %>' ID="Label6"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="BillingCity" HeaderText="Billing City" SortExpression="BillingCity" ValidationGroup="sum"></asp:DynamicField>


                            <asp:DynamicField DataField="BillingState" HeaderText="Billing State" SortExpression="BillingState" ValidationGroup="sum"></asp:DynamicField>
                            <asp:DynamicField DataField="BillingZip" HeaderText="Billing Zip" SortExpression="BillingZip" ValidationGroup="sum"></asp:DynamicField>
                            <asp:TemplateField HeaderText="Billing Country" SortExpression="BillingCountry">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="BillingCountryDataSource" runat="server" DataObjectTypeName="C3App.DAL.Country" SelectMethod="GetCountries" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="BillingCountryDropDownList" runat="server" DataSourceID="BillingCountryDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("BillingCountry")==null ? "-1" : Eval("BillingCountry") %>'
                                        DataTextField="CountryName" DataValueField="CountryID" OnInit="BillingCountryDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="BillingCountryDataSource" runat="server" DataObjectTypeName="C3App.DAL.Country" SelectMethod="GetCountries" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="BillingCountryDropDownList" runat="server" DataSourceID="BillingCountryDataSource" AppendDataBoundItems="True"
                                        DataTextField="CountryName" DataValueField="CountryID" OnInit="BillingCountryDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Shipping Account" SortExpression="ShippingAccountID">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ShippingAccountNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("Account1.Name") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton56" runat="server" CommandArgument="ShippingAccounts" OnClick="ShippingAccountsSelectButton_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="ShippingAccountNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("ShippingAccountID") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton5" runat="server" CommandArgument="ShippingAccounts" OnClick="ShippingAccountsSelectButton_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="AccountID" runat="server" Text='<%# Eval("Account.Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Shipping Contact" SortExpression="ShippingContactID">
                                <EditItemTemplate>

                                    <asp:TextBox ID="ShippingContactNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("Contact1.FirstName") +" "+   Eval("Contact1.LastName")%>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button runat="server" ID="ModalPopButton77" SkinID="ButtonWithTextBox" CommandArgument="ShippingContacts" OnClick="ShippingContactsSelectButton_Click"
                                        Text="Select" OnClientClick="OpenModal('BodyContent_ModalPanel1')" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="ShippingContactNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("ShippingContactID")%>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button runat="server" ID="ModalPopButton7" SkinID="ButtonWithTextBox" CommandArgument="ShippingContacts" OnClick="ShippingContactsSelectButton_Click"
                                        Text="Select" OnClientClick="OpenModal('BodyContent_ModalPanel1')" />
                                    <%--                                    <asp:RequiredFieldValidator CssClass="input-validate" ID="FirstNameRequiredValidator" runat="server" ControlToValidate="ShippingContactNameTextBox" ValidationGroup="sum" ForeColor="Red" ErrorMessage="Name is required"></asp:RequiredFieldValidator>--%>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="ShippingContactNameTextBox" runat="server" Text='<%# Eval("Contact.FirstName") +" "+   Eval("Contact.LastName")%>'></asp:Label>


                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Shipping Street" SortExpression="ShippingStreet">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" TextMode="MultiLine" Text='<%# Bind("ShippingStreet") %>' ID="TextBox1"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox runat="server" TextMode="MultiLine" Text='<%# Bind("ShippingStreet") %>' ID="TextBox1"></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" TextMode="MultiLine" Text='<%# Bind("ShippingStreet") %>' ID="Label1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:DynamicField DataField="ShippingCity" HeaderText="Shipping City" SortExpression="ShippingCity" ValidationGroup="sum"></asp:DynamicField>
                            <asp:DynamicField DataField="ShippingState" HeaderText="Shipping State" SortExpression="ShippingState" ValidationGroup="sum"></asp:DynamicField>
                            <asp:DynamicField DataField="ShippingZip" HeaderText="Shipping Zip" SortExpression="ShippingZip" ValidationGroup="sum"></asp:DynamicField>
                            <asp:TemplateField HeaderText="Shipping Country" SortExpression="ShippingCountry">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="ShippingCountryDataSource" runat="server" DataObjectTypeName="C3App.DAL.Country" SelectMethod="GetCountries" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="ShippingCountryDropDownList" runat="server" DataSourceID="ShippingCountryDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("ShippingCountry")==null ? "-1" : Eval("ShippingCountry") %>'
                                        DataTextField="CountryName" DataValueField="CountryID" OnInit="ShippingCountryDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="ShippingCountryDataSource" runat="server" DataObjectTypeName="C3App.DAL.Country" SelectMethod="GetCountries" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="ShippingCountryDropDownList" runat="server" DataSourceID="ShippingCountryDataSource" AppendDataBoundItems="True"
                                        DataTextField="CountryName" DataValueField="CountryID" OnInit="ShippingCountryDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Currency " SortExpression="CurrencyID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CurrenciesDataSource" runat="server" DataObjectTypeName="C3App.DAL.Currency" SelectMethod="GetCurrencies" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CurrenciesDropDownList" runat="server" DataSourceID="CurrenciesDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Bind("CurrencyID") %>'
                                        DataTextField="Name" DataValueField="CurrencyID" OnInit="CurrenciesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="CurrenciesDataSource" runat="server" DataObjectTypeName="C3App.DAL.Currency" SelectMethod="GetCurrencies" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CurrenciesDropDownList" runat="server" DataSourceID="CurrenciesDataSource" AppendDataBoundItems="True"
                                        DataTextField="Name" DataValueField="CurrencyID" OnInit="CurrenciesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>

                            <asp:DynamicField DataField="ConversionRate" HeaderText="Conversion Rate" SortExpression="ConversionRate" ValidationGroup="sum"></asp:DynamicField>
                            <asp:DynamicField DataField="TaxRate" HeaderText="Tax Rate" SortExpression="TaxRate" ValidationGroup="sum"></asp:DynamicField>
                            <asp:DynamicField DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper" ValidationGroup="sum"></asp:DynamicField>
                            <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" SortExpression="Subtotal">
                                <ItemStyle CssClass="replaced" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Discount" HeaderText="Discount" SortExpression="Discount">
                                <ItemStyle CssClass="replaced" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Shipping" HeaderText="Shipping" SortExpression="Shipping">
                                <ItemStyle CssClass="replaced" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Tax" HeaderText="Tax" SortExpression="Tax">
                                <ItemStyle CssClass="replaced" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total">
                                <ItemStyle CssClass="replaced" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignTODataSource" runat="server" DataObjectTypeName="C3App.DAL.User" SelectMethod="GetUsers" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssignedToDropDownList" runat="server" DataSourceID="AssignTODataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("AssignedUserID")==null ? "-1" : Eval("AssignedUserID") %>'
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssignedToDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="AssignTODataSource" runat="server" DataObjectTypeName="C3App.DAL.User" SelectMethod="GetUsers" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssignedToDropDownList" runat="server" DataSourceID="AssignTODataSource" AppendDataBoundItems="True"
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssignedToDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Teams" SortExpression="TeamID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TeamsDataSource" runat="server" DataObjectTypeName="C3App.DAL.Team" SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsDropDownList" runat="server" DataSourceID="TeamsDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("TeamID")==null ? "-1" : Eval("TeamID") %>'
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="TeamsDataSource" runat="server" DataObjectTypeName="C3App.DAL.Team" SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsDropDownList" runat="server" DataSourceID="TeamsDataSource" AppendDataBoundItems="True"
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                <ItemStyle CssClass="replaced" />
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>' ID="TextBox2"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>' ID="TextBox2"></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>' ID="Label2"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Select Products">
                                <EditItemTemplate>
                                    <asp:Button ID="ModalPopButton14" runat="server" CommandArgument="ProductID"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel2');return false;" SkinID="ButtonWithTextBox" Text="Select" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:Button ID="ModalPopButton14" runat="server" CommandArgument="ProductID"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel2');return false;" SkinID="ButtonWithTextBox" Text="Select" />
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:ObjectDataSource ID="QuoteDetailsObjectDataSource" runat="server" SelectMethod="GetQuoteDetails" DataObjectTypeName="C3App.DAL.QuoteDetail" TypeName="C3App.BLL.QuoteBL"
                                        InsertMethod="InsertQuoteDetails" UpdateMethod="UpdateQuoteDetails"></asp:ObjectDataSource>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Update" Text="Save" ValidationGroup="sum"></asp:LinkButton>&nbsp;
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="LinkButton4" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="InsertLinkButton3" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" ValidationGroup="sum" Text="Save"></asp:LinkButton>&nbsp;
                                </InsertItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                    </asp:DetailsView>
                    <asp:GridView ID="QuoteDetailsGridView" runat="server" CssClass="grid-form" AutoGenerateColumns="False" DataKeyNames="QuoteLineID,QuoteID" OnRowDeleting="QuoteDetailsGridView_RowDeleting">
                        <Columns>
                            <asp:TemplateField HeaderText="Quantity">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("Quantity") %>' ID="QuantityTextBox"></asp:TextBox>

                                    <%--                                    <asp:RequiredFieldValidator ID="NameRequiredValidator" runat="server" ControlToValidate="QuantityTextBox" Display="Static" ErrorMessage="A product must be select" Text="*" ForeColor="Red" ValidationGroup="sum" />--%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("Name") %>' ID="NameLabel"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="MftPartNum">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("MftPartNum") %>' ID="MftPartNumLabel"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Cost">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("Cost") %>' ID="CostPriceTextBox"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ListPrice">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("ListPrice") %>' ID="ListPriceTextBox"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Discount">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("Discount") %>' ID="DiscountTextBox"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Note">
                                <ItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("Note") %>' TextMode="MultiLine" ID="NoteTextBox"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="False" HeaderText="ProductID">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("ProductID") %>' ID="ProductIDLabel"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="False" HeaderText="QuoteLineID">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("QuoteLineID") %>' ID="QuoteLineIDLabel"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="False" HeaderText="QuoteID">
                                <InsertItemTemplate>
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("QuoteID") %>' ID="QuoteIDLabel"></asp:Label>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("QuoteID") %>' ID="QuoteIDLabel"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <span onclick="return confirm('Are you sure to Delete the record?')">
                                        <asp:LinkButton ID="lnkB" runat="Server" Text="Delete" CommandName="Delete"></asp:LinkButton>
                                    </span>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <%--             </ContentTemplate>
                        
                    </Asp:UpdatePanel> --%>
                    <%--                             <asp:HiddenField ID="hfQuotelineID" runat="server" Value=""/>--%>

                    <%--                            <asp:LinkButton ID="SaveLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" Text="Insert" OnClick="SaveButton_Click"></asp:LinkButton>--%>

                    <div class="replaced-field">
                        <table class="details-form" id="tableTotalDemo">
                            <tbody>
                            </tbody>
                        </table>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress runat="server" ID="LeadDetailsUpdateProgress" LeadDetailsUpdateProgress="UpdatePanel1">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>

        <asp:Panel ID="ModalPanel1" SkinID="ModalPopLeft" runat="server">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

            <asp:UpdatePanel runat="server" ID="UpdatePanel3" UpdateMode="Always">
                <Triggers>
                    <%--<asp:AsyncPostBackTrigger ControlID="ModalPopaccountSearchButton" EventName="Click" />--%>
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="ModalLabel" runat="server" SkinID="ModalTitle"></asp:Label>
                    <asp:Panel ID="ModalCreatePanel" SkinID="ModalCreatePanel" runat="server">
                        <%--                    Create Panel--%>
                        <%-- 
                            Place your Create Panel Content Here 
                        --%>

                        <asp:Panel ID="ContactPanel" Visible="False" runat="server">



                            <asp:ObjectDataSource ID="ContactCreateObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Contact" InsertMethod="InsertContact" SelectMethod="GetContacts" TypeName="C3App.BLL.ContactBL"></asp:ObjectDataSource>

                            <asp:DetailsView ID="ContactCreateDetailsView" runat="server" AutoGenerateRows="False" Visible="False" DataSourceID="ContactCreateObjectDataSource" DefaultMode="Insert" OnItemInserted="ContactCreateDetailsView_ItemInserted" OnItemInserting="ContactCreateDetailsView_ItemInserting" OnItemCommand="ContactCreateDetailsView_ItemCommand">
                                <Fields>


                                    <asp:BoundField DataField="FirstName" HeaderText="First Name" SortExpression="FirstName"></asp:BoundField>
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                                    <asp:TemplateField HeaderText="Account Name" SortExpression="AccountID">
                                        <EditItemTemplate>
                                            <asp:TextBox runat="server" Text='<%# Bind("AccountID") %>' ID="TextBox1"></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:ObjectDataSource ID="AccountsDataSource" runat="server"
                                                SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL"
                                                DataObjectTypeName="C3App.DAL.Account"></asp:ObjectDataSource>
                                            <asp:DropDownList ID="AccountsDropDownList" runat="server"
                                                DataSourceID="AccountsDataSource"
                                                DataTextField="Name" DataValueField="AccountID"
                                                OnInit="accountDropDownList_Init">
                                            </asp:DropDownList>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("AccountID") %>' ID="Label1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="PrimaryEmail" HeaderText="Email Address" SortExpression="PrimaryEmail"></asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="ContactSelectLinkButton" runat="server" CommandArgument='<%# Eval("ContactID") %>'
                                                CommandName="Insert" CausesValidation="False"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Fields>

                            </asp:DetailsView>
                            <%--                                <asp:LinkButton ID="ContactCreate" runat="server" CommandArgument="Insert" OnClientClick="GoToTab(1);" OnClick="ContactCreate_Click"  />--%>
                            <%--                            <asp:LinkButton ID="CreateContactLinkButton" runat="server" OnClick="CreateContactLinkButton_Click">Create New Contact</asp:LinkButton>--%>
                        </asp:Panel>
                        <asp:Panel ID="AccountPanel" Visible="False" runat="server">

                            <asp:ObjectDataSource ID="AccountCreateObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Account" InsertMethod="InsertAccount" SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL"></asp:ObjectDataSource>

                            <asp:DetailsView ID="AccountCreateDetailsView" runat="server" AutoGenerateRows="False" Visible="False" DataSourceID="AccountCreateObjectDataSource" DefaultMode="Insert" OnItemInserted="AccountCreateDetailsView_ItemInserted" OnItemInserting="AccountCreateDetailsView_ItemInserting">
                                <Fields>
                                    <asp:BoundField DataField="Name" HeaderText=" Account Name" SortExpression="Name"></asp:BoundField>
                                    <asp:BoundField DataField="OfficePhone" HeaderText="Phone" SortExpression="OfficePhone"></asp:BoundField>
                                    <asp:BoundField DataField="PrimaryEmail" HeaderText="Email Adress" SortExpression="PrimaryEmail"></asp:BoundField>
                                </Fields>
                            </asp:DetailsView>
                            <%--                            <asp:LinkButton ID="CreateAccountLinkButton" runat="server" OnClick="CreateAccountLinkButton_Click">Create New Account</asp:LinkButton>--%>
                        </asp:Panel>
                        <asp:Panel ID="OpportunityPanel" Visible="False" runat="server">

                            <asp:ObjectDataSource ID="OpportunityCreateObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity" InsertMethod="InsertOpportunity" SelectMethod="GetOpportunities" TypeName="C3App.BLL.OpportunityBL"></asp:ObjectDataSource>

                            <asp:DetailsView ID="OpportunityCreateDetailsView" runat="server" AutoGenerateRows="False" Visible="False" DataSourceID="OpportunityCreateObjectDataSource" DefaultMode="Insert" OnItemInserted="OpportunityCreateDetailsView_ItemInserted" OnItemInserting="OpportunityCreateDetailsView_ItemInserting">
                                <Fields>
                                    <asp:BoundField DataField="Name" HeaderText=" Opportunity Name" SortExpression="Name"></asp:BoundField>
                                    <asp:TemplateField HeaderText="AccountName" SortExpression="AccountID">
                                        <EditItemTemplate>
                                            <asp:ObjectDataSource ID="accountDataSource" runat="server"
                                                SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL"
                                                DataObjectTypeName="C3App.DAL.Account"></asp:ObjectDataSource>
                                            <asp:DropDownList ID="accountDropDownList" runat="server"
                                                DataSourceID="accountDataSource"
                                                SelectedValue='<%# Eval("AccountID")==null ? "-1" : Eval("AccountID") %>'
                                                DataTextField="Name" DataValueField="AccountID"
                                                OnInit="accountDropDownList_Init">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:ObjectDataSource ID="accountDataSource" runat="server"
                                                SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL"
                                                DataObjectTypeName="C3App.DAL.Account"></asp:ObjectDataSource>
                                            <asp:DropDownList ID="accountDropDownList" runat="server"
                                                DataSourceID="accountDataSource"
                                                DataTextField="Name" DataValueField="AccountID"
                                                OnInit="accountDropDownList_Init">
                                            </asp:DropDownList>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("AccountID") %>' ID="Label1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount"></asp:BoundField>
                                </Fields>
                            </asp:DetailsView>
                            <%--                            <asp:LinkButton ID="CreateOpportunityLinkButton" runat="server" OnClick="CreateOpportunityLinkButton_Click">Create New Opportunity</asp:LinkButton>--%>
                        </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="ModalSearchPanel" SkinID="ModalSearchPanel" runat="server">
                        <%--                    Search Panel--%>
                        <%-- 
                            Place your Search Panel Content Here 
                        --%>
                        <asp:Panel ID="AccountSearchPanel" runat="server" Visible="False">

                            <asp:Panel ID="Panel4" runat="server" CssClass="search">
                                <asp:Label ID="Label12" runat="server" Text="Search"></asp:Label>
                                <asp:TextBox ID="AccountSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="AccountSearchTextBox_TextChanged"></asp:TextBox>
                                <asp:LinkButton ID="accountSearchLinkButton" runat="server" CssClass="search-btn modal-search" OnClick="accountSearchButton_Click"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>
                        <asp:Panel ID="ContactSearchPanel" runat="server" Visible="False">

                            <asp:Panel ID="Panel5" runat="server" CssClass="search">
                                <asp:Label ID="Label13" runat="server" Text="Search"></asp:Label>
                                <asp:TextBox ID="ContactSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="ContactSearchTextBox_TextChanged"></asp:TextBox>
                                <asp:LinkButton ID="ContactLinkButton" runat="server" CssClass="search-btn modal-search" OnClick="ContactSearchButton_Click"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>
                        <asp:Panel ID="OpportuntySearchPanel" runat="server" Visible="False">

                            <asp:Panel ID="Panel7" runat="server" CssClass="search">
                                <asp:Label ID="Label3" runat="server" Text="Search"></asp:Label>
                                <asp:TextBox ID="OppotunitySearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="OpportunitySearchTextBox_TextChanged"></asp:TextBox>
                                <asp:LinkButton ID="OpportunityLinkButton" runat="server" CssClass="search-btn modal-search" OnClick="OpportunitySearchButton_Click"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="ModalListPanel" SkinID="ModalListPanel" runat="server">
                        <%--                    List Panel--%>
                        <%-- 
                            Place your List Panel Content Here 
                        --%>
                        <asp:ObjectDataSource ID="ContactObjectDataSource" runat="server" SelectMethod="GetContactByName" TypeName="C3App.BLL.ContactBL">

                            <SelectParameters>
                                <asp:ControlParameter ControlID="ContactSearchTextBox" PropertyName="Text" Name="nameSearchString" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:UpdatePanel ID="ContactList" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="ContactsGridView" runat="server" DataSourceID="ContactObjectDataSource" AutoGenerateColumns="False" Visible="False"
                                    CssClass="list-form" ShowHeader="False">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" Height="60" Width="60" />
                                                <asp:LinkButton ID="BillingContactSelectLinkButton" runat="server" CommandArgument='<%# Eval("ContactID") %>' CommandName="Select" OnCommand="ContactsSelectLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("FirstName") +" "+   Eval("LastName")%>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                                </asp:LinkButton>
                                                <%--                                                 <asp:LinkButton ID="ShippingContactSelectLinkButton" Visible="False" runat="server" CommandArgument='<%# Eval("ContactID") %>' CommandName="Select" OnCommand="ShippingContactSelectLinkButton_Command"  CausesValidation="False">
                                                    <%# Eval("FirstName") +" "+   Eval("LastName")%>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("EmailAddress") %>'></asp:Label>
                                                </asp:LinkButton>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:ObjectDataSource ID="AccountObjectDataSource" runat="server" SelectMethod="SearchAccount" TypeName="C3App.BLL.AccountBL">

                            <SelectParameters>
                                <asp:ControlParameter ControlID="AccountSearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:UpdatePanel ID="AccountList" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="AccountGridView" runat="server" AutoGenerateColumns="False" DataSourceID="AccountObjectDataSource" Visible="False"
                                    CssClass="list-form" ShowHeader="False">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" Height="60" Width="60" />
                                                <asp:LinkButton ID="BillingAccountLinkButton" runat="server" Visible="true" CommandArgument='<%# Eval("AccountID") %>' CommandName="Select" OnCommand="AccountsSelectLinkButton_Command" CausesValidation="False">

                                                    <%# Eval("Name")%>

                                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                                </asp:LinkButton>

                                                <%--                                                 <asp:LinkButton ID="ShippingAccountLinkButton" runat="server" Visible="False" CommandArgument='<%# Eval("AccountID") %>' CommandName="Select" OnCommand="ShippingAccountSelectLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>

                                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("Email1") %>'></asp:Label>

                                                </asp:LinkButton>--%>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:ObjectDataSource ID="OppotunityListObjectDataSource" runat="server" SelectMethod="SearchOpportunities" TypeName="C3App.BLL.OpportunityBL">

                            <SelectParameters>
                                <asp:ControlParameter ControlID="OppotunitySearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:UpdatePanel ID="opportunityList" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="OpportunityGridView" runat="server" DataSourceID="OppotunityListObjectDataSource" AutoGenerateColumns="False" Visible="False"
                                    CssClass="list-form" ShowHeader="False">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" Height="60" Width="60" />
                                                <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("OpportunityID") %>' CommandName="Select" OnCommand="OpportunitySelectLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("Account.Name") %>'></asp:Label>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>

        </asp:Panel>

<%--        <asp:Panel ID="ModalPanel2" SkinID="ModalPopRight" runat="server">
            <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:UpdatePanel runat="server" ID="UpdatePanel4" UpdateMode="Conditional">
                <Triggers>
                </Triggers>
                <ContentTemplate>
                    <asp:Panel ID="ProductPanel" runat="server">
                        <asp:Label ID="Label29" runat="server" SkinID="ModalTitle" Text="Select Products"></asp:Label>
                        <asp:Panel ID="Panel29" SkinID="ModalCreatePanel" runat="server">
                        </asp:Panel>
                        <asp:Panel ID="Panel39" SkinID="ModalSearchPanel" runat="server">
                            <asp:Label ID="Label14" runat="server" Text="Search"></asp:Label>
                            <asp:TextBox ID="ProductSearchTextBox" runat="server" AutoPostBack="True"></asp:TextBox>
                            <asp:LinkButton ID="LinkButton5" runat="server" CssClass="search-btn">
                        <i class="icon-search"></i>
                            </asp:LinkButton>
                        </asp:Panel>
                        <asp:Label ID="Label16" runat="server" Text="Product List" CssClass="list-title"></asp:Label>
                        <asp:Panel ID="Panel49" SkinID="ModalListPanel" runat="server">
                            <asp:ObjectDataSource ID="ProductsObjectDataSource" runat="server"
                                SelectMethod="GetProducts" TypeName="C3App.BLL.ProductBL">

                            </asp:ObjectDataSource>
                            <asp:LinkButton ID="LinkButton6" runat="server" Text="Add" CssClass="form-btn" OnClientClick="CloseModal('BodyContent_ModalPanel2')" OnClick="AddProduct_Click"></asp:LinkButton>
                            <br />
                            <asp:GridView ID="ProductsGridView" runat="server" class="list-form"
                                AutoGenerateColumns="False"
                                DataKeyNames="ProductID" GridLines="None"
                                DataSourceID="ProductsObjectDataSource">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="selectProduct" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" />
                                            <asp:LinkButton ID="SelectLinkButton1" runat="server" CommandArgument='<%# Eval("ProductID") %>' CommandName="Select" CausesValidation="False">
                                                <%# Eval("Name")%>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Cost") %>'></asp:Label>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>--%>
          <asp:Panel ID="ModalPanel2" SkinID="ModalPopRight" runat="server">
        <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
        <asp:UpdatePanel runat="server" ID="UpdatePanel4" UpdateMode="Conditional">
            <Triggers>
                <%--                    <asp:AsyncPostBackTrigger ControlID="ModalPopButton2" EventName="Click" />--%>
            </Triggers>
            <ContentTemplate>
                <asp:Label ID="Label29" runat="server" SkinID="ModalTitle" Text="Select Products"></asp:Label>
                <%--                <asp:LinkButton ID="LinkButton3" runat="server" CssClass="modal-create-btn" Text="Create" PostBackUrl="javascript:void(0)" OnClientClick="OpenCreateModal('BodyContent_Panel112')"></asp:LinkButton>--%>
                <asp:Panel ID="Panel29" SkinID="ModalCreatePanel" runat="server">
                </asp:Panel>
                <asp:Panel ID="Panel39" SkinID="ModalSearchPanel" runat="server">
                    <asp:Label ID="Label14" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="ProductSearchTextBox" runat="server" AutoPostBack="True"></asp:TextBox>
                    <asp:LinkButton ID="LinkButton5" runat="server" CssClass="search-btn">
                        <i class="icon-search"></i>
                    </asp:LinkButton>
                </asp:Panel>
                <asp:Label ID="Label16" runat="server" Text="Product List" CssClass="list-title"></asp:Label>
                <asp:Panel ID="Panel49" SkinID="ModalListPanel" runat="server">
                    <asp:ObjectDataSource ID="ProductsObjectDataSource" runat="server"
                        SelectMethod="GetProducts" TypeName="C3App.BLL.ProductBL">

                        <%--<SelectParameters>
                                <asp:ControlParameter ControlID="ProductSearchTextBox" PropertyName="Text" Name="productID" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>--%>
                    </asp:ObjectDataSource>
                    <asp:LinkButton ID="LinkButton6" runat="server" Text="Add" CssClass="form-btn" OnClientClick="CloseModal('BodyContent_ModalPanel2')" OnClick="AddProduct_Click"></asp:LinkButton>
                    <br />
                    <asp:GridView ID="ProductsGridView" runat="server" class="list-form"
                        AutoGenerateColumns="False"
                        DataKeyNames="ProductID" GridLines="None"
                        DataSourceID="ProductsObjectDataSource">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="selectProduct" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" />
                                    <asp:LinkButton ID="SelectLinkButton1" runat="server" CommandArgument='<%# Eval("ProductID") %>' CommandName="Select" CausesValidation="False">
                                        <%# Eval("Name")%>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Cost") %>'></asp:Label>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                    <%--                    <asp:LinkButton ID="Save" runat="server" Text="Add" CssClass="form-btn" OnClientClick="CloseModal('BodyContent_ModalPanel2')" OnClick="Save_Click"></asp:LinkButton>--%>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    </asp:Panel>

    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">

        <asp:LinkButton runat="server" ID="QuoteEditLinksButton" SkinID="TabTitle" OnClick="UpdateButton_Click" Text="View Quotes" OnClientClick="GoToTab(2,'Create Quotation')" />

        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">

            <%-- <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="QuoteEditLinksButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>--%>
            <asp:ObjectDataSource ID="QuoteSearchObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Quote" DeleteMethod="DeleteQuote" InsertMethod="InsertQuote" SelectMethod="SearchQuotes" TypeName="C3App.BLL.QuoteBL" UpdateMethod="UpdateQuote">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" Name="search" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>

            <asp:Panel ID="Panel11" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="Panel12" runat="server" CssClass="filter">
                    <asp:Label ID="Label8" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="SearchAllLinkButton" CssClass="search-label active" OnClick="SearchAllButton_Click">All</asp:LinkButton>
                    <asp:LinkButton runat="server" Visible="False" ID="ApprovedQuoteLinkButton" CssClass="search-label active" OnClick="ApprovedQuote_Click">Approved</asp:LinkButton>
                    <asp:LinkButton runat="server" Visible="False" ID="UnApprovedQuoteLinkButton" CssClass="search-label active" OnClick="UnApprovedQuote_Click">UnApproved</asp:LinkButton>
                </asp:Panel>

                <asp:Panel ID="Panel3" runat="server" CssClass="search" DefaultButton="SearchLinkButton">
                    <asp:Label ID="Label91" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server" OnTextChanged="SearchTextBox_TextChanged"></asp:TextBox>
                    <asp:LinkButton ID="SearchLinkButton" runat="server" OnClick="SearchButton_Click" CssClass="search-btn" Text="Search" />
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">
                <%--                        ListPanel--%>
                <%-- 
                            Place your ListPanel Content Here 
                --%>
                <%--              <asp:Button ID="QuoteInsertButton" runat="server" Text="Create New Quote" CommandArgument="Insert" OnClientClick="GoToTab(1);" 
                             OnClick="QuoteInsertButton_Click"   />--%>

                <%--                        <asp:ObjectDataSource ID="ListPanelObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Quote" DeleteMethod="DeleteQuote" InsertMethod="InsertQuote" SelectMethod="SearchQuotes" TypeName="C3App.BLL.QuoteBL" UpdateMethod="UpdateQuote">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="SearchTextBox" Name="search" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>--%>
                <asp:ObjectDataSource ID="ListPanelObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Quote" DeleteMethod="DeleteQuote" InsertMethod="InsertQuote" SelectMethod="GetQuotes" TypeName="C3App.BLL.QuoteBL" UpdateMethod="UpdateQuote"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ApprovedQuoteObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Quote" DeleteMethod="DeleteQuote" InsertMethod="InsertQuote" SelectMethod="GetApprovedQuotes" TypeName="C3App.BLL.QuoteBL" UpdateMethod="UpdateQuote"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="UnapprovedQuoteObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Quote" DeleteMethod="DeleteQuote" InsertMethod="InsertQuote" SelectMethod="GetUnApprovedQuotes" TypeName="C3App.BLL.QuoteBL" UpdateMethod="UpdateQuote"></asp:ObjectDataSource>

                <asp:UpdatePanel ID="upListView" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="QuoteEditLinksButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="ApprovedQuoteLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="UnApprovedQuoteLinkButton" EventName="Click" />

                    </Triggers>

                    <ContentTemplate>
                        <asp:GridView ID="QuotesGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                            DataKeyNames="QuoteID"
                            DataSourceID="ListPanelObjectDataSource" ShowHeader="False" GridLines="None">
                            <EmptyDataTemplate>
                                <p>
                                    No Quotes found.
                                </p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/Quote.jpg" />
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("QuoteID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                            <%# Eval("Name")%>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("Opportunity.Name") %>'></asp:Label>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="QuoteUpdateProgress" runat="server" AssociatedUpdatePanelID="upListView" DynamicLayout="true" DisplayAfter="0">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </asp:Panel>

            <asp:UpdatePanel ID="miniDetails" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Panel ID="MiniDetailBasicPanel" SkinID="MiniDetailBasicPanel" runat="server">
                        <%--                            MiniDetailPanel--%>
                        <%-- 
                                Place your MiniDetailPanel Content Here 
                        --%>
                        <asp:ObjectDataSource ID="MiniQuotesObjectDataSource" runat="server"
                            DataObjectTypeName="C3App.DAL.Quote" DeleteMethod="DeleteQuote"
                            InsertMethod="InsertQuote" SelectMethod="QuoteByID" TypeName="C3App.BLL.QuoteBL"
                            UpdateMethod="UpdateQuote">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="QuotesGridView" Name="QuoteID" Type="Int32" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <%--<asp:UpdatePanel ID="miniDetails" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>--%>


                        <asp:FormView ID="MiniQuotesFormView" runat="server" CssClass="mini-details-form" DataSourceID="MiniQuotesObjectDataSource"
                            DataKeyNames="QuoteID">

                            <EmptyDataTemplate>
                                <p>
                                    No Quote selected.
                                </p>
                            </EmptyDataTemplate>

                            <ItemTemplate>
                                <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/Quote.jpg" />
                                <asp:Panel ID="Panel1" runat="server">
                                    <asp:Label ID="Label7" CssClass="fullname" runat="server" Text='<%# Eval("Name")%>'></asp:Label>
                                    <asp:Label ID="Label9" CssClass="calendar-number" runat="server" Text='<%# Eval("QuoteStage.Value") %>'></asp:Label>
                                    <asp:Label ID="Label10" runat="server" CssClass="amount" Text='<%# Eval("PaymentTerm.Value") %>'></asp:Label>
                                    <asp:Label ID="Label8" runat="server" CssClass="graph" Text='<%# Eval("Team.Name") %>'></asp:Label>
                                    <asp:Label ID="Label11" runat="server" CssClass="user" Text='<%# Eval("User.FirstName") %>'></asp:Label>
                                </asp:Panel>

                            </ItemTemplate>
                        </asp:FormView>
                        <asp:Panel ID="Panel2" runat="server" CssClass="mini-detail-control-panel five-controls">
                            <ul>

                                <%--                                            <li>
                                                <asp:LinkButton ID="CalenderLinkButton" CssClass="control-btn" runat="server" OnClientClick="OpenModal('BodyContent_ModalCalendar')">
                                            <i class="icon-check"></i>
                                                </asp:LinkButton>
                                            </li>--%>
                                <li>
                                                                      <asp:Panel ID="Panel10" runat="server" CssClass="slide-confirm">

                                    <asp:LinkButton ID="ApproveLinkButton" CssClass="control-btn has-confirm" runat="server" Text="Approve">
                                       <i class="icon-check"></i></asp:LinkButton>

                                        <asp:LinkButton ID="LinkButton10" runat="server" OnClientClick="GoToTab(2);" OnClick="approveButton_Click">Confirm</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton11" runat="server" class="slide-cancel">Cancel</asp:LinkButton>

                                    </asp:Panel>
                                </li>

                                <li>
                                    <asp:LinkButton ID="QuoteEditLinkButton" CssClass="control-btn" runat="server" Text="Edit" CommandArgument="" OnClientClick="GoToTab(1,'Quotation Details');"
                                        OnClick="QuoteEditButton_Click"> <i class="icon-edit"></i> 
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:Panel ID="Panel9" runat="server" CssClass="slide-confirm">
                                    <asp:LinkButton ID="ConvertLinkButton" CssClass="control-btn has-confirm" runat="server" Text="Convert">
                                       <i class="icon-share-alt"></i></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="GoToTab(2);" OnClick="ConvertButton_Click">Confirm</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton8" runat="server" class="slide-cancel">Cancel</asp:LinkButton>

                                    </asp:Panel>
                                </li>
                                <li>
                                                                        <asp:Panel ID="Panel6" runat="server" CssClass="slide-confirm">
                                    <asp:LinkButton ID="DeleteLinkButton" CssClass="control-btn has-confirm" runat="server" Text="Delete">
                                       <i class="icon-trash"></i></asp:LinkButton>

                                        <asp:LinkButton ID="LinkButton3" runat="server" OnClientClick="GoToTab(2);" OnClick="deleteButton1_Click">Confirm</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton7" runat="server" class="slide-cancel">Cancel</asp:LinkButton>

                                    </asp:Panel>
                                </li>
                                <li>
                                    <asp:LinkButton ID="QuoteDetailsLinkButton" CssClass="control-btn " runat="server" Text="Edit" CommandArgument="" OnClientClick="OpenModal('BodyContent_ModalPanel112');"
                                        OnClick="QuoteDetailsButton_Click"> <i class="icon-list-alt"></i> 
                                    </asp:LinkButton>
                                </li>

                            </ul>
                        </asp:Panel>



                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <%--                            MiniDetailMorePanel--%>
                        <%-- 
                                Place your MiniDetailMorePanel Content Here 
                        --%>
                        <asp:DetailsView ID="MiniMoreQuotesDetailsView" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label"
                            AutoGenerateRows="False" DataSourceID="MiniQuotesObjectDataSource">
                            <EmptyDataTemplate>
                                <p>
                                    No Quotes selected.
                                </p>
                            </EmptyDataTemplate>
                            <Fields>
                                <asp:BoundField DataField="QuoteNumber" HeaderText="Quote Number" SortExpression="QuoteNumber" />
                                <asp:TemplateField HeaderText="Billing Account" SortExpression="BillingAccountID">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Account.Name") %>' ID="Label1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Billing Contact" SortExpression="BillingContactID">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Contact.FirstName") +" "+   Eval("Contact.LastName")%>' ID="Label2"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="BillingStreet" HeaderText="Billing Street" SortExpression="BillingStreet" />
                                <asp:BoundField DataField="BillingCity" HeaderText="Billing City" SortExpression="BillingCity" />
                                <asp:BoundField DataField="BillingState" HeaderText="Billing State" SortExpression="BillingState" />
                                <asp:BoundField DataField="BillingZip" HeaderText="Billing Zip" SortExpression="BillingZip" />
                                <asp:TemplateField HeaderText="Billing Country" SortExpression="BillingCountry">
                                    <ItemTemplate>
                                        <asp:Label ID="BillingCountryLabel" runat="server" Text='<%# Eval("Country.CountryName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Shipping Account" SortExpression="ShippingAccountID">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Account1.Name") %>' ID="Label4"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Shipping Contact" SortExpression="ShippingContactID">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Contact1.FirstName") +" "+   Eval("Contact1.LastName")%>' ID="Label5"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ShippingStreet" HeaderText="Shipping Street" SortExpression="ShippingStreet"></asp:BoundField>
                                <asp:BoundField DataField="ShippingCity" HeaderText="Shipping City" SortExpression="ShippingCity"></asp:BoundField>
                                <asp:BoundField DataField="ShippingState" HeaderText="Shipping State" SortExpression="ShippingState"></asp:BoundField>
                                <asp:BoundField DataField="ShippingZip" HeaderText="Shipping Zip" SortExpression="ShippingZip"></asp:BoundField>
                                <asp:TemplateField HeaderText="Shipping Country" SortExpression="ShippingCountry">
                                    <ItemTemplate>
                                        <asp:Label ID="ShippingCountryLabel" runat="server" Text='<%# Eval("Country1.CountryName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Currency" SortExpression="CurrencyID">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Currency.Name") %>' ID="Label7"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="ConversionRate" HeaderText="Conversion Rate" SortExpression="ConversionRate"></asp:BoundField>
                                <asp:BoundField DataField="TaxRate" HeaderText="Tax Rate" SortExpression="TaxRate"></asp:BoundField>
                                <asp:BoundField DataField="Shipper" HeaderText="Shipper" SortExpression="Shipper"></asp:BoundField>
                                <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" SortExpression="Subtotal"></asp:BoundField>
                                <asp:BoundField DataField="Discount" HeaderText="Discount" SortExpression="Discount"></asp:BoundField>
                                <asp:BoundField DataField="Shipping" HeaderText="Shipping" SortExpression="Shipping"></asp:BoundField>
                                <asp:BoundField DataField="Tax" HeaderText="Tax" SortExpression="Tax"></asp:BoundField>
                                <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total"></asp:BoundField>
                                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                            </Fields>
                        </asp:DetailsView>
                    </asp:Panel>

                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="MiniDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="miniDetails">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel3" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent3" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>


        <%-- start Calendar in Formview--%>
        <asp:Panel ID="ModalCalendar" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink3" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label4" runat="server" SkinID="ModalTitle" Text="Mini Calendar"></asp:Label>
            <%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="modal-create-btn" Text="Create" PostBackUrl="javascript:void(0)" OnClientClick="OpenCreateModal('BodyContent_Panel112')"></asp:LinkButton>--%>
            <asp:Panel ID="Panel8" SkinID="ModalListPanel" runat="server">
                <table class="calendar-form">
                    <tbody>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                        <a href="#" class="open-btn"><i class="icon-external-link"></i></a>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </asp:Panel>
        </asp:Panel>

        <%--        <asp:Panel ID="Panel112" SkinID="ModalCreatePanelRight" runat="server">
            <asp:HyperLink ID="HyperLink12" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
<%--            <asp:Label ID="Label32" runat="server" SkinID="ModalTitle" Text="Create Panel"></asp:Label>--%>
    </asp:Panel>
    
    <asp:Panel ID="ModalPanel112" SkinID="ModalPopRight" runat="server">
                    <asp:HyperLink ID="HyperLink4" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
                    <asp:UpdatePanel runat="server" ID="UpdatePanel122" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:Panel ID="Panel14" runat="server">
                                <asp:Label ID="Label15" runat="server" SkinID="ModalTitle" Text="Quote Details"></asp:Label>
                                <asp:Panel ID="Panel17" SkinID="ModalListPanel" runat="server">
                                    <asp:ObjectDataSource ID="QuoteDetailObjectDataSource" runat="server" SelectMethod="GetQuoteDetailsByQuoteID" TypeName="C3App.BLL.QuoteBL">
                                        <SelectParameters>
                                            <asp:SessionParameter SessionField="EditQuoteID" Name="QuoteID" Type="Int64"></asp:SessionParameter>
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="QuoteDetailObjectDataSource"
                                        CssClass="list-form" ShowHeader="False" GridLines="None">
<%--                                        <Columns>
                                            <asp:TemplateField HeaderText="ProductID" SortExpression="ProductID">
                                                <ItemTemplate>
                                                    <asp:Label runat="server" Text='<%# Eval("Product.Name") %>' ID="ProductLabel"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" SortExpression="Quantity"></asp:BoundField>
                                            <asp:BoundField DataField="ListPrice" HeaderText="ListPrice" SortExpression="ListPrice"></asp:BoundField>
                                        </Columns>--%>
                               <EmptyDataTemplate>
                                <p>
                                    No Quote Details.
                                </p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/product.jpg" />
                                        <asp:LinkButton ID="SelectLinkButton111" runat="server" CausesValidation="False">
                                            <%# Eval("Product.Name")%>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                            <asp:Label ID="Label17" runat="server" Text='<%# Eval("ListPrice") %>'></asp:Label>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>

                                    </asp:GridView>

                                </asp:Panel>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>

    
    <%-- End Calendar in Formview--%>



    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel78" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="Literal1" runat="server" Text=""></asp:Literal></h4>
                <a class="close-reveal-modal">&#215;</a>
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
<%--                <asp:HyperLink runat="server"ID="hyperlink" Text="Click here" Visible="False" ></asp:HyperLink>--%>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
