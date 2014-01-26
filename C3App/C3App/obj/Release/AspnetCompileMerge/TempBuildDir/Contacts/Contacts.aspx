<%@ Page Title="Contact Page" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Contacts.aspx.cs" Inherits="C3App.Contacts.Contacts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="BodyContent">
        <%--lsdfjlsd--%>
    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">

        <asp:LinkButton ID="ContactDetailsLinkButton" runat="server" SkinID="TabTitle" CommandArgument="Insert" Text="Create Contact" OnClientClick="GoToTab(1,'Create Contact');" OnClick="ContactDetailsLinkButton_Click" />

        <asp:Panel ID="DetailsContentPanel" runat="server" SkinID="TabContent">
            <asp:UpdatePanel ID="ContactDetailUpdatePanel" runat="server">

                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ContactDetailsLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <asp:ValidationSummary ID="ContactDetilsValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                    <asp:ObjectDataSource ID="CreateContactObjectDataSource" runat="server" OldValuesParameterFormatString="original_{0}" TypeName="C3App.BLL.ContactBL"
                        DataObjectTypeName="C3App.DAL.Contact"
                        InsertMethod="InsertContact"
                        SelectMethod="GetContactByID"
                        UpdateMethod="UpdateContact" OnUpdated="CreateContactObjectDataSource_Updated"
                        DeleteMethod="DeleteContactByID" OnInserted="CreateContactObjectDataSource_Inserted">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditContactID" Name="contactID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>



                    <asp:DetailsView ID="ContactDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="fields-label" AutoGenerateRows="False"
                        DataSourceID="CreateContactObjectDataSource" DataKeyNames="ContactID,AccountID,CompanyID,Timestamp,CreatedTime,createdBy,FirstName,Salutation"
                        OnItemInserting="ContactDetailsView_ItemInserting"
                        OnItemUpdating="ContactDetailsView_ItemUpdating"
                        OnItemCommand="ContactDetailsView_ItemCommand"
                        DefaultMode="Insert">
                        <Fields>
                            <asp:TemplateField HeaderText="Salutation">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="SalutationDropDownList" runat="server" AppendDataBoundItems="true" OnInit="SalutationDropDownList_Init" SelectedValue='<%# Eval("Salutation")==null ? "None" : Eval("Salutation") %>' ViewStateMode="Disabled">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="None"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Mr." Value="Mr."></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Ms." Value="Ms."></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Mrs." Value="Mrs."></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Dr." Value="Dr."></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Prof." Value="Prof."></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="First Name" SortExpression="FirstName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="FirstNameText" runat="server" CssClass="required-field mask-name" Text='<%# Bind("FirstName") %>' MaxLength="100"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="FirstNameRequiredValidator" runat="server" ControlToValidate="FirstNameText" Display="Static" ErrorMessage="First Name is Required" Text="*" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator ID="FirstNameTextLength" runat="server" ControlToValidate="FirstNameText" Display="None" ValidationExpression="^[A-z\s.-]{1,100}$" Text=""
                                        ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in First Name Field !" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Middle Name" SortExpression="MiddleName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="MiddleNameTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("MiddleName") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="MiddleNameLength" runat="server" ControlToValidate="MiddleNameTextBox" Display="None" ValidationExpression="^[A-z\s.-]{1,50}$" ErrorMessage="Only Letters, Fullstop and Hyphen are allowed in Middel Name Field ! " ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="required-field mask-name" Text='<%# Bind("LastName") %>' MaxLength="100"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="LastNameTextLength" runat="server" ControlToValidate="LastNameTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" Text="" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Last Name Field" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Account Name">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AccountNameTextBox" runat="server" ReadOnly="true" SkinID="TextBoxWithButton" Text='<%# Eval("Account.Name") %>'></asp:TextBox>
                                    <asp:Button ID="ModalPopButton2" runat="server" CausesValidation="false" CommandArgument="Accounts" OnClick="SelectButton_Click" OnClientClick="OpenModal('BodyContent_AccountListModalPanel')" SkinID="ButtonWithTextBox" Text="Select" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Lead Source" SortExpression="LeadSourcesID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="LeadSourcesObjectDataSource" runat="server" TypeName="C3App.BLL.LeadBL" SelectMethod="GetLeadSources" DataObjectTypeName="C3App.DAL.LeadSource"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="LeadSourceDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="LeadSourcesObjectDataSource" DataTextField="Value" DataValueField="LeadSourceID" OnInit="LeadSourceDropDownList_Init"
                                        SelectedValue='<%# Eval("LeadSourcesID")==null ? "0" : Eval("LeadSourcesID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Department" SortExpression="Department">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DepartmentTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("Department") %>' MaxLength="100"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="DepartmentTextLength" runat="server" ControlToValidate="DepartmentTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" Text=""
                                        ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Department Field" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Designation" SortExpression="Designation">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DesignationTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("Designation") %>' MaxLength="100"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="DesignationTextLength" runat="server" ControlToValidate="DesignationTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" Text=""
                                        ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Designation Field" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Date of Birth " SortExpression="BirthDate">
                                <EditItemTemplate>
                                    <asp:TextBox ID="BirthDateTextBox" CssClass="datepicker" runat="server" Text='<%# Bind("BirthDate","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Reports To" SortExpression="ReportsTo">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="ReportToObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" SelectMethod="GetContacts" DataObjectTypeName="C3App.DAL.Contact"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="ReportToDropDownList" runat="server" DataSourceID="ReportToObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("ReportsTo")==null ? "0" : Eval("ReportsTo") %>'
                                        DataTextField="FirstName" DataValueField="ContactID" OnInit="ReportToDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <%--<asp:TemplateField HeaderText="Reports To" SortExpression="ReportsTo">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="ReportToObjectDataSource" runat="server" TypeName="C3App.BLL.UserBL" SelectMethod="GetUsers"                                                          DataObjectTypeName="C3App.DAL.User">
                                    </asp:ObjectDataSource>
                                    <asp:DropDownList ID="ReportToDropDownList" runat="server" DataSourceID="ReportToObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("ReportsTo")==null ? "0" : Eval("ReportsTo") %>'
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="ReportToDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>

                            <asp:TemplateField HeaderText="Office Phone" SortExpression="OfficePhone">
                                <EditItemTemplate>
                                    <asp:TextBox ID="OfficePhoneTextBox" runat="server" CssClass="mask-phone" Text='<%# Bind("OfficePhone") %>' MaxLength="25"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="OfficePhoneTextLength" runat="server" ControlToValidate="OfficePhoneTextBox" Display="None"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$" Text=""
                                        ErrorMessage="Office phone should only accept phone format value" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Mobile No" SortExpression="MobilePhone">
                                <EditItemTemplate>
                                    <asp:TextBox ID="MobilePhoneTextBox" runat="server" CssClass="mask-phone" Text='<%# Bind("MobilePhone") %>' MaxLength="25"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="MobilePhoneTextLength" runat="server" ControlToValidate="MobilePhoneTextBox" Display="None"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$" Text=""
                                        ErrorMessage="Mobile phone should only accept phone format value" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Home Phone" SortExpression="HomePhone">
                                <EditItemTemplate>
                                    <asp:TextBox ID="HomePhoneTextBox" runat="server" CssClass="mask-phone" Text='<%# Bind("HomePhone") %>' MaxLength="25"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="HomePhoneTextLength" runat="server" ControlToValidate="HomePhoneTextBox" Display="None"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$" Text=""
                                        ErrorMessage="Home phone should only accept phone format value" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Other Phone" SortExpression="OtherPhone">
                                <EditItemTemplate>
                                    <asp:TextBox ID="OtherPhoneTextBox" runat="server" CssClass="mask-phone" Text='<%# Bind("OtherPhone") %>' MaxLength="25"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="OtherPhoneTextLength" runat="server" ControlToValidate="OtherPhoneTextBox" Display="None"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$" Text=""
                                        ErrorMessage="Other phone should only accept phone format value" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Fax" SortExpression="Fax">
                                <EditItemTemplate>
                                    <asp:TextBox ID="FaxTextBox" runat="server" Text='<%# Bind("Fax") %>' MaxLength="25"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="FaxTextLength" runat="server" ControlToValidate="FaxTextBox" Display="None"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$" Text=""
                                        ErrorMessage="Fax should only accept fax format value" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Primary Email" SortExpression="PrimaryEmail">
                                <EditItemTemplate>
                                    <asp:TextBox ID="PrimaryEmailTextBox" runat="server" CssClass="required-field mask-email" Text='<%# Bind("PrimaryEmail") %>' MaxLength="100"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="AddRegexEmailValid" runat="server"
                                        ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*.{1,100}"
                                        ControlToValidate="PrimaryEmailTextBox" ErrorMessage="Primary email address invelid, accept only email format value" Display="None" ValidationGroup="sum"></asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Alternate Email" SortExpression="AlternateEmail">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AlternateEmailTextBox" runat="server" CssClass="mask-email" Text='<%# Bind("AlternateEmail") %>' MaxLength="100"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="regexOthersEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*.{1,100}"
                                        ControlToValidate="AlternateEmailTextBox" ErrorMessage="Alternate email address invelid, accept only email format value" Display="None" ValidationGroup="sum" />
                                    <asp:CompareValidator ID="cvEmail" runat="server" ControlToValidate="AlternateEmailTextBox" ControlToCompare="PrimaryEmailTextBox" Operator="NotEqual"
                                        ErrorMessage="Alternate Email address must be different from Primary Email address" Display="None" ValidationGroup="sum"></asp:CompareValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Assistant Name" SortExpression="AssistantName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AssistantNameTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("AssistantName") %>' MaxLength="75"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="AssistantNameLength" runat="server" ControlToValidate="AssistantNameTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,75}$" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Assistant Name Field ! " ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Assistant Phone" SortExpression="AssistantPhone">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AssistantPhoneTextBox" runat="server" CssClass="mask-phone" Text='<%# Bind("AssistantPhone") %>' MaxLength="25"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="AssistantPhoneLength" runat="server" ControlToValidate="AssistantPhoneTextBox" Display="None"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$" Text="" ErrorMessage="Assistant phone should only accept phone format value" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Primary Street" SortExpression="PrimaryStreet">
                                <EditItemTemplate>
                                    <asp:TextBox ID="PrimaryStreetTextBox" runat="server" CssClass="mask-street" Text='<%# Bind("PrimaryStreet") %>' MaxLength="150"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="PrimaryStreetLength" runat="server" ControlToValidate="PrimaryStreetTextBox" Display="None"
                                        ValidationExpression="^[a-zA-Z0-9\s\(\)\/,\:\;\.-]+$" Text="" ErrorMessage="Some Special Characters are not supported in Primary Street " ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Primary City" SortExpression="PrimaryCity">
                                <EditItemTemplate>
                                    <asp:TextBox ID="PrimaryCityTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("PrimaryCity") %>' MaxLength="100"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="PrimaryCityLength" runat="server" ControlToValidate="PrimaryCityTextBox" Display="None"
                                        ValidationExpression="^[a-zA-Z\s]+$" Text="" ErrorMessage="Some Special Characters are not supported in Primary City" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Primary State" SortExpression="PrimaryState">
                                <EditItemTemplate>
                                    <asp:TextBox ID="PrimaryStateTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("PrimaryState") %>' MaxLength="100"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="PrimaryStateLength" runat="server" ControlToValidate="PrimaryStateTextBox" Display="None"
                                        ValidationExpression="^[a-zA-Z\s]+$" Text="" ErrorMessage="Some Special Characters are not supported in Primary State" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Primary Postal Code" SortExpression="PrimaryPostalCode">
                                <EditItemTemplate>
                                    <asp:TextBox ID="PrimaryPostalCodeTextBox" runat="server" CssClass="mask-pint" Text='<%# Bind("PrimaryPostalCode") %>' MaxLength="25"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="PrimaryPostalCodeLength" runat="server" ControlToValidate="PrimaryPostalCodeTextBox" Display="None"
                                        ValidationExpression="^\d{4}$" Text="" ErrorMessage="Primary postal code should only accept postal code format value" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Primary Country" SortExpression="PrimaryCountry">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource runat="server" ID="PrimaryCountryObjectDataSource"
                                        TypeName="C3App.BLL.UserBL" DataObjectTypeName="C3App.DAL.Country"
                                        SelectMethod="GetCountries"></asp:ObjectDataSource>
                                    <asp:DropDownList runat="server" ID="PrimaryCountryDropDownList"
                                        DataSourceID="PrimaryCountryObjectDataSource"
                                        SelectedValue='<%# Eval("PrimaryCountry")==null ? "0" : Eval("PrimaryCountry") %>'
                                        AppendDataBoundItems="true"
                                        DataTextField="CountryName" DataValueField="CountryID"
                                        AutoPostBack="False" OnInit="PrimaryCountryDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Alternate Street" SortExpression="AlternateStreet">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AlternateStreetTextBox" runat="server" CssClass="mask-street" Text='<%# Bind("AlternateStreet") %>' MaxLength="150"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="AlternateStreetLength" runat="server" ControlToValidate="AlternateStreetTextBox" Display="None"
                                        ValidationExpression="^[a-zA-Z0-9\s\(\)\/,\:\;\.-]+$" Text="" ErrorMessage="Some Special Characters are not supported in Alternate Street !" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Alternate City" SortExpression="AlternateCity">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AlternateCityTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("AlternateCity") %>' MaxLength="100"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="AlternateCityLength" runat="server" ControlToValidate="AlternateCityTextBox" Display="None"
                                        ValidationExpression="^[a-zA-Z\s]+$" Text="" ErrorMessage="Some Special Characters are not supported in Alternate City" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Alternate State" SortExpression="AlternateState">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AlternateStateTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("AlternateState") %>' MaxLength="100"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="AlternateStateLength" runat="server" ControlToValidate="AlternateStateTextBox" Display="None"
                                        ValidationExpression="^[a-zA-Z\s]+$" Text="" ErrorMessage="Some Special Characters are not supported in Alternate State" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Alternate Postal Code" SortExpression="AlternatePostalCode">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AlternatePostalCodeTextBox" runat="server" CssClass="mask-pint" Text='<%# Bind("AlternatePostalCode") %>' MaxLength="25"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="AlternatePostalCodeExpretion" runat="server" ControlToValidate="AlternatePostalCodeTextBox" Display="None" ValidationExpression="^\d{4}$" Text="" ErrorMessage="Alternate postal code should only accept postal code format value" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Alternate Country" SortExpression="AlternateCountry">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource runat="server" ID="AlternateCountryObjectDataSource"
                                        TypeName="C3App.BLL.UserBL" DataObjectTypeName="C3App.DAL.Country"
                                        SelectMethod="GetCountries"></asp:ObjectDataSource>
                                    <asp:DropDownList runat="server" ID="AlternateCountryDropDownList"
                                        DataSourceID="AlternateCountryObjectDataSource" SelectedValue='<%# Eval("AlternateCountry")==null ? "0" : Eval("AlternateCountry") %>'
                                        AppendDataBoundItems="true"
                                        DataTextField="CountryName" DataValueField="CountryID"
                                        AutoPostBack="False" OnInit="AlternateCountryDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:CheckBoxField DataField="DoNotCall" HeaderText="Do Not Call" SortExpression="DoNotCall" />

                            <asp:CheckBoxField DataField="EmailOptOut" HeaderText="Email Opt Out" SortExpression="EmailOptOut" />

                            <asp:CheckBoxField DataField="InvalidEmail" HeaderText="Invalid Email" SortExpression="InvalidEmail" />

                            <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TameNameObjectDataSource" runat="server" TypeName="C3App.BLL.TeamBL" SelectMethod="GetTeams" DataObjectTypeName="C3App.DAL.Team"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamNameDropDownList" runat="server" DataSourceID="TameNameObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("TeamID")==null ? "0" : Eval("TeamID") %>'
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamNameDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedTo">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignedToObjectDataSource" runat="server" TypeName="C3App.BLL.UserBL" SelectMethod="GetUsers" DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssaigendToDropDownList" runat="server" DataSourceID="AssignedToObjectDataSource" AppendDataBoundItems="true" OnSelectedIndexChanged="AssaigendToDropDownList_SelectedIndexChanged" AutoPostBack="True"
                                        SelectedValue='<%# Eval("AssignedTo")==null ? "0" : Eval("AssignedTo") %>'
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssaigendToDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:Label ID="NotifyLabel" runat="server" Text="Notify user" Visible="False"></asp:Label>
                                    <asp:CheckBox ID="NotifyCheckBox" runat="server" Text="" Visible="False" OnCheckedChanged="NotifyCheckBox_CheckedChanged" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DescriptionText" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False">
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>&nbsp;
                                    <asp:LinkButton ID="InsertLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" Text="Save" ValidationGroup="sum"></asp:LinkButton>
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>&nbsp;
                                    <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Update" Text="Save" ValidationGroup="sum"></asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>

                        </Fields>
                    </asp:DetailsView>

                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="ContactDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="ContactDetailUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>



        <asp:Panel ID="AccountListModalPanel" runat="server" SkinID="ModalPopLeft">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

            <asp:UpdatePanel runat="server" ID="ModalUpdatePanel" UpdateMode="Always">
                <Triggers>
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="AccountModalTitleLabel" runat="server" SkinID="ModalTitle" Text="Select Account"></asp:Label>
                    <asp:LinkButton ID="CreateAccountLinkButton" runat="server" CssClass="modal-create-btn" Text="Create" OnClientClick="OpenCreateModal('BodyContent_CreateAccountModalPanel')" />

                    <asp:Panel ID="ModalSearchPanel" runat="server" SkinID="ModalSearchPanel">

                        <asp:Panel ID="AccountSearchPanel" runat="server" Visible="False">
                            <asp:Label ID="SearchLabel" runat="server" Text="Search" />
                            <asp:Panel ID="AccountSearchPanel2" runat="server" CssClass="search">
                                <asp:TextBox ID="AccountSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="AccountSearchTextBox_TextChanged"></asp:TextBox>
                                <asp:LinkButton ID="AccountSearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="AccountSearchTextBox_TextChanged"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                    </asp:Panel>
                    <asp:Panel ID="ModalListPanel" runat="server" SkinID="ModalListPanel">
                        <asp:ObjectDataSource ID="AccountObjectDataSource" runat="server" SelectMethod="SearchAccount" TypeName="C3App.BLL.AccountBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="AccountSearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:UpdatePanel ID="AccountList" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="AccountGridView" runat="server" AutoGenerateColumns="False" DataSourceID="AccountObjectDataSource" Visible="False" CssClass="list-form" ShowHeader="False">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="AccountImage" runat="server" ImageUrl="~/Content/images/c3/account.jpg" />
                                                <asp:LinkButton ID="SelectAccountLinkButton" runat="server" CommandArgument='<%# Eval("AccountID") %>' CommandName="Select" OnCommand="SelectAccountLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("PrimaryEmail") %>' />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdateProgress ID="UpdateProgress4" runat="server" AssociatedUpdatePanelID="AccountList">
                            <ProgressTemplate>
                                <asp:Panel ID="ProgressOverlayPanel1" runat="server" CssClass="loading"></asp:Panel>
                                <asp:Panel ID="ProgressOverlayContent1" runat="server" CssClass="loadingContent">
                                    <h2>Loading...</h2>
                                    <asp:Image ID="ProgressImage1" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                                </asp:Panel>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
           <%-- <asp:UpdateProgress ID="ModalUpdateProgress" runat="server" AssociatedUpdatePanelID="ModalUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>--%>
        </asp:Panel>
        <asp:UpdatePanel ID="AccountUpdatePanel" runat="server" UpdateMode="Conditional">
            <Triggers>
            </Triggers>
            <ContentTemplate>
                <asp:Panel ID="CreateAccountModalPanel" runat="server" SkinID="ModalCreatePanelLeft">
                    <asp:HyperLink ID="HyperLink11" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
                    <asp:Label ID="CreateAccountLabel" runat="server" SkinID="ModalTitle" Text="Create New Account" />
                    <asp:Panel ID="CreateContentPanel" runat="server" CssClass="modal-create-content">

                        <asp:ObjectDataSource ID="AccountsDetailsObjectDataSource" runat="server"
                            TypeName="C3App.BLL.AccountBL" DataObjectTypeName="C3App.DAL.Account"
                            InsertMethod="InsertAccount" SelectMethod="GetAccounts" OnInserted="AccountsDetailsObjectDataSource_Inserted"></asp:ObjectDataSource>

                        <asp:ValidationSummary ID="AccountValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="avs" />
                        <br />
                        <asp:DetailsView ID="AccountDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="field-label"
                            DataSourceID="AccountsDetailsObjectDataSource"
                            DataKeyNames="AccountID,CompanyID,Name,CreatedTime,ModifiedTime"
                            AutoGenerateRows="False"
                            OnItemInserting="AccountDetailsView_ItemInserting"
                            OnItemInserted="AccountDetailsView_ItemInserted"
                            OnItemCommand="AccountDetailsView_ItemCommand"
                            DefaultMode="Insert">
                            <Fields>
                                <asp:TemplateField HeaderText="Account Name" SortExpression="Name">
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="AccountNameTextBox" runat="server" CssClass="required-field mask-name" Text='<%# Bind("Name") %>' MaxLength="150"></asp:TextBox><asp:RequiredFieldValidator ID="AccountNameRequiredValidator" runat="server" ControlToValidate="AccountNameTextBox" Display="none" ErrorMessage="Name is Required" Text="*" ValidationGroup="avs" />
                                        <asp:RegularExpressionValidator ID="AccountNameRegularExpression" runat="server" ControlToValidate="AccountNameTextBox" Display="None" ValidationExpression="^[A-z\s.-]{1,150}$" Text="" ErrorMessage="Only Letters, Fullstop and Hyphen are allowed in Account Name Field !" ValidationGroup="sum" />
                                    </InsertItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Primary Email" SortExpression="PrimaryEmail">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="AccountPrimaryEmailTextBox" runat="server" CssClass="mask-email" Text='<%# Bind("PrimaryEmail") %>' MaxLength="100"></asp:TextBox><asp:RegularExpressionValidator ID="AccountPrimaryEmailRegularExpression" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*.{1,100}"
                                            ControlToValidate="AccountPrimaryEmailTextBox" ErrorMessage="Primary email address invelid, accept only email format value" Display="None" ValidationGroup="avs"></asp:RegularExpressionValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Office Phone" SortExpression="OfficePhone">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="AccountOfficePhoneTextBox" runat="server" CssClass="mask-phone" Text='<%# Bind("OfficePhone") %>' MaxLength="25"></asp:TextBox><asp:RegularExpressionValidator ID="AccountOfficePhoneRegularExpression" runat="server" ControlToValidate="AccountOfficePhoneTextBox" Display="None"
                                            ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$" Text="" ErrorMessage="Office phone should only accept phone format value" ValidationGroup="avs" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Website" SortExpression="Website">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="AccountWebsiteTextBox" runat="server" CssClass="mask-url" Text='<%# Bind("Website") %>' MaxLength="255"></asp:TextBox><asp:RegularExpressionValidator ID="AccountWebsiteRegularExpression" runat="server" ControlToValidate="AccountWebsiteTextBox" Display="None"
                                            ValidationExpression="^(ht|f)tp(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(\/?)([a-zA-Z0-9\-\.\?\,\'\/\\\+&amp;%\$#_]*)?$"
                                            Text="" ErrorMessage="Website should only accept URL format value" ValidationGroup="avs" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ShowHeader="False">
                                    <InsertItemTemplate>
                                        <%--<asp:LinkButton ID="CancelLinkButton2" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>&nbsp;&nbsp;--%>
                                        <asp:LinkButton ID="InsertLinkButton2" runat="server" CssClass="form-btn" CausesValidation="true" CommandName="Insert" Text="Save" ValidationGroup="avs"></asp:LinkButton>
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                    </asp:Panel>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdateProgress ID="AccountUpdateProgress" runat="server" AssociatedUpdatePanelID="AccountUpdatePanel">
            <ProgressTemplate>
                <asp:Panel ID="ProgressOverlayPanel3" runat="server" CssClass="loading"></asp:Panel>
                <asp:Panel ID="ProgressOverlayContent3" runat="server" CssClass="loadingContent">
                    <h2>Loading...</h2>
                    <asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
    </asp:Panel>

    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">
        <asp:LinkButton ID="ViewContactsLinkButton" runat="server" SkinID="TabTitle" OnClick="ViewContactsLinkButton_Click" Text="View Contacts" OnClientClick="GoToTab(2,'Create Contact');" />
        <asp:Panel ID="ViewContentPanel" runat="server" SkinID="TabContent">

            <asp:ObjectDataSource ID="SearchContactObjectDataSource" runat="server"
                DataObjectTypeName="C3App.DAL.Contact"
                TypeName="C3App.BLL.ContactBL"
                SelectMethod="GetContactByName"
                UpdateMethod="UpdateContact">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>

            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">

                <asp:Panel ID="filterSearchPanel" runat="server" CssClass="filter">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search Filter" />
                    <asp:LinkButton ID="SearchAllLinkButton" runat="server" CssClass="search-label active" OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="TextSearchPanel" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="SearchTextLabel" runat="server" Text="Search" />
                    <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox><asp:LinkButton ID="SearchButton" runat="server" CssClass="search-btn" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="ListPanel" runat="server" SkinID="ListPanel">
                <asp:UpdatePanel ID="ContactListUpdatePanel" runat="server" UpdateMode="Conditional">

                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewContactsLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                    </Triggers>

                    <ContentTemplate>

                        <asp:ObjectDataSource ID="ContactListObjectDataSource" runat="server" SelectMethod="GetContacts"
                            TypeName="C3App.BLL.ContactBL" DataObjectTypeName="C3App.DAL.Contact"></asp:ObjectDataSource>

                        <asp:GridView ID="ContactGridView" runat="server" CssClass="list-form"
                            AutoGenerateColumns="False"
                            DataKeyNames="ContactID"
                            DataSourceID="ContactListObjectDataSource"
                            GridLines="None"
                            ShowHeader="false">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="ContactImage" runat="server" ImageUrl="~/Content/images/c3/contact.jpg" />
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("ContactID")+ ";" + Eval("AssignedTo") + ";" + Eval("FirstName")+" "+Eval("LastName") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                            <%-- <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("ContactID") %>'  CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">--%>
                                            <%# Eval("FirstName") %>&nbsp;
                                                 <%# Eval("LastName") %><br />
                                            <asp:Label ID="EmailAddressLabel" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="ListViewUpdateProgress" runat="server" AssociatedUpdatePanelID="ContactListUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel4" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent4" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage4" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </asp:Panel>
            <asp:UpdatePanel ID="MiniDetailsUpdatePanel" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Panel ID="MiniDetailBasicPanel" runat="server" CssClass="mini-detail-panel">

                        <asp:ObjectDataSource ID="MiniContactObjectDataSource" runat="server"
                            TypeName="C3App.BLL.ContactBL"
                            SelectMethod="GetContactByID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ContactGridView" Type="Int64" Name="contactID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:FormView ID="MiniContactFormView" runat="server" CssClass="mini-details-form"
                            DataSourceID="MiniContactObjectDataSource"
                            DataKeyNames="ContactID">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Image ID="ContactImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/contact.jpg" />
                                <asp:Panel ID="MinBasicPanel" runat="server">
                                    <asp:Label ID="FirstNameLabel" runat="server" CssClass="fullname" Text='<%# string.Concat(Eval("FirstName")," ",Eval("LastName"))%>'></asp:Label>
                                    <asp:Label ID="DesignationLabel" runat="server" CssClass="id-card" Text='<%# Eval("Designation") %>'></asp:Label>
                                    <asp:Label ID="AccountNameLabel" runat="server" CssClass="royal-building" Text='<%# Eval("Account.Name") %>'></asp:Label>
                                    <asp:Label ID="PrimaryEmailLabel" runat="server" CssClass="email" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                    <asp:Label ID="OfficePhoneLabel" runat="server" CssClass="phone" Text='<%# Eval("OfficePhone") %>'></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:Panel ID="ButtonPanel" runat="server" CssClass="mini-detail-control-panel four-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="EditLinkButton" runat="server" CssClass="control-btn" Text="Edit" ToolTip="Edit" CommandArgument="ContactID" OnClientClick="GoToTab(1,'Contact Details');" OnClick="EditLinkButton_Click">
                                            <i class="icon-edit"></i>
                                    </asp:LinkButton></li>
                                <li>
                                    <asp:Panel ID="Panel1" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="NotifyLinkButton" CssClass="control-btn has-confirm " runat="server" Text="Convert" ToolTip="Notify to User">
                                       <i class="icon-share-alt"></i></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="GoToTab(2);" OnClick="NotifyLinkButton_Click">Notify</asp:LinkButton><asp:LinkButton ID="LinkButton2" runat="server" class="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>
                                <li>
                                    <asp:LinkButton ID="MeetingSummaryLinkButton" runat="server" CssClass="control-btn" ToolTip="Meeting Summary" OnClick="ShowMeetings_Click" OnClientClick="OpenModal('BodyContent_MeetingInviteeModalPanel')">
                                            <i class="icon-calendar"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:Panel ID="DeleteConfirmPanel" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CssClass="control-btn has-confirm" Text="Delete" CommandArgument="ContactID" ToolTip="Delete">
                                            <i class="icon-trash"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="ConfirmLinkButton" runat="server" OnClick="DeleteLinkButton_Click">Confirm</asp:LinkButton><asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>
                            </ul>
                        </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="MiniDetailMorePanel" runat="server" SkinID="MiniDetailMorePanel">
                        <asp:Panel ID="MiniContactDetailMore" runat="server">

                            <asp:DetailsView ID="MiniContactDetailsView" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label"
                                DataSourceID="MiniContactObjectDataSource"
                                DataKeyNames="ContactID"
                                AutoGenerateRows="False">
                                <EmptyDataTemplate>
                                    <p>Data Not Found</p>
                                </EmptyDataTemplate>
                                <FieldHeaderStyle CssClass="field-label" />
                                <Fields>
                                    <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
                                    <asp:TemplateField HeaderText="Date of Birth" SortExpression="BirthDate">
                                        <ItemTemplate>
                                            <asp:Label ID="BirthDateLabel" runat="server" Text='<%# Bind("BirthDate","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="MobilePhone" HeaderText="Mobile No" SortExpression="MobilePhone" />
                                    <asp:BoundField DataField="HomePhone" HeaderText="Home Phone" SortExpression="HomePhone" />
                                    <asp:BoundField DataField="OtherPhone" HeaderText="Other Phone" SortExpression="OtherPhone" />
                                    <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax" />
                                    <asp:BoundField DataField="AlternateEmail" HeaderText="Alternate Email" SortExpression="AlternateEmail" />
                                    <asp:BoundField DataField="AssistantName" HeaderText="Assistant Name" SortExpression="AssistantName" />
                                    <asp:BoundField DataField="AssistantPhone" HeaderText="Assistant Phone" SortExpression="AssistantPhone" />

                                    <asp:BoundField DataField="PrimaryStreet" HeaderText="Primary Street" SortExpression="PrimaryStreet" />
                                    <asp:BoundField DataField="PrimaryCity" HeaderText="Primary City" SortExpression="PrimaryCity" />
                                    <asp:BoundField DataField="PrimaryState" HeaderText="Primary State" SortExpression="PrimaryState" />
                                    <asp:BoundField DataField="PrimaryPostalCode" HeaderText="Primary Postal Code" SortExpression="PrimaryPostalCode" />

                                    <asp:TemplateField HeaderText="Primary Country" SortExpression="PrimaryCountry">
                                        <ItemTemplate>
                                            <asp:Label ID="PrimaryCountryLabel" runat="server" Text='<%# Eval("Country1.CountryName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="AlternateStreet" HeaderText="Alternate Street" SortExpression="AlternateStreet" />
                                    <asp:BoundField DataField="AlternateCity" HeaderText="Alternate City" SortExpression="AlternateCity" />
                                    <asp:BoundField DataField="AlternateState" HeaderText="Alternate State" SortExpression="AlternateState" />
                                    <asp:BoundField DataField="AlternatePostalCode" HeaderText="Alternate Postal Code" SortExpression="AlternatePostalCode" />
                                    <asp:TemplateField HeaderText="Alternate Country" SortExpression="AlternateCountry">
                                        <ItemTemplate>
                                            <asp:Label ID="AlternateCountryLabel" runat="server" Text='<%# Bind("Country.CountryName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />

                                    <asp:TemplateField HeaderText="Reports To" SortExpression="ReportsTo">
                                        <ItemTemplate>
                                            <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("User.FirstName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Lead Source" SortExpression="LeadSourceID">
                                        <ItemTemplate>
                                            <asp:Label ID="LeadSourceLabel" runat="server" Text='<%# Eval("LeadSource.Value") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                        <ItemTemplate>
                                            <asp:Label ID="TeamNameLabel" runat="server" Text='<%# Eval("Team.Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedTo">
                                        <ItemTemplate>
                                            <asp:Label ID="AssingdUserLabel" runat="server" Text='<%# Eval("User.FirstName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                            </asp:DetailsView>
                        </asp:Panel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="miniDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="MiniDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel5" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent5" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage5" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </asp:Panel>



        <asp:Panel ID="MeetingInviteeModalPanel" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label4" runat="server" SkinID="ModalTitle" Text="Meetings Summary"></asp:Label><asp:Panel ID="Panel9" SkinID="ModalListPanel" runat="server">

                <asp:UpdatePanel runat="server" ID="MeetingSummaryUpdatePanel" UpdateMode="Conditional">
                    <ContentTemplate>

                        <asp:ObjectDataSource ID="MeetingInviteeObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Meeting"
                            TypeName="C3App.BLL.MeetingBL" SelectMethod="GetMeetingsByInvitee">
                            <SelectParameters>
                                <asp:Parameter Name="inviteeType" Type="String" DefaultValue="Contacts"></asp:Parameter>
                                <asp:SessionParameter SessionField="EditContactID" Name="inviteeID" Type="Int64"></asp:SessionParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:GridView ID="MeetingsInvitedGridView" runat="server" CssClass="list-form calendar-form" OnInit="MeetingsInvitedGridView_Init"
                            AutoGenerateColumns="False" GridLines="None">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>

                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <table>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <asp:Label runat="server" ID="DateLabel" CssClass="date" Text='<%# Eval("StartDate","{0:dd}")%>'></asp:Label>
                                                        <asp:Label runat="server" ID="MonthLabel" CssClass="month" Text='<%# Eval("StartDate","{0:MMM}")%>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <ul class="event">
                                                            <li>
                                                                <asp:Label runat="server" ID="SubjectLabel" CssClass="name" Text='<%# Eval("Subject")%>'></asp:Label>
                                                                <asp:Label runat="server" ID="TimeLabel" CssClass="time" Text='<%# Eval("StartDate","{0:hh:mm}")+ " - " + Eval("EndDate","{0:hh:mm}")%>'></asp:Label>
                                                                <asp:Label runat="server" ID="LocationLabel" CssClass="time" Text='<%# Eval("Location") %>'></asp:Label>
                                                            </li>
                                                        </ul>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>

                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>

                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>


            </asp:Panel>
        </asp:Panel>

    </asp:Panel>

    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel4" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="MessageLiteral" runat="server" Text=""></asp:Literal></h4>
                <a class="close-reveal-modal">&#215;</a>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
