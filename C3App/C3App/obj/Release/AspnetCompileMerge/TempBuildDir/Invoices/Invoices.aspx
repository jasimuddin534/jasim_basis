<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Invoices.aspx.cs" Inherits="C3App.Invoices.Invoices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">
        <asp:LinkButton ID="InvoiceInsertButton" runat="server" SkinID="TabTitle" CommandArgument="Insert" CausesValidation="false" OnClientClick="GoToTab(1, 'Create Invoice');" Text="Create Invoice" OnClick="InvoiceInsertButton_Click" />
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="InvoiceInsertButton" EventName="Click" />
                    <%-- <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />--%>
                </Triggers>
                <ContentTemplate>

                    <asp:ValidationSummary ID="InvoiceValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="sum" ShowValidationErrors="True" />
                    <asp:ObjectDataSource ID="InvoiceObjectDataSource"
                        TypeName="C3App.BLL.InvoiceBL" runat="server"
                        DataObjectTypeName="C3App.DAL.Invoice"
                        InsertMethod="InsertInvoice"
                        SelectMethod="GetInvoiceByID"
                        UpdateMethod="UpdateInvoice">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditInvoiceID" Name="InvoiceID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>

                    <%-- <asp:ObjectDataSource ID="OpportunityObjectDataSource" runat="server" TypeName="C3App.BLL.InvoiceBL" SelectMethod="GetOpportunities" DataObjectTypeName="C3App.DAL.Opportunity"></asp:ObjectDataSource>
                     <asp:ObjectDataSource ID="OrderObjectDataSource" runat="server" TypeName="C3App.BLL.InvoiceBL" SelectMethod="GetOrders" DataObjectTypeName="C3App.DAL.Order"></asp:ObjectDataSource>--%>

                    <asp:UpdatePanel ID="DetailsViewlist" runat="server">
                        <ContentTemplate>

                            <asp:DetailsView CssClass="details-form" runat="server" AutoGenerateRows="False"
                                ID="InvoiceDetailsView" DefaultMode="Insert" FieldHeaderStyle-CssClass="field-label"
                                DataSourceID="InvoiceObjectDataSource"
                                DataKeyNames="InvoiceID,OrderID,OpportunityID,CreatedTime,CreatedBy"
                                OnItemCommand="InvoiceDetailsView_ItemCommand"
                                OnItemInserting="InvoiceDetailsView_ItemInserting"
                                OnItemInserted="InvoiceDetailsView_ItemInserted"
                                OnItemUpdating="InvoiceDetailsView_ItemUpdating"
                                OnItemUpdated="InvoiceDetailsView_ItemUpdated">
                                <EmptyDataTemplate>
                                    <p>
                                        No data found.<br />
                                        Please Select an Invoice to edit..
                                    </p>
                                </EmptyDataTemplate>
                                <Fields>
                                    <%--<asp:TemplateField HeaderText="Invoice Name">
                                <EditItemTemplate>
                                    <asp:RequiredFieldValidator CssClass="input-validate" ID="NameRequiredValidator" runat="server"
                                      ControlToValidate="InvoiceNameTextBox" ValidationGroup="sum" ErrorMessage="Invoice name required"  Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="InvoiceNameTextBox" CssClass="required-field" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="NameRegex" runat="server" ErrorMessage="Invoice name input format not correct" ControlToValidate="InvoiceNameTextBox" ValidationExpression="^[a-zA-Z''-'\.\s]{1,40}$" ValidationGroup="sum" />
                                    </EditItemTemplate>
                            </asp:TemplateField>--%>

                                    <asp:DynamicField DataField="Name" HeaderText="Invoice Name" ValidationGroup="sum" />
                                    <asp:TemplateField HeaderText="Opportunity">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="OpportunityNameTextBox" runat="server" ReadOnly="True" SkinID="TextBoxWithButton" Text='<%# Eval("Opportunity.Name") %>'></asp:TextBox>
                                            <asp:Button ID="OpportunityModalPopButton1" runat="server" CommandArgument="Opportunity" OnClick="ModalPopButton_Click" OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="OpportunityNameTextBox" runat="server" ReadOnly="True" SkinID="TextBoxWithButton"></asp:TextBox>
                                            <asp:Button ID="OpportunityModalPopButton2" runat="server" CommandArgument="Opportunity" OnClick="ModalPopButton_Click" OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Invoice Stage" SortExpression="InvoiceStageID">
                                        <EditItemTemplate>
                                            <asp:ObjectDataSource ID="InvoiceStageObjectDataSource" runat="server" TypeName="C3App.BLL.InvoiceBL" SelectMethod="GetInvoiceStages" DataObjectTypeName="C3App.DAL.InvoiceStage"></asp:ObjectDataSource>
                                            <asp:DropDownList ID="InvoiceStageDropDownList" runat="server" DataSourceID="InvoiceStageObjectDataSource" AppendDataBoundItems="true"
                                                SelectedValue='<%# Eval("InvoiceStageID")==null ? "0" : Eval("InvoiceStageID") %>'
                                                DataTextField="Value" DataValueField="InvoiceStageID" OnInit="InvoiceStageDropDownList_Init">
                                                <asp:ListItem Selected="True" Enabled="True" Text="None" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Order">
                                        <EditItemTemplate>
                                            <asp:RequiredFieldValidator CssClass="input-validate" ID="OrderRequiredValidator" runat="server"
                                                ControlToValidate="OrderTextBox" ValidationGroup="sum" ErrorMessage="Plz,select an order" Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:TextBox ID="OrderTextBox" CssClass="input-with-btn required-field" runat="server" ReadOnly="True" Text='<%# Eval("Order.Name") %>'></asp:TextBox>
                                            <asp:Button ID="OrderModalPopButton1" runat="server" CommandArgument="Order" OnClick="ModalPopButton_Click" OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:RequiredFieldValidator CssClass="input-validate" ID="OrderRequiredValidator" runat="server"
                                                ControlToValidate="OrderTextBox" ValidationGroup="sum" ErrorMessage="Plz,select an order" Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:TextBox ID="OrderTextBox" CssClass="input-with-btn required-field" runat="server" ReadOnly="True"></asp:TextBox>
                                            <asp:Button ID="OrderModalPopButton2" runat="server" CommandArgument="Order" OnClick="ModalPopButton_Click" OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Invoice Number">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="InvoiceNumberTextBox" ReadOnly="True" runat="server" Text='<%# Bind("InvoiceNumber") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Purchase order Number">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="PurchaseOrderNumTextBox" runat="server" Text='<%# Bind("PurchaseOrderNum") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Amount Due">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="AmountDueTextBox" runat="server" Text='<%# Bind("AmountDue") %>'></asp:TextBox>
                                            <asp:CompareValidator runat="server" ID="AmountDueDateCompare" ControlToValidate="AmountDueTextBox" Operator="DataTypeCheck" Type="Double" Display="None" Text="" ErrorMessage="Amount due must be decimal" ValidationGroup="sum" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <%--  <asp:DynamicField DataField="PurchaseOrderNum" HeaderText="Purchase Order No" ValidationGroup="sum" />
                            <asp:DynamicField DataField="AmountDue" HeaderText="Amount Due" ValidationGroup="sum" />--%>
                                    <asp:TemplateField HeaderText="Due Date" SortExpression="DueDate">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="DueDateTextBox" CssClass="datepicker" runat="server" Text='<%# Bind("DueDate","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Payment Term" SortExpression="InvoicePayTermID">
                                        <EditItemTemplate>
                                            <asp:ObjectDataSource ID="InvoicePaymentTermObjectDataSource" runat="server" TypeName="C3App.BLL.InvoiceBL" DataObjectTypeName="C3App.DAL.InvoicePayTerm" SelectMethod="GetInvoicePaymentTerms"></asp:ObjectDataSource>
                                            <asp:DropDownList ID="PaymentTermDropDownList" runat="server" DataSourceID="InvoicePaymentTermObjectDataSource" AppendDataBoundItems="true"
                                                SelectedValue='<%# Eval("PaymentTermID")==null ? "0" : Eval("PaymentTermID") %>'
                                                DataTextField="Value" DataValueField="InvoicePayTermID" OnInit="PaymentTermDropDownList_Init">
                                                <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                        <EditItemTemplate>
                                            <asp:ObjectDataSource ID="TeamNameObjectDataSource" runat="server" TypeName="C3App.BLL.TeamBL" SelectMethod="GetTeams" DataObjectTypeName="C3App.DAL.Team"></asp:ObjectDataSource>
                                            <asp:DropDownList ID="TeamNameDropDownList" runat="server" DataSourceID="TeamNameObjectDataSource" AppendDataBoundItems="true"
                                                SelectedValue='<%# Eval("TeamID")==null ? "0" : Eval("TeamID") %>'
                                                DataTextField="Name" DataValueField="TeamID" OnInit="TeamNameDropDownList_Init">
                                                <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                        <EditItemTemplate>
                                            <asp:ObjectDataSource ID="AssignedToObjectDataSource" runat="server" TypeName="C3App.BLL.UserBL" SelectMethod="GetUsers" DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                                            <asp:DropDownList ID="AssignedToDropDownList" runat="server" DataSourceID="AssignedToObjectDataSource" AppendDataBoundItems="true"
                                                SelectedValue='<%# Eval("AssignedUserID")==null ? "0" : Eval("AssignedUserID") %>'
                                                DataTextField="FirstName" DataValueField="UserID" OnInit="AssignedToDropDownList_Init">
                                                <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <EditItemTemplate>
                                            <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" ValidationGroup="sum" CommandName="Update" Text="Save"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:LinkButton ID="CancelLinkButton1" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                            <asp:LinkButton ID="InsertLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" ValidationGroup="sum" CommandName="Insert" Text="Save"></asp:LinkButton>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <%-- <asp:TemplateField HeaderText="Invoice Name" SortExpression="Name">
                                <EditItemTemplate>
                                    <asp:RequiredFieldValidator CssClass="input-validate" ID="NameRequiredValidator" runat="server"
                                        ControlToValidate="InvoiceNameTextBox" ValidationGroup="sum" ErrorMessage="Invoice name required"  Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="InvoiceNameTextBox" CssClass="required-field" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
                                    <%--<asp:TemplateField HeaderText="Amount Due" SortExpression="AmountDue">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AmountDueTextBox" runat="server" Text='<%# Bind("AmountDue") %>'></asp:TextBox>
                                    <asp:CompareValidator runat="server" ID="AmountDueDateCompare" ControlToValidate="AmountDueTextBox" Operator="DataTypeCheck" Type="Double" Display="None" Text="" ErrorMessage="Amount due must be decimal" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="PurchaseOrderNum" HeaderText="Purchase Order No" SortExpression="PurchaseOrderNum" />--%>
                                </Fields>
                            </asp:DetailsView>


                            <asp:DetailsView runat="server" FieldHeaderStyle-CssClass="field-label" CssClass="details-form"
                                ID="orderDetailsview">
                                <Fields>
                                    <asp:TemplateField HeaderText="Billing Account" SortExpression="BillingAccountID">
                                        <ItemTemplate>
                                            <asp:TextBox ID="BillingAccountNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("BillingAccountName") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Billing Contact" SortExpression="BillingContactID">
                                        <ItemTemplate>
                                            <asp:TextBox ID="BillingContactNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("BillingContactName") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Billing Street" SortExpression="BillingStreet">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" TextMode="MultiLine" ReadOnly="True" ID="BillingStreetTextBox" Text='<%# Eval("BillingStreet") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Billing City" SortExpression="BillingStreet">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="BillingCityTextBox" ReadOnly="True" Text='<%# Eval("BillingCity") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Billing State" SortExpression="BillingState">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="BillingStateTextBox" ReadOnly="True" Text='<%# Eval("BillingState") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Postal Code" SortExpression="BillingZip">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="BillingZipTextBox" ReadOnly="True" Text='<%# Eval("BillingPostalCode") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Billing Country" SortExpression="BillingCountry">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="BillingCountryTextBox" ReadOnly="True" Text='<%# Eval("BillingCountry") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Shipping Account" SortExpression="ShippingAccountID">
                                        <ItemTemplate>
                                            <asp:TextBox ID="ShippingAccountNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("ShipingAccountName") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Shipping Contact" SortExpression="ShippingContactID">
                                        <ItemTemplate>
                                            <asp:TextBox ID="ShippingContactNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("ShipingContactName") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Shipping Street" SortExpression="ShippingStreet">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" TextMode="MultiLine" ReadOnly="True" ID="ShippingStreetTextBox" Text='<%# Eval("ShipingStreet") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Shipping City" SortExpression="ShippingCity">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="ShippingCityTextBox" ReadOnly="True" Text='<%# Eval("ShipingCity") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Shipping State" SortExpression="ShippingState">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="ShippingStateTextBox" ReadOnly="True" Text='<%# Eval("ShipingState") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Postal Code" SortExpression="ShippingZip">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="ShippingZipTextBox" ReadOnly="True" Text='<%# Eval("ShipingPostalCode") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Shipping Country" SortExpression="ShippingCountry">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="ShippingCountryTextBox" ReadOnly="True" Text='<%# Eval("ShipingCountry") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Currency" SortExpression="CurrencyID">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="CurrencyTextBox" ReadOnly="True" Text='<%# Eval("Currency") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Conversion Rate" SortExpression="ConversionRate">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="ConversionRateTextBox" ReadOnly="True" Text='<%# Eval("ConversionRate") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Tax Rate" SortExpression="TaxRate">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="TaxRateTextBox" ReadOnly="True" Text='<%# Eval("TaxRate") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Shipper" SortExpression="Shipper">
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="ShipperTextBox" ReadOnly="True" Text='<%# Eval("Shipper") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Subtotal" SortExpression="Subtotal">
                                        <ItemStyle CssClass="replaced" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="SubtotalTextBox" ReadOnly="True" Text='<%# Bind("Subtotal") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Discount" SortExpression="Discount">
                                        <ItemStyle CssClass="replaced" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="DiscountTextBox" ReadOnly="True" Text='<%# Bind("Discount") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Shipping" SortExpression="Shipping">
                                        <ItemStyle CssClass="replaced" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="ShippingTextBox" ReadOnly="True" Text='<%# Bind("Shipping") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Tax" SortExpression="Tax">
                                        <ItemStyle CssClass="replaced" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="TaxTextBox" ReadOnly="True" Text='<%# Bind("Tax") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Total" SortExpression="Total">
                                        <ItemStyle CssClass="replaced" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" ID="TotalTextBox" ReadOnly="True" Text='<%# Bind("Total") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                        <ItemStyle CssClass="replaced" />
                                        <ItemTemplate>
                                            <asp:TextBox runat="server" TextMode="MultiLine" ReadOnly="True" ID="DescriptionTextBox" Text='<%# Bind("Description") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                            </asp:DetailsView>

                            <asp:GridView ID="OrderDetailsGridView" runat="server"
                                CssClass="grid-form" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:TemplateField HeaderText="Quantity">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("Quantity") %>' ReadOnly="True" ID="QuantityTextBox"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Name">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("Name") %>' ReadOnly="True" ID="NameLabel"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="MftPartNum">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("MftPartNum") %>' ReadOnly="True" ID="MftPartNumLabel"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Cost">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("Cost") %>' ReadOnly="True" ID="CostPriceTextBox"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="ListPrice">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("ListPrice") %>' ReadOnly="True" ID="ListPriceTextBox"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Discount">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("Discount") %>' ReadOnly="True" ID="DiscountTextBox"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Note">
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Bind("Note") %>' ReadOnly="True" ID="NoteTextBox"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </ContentTemplate>
                    </asp:UpdatePanel>

                    <div class="replaced-field">
                        <table class="details-form" id="tableInvoiceDemo">
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="InvoiceDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
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
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="ModalLabel" runat="server" SkinID="ModalTitle"></asp:Label>

                    <asp:Panel ID="OpportunitySearchPanel" runat="server" Visible="False" SkinID="ModalSearchPanel">
                        <asp:Label ID="Label12" runat="server" Text="Search"></asp:Label>
                        <asp:TextBox ID="OpportunitySearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="OpportunitySearchTextBox_TextChanged"></asp:TextBox>
                        <asp:LinkButton ID="OpportunitySearchLinkButton" CssClass="search-btn modal-search" runat="server" Text="Search" OnClick="OpportunitySearchLinkButton_Click"><i class="icon-search"></i></asp:LinkButton>

                    </asp:Panel>

                    <asp:Panel ID="OrderSearchPanel" runat="server" Visible="False" SkinID="ModalSearchPanel">
                        <asp:Label ID="Label5" runat="server" Text="Search"></asp:Label>
                        <asp:TextBox ID="OrderSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="OrderSearchTextBox_TextChanged"></asp:TextBox>
                        <asp:LinkButton ID="OrderSearchLinkButton" CssClass="search-btn modal-search" runat="server" Text="Search" OnClick="OrderSearchLinkButton_Click"><i class="icon-search"></i></asp:LinkButton>

                    </asp:Panel>

                    <asp:Panel ID="ModalListPanel" SkinID="ModalListPanel" runat="server">

                        <asp:ObjectDataSource ID="OpportunityListObjectDataSource" runat="server" SelectMethod="SearchOpportunities" TypeName="C3App.BLL.OpportunityBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="OpportunitySearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:UpdatePanel ID="OpportunityListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="OpportunityGridView" runat="server" AutoGenerateColumns="False" DataSourceID="OpportunityListObjectDataSource" Visible="False"
                                    CssClass="list-form" ShowHeader="False">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/opportunity.jpg" />
                                                <asp:LinkButton ID="SelectOpportunityList" runat="server" CommandArgument='<%# Eval("OpportunityID") %>' CommandName="Select" OnCommand="SelectOpportunityList_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Account.Name") %>'></asp:Label>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <asp:ObjectDataSource ID="OrderListObjectDataSource" runat="server" SelectMethod="SearchInvoiceOrders" TypeName="C3App.BLL.OrderBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="OrderSearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:UpdatePanel ID="OrderListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="OrderListGridView" runat="server" AutoGenerateColumns="False" DataSourceID="OrderListObjectDataSource" Visible="False"
                                    CssClass="list-form" ShowHeader="False">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/order.jpg" />
                                                <asp:LinkButton ID="SelectOrderList" runat="server" CommandArgument='<%# Eval("OrderID") %>' CommandName="Select" OnCommand="SelectOrderList_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
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
    </asp:Panel>
    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">

        <asp:LinkButton runat="server" ID="ViewInvoiceLinkButton" OnClick="UpdateButton_Click" SkinID="TabTitle" OnClientClick="GoToTab(2,'Create Invoice');" Text="View Invoices" />
        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">
            <asp:ObjectDataSource ID="SearchObjectDataSource" runat="server" SelectMethod="GetInvoiceByName" TypeName="C3App.BLL.InvoiceBL" DataObjectTypeName="C3App.DAL.Invoice">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" PropertyName="Text" Name="nameSearchString" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>

            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="Panel5" runat="server" CssClass="filter">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="SearchAllLinkButton" CssClass="search-label active" OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="SearchPanel2" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server" OnTextChanged="SearchTextBox_TextChanged"></asp:TextBox>
                    <asp:LinkButton CssClass="search-btn" ID="SearchButton" runat="server" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>
            <%-- <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ViewInvoiceLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                        <asp:Panel ID="Panel3" runat="server" CssClass="search">
                            <asp:TextBox ID="SearchTextBox" runat="server" AutoPostBack="true"></asp:TextBox><asp:LinkButton ID="LinkButton5" runat="server" CssClass="search-btn" Text="Search" />
                        </asp:Panel>
                    </asp:Panel>--%>


            <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">



                <%-- <asp:UpdatePanel ID="upListView" runat="server" UpdateMode="Conditional">--%>
                <asp:UpdatePanel ID="InvoiceListUpdatePanel" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewInvoiceLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:ObjectDataSource ID="InvoiceViewObjectDataSource" runat="server"
                            DataObjectTypeName="C3App.DAL.Invoice"
                            TypeName="C3App.BLL.InvoiceBL"
                            SelectMethod="GetInvoices"
                            UpdateMethod="UpdateInvoice">
                            <%-- <SelectParameters>
                                <asp:ControlParameter ControlID="SearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                            </SelectParameters>--%>
                        </asp:ObjectDataSource>
                        <asp:GridView ID="InvoiceGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                            DataKeyNames="InvoiceID"
                            DataSourceID="InvoiceViewObjectDataSource"
                            GridLines="None"
                            ShowHeader="false">
                            <EmptyDataTemplate>
                                <p>
                                    No Invoice found...
                                </p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/invoice.jpg" />
                                        <asp:LinkButton ID="InvoiceListSelectButton" runat="server" CommandArgument='<%# Eval("InvoiceID") + ";" + Eval("OrderID") %>' CommandName="Select" OnCommand="InvoiceListSelectButton_Command" CausesValidation="False">
                                            <%# Eval("Name") %>
                                            <asp:Label ID="InvoiceNumberLabel" runat="server" Text='<%# Eval("InvoiceNumber") %>' />
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="InvoiceListUpdateProgress" runat="server" AssociatedUpdatePanelID="InvoiceListUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel1" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent1" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage1" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </asp:Panel>



            <%-- <asp:UpdatePanel ID="miniDetails" runat="server" UpdateMode="Conditional">--%>
            <asp:UpdatePanel ID="MiniInvoiceUpdatePanel" runat="server" UpdateMode="Conditional">
                <%--<Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="InvoiceEditButton" EventName="Click" />
                                 </Triggers>--%>
                <ContentTemplate>
                    <asp:Panel ID="MiniDetailBasicPanel" SkinID="MiniDetailBasicPanel" runat="server">
                        <asp:ObjectDataSource ID="MiniInvoiceObjectDataSource" runat="server"
                            TypeName="C3App.BLL.InvoiceBL"
                            SelectMethod="GetInvoiceByID"
                            DataObjectTypeName="C3App.DAL.Invoice">
                            <SelectParameters>
                                <%--<asp:ControlParameter ControlID="InvoiceGridView" Type="String" Name="nameSearchString" PropertyName="SelectedValue" />--%>
                                <asp:ControlParameter ControlID="InvoiceGridView" Type="Int64" Name="InvoiceID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:FormView ID="MiniInvoiceFormView" runat="server" CssClass="mini-details-form"
                            DataSourceID="MiniInvoiceObjectDataSource"
                            DataKeyNames="InvoiceID">
                            <EmptyDataTemplate>
                                <p>No Invoice selected...</p>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/invoice.jpg" />
                                <asp:Panel ID="Panel1" runat="server" CssClass="@">
                                    <asp:Label ID="InvoiceNameLabel" runat="server" CssClass="fullname" Text='<%# Eval("Name") %>'></asp:Label>
                                    <%--<asp:Label ID="OrdernameLabel" runat="server" CssClass="order" Text='<%# Eval("Order.Name") %>'></asp:Label>--%>
                                    <asp:Label ID="InvoiceNumberLabel" CssClass="calendar-number" runat="server" Text='<%# Eval("InvoiceNumber") %>'></asp:Label>
                                    <asp:Label ID="OpportunityLabel" runat="server" CssClass="amount" Text='<%# Eval("Opportunity.Name") %>'></asp:Label>
                                    <asp:Label ID="AmountDueLabel" runat="server" CssClass="due-amount" Text='<%# Eval("AmountDue") %>'></asp:Label>
                                    <asp:Label ID="DueDateLabel" runat="server" CssClass="due-date" Text='<%# Eval("DueDate","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:Panel ID="Panel1" runat="server" CssClass="mini-detail-control-panel two-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="ReportModalPopButton" CssClass="control-btn" runat="server" OnClick="ReportModalPopButton_Click" OnClientClick="OpenModal('BodyContent_InvoiceReportModalPanel')">
                                                <i class="icon-paste"></i>
                                    </asp:LinkButton>
                                </li>
                                <%-- <li>
                                            <asp:LinkButton ID="ModalPopButton2" CssClass="control-btn" runat="server" OnClientClick="OpenModal('BodyContent_ModalPanel2')" >
                                                <i class="icon-calendar"></i>
                                            </asp:LinkButton>
                                        </li>--%>
                                <%-- <li>
                                            <asp:LinkButton ID="EditLinkButton" CssClass="control-btn" runat="server" CommandArgument="" OnClientClick="GoToTab(1,'Invoice Details');" OnClick="InvoiceEditButton_Click">
                                                <i class="icon-edit"></i> 
                                            </asp:LinkButton>
                                        </li>--%>
                                <li>
                                    <asp:Panel ID="Panel2" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="DeleteLinkButton" CssClass="control-btn has-confirm" runat="server" Text="Delete">
                                               <i class="icon-trash"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="DeleteConfirmButton" runat="server" OnClick="InvoiceDeleteButton_Click">Confirm</asp:LinkButton>
                                        <asp:LinkButton ID="DeleteCancelButton" runat="server" CssClass="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>
                            </ul>
                        </asp:Panel>
                        <%-- <asp:UpdateProgress ID="MiniDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="MiniInvoiceUpdatePanel">
                               <ProgressTemplate>
                                <asp:Panel ID="ProgressOverlayPanel1" runat="server" CssClass="loading"></asp:Panel>
                                <asp:Panel ID="ProgressOverlayContent1" runat="server" CssClass="loadingContent">
                                    <h2>Loading...</h2>
                                    <asp:Image ID="ProgressImage1" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                                </asp:Panel>
                            </ProgressTemplate>
                        </asp:UpdateProgress>--%>
                        <%--</ContentTemplate>
                        </asp:UpdatePanel>--%>
                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" CssClass="mini-detail-more-panel" runat="server">
                        <asp:DetailsView ID="MiniInvoiceDetailsView" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label" AutoGenerateRows="False"
                            DataKeyNames="InvoiceID,OrderID,OpportunityID" DataSourceID="MiniInvoiceObjectDataSource">
                            <EmptyDataTemplate>
                                <p>No Invoice selected...</p>
                            </EmptyDataTemplate>
                            <Fields>
                                <asp:TemplateField HeaderText="Order Name">
                                    <ItemTemplate>
                                        <asp:Label ID="OrderLabel" runat="server" Text='<%# Eval("Order.Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Invoice Number">
                                    <ItemTemplate>
                                        <asp:Label ID="InvoiceNumberLabel" runat="server" Text='<%# Eval("InvoiceNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Invoice Stage">
                                    <ItemTemplate>
                                        <asp:Label ID="InvoiceStageLabel" runat="server" Text='<%# Eval("InvoiceStage.Value") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Payment Terms">
                                    <ItemTemplate>
                                        <asp:Label ID="PaymentTermsLabel" runat="server" Text='<%# Eval("InvoicePayTerm.Value") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="AmountDue" HeaderText="Amount Due" SortExpression="AmountDue"></asp:BoundField>
                                <asp:BoundField DataField="PurchaseOrderNum" HeaderText="Purchase order no." SortExpression="PurchaseOrderNum"></asp:BoundField>

                                <asp:TemplateField HeaderText="Asssigned To">
                                    <ItemTemplate>
                                        <asp:Label ID="AssignedUserLabel" runat="Server" Text='<%# Eval("User.FirstName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Team">
                                    <ItemTemplate>
                                        <asp:Label ID="AssignedUserLabel" runat="Server" Text='<%# Eval("Team.Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <%-- for invoice report --%>

        <asp:Panel ID="InvoiceReportModalPanel" CssClass="modal-pop full left" runat="server">
            <asp:HyperLink ID="HyperLink3" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

            <asp:UpdatePanel runat="server" ID="InvoiceReportUpdatePanel" UpdateMode="Always">
                <Triggers>
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="InvoiceReportLabel" runat="server" Text="Invoice" CssClass="invoice-report-title"></asp:Label>
                    <asp:Panel ID="Panel7" SkinID="ModalListPanel" runat="server">

                        <asp:ObjectDataSource ID="InvoiceReportObjectDataSource" runat="server"
                            TypeName="C3App.BLL.InvoiceBL"
                            DataObjectTypeName="C3App.DAL.Invoice"
                            SelectMethod="GetInvoiceByID">
                            <SelectParameters>
                                <%--                                <asp:SessionParameter SessionField="EditInvoiceID" Name="InvoiceID" Type="Int64"></asp:SessionParameter>--%>
                                <asp:ControlParameter ControlID="InvoiceGridView" Type="Int64" Name="InvoiceID" PropertyName="SelectedValue" />

                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:FormView ID="ReportFormView1" runat="server"
                            DataSourceID="InvoiceReportObjectDataSource"
                            DataKeyNames="InvoiceID,OrderID">
                            <ItemTemplate>
                                <asp:Panel ID="Panel1" runat="server" CssClass="invoice-report-address">
                                    <asp:Label ID="InvoiceNameLabel" runat="server" CssClass="invoice-street" Text='<%# Eval("Order.BillingStreet") %>'></asp:Label>
                                    <%--<asp:Label ID="OrdernameLabel" runat="server" CssClass="order" Text='<%# Eval("Order.Name") %>'></asp:Label>--%>
                                    <asp:Label ID="InvoiceNumberLabel" CssClass="invoice-city" runat="server" Text='<%# Eval("Order.BillingCity") %>'></asp:Label>
                                    <asp:Label ID="OpportunityLabel" runat="server" CssClass="invoice-state" Text='<%# Eval("Order.BillingState") %>'></asp:Label>
                                    <asp:Label ID="AmountDueLabel" runat="server" CssClass="invoice-zip" Text='<%# Eval("Order.BillingZip") %>'></asp:Label>
                                    <asp:Label ID="DueDateLabel" runat="server" CssClass="invoice-country" Text='<%# Eval("Order.BillingCountry") %>'></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:FormView ID="ReportFormView2" runat="server"
                            DataSourceID="InvoiceReportObjectDataSource"
                            DataKeyNames="InvoiceID,OrderID">
                            <ItemTemplate>
                                <asp:Panel ID="Panel1231" runat="server" CssClass="invoice-report-to">
                                    <asp:Label ID="billingAccountLabel" runat="server" CssClass="" Text='<%# Eval("Order.Account.Name") %>'></asp:Label>
                                    <asp:Label ID="billingContactLabel" CssClass="" runat="server" Text='<%# "C/O: "+ Eval("Order.Contact.FirstName") +" "+ Eval("Order.Contact.LastName") %>'></asp:Label>

                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:DetailsView CssClass="details-form invoice-report" runat="server" AutoGenerateRows="False"
                            ID="ReportDetailsView1" FieldHeaderStyle-CssClass="field-label"
                            DataSourceID="InvoiceReportObjectDataSource"
                            DataKeyNames="InvoiceID,OrderID"
                            OnItemCommand="InvoiceDetailsView_ItemCommand">
                            <EmptyDataTemplate>
                                <p>
                                    No data found.<br />
                                    Please Select an Invoice to edit..
                                </p>
                            </EmptyDataTemplate>
                            <Fields>

                                <%--                           <asp:TemplateField HeaderText="Invoice name">
                               <ItemTemplate>
                                   <asp:Label ID="InvoiceNameLabel" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                               </ItemTemplate>
                            </asp:TemplateField>--%>

                                <asp:TemplateField HeaderText="Invoice number">
                                    <ItemTemplate>
                                        <asp:Label ID="InvoiceNumberLabel" runat="server" Text='<%# Bind("InvoiceNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <%--                             <asp:TemplateField HeaderText="Purchase order no.">
                                <ItemTemplate>
                                    <asp:Label ID="PurchaseOrderNumTextBox" ReadOnly="True" runat="server" Text='<%# Bind("PurchaseOrderNum") %>'></asp:Label>
                                    </ItemTemplate>
                            </asp:TemplateField>--%>

                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="DateTextBox" ReadOnly="True" runat="server" Text='<%# Bind("CreatedTime","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount Due">
                                    <ItemTemplate>
                                        <asp:Label ID="AmountDueLabel" runat="server" Text='<%# Bind("AmountDue") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <%--                             <asp:TemplateField HeaderText="Due Date">
                               <ItemTemplate>
                                   <asp:Label ID="DueDateLabel" runat="server" Text='<%# Bind("DueDate","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                               </ItemTemplate>
                            </asp:TemplateField>--%>
                            </Fields>
                        </asp:DetailsView>

                        <asp:GridView ID="InvoicedOrderDetailsGridView" runat="server"
                            CssClass="grid-form invoice-report" AutoGenerateColumns="False">
                            <Columns>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Bind("Name") %>' ReadOnly="True" ID="NameLabel"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Quantity">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Bind("Quantity") %>' ReadOnly="True" ID="QuantityTextBox"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="MftPartNum">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Bind("MftPartNum") %>' ReadOnly="True" ID="MftPartNumLabel"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cost">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Bind("Cost") %>' ReadOnly="True" ID="CostPriceTextBox"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ListPrice">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Bind("ListPrice") %>' ReadOnly="True" ID="ListPriceTextBox"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Discount">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Bind("Discount") %>' ReadOnly="True" ID="DiscountTextBox"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Note">
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Bind("Note") %>' ReadOnly="True" ID="NoteTextBox"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <%--                        <asp:DetailsView  CssClass="details-form invoice-report" runat="server" AutoGenerateRows="False"
                        ID="ReportDetailsView2" FieldHeaderStyle-CssClass="field-label"
                        DataSourceID="InvoiceReportObjectDataSource" 
                        DataKeyNames="InvoiceID,OrderID"
                        OnItemCommand="InvoiceDetailsView_ItemCommand">
                        
                        <Fields>
                             

                             <asp:TemplateField HeaderText="Invoice number">
                               <ItemTemplate>
                                   <asp:Label ID="InvoiceNumberLabel" runat="server" Text='<%# Bind("InvoiceNumber") %>'></asp:Label>
                               </ItemTemplate>
                            </asp:TemplateField>
                           
                            
                             <asp:TemplateField HeaderText="Date">
                                <ItemTemplate>
                                    <asp:Label ID="DateTextBox" ReadOnly="True" runat="server" Text='<%# Bind("CreatedTime","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                    </ItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Amount Due">
                               <ItemTemplate>
                                   <asp:Label ID="AmountDueLabel" runat="server" Text='<%# Bind("AmountDue") %>'></asp:Label>
                               </ItemTemplate>
                            </asp:TemplateField>
                            
                            </Fields>
                    </asp:DetailsView>--%>

                        <asp:DetailsView runat="server" FieldHeaderStyle-CssClass="field-label" CssClass="details-form invoice-report"
                            ID="InvoicedOrderDetailsView">
                            <Fields>

                                <%--                            <asp:TemplateField >
                                <ItemTemplate>
                                    <asp:Label ID="BillingContactNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("BillingContactName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                                <%--                            <asp:TemplateField HeaderText="Billing address">
                                <ItemTemplate>
                                    <asp:Label ID="BillingStreetTextBox"  runat="server" TextMode="MultiLine" ReadOnly="True" Text='<%# Eval("BillingStreet")+ "," + Eval("BillingCity")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                                <%-- <asp:TemplateField HeaderText="Billing City">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="BillingCityTextBox" ReadOnly="True" Text='<%# Eval("BillingCity") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                                <%--                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="BillingStateTextBox" ReadOnly="True" Text='<%# Eval("BillingState")+ "," +Eval("BillingPostalCode")+","+Eval("BillingCountry") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                                <%--<asp:TemplateField HeaderText="Postal Code">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="BillingZipTextBox" ReadOnly="True" Text='<%# Eval("BillingPostalCode") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Billing Country">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="BillingCountryTextBox" ReadOnly="True" Text='<%# Eval("BillingCountry") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                                <%-- <asp:TemplateField HeaderText="Shipping Account">
                                <ItemTemplate>
                                    <asp:Label ID="ShippingAccountNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("ShipingAccountName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Shipping Contact" SortExpression="ShippingContactID">
                                <ItemTemplate>
                                    <asp:Label ID="ShippingContactNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("ShipingContactName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Shipping Street" >
                                <ItemTemplate>
                                    <asp:Label runat="server" TextMode="MultiLine" ReadOnly="True" ID="ShippingStreetTextBox" Text='<%# Eval("ShipingStreet") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Shipping City">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="ShippingCityTextBox" ReadOnly="True" Text='<%# Eval("ShipingCity") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Shipping State">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="ShippingStateTextBox" ReadOnly="True" Text='<%# Eval("ShipingState") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Postal Code">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="ShippingZipTextBox" ReadOnly="True" Text='<%# Eval("ShipingPostalCode") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Shipping Country">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="ShippingCountryTextBox" ReadOnly="True" Text='<%# Eval("ShipingCountry") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Currency">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="CurrencyTextBox" ReadOnly="True" Text='<%# Eval("Currency") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>


                                <%-- <asp:TemplateField HeaderText="Shipper">
                                <ItemTemplate>
                                    <asp:Label runat="server" ID="ShipperTextBox" ReadOnly="True" Text='<%# Eval("Shipper") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                                <asp:TemplateField HeaderText="Subtotal">

                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="SubtotalTextBox" ReadOnly="True" Text='<%# Bind("Subtotal") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Discount">

                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="DiscountTextBox" ReadOnly="True" Text='<%# Bind("Discount") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>




                                <asp:TemplateField HeaderText="Total">

                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="TotalTextBox" ReadOnly="True" Text='<%# Bind("Total") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Amount Paid">
                                    <ItemTemplate>
                                        <asp:Label runat="server" ID="AmountPaidTextBox" ReadOnly="True" Text='<%# Eval("AmountPaid") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Balance Due">

                                    <ItemTemplate>
                                        <asp:Label runat="server" ReadOnly="True" ID="AmountDueTextBox" Text='<%# Bind("AmountDue") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                        <asp:Panel runat="server" CssClass="invoice-report-footer">
                            <asp:Label runat="server" ReadOnly="True" ID="FooterLabel" Text="ADDITIONAL NOTES" CssClass="footer-title"></asp:Label>
                            <asp:Label runat="server" ReadOnly="True" ID="FooterTextLabel" CssClass="footer-text" Text="A finance charge of 1.5% will be made on unpaid balances after 30 days."></asp:Label>
                        </asp:Panel>                        
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
