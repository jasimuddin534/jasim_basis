<%@ Page Title="Create Contacts" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="ContactDetails.aspx.cs" Inherits="C3App.Contacts.ContactDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <a class="title" href="javascript:void(0)">Create Contacts<span class="pull-right">&bull; Required</span></a>
    <div class="tab-content">
        <asp:ObjectDataSource ID="ContactObjectDataSource" runat="server"
            TypeName="C3App.BLL.ContactBL"
            DataObjectTypeName="C3App.DAL.Contact"
            InsertMethod="InsertContact" 
            SelectMethod="GetContactByID"
            UpdateMethod="UpdateContact"
            DeleteMethod="DeleteContact">
            <SelectParameters>
                 <asp:QueryStringParameter Name="contactID" QueryStringField="ContactID" Type="Int32" />
             </SelectParameters>
        </asp:ObjectDataSource>

        <asp:DetailsView FieldHeaderStyle-CssClass="form-fields-header" CssClass="form-fields" ID="ContactDetailsView" runat="server" AutoGenerateRows="False"
            
            OnItemInserting="ContactDetailsView_ItemInserting"
            DataSourceID="ContactObjectDataSource"
             AllowPaging="True"
             DataKeyNames="ContactID,CompanyID,CreatedTime,createdBy"
             OnItemUpdating="ContactDetailsView_ItemUpdating"
             OnItemCommand="ContactDetailsView_ItemCommand"      
            >
<FieldHeaderStyle CssClass="form-fields-header"></FieldHeaderStyle>
            <Fields>
                <asp:TemplateField HeaderText="Salutation" SortExpression="Salutation">
                    <EditItemTemplate>
                        <asp:TextBox ID="SalutationTxt" runat="server" Text='<%# Bind("Salutation") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="SalutationTxt" runat="server" Text='<%# Bind("Salutation") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="SalutationLabel" runat="server" Text='<%# Bind("Salutation") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="First Name" SortExpression="FirstName">
                    <EditItemTemplate>
                        <asp:TextBox ID="FirstNameTxt" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="FirstNameTxt" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="input-validate" ID="FirstNameRequiredValidator" runat="server" ControlToValidate="firstNameTxt" ForeColor="Red" ErrorMessage=" First name required "></asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Middle Name" SortExpression="MiddleName">
                    <EditItemTemplate>
                        <asp:TextBox ID="MiddleNameTxt" runat="server" Text='<%# Bind("MiddleName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="MiddleNameTxt" runat="server" Text='<%# Bind("MiddleName") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="MiddleNameLabel" runat="server" Text='<%# Bind("MiddleName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">
                    <EditItemTemplate>
                        <asp:TextBox ID="LastNameTxt" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="LastNameTxt" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="LastNameLabel" runat="server" Text='<%# Bind("LastName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Account Name">
                    <InsertItemTemplate>
                        <asp:ObjectDataSource ID="AccountNameObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" SelectMethod="GetAccounts"
                            DataObjectTypeName="C3App.DAL.Account"></asp:ObjectDataSource>
                        <asp:DropDownList ID="AccountNameDropDownList" runat="server" DataSourceID="AccountNameObjectDataSource"
                            DataTextField="Name" DataValueField="AccountID" OnInit="AccountNameDropDownList_Init">
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Lead Sources">
                    <InsertItemTemplate>
                        <asp:ObjectDataSource ID="LeadSourcesObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" SelectMethod="GetLeadSources"
                            DataObjectTypeName="C3App.DAL.LeadSource"></asp:ObjectDataSource>
                        <asp:DropDownList ID="LeadSourceDropDownList" runat="server" DataSourceID="LeadSourcesObjectDataSource"
                            DataTextField="Value" DataValueField="LeadSourceID" OnInit="LeadSourceDropDownList_Init">
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Title" SortExpression="Title">
                    <EditItemTemplate>
                        <asp:TextBox ID="TitleTxt" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TitleTxt" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Department" SortExpression="Department">
                    <EditItemTemplate>
                        <asp:TextBox ID="DepartmentTxt" runat="server" Text='<%# Bind("Department") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="DepartmentTxt" runat="server" Text='<%# Bind("Department") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="DepartmentLabel" runat="server" Text='<%# Bind("Department") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <%--    <asp:TemplateField HeaderText="Designation" SortExpression="Designation">
                <EditItemTemplate>
                    <asp:TextBox ID="DesignationTxt" runat="server" Text='<%# Bind("Designation") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="DesignationTxt" runat="server" Text='<%# Bind("Designation") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="DesignationLabel" runat="server" Text='<%# Bind("Designation") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>--%>

                <asp:TemplateField HeaderText="Birth Date" SortExpression="BirthDate">
                    <EditItemTemplate>
                        <asp:TextBox ID="BirthDateTxt" runat="server" Text='<%# Bind("BirthDate") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="BirthDateTxt" runat="server" Text='<%# Bind("BirthDate") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="BirthDateLabel" runat="server" Text='<%# Bind("BirthDate") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Reports To">
                    <InsertItemTemplate>
                        <asp:ObjectDataSource ID="ReportToObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" SelectMethod="GetUsers"
                            DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                        <asp:DropDownList ID="ReportToDropDownList" runat="server" DataSourceID="ReportToObjectDataSource"
                            DataTextField="UserName" DataValueField="UserID" OnInit="ReportToDropDownList_Init">
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>


               <%-- <asp:TemplateField HeaderText="Do Not Call" SortExpression="DoNotCall">
                    <EditItemTemplate>
                        <asp:CheckBox ID="DoNotCallCheckBox" runat="server" Checked='<%# Bind("DoNotCall") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="DoNotCallCheckBox" runat="server" Checked='<%# Bind("DoNotCall") %>' />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="DoNotCallCheckBox" runat="server" Checked='<%# Bind("DoNotCall") %>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>--%>

                <asp:TemplateField HeaderText="Team Name">
                    <InsertItemTemplate>
                        <asp:ObjectDataSource ID="TameNameObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" SelectMethod="GetTeams"
                            DataObjectTypeName="C3App.DAL.Team"></asp:ObjectDataSource>
                        <asp:DropDownList ID="TeamNameDropDownList" runat="server" DataSourceID="TameNameObjectDataSource"
                            DataTextField="Name" DataValueField="TeamID" OnInit="TeamNameDropDownList_Init">
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Assigned To">
                    <InsertItemTemplate>
                        <asp:ObjectDataSource ID="AssignedToObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" SelectMethod="GetUsers"
                            DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                        <asp:DropDownList ID="AssaigendToDropDownList" runat="server" DataSourceID="AssignedToObjectDataSource"
                            DataTextField="UserName" DataValueField="UserID" OnInit="AssaigendToDropDownList_Init">
                        </asp:DropDownList>
                    </InsertItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField HeaderText="Office Phone" SortExpression="OfficePhone">
                    <EditItemTemplate>
                        <asp:TextBox ID="OfficePhoneTxt" runat="server" Text='<%# Bind("OfficePhone") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="OfficePhoneTxt" runat="server" Text='<%# Bind("OfficePhone") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="OfficePhoneLabel" runat="server" Text='<%# Bind("OfficePhone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Mobile Phone" SortExpression="MobilePhone">
                    <EditItemTemplate>
                        <asp:TextBox ID="MobilePhoneTxt" runat="server" Text='<%# Bind("MobilePhone") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="MobilePhoneTxt" runat="server" Text='<%# Bind("MobilePhone") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="MobilePhoneLabel" runat="server" Text='<%# Bind("MobilePhone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Home Phone" SortExpression="HomePhone">
                    <EditItemTemplate>
                        <asp:TextBox ID="HomePhoneTxt" runat="server" Text='<%# Bind("HomePhone") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="HomePhoneTxt" runat="server" Text='<%# Bind("HomePhone") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="HomePhoneLabel" runat="server" Text='<%# Bind("HomePhone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Other Phone" SortExpression="OtherPhone">
                    <EditItemTemplate>
                        <asp:TextBox ID="OtherPhoneTxt" runat="server" Text='<%# Bind("OtherPhone") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="OtherPhoneTxt" runat="server" Text='<%# Bind("OtherPhone") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="OtherPhoneLabel" runat="server" Text='<%# Bind("OtherPhone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Fax" SortExpression="Fax">
                    <EditItemTemplate>
                        <asp:TextBox ID="FaxTxt" runat="server" Text='<%# Bind("Fax") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="FaxTxt" runat="server" Text='<%# Bind("Fax") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="FaxLabel" runat="server" Text='<%# Bind("Fax") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Email Address" SortExpression="EmailAddress">
                    <EditItemTemplate>
                        <asp:TextBox ID="EmailAddressTxt" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="EmailAddressTxt" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="EmailAddressLabel" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Other Email Address" SortExpression="OtherEmailAddress">
                    <EditItemTemplate>
                        <asp:TextBox ID="OtherEmailAddressTxt" runat="server" Text='<%# Bind("OtherEmailAddress") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="OtherEmailAddressTxt" runat="server" Text='<%# Bind("OtherEmailAddress") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="OtherEmailAddressLabel" runat="server" Text='<%# Bind("OtherEmailAddress") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Assistant" SortExpression="Assistant">
                    <EditItemTemplate>
                        <asp:TextBox ID="AssistantTxt" runat="server" Text='<%# Bind("Assistant") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="AssistantTxt" runat="server" Text='<%# Bind("Assistant") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="AssistantLabel" runat="server" Text='<%# Bind("Assistant") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Assistant Phone" SortExpression="AssistantPhone">
                    <EditItemTemplate>
                        <asp:TextBox ID="AssistantPhoneTxt" runat="server" Text='<%# Bind("AssistantPhone") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="AssistantPhoneTxt" runat="server" Text='<%# Bind("AssistantPhone") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="AssistantPhoneLabel" runat="server" Text='<%# Bind("AssistantPhone") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

            <%--    <asp:TemplateField HeaderText="Email Opt Out" SortExpression="EmailOptOut">
                    <EditItemTemplate>
                        <asp:CheckBox ID="EmailOptOutCheckBox" runat="server" Checked='<%# Bind("EmailOptOut") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="EmailOptOutCheckBox" runat="server" Checked='<%# Bind("EmailOptOut") %>' />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="EmailOptOutCheckBox" runat="server" Checked='<%# Bind("EmailOptOut") %>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>--%>

               <%-- <asp:TemplateField HeaderText="Invalid Email" SortExpression="InvalidEmail">
                    <EditItemTemplate>
                        <asp:CheckBox ID="InvalidEmailCheckBox" runat="server" Checked='<%# Bind("InvalidEmail") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="InvalidEmailCheckBox" runat="server" Checked='<%# Bind("InvalidEmail") %>' />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="InvalidEmailCheckBox" runat="server" Checked='<%# Bind("InvalidEmail") %>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>--%>

                <asp:TemplateField HeaderText="Primary Address" SortExpression="PrimaryAddress">
                    <EditItemTemplate>
                        <asp:TextBox ID="PrimaryAddressTxt" runat="server" Text='<%# Bind("PrimaryAddress") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="PrimaryAddressTxt" runat="server" Text='<%# Bind("PrimaryAddress") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="PrimaryAddressLabel" runat="server" Text='<%# Bind("PrimaryAddress") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="City" SortExpression="PrimaryCity">
                    <EditItemTemplate>
                        <asp:TextBox ID="PrimaryCityTxt" runat="server" Text='<%# Bind("PrimaryCity") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="PrimaryCityTxt" runat="server" Text='<%# Bind("PrimaryCity") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="PrimaryCityLabel" runat="server" Text='<%# Bind("PrimaryCity") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="State" SortExpression="PrimaryState">
                    <EditItemTemplate>
                        <asp:TextBox ID="PrimaryStateTxt" runat="server" Text='<%# Bind("PrimaryState") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="PrimaryStateTxt" runat="server" Text='<%# Bind("PrimaryState") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="PrimaryStateLabel" runat="server" Text='<%# Bind("PrimaryState") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Postal Code" SortExpression="PrimaryPostalCode">
                    <EditItemTemplate>
                        <asp:TextBox ID="PrimaryPostalCodeTxt" runat="server" Text='<%# Bind("PrimaryPostalCode") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="PrimaryPostalCodeTxt" runat="server" Text='<%# Bind("PrimaryPostalCode") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="PrimaryPostalCodeLabel" runat="server" Text='<%# Bind("PrimaryPostalCode") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Country" SortExpression="PrimaryCountry">
                    <EditItemTemplate>
                        <asp:TextBox ID="PrimaryCountryTxt" runat="server" Text='<%# Bind("PrimaryCountry") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="PrimaryCountryTxt" runat="server" Text='<%# Bind("PrimaryCountry") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="PrimaryCountryLabel" runat="server" Text='<%# Bind("PrimaryCountry") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Alternate Address" SortExpression="AlternateAddress">
                    <EditItemTemplate>
                        <asp:TextBox ID="AlternateAddressTxt" runat="server" Text='<%# Bind("AlternateAddress") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="AlternateAddressTxt" runat="server" Text='<%# Bind("AlternateAddress") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="AlternateAddressLabel" runat="server" Text='<%# Bind("AlternateAddress") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="City" SortExpression="AlternateCity">
                    <EditItemTemplate>
                        <asp:TextBox ID="AlternateCityTxt" runat="server" Text='<%# Bind("AlternateCity") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="AlternateCityTxt" runat="server" Text='<%# Bind("AlternateCity") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="AlternateCityLabel" runat="server" Text='<%# Bind("AlternateCity") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="State" SortExpression="AlternateState">
                    <EditItemTemplate>
                        <asp:TextBox ID="AlternateStateTxt" runat="server" Text='<%# Bind("AlternateState") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="AlternateStateTxt" runat="server" Text='<%# Bind("AlternateState") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="AlternateStateLabel" runat="server" Text='<%# Bind("AlternateState") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Postal Code" SortExpression="AlternatePostalCode">
                    <EditItemTemplate>
                        <asp:TextBox ID="AlternatePostalCodeTxt" runat="server" Text='<%# Bind("AlternatePostalCode") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="AlternatePostalCodeTxt" runat="server" Text='<%# Bind("AlternatePostalCode") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="AlternatePostalCodeLabel" runat="server" Text='<%# Bind("AlternatePostalCode") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Country" SortExpression="AlternateCountry">
                    <EditItemTemplate>
                        <asp:TextBox ID="AlternateCountryTxt" runat="server" Text='<%# Bind("AlternateCountry") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="AlternateCountryTxt" runat="server" Text='<%# Bind("AlternateCountry") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="AlternateCountryLabel" runat="server" Text='<%# Bind("AlternateCountry") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description" SortExpression="Description">
                    <EditItemTemplate>
                        <asp:TextBox ID="DescriptionTxt" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="DescriptionTxt" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine"></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Bind("Description") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false" ItemStyle-CssClass="button-row">
                    <InsertItemTemplate>
                        <asp:LinkButton SkinID="LinkButtonOk" ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Insert"></asp:LinkButton>
                        &nbsp;<%--<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>--%>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="New" Text="New"></asp:LinkButton>
                    </ItemTemplate>

<ItemStyle CssClass="button-row"></ItemStyle>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" />
            </Fields>

        </asp:DetailsView>

        <asp:Button ID="updateButton" runat="server" Text="Update" Visible="False" OnClick="updateButton_Click"/>
         <asp:Button ID="deleteButton" runat="server" Text="Delete" Visible="False" OnClick="deleteButton_Click" />
    </div>
</asp:Content>
