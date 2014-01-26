<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Company.aspx.cs" Inherits="C3App.Users.Company" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">
        <asp:LinkButton ID="CompanyInsertButton" runat="server" SkinID="TabTitle" Text="Company Details" CommandArgument="Insert" OnClientClick="GoToTab(1);"  OnClick="CompanyEditButton_Click" />
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="CompanyInsertButton" EventName="Click" />            
                </Triggers>
                <ContentTemplate>
   
                     <asp:ValidationSummary ID="CompanyDetailsValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />
                       
                    <asp:ObjectDataSource ID="CompanyObjectDataSource" runat="server" 
                        DataObjectTypeName="C3App.DAL.Company"
                        TypeName="C3App.BLL.UserBL"
                         OnUpdated="CompanyObjectDataSource_Updated"
                        SelectMethod="GetCompanyByID"
                        UpdateMethod="CompanyUpdate">
                    </asp:ObjectDataSource>
                
                    <asp:DetailsView FieldHeaderStyle-CssClass="field-label" CssClass="details-form"
                         ID="CompanyDetailsView" runat="server"  DefaultMode="Edit"
                        OnItemUpdating="CompanyDetailsView_ItemUpdating"
                        OnItemUpdated="CompanyDetailsView_ItemUpdated"
                        OnItemCommand="CompanyDetailsView_ItemCommand"
                        DataKeyNames="CompanyID,CreatedTime,CreatedBy,BankAccount"
                        AutoGenerateRows="False" DataSourceID="CompanyObjectDataSource">

                        <Fields>
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="true"></asp:BoundField>
                            
                           <%-- <asp:BoundField DataField="ShortName" HeaderText="Short Name" SortExpression="ShortName"></asp:BoundField>
                            <asp:BoundField DataField="HeadOfficeAddress" HeaderText="Head Office Address" SortExpression="HeadOfficeAddress"></asp:BoundField>--%>

                            <asp:TemplateField HeaderText="ShortName" SortExpression="ShortName">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50" Text='<%# Bind("ShortName") %>' CssClass="mask-name" ID="ShortNameTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="ShortNameRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,200}$"
                                        ControlToValidate="ShortNameTextBox" Text="*"
                                        ErrorMessage="Short Name is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="HeadOfficeAddress" SortExpression="HeadOfficeAddress">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="200" Text='<%# Bind("HeadOfficeAddress") %>' CssClass="mask-name" ID="HeadOfficeAddressTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="HeadOfficeAddressRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,200}$"
                                        ControlToValidate="HeadOfficeAddressTextBox" Text="*"
                                        ErrorMessage="Head Office Address is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>
                                 
                            <asp:TemplateField HeaderText="Company Type">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Eval("CompanyType.Value") %>' ID="CompanyTypeLabel"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CompanyTypesObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.CompanyTypes"
                                        SelectMethod="GetCompanyTypes"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CompanyTypesDropDownList" runat="server"
                                        DataSourceID="CompanyTypesObjectDataSource"
                                        SelectedValue='<%# Eval("CompanyTypeID")==null ? "0" : Eval("CompanyTypeID") %>'
                                        DataTextField="Value" DataValueField="CompanyTypeID" OnInit="CompanyTypesDropDownList_Init" AppendDataBoundItems="True">
                                        <asp:ListItem Value="0" Text="None" />
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            
                             <asp:BoundField DataField="Tin" HeaderText="TIN" SortExpression="Tin"></asp:BoundField>
                            <asp:BoundField DataField="TradeNumber" HeaderText="Trade Number" SortExpression="TradeNumber"></asp:BoundField>
                            <asp:TemplateField HeaderText="Start Date" SortExpression="StartDate">
                                <ItemTemplate>
                                      <asp:Label runat="server" Text='<%# Bind("StartDate", "{0:d}") %>' ID="StartDateLabel" ></asp:Label>
                                </ItemTemplate>

                                <EditItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("StartDate", "{0:d}") %>' ID="TextBox1" CssClass="datepicker"></asp:TextBox>
                                </EditItemTemplate>
                           
                            </asp:TemplateField>

                   <%--         <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"></asp:BoundField>
                            <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website"></asp:BoundField>
                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone"></asp:BoundField>
                            <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax"></asp:BoundField>
                            <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address"></asp:BoundField>
                            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City"></asp:BoundField>
                            <asp:BoundField DataField="State" HeaderText="State" SortExpression="State"></asp:BoundField>
                            <asp:BoundField DataField="PostalCode" HeaderText="Postal Code" SortExpression="PostalCode"></asp:BoundField>--%>

                            <asp:TemplateField HeaderText="Email" SortExpression="Email">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("Email") %>' CssClass="mask-email" ID="EmailTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="EmailRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*.{1,100}"
                                        ControlToValidate="EmailTextBox" Text="*"
                                        ErrorMessage="Email Address is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Website" SortExpression="Website">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("Website") %>'  ID="WebsiteTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="WebsiteRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(ht|f)tp(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(\/?)([a-zA-Z0-9\-\.\?\,\'\/\\\+&amp;%\$#_]*)?$"
                                        ControlToValidate="WebsiteTextBox" Text="*"
                                        ErrorMessage="Website Address is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Phone" SortExpression="Phone">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50" Text='<%# Bind("Phone") %>' CssClass="mask-phone" ID="PhoneTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="PhoneRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="PhoneTextBox" Text="*"
                                        ErrorMessage="Phone Field is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Fax" SortExpression="Fax">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50" Text='<%# Bind("Fax") %>' CssClass="mask-phone" ID="FaxTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="FaxRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="FaxTextBox" Text="*"
                                        ErrorMessage="Fax Field is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Address" SortExpression="Address">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("Address") %>' CssClass="mask-street" ID="AddressTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="AddressRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z0-9\s()\/,:;.-]{1,100}$"
                                        ControlToValidate="AddressTextBox" Text="*"
                                        ErrorMessage="Address Field is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="City" SortExpression="City">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("City") %>' CssClass="mask-name" ID="CityTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="CityRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,100}$"
                                        ControlToValidate="CityTextBox" Text="*"
                                        ErrorMessage="City Field is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="State" SortExpression="State">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("State") %>' CssClass="mask-name" ID="StateTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="StateRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,100}$"
                                        ControlToValidate="StateTextBox" Text="*"
                                        ErrorMessage="State Field is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="PostalCode" SortExpression="PostalCode">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="25" Text='<%# Bind("PostalCode") %>' CssClass="mask-pint (zip)" ID="PostalCodeTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="PostalCodeRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^\d{4}$"
                                        ControlToValidate="PostalCodeTextBox" Text="*"
                                        ErrorMessage="Postal Code is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>






                            <asp:TemplateField HeaderText="Bank Account" SortExpression="BankAccount">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Eval("BankAccountsInfo.BankAccountName") %>' ID="BankAccountLabel"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="BankAccountTextBox"  runat="server" ReadOnly="True" SkinID="TextBoxWithButton" OnLoad="BankAccountTextBox_Load"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton2" runat="server" CommandArgument="BankAccount" OnClick="ModalPopButton2_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Country">
                                 <ItemTemplate>
                                     <asp:Label runat="server" Text='<%# Eval("Country.CountryName") %>' ID="CountryLabel"></asp:Label>
                                 </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CountryObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.Country"
                                        SelectMethod="GetCountries"></asp:ObjectDataSource>
                                        <asp:DropDownList ID="CountryDropDownList" runat="server"
                                        DataSourceID="CountryObjectDataSource"  
                                        SelectedValue='<%# Bind("CountryID")%>'
                                        DataTextField="CountryName" DataValueField="CountryID" OnInit="CountryDropDownList_Init" AppendDataBoundItems="True">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>


                               <asp:TemplateField HeaderText="Language">
                                   <ItemTemplate>
                                       <asp:Label runat="server" Text='<%# Eval("Language.Value") %>' ID="LanguageLabel"></asp:Label>
                                   </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="LanguageObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.Language"
                                        SelectMethod="GetLanguages"></asp:ObjectDataSource>
                                        <asp:DropDownList ID="LanguageDropDownList" runat="server"
                                        DataSourceID="LanguageObjectDataSource"  
                                        SelectedValue='<%# Eval("LanguageID")==null ? "0" : Eval("LanguageID") %>'
                                        DataTextField="Value" DataValueField="LanguageID" OnInit="LanguageDropDownList_Init" AppendDataBoundItems="True">
                                            <asp:ListItem Value="0" Text="None" />
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                          
                            <asp:TemplateField HeaderText="Currency">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Eval("Currency.Name") %>' ID="CurrencyLabel"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CurrencyObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.Currency"
                                        SelectMethod="GetCurrencies"></asp:ObjectDataSource>
                                        <asp:DropDownList ID="CurrencyDropDownList" runat="server"
                                        DataSourceID="CurrencyObjectDataSource"  
                                        SelectedValue='<%# Eval("CurrencyID")==null ? "0" : Eval("CurrencyID") %>'
                                        DataTextField="Name" DataValueField="CurrencyID" OnInit="CurrencyDropDownList_Init" AppendDataBoundItems="True">
                                            <asp:ListItem Value="0" Text="None" />
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                              <asp:TemplateField HeaderText="Date Format">
                                  <ItemTemplate>
                                      <asp:Label runat="server" Text='<%# Eval("DateFormat.Value") %>' ID="DateFormatLabel"></asp:Label>
                                  </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="DateFormatObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.DateFormat"
                                        SelectMethod="GetDateFormats"></asp:ObjectDataSource>
                                        <asp:DropDownList ID="DateFormatDropDownList" runat="server"
                                        DataSourceID="DateFormatObjectDataSource"  
                                        SelectedValue='<%# Eval("DateFormatID")==null ? "0" : Eval("DateFormatID") %>'
                                        DataTextField="Value" DataValueField="DateFormatID" OnInit="DateFormatDropDownList_Init" AppendDataBoundItems="True">
                                            <asp:ListItem Value="0" Text="None" />
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            

                                 <asp:TemplateField HeaderText="Time Format">
                                     <ItemTemplate>
                                         <asp:Label runat="server" Text='<%# Eval("TimeFormat.Value") %>' ID="TimeFormatLabel"></asp:Label>
                                     </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TimeFormatObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.TimeFormat"
                                        SelectMethod="GetTimeFormats"></asp:ObjectDataSource>
                                        <asp:DropDownList ID="TimeFormatDropDownList" runat="server"
                                        DataSourceID="TimeFormatObjectDataSource"  
                                        SelectedValue='<%# Eval("TimeFormatID")==null ? "0" : Eval("TimeFormatID") %>'
                                        DataTextField="Value" DataValueField="TimeFormatID" OnInit="TimeFormatDropDownList_Init" AppendDataBoundItems="True">
                                            <asp:ListItem Value="0" Text="None" />
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Time Zone">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Eval("TimeZone.Value") %>' ID="TimeZoneLabel"></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TimeZoneObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.TimeZone"
                                        SelectMethod="GetTimeZones"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TimeZoneDropDownList" runat="server"
                                        DataSourceID="TimeZoneObjectDataSource"
                                        SelectedValue='<%# Eval("TimeZoneID")==null ? "0" : Eval("TimeZoneID") %>'
                                        DataTextField="Value" DataValueField="TimeZoneID" OnInit="TimeZoneDropDownList_Init" AppendDataBoundItems="True">
                                        <asp:ListItem Value="0" Text="None" />
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                   
                           
                             <asp:TemplateField ShowHeader="False">
                                 <EditItemTemplate>
                                <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" ValidationGroup="sum" CausesValidation="True" CommandName="Update" Text="Save" ></asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                    </asp:DetailsView>
                      </ContentTemplate>
            </asp:UpdatePanel>

                     <asp:UpdateProgress ID="CompanyUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
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
            <asp:UpdatePanel runat="server" ID="UpdatePanel3" UpdateMode="Always" >
                <ContentTemplate>
                    <asp:Label ID="ModalLabel" runat="server" SkinID="ModalTitle" Text="Bank Account Details"></asp:Label>

               <br /> <br />

                    <asp:Panel ID="ModalListPanel" SkinID="ModalListPanel" runat="server">
                        <asp:ObjectDataSource ID="BankAccountObjectDataSource" runat="server" SelectMethod="GetBankAccountByCompanyID"
                            
                            TypeName="C3App.BLL.UserBL" DataObjectTypeName="C3App.DAL.BankAccountsInfo"
                             OnInserted="BankAccountObjectDataSource_Inserted"
                             InsertMethod="InsertBankAccount" UpdateMethod="UpdateBankAccount">

                        </asp:ObjectDataSource>
                          <asp:ValidationSummary ID="ValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="company" />
                        <asp:DetailsView FieldHeaderStyle-CssClass="fields-label" CssClass="details-form" ID="BankAccountDetailsView" runat="server"
                            OnItemUpdated="BankAccountDetailsView_ItemUpdated"
                             OnItemInserted="BankAccountDetailsView_ItemInserted"
                              OnItemInserting="BankAccountDetailsView_ItemInserting"
                             OnItemUpdating="BankAccountDetailsView_ItemUpdating"
                             DataKeyNames="BankAccountID" 
                            AutoGenerateRows="False" DataSourceID="BankAccountObjectDataSource">
                            <Fields>
                                <asp:TemplateField HeaderText="Bank Account Name" SortExpression="BankAccountName">
                                    <EditItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Bind("BankAccountName") %>' ID="BankAccountNameTextBox"></asp:TextBox>
                                         <asp:RequiredFieldValidator runat="server" ID="BankAccountNameTextBoxRequiredFieldValidator" ControlToValidate="BankAccountNameTextBox" Text="*" ErrorMessage="Bank Account Name is Required!" ValidationGroup="company" />
                                    </EditItemTemplate>
                                    <InsertItemTemplate>
                                        <asp:TextBox runat="server" Text='<%# Bind("BankAccountName") %>' ID="BankAccountNameTextBox"></asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ID="BankAccountNameTextBoxBoxRequiredFieldValidator" ControlToValidate="BankAccountNameTextBox" Text="*" ErrorMessage="Bank Account Name is Required!" ValidationGroup="company" />
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Bind("BankAccountName") %>' ID="Label1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="BankAccountNumber" HeaderText="Bank Account Number" SortExpression="BankAccountNumber"></asp:BoundField>
                               
                                <asp:TemplateField HeaderText="BankAccountType">
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="BankAccountTypeDropDownList" runat="server"
                                            OnInit="BankAccountTypeDropDownList_Init">
                                            <asp:ListItem Value="" Text="None" />
                                            <asp:ListItem Value="Primary">Primary</asp:ListItem>
                                            <asp:ListItem Value="Current">Current</asp:ListItem>
                                            <asp:ListItem Value="Savings">Savings</asp:ListItem>
                                            <asp:ListItem Value="Salary">Salary</asp:ListItem>
                                            <asp:ListItem Value="Fixed">Fixed</asp:ListItem>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                <asp:LinkButton ID="BankCancelLinkButton" runat="server" OnClientClick="CloseModal('BodyContent_ModalPanel1')" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                <asp:LinkButton ID="BankUpdateLinkButton" runat="server" CssClass="form-btn" ValidationGroup="company" CausesValidation="True" CommandName="Update" Text="Save"></asp:LinkButton>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                  <asp:LinkButton ID="BankCancelLinkButton" runat="server" OnClientClick="CloseModal('BodyContent_ModalPanel1')" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                 <asp:LinkButton ID="BankInsertLinkButton" runat="server" CssClass="form-btn" ValidationGroup="company" CausesValidation="True" CommandName="Insert" Text="Save"></asp:LinkButton>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>                      
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>

        <div id="myModal" class="reveal-modal small">
            <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Always">
                <ContentTemplate>
                    <h4>
                        <asp:Literal ID="Literal1" runat="server" Text=""></asp:Literal></h4>
                    <a class="close-reveal-modal">&#215;</a>
                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

    </asp:Panel>
</asp:Content>
