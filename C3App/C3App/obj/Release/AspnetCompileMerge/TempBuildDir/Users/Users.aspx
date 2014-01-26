<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="C3App.Users.Users" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">
        <asp:LinkButton ID="UserInsertButton" runat="server" SkinID="TabTitle" Text="Create User" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create User');" OnClick="UserInsertButton_Click" />
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="UserInsertButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                 <%-- <asp:PostBackTrigger ControlID="UsersDetailsView" />--%>
                </Triggers>
                <ContentTemplate>

                     <asp:ValidationSummary ID="UsersValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                    <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server"
                         DataObjectTypeName="C3App.DAL.User" OnInserted="UsersObjectDataSource_Inserted" OnUpdated="UsersObjectDataSource_Updated"
                        TypeName="C3App.BLL.UserBL"
                        SelectMethod="GetUsersByID"
                        InsertMethod="InsertOrUpdate"
                        UpdateMethod="InsertOrUpdate">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditUserID" Name="uid" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    


                    <asp:DetailsView FieldHeaderStyle-CssClass="fields-label" CssClass="details-form" ID="UsersDetailsView" runat="server"
                        OnItemUpdating="UsersDetailsView_ItemUpdating" DefaultMode="Insert"
                        DataKeyNames="UserID,CompanyID,PrimaryEmail,Password,PasswordSalt,CreatedTime,ActivationID,CreatedBy,Image,IsAdmin,SecurityQuestion,SecurityAnswer,IsLockedOut,FailedPasswordAttemptCount,LastLockoutDate"
                        OnItemUpdated="UsersDetailsView_ItemUpdated"
                        OnItemCommand="UsersDetailsView_ItemCommand"
                        OnItemInserting="UsersDetailsView_ItemInserting"
                        OnItemInserted="UsersDetailsView_ItemInserted"
                        AutoGenerateRows="False" DataSourceID="UsersObjectDataSource">
                        <EmptyDataTemplate>
                            <p>
                                No user Selected...
                            </p>
                        </EmptyDataTemplate>
                        <Fields>

                            <asp:TemplateField HeaderText="First Name" SortExpression="FirstName">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" CssClass="required-field mask-name" Text='<%# Bind("FirstName") %>' ID="FirstNameTextBox" MaxLength="30"></asp:TextBox>
                                    <asp:RequiredFieldValidator  runat="server" ID="FirstNameTextBoxRequiredFieldValidator" ControlToValidate="FirstNameTextBox" Text="*" ErrorMessage="First Name is Required!" ValidationGroup="sum" />

                                    <asp:RegularExpressionValidator
                                        ID="FirstNameRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,200}$"
                                        ControlToValidate="FirstNameTextBox" Text="*"
                                        ErrorMessage="Some Special Characters are not supported in First Name Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" CssClass="required-field mask-name" Text='<%# Bind("LastName") %>' MaxLength="30" ID="LastNameTextBox"  ></asp:TextBox>
                                      <asp:RequiredFieldValidator  runat="server" ID="LastNameTextBoxRequiredFieldValidator" ControlToValidate="LastNameTextBox" Text="*" ErrorMessage="Last Name is Required!" ValidationGroup="sum" />
                                       <asp:RegularExpressionValidator
                                        ID="LastNameRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'\s]{1,200}$"
                                        ControlToValidate="LastNameTextBox" Text="*"
                                        ErrorMessage="Some Special Characters are not supported in Last Name Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                        <%-- <asp:TemplateField HeaderText="Password" SortExpression="Password">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" value='<%# Eval("Password") %>' Text='<%# Bind("Password") %>' ID="PasswordTextBox" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="PasswordRequiredFieldValidator" ControlToValidate="PasswordTextBox" Text="*" ErrorMessage="Password Field is Required!" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>--%>


                            <asp:TemplateField HeaderText="Password" SortExpression="Password">
                                <EditItemTemplate>
                                      <asp:TextBox runat="server"   CssClass="required-field" ID="CreatePasswordTextBox" TextMode="Password" OnInit="CreatePasswordTextBox_Init" ></asp:TextBox>
                                    <asp:TextBox ID="PasswordTextBox"  CssClass="required-field input-with-btn" value='<%# Eval("Password") %>' TextMode="Password" runat="server" ReadOnly="True" OnLoad="PasswordTextBox_Load"></asp:TextBox>
                                      <asp:RequiredFieldValidator  runat="server" ID="PasswordRequiredFieldValidator" ControlToValidate="CreatePasswordTextBox" Text="*" ErrorMessage="Password Field is Required!" ValidationGroup="sum" />
                                    <asp:Button ID="ModalPopButton2" runat="server" CommandArgument="Password" OnClick="ModalPopButton2_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Change" />
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Gender">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="GenderDropDownList" runat="server"         
                                        OnInit="GenderDropDownList_Init">
                                        <asp:ListItem Value="" Text="None" />
                                        <asp:ListItem Value="Male" >Male</asp:ListItem>
                                        <asp:ListItem Value="Female">Female</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                                <asp:TemplateField HeaderText="Birth Date" SortExpression="BirthDate">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("BirthDate", "{0:d}") %>' ID="DOBTextBox" CssClass="datepicker" ></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("BirthDate", "{0:d}") %>' ID="DOBTextBox" CssClass="datepicker"  ></asp:TextBox>
                                </insertItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Designation" SortExpression="Designation">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("Designation") %>' CssClass="mask-name"  MaxLength="50" ID="DesignationTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="DesignationRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,200}$"
                                        ControlToValidate="DesignationTextBox" Text="*"
                                        ErrorMessage="Some Special Characters are not supported in Designation Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Department" SortExpression="Department">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("Department") %>' CssClass="mask-name" MaxLength="50" ID="DepartmentTextBox"></asp:TextBox>
                                   <asp:RegularExpressionValidator
                                        ID="DepartmentRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,200}$"
                                        ControlToValidate="DepartmentTextBox" Text="*"
                                        ErrorMessage="Some Special Characters are not supported in Department Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Reports To">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="ReportsToObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.User"
                                        SelectMethod="GetUsers"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="ReportsToDropDownList" runat="server"
                                         AppendDataBoundItems="true"
                                        DataSourceID="ReportsToObjectDataSource"
                                        SelectedValue='<%# Eval("ReportsTo")==null ? "0" : Eval("ReportsTo") %>'
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="ReportsToDropDownList_Init">
                                        <asp:ListItem Value="0" Text="None" />
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                    
                            <asp:TemplateField HeaderText="Office Phone" SortExpression="OfficePhone">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="25" Text='<%# Bind("OfficePhone") %>' CssClass="mask-phone"   ID="OfficePhoneTextBox"></asp:TextBox>
                                  <asp:RegularExpressionValidator
                                        ID="OfficePhoneRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="OfficePhoneTextBox" Text="*"
                                        ErrorMessage="OfficePhone number is not valid !" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Mobile Phone" SortExpression="MobilePhone">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" CssClass="required-field mask-phone" MaxLength="25" Text='<%# Bind("MobilePhone") %>'  ID="MobilePhoneTextBox"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server"  ID="MobilePhoneTextBoxRequiredFieldValidator" ControlToValidate="MobilePhoneTextBox" Text="*" ErrorMessage="Mobile Phone number is Required!" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator
                                        ID="MobilePhoneRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="MobilePhoneTextBox" Text="*"
                                        ErrorMessage="MobilePhone number is not valid !" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Other Phone" SortExpression="OtherPhone">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="40" CssClass="mask-phone" Text='<%# Bind("OtherPhone") %>'  ID="OtherPhoneTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="OtherPhoneRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="OtherPhoneTextBox" Text="*"
                                        ErrorMessage="OtherPhone number is not valid !" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Home Phone" SortExpression="HomePhone">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="40" CssClass="mask-phone" Text='<%# Bind("HomePhone") %>'  ID="HomePhoneTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="HomePhoneRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="HomePhoneTextBox" Text="*"
                                        ErrorMessage="HomePhone number is not valid !" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Fax" SortExpression="Fax">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="40" CssClass="mask-phone" Text='<%# Bind("Fax") %>'   ID="FaxTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="FaxRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="FaxTextBox" Text="*"
                                        ErrorMessage="Fax number is not valid !" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Primary Email" SortExpression="PrimaryEmail">
                                <ItemTemplate>
                                    <asp:Label ID="PrimaryEmail" runat="server" Text='<%#Eval("PrimaryEmail") %>'></asp:Label>
                                    <asp:TextBox ID="txtPrimaryEmail" MaxLength="100" CssClass="required-field" runat="server" OnInit="txtPrimaryEmail_Init"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server"  ID="PrimaryEmailRequiredFieldValidator" ControlToValidate="txtPrimaryEmail" Text="*" ErrorMessage="Primary Email is Required!"  ValidationGroup="sum"  />
                                    <asp:RegularExpressionValidator
                                        ID="PrimaryEmailRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*.{1,100}"
                                        ControlToValidate="txtPrimaryEmail" Text="*"
                                        ErrorMessage="Primary Email Address is not Valid!" ValidationGroup="sum"  >  
                                    </asp:RegularExpressionValidator>

                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Alternate Email" SortExpression="AlternateEmail">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("AlternateEmail") %>'  ID="AlternateEmailTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="AlternateEmailRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*.{1,100}"
                                        ControlToValidate="AlternateEmailTextBox" Text="*"
                                        ErrorMessage="Alternate Email Address is not Valid!" ValidationGroup="sum">
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Street" SortExpression="Street">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="150" Text='<%# Bind("Street") %>' CssClass="mask-street" ID="StreetTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="StreetRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z0-9\s\(\)\/,\:\;\.-]+$"
                                        ControlToValidate="StreetTextBox" Text="*"
                                        ErrorMessage="Some Special Characters are not supported in Street Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="City" SortExpression="City">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("City") %>' CssClass="mask-name"  ID="CityTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="CityRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,200}$"
                                        ControlToValidate="CityTextBox" Text="*"
                                        ErrorMessage="Some Special Characters are not supported in City Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="State" SortExpression="State">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("State") %>' CssClass="mask-name"   ID="StateTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="StateRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,200}$"
                                        ControlToValidate="StateTextBox" Text="*"
                                        ErrorMessage="Some Special Characters are not supported in State Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Postal Code" SortExpression="PostalCode">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="9" Text='<%# Bind("PostalCode") %>'  CssClass="mask-pint (zip)" ID="PostalCodeTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="PostalCodeRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^\d{4}$"
                                        ControlToValidate="PostalCodeTextBox" Text="*"
                                        ErrorMessage="Some Special Characters are not supported in PostalCode Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                          
                            <asp:TemplateField HeaderText="Country">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CountryObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.Country"
                                        SelectMethod="GetCountries"></asp:ObjectDataSource>
                                        <asp:DropDownList ID="CountryDropDownList" runat="server"
                                        DataSourceID="CountryObjectDataSource"  
                                        SelectedValue='<%# Bind("CountryID") %>'
                                        DataTextField="CountryName" DataValueField="CountryID" OnInit="CountryDropDownList_Init" AppendDataBoundItems="True">
                                          
                                    </asp:DropDownList>
                                     <asp:RequiredFieldValidator runat="server"  ID="CountryRequiredFieldValidator" ControlToValidate="CountryDropDownList" Text="*" ErrorMessage="Country Field is Required!"  ValidationGroup="sum"  />
                                </EditItemTemplate>
                            </asp:TemplateField>
               

                            <asp:TemplateField HeaderText="Messenger Type">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="MessengerTypeDropDownList" runat="server"
                                        OnInit="MessengerTypeDropDownList_Init">
                                        <asp:ListItem Value="" Text="None" />
                                        <asp:ListItem Value="yahoo">yahoo</asp:ListItem>
                                        <asp:ListItem Value="live">live</asp:ListItem>
                                        <asp:ListItem Value="gmail">gmail</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Messenger ID" SortExpression="MessengerID">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="25" Text='<%# Bind("MessengerID") %>' ID="MessengerIDTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Facebook ID" SortExpression="FacebookID">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="25" Text='<%# Bind("FacebookID") %>' ID="FacebookIDTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="National ID" SortExpression="NationalID">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50"  Text='<%# Bind("NationalID") %>' ID="NationalIDTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Driving License" SortExpression="DrivingLicense">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50"  Text='<%# Bind("DrivingLicense") %>' ID="DrivingLicenseTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Passport No" SortExpression="PassportNo">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50" Text='<%# Bind("PassportNo") %>'  ID="PassportNoTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Social Security No" SortExpression="SocialSecurityNo">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50" Text='<%# Bind("SocialSecurityNo") %>'  ID="SocialSecurityNoTextBox"></asp:TextBox>         
                                </EditItemTemplate>
                            </asp:TemplateField>
            
                            
                            <asp:TemplateField HeaderText="Status">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="IsActiveDropDownList" runat="server"
                                        OnInit="IsActiveDropDownList_Init">
                                        <asp:ListItem Value="True">Active</asp:ListItem>
                                        <asp:ListItem Value="False">Inactive</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            
                            <asp:CheckBoxField DataField="IsEmployee" HeaderText="Is Employee" SortExpression="IsEmployee" />
                            <asp:CheckBoxField DataField="IsLockedOut" HeaderText="Is Locked" SortExpression="IsLockedOut" />
                            
                            <asp:TemplateField HeaderText="Role">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="RoleObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.ACLRoleBL"
                                        DataObjectTypeName="C3App.DAL.ACLRole"
                                        SelectMethod="GetRolesByCompanyID"></asp:ObjectDataSource>

                                    <asp:DropDownList ID="RoleDropDownList" runat="server"
                                        DataSourceID="RoleObjectDataSource" AppendDataBoundItems="true"
                                       SelectedValue='<%# Bind("RoleID") %>'
                                        DataTextField="Name" DataValueField="RoleID" OnInit="RoleDropDownList_Init">
                             
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Team">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TeamObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.TeamBL"
                                        DataObjectTypeName="C3App.DAL.Team"
                                        SelectMethod="GetTeamsByCompanyID"></asp:ObjectDataSource>

                                    <asp:DropDownList ID="TeamDropDownList" runat="server"
                                        DataSourceID="TeamObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Bind("TeamID") %>'
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                         

                   <%--         <asp:TemplateField HeaderText="SecurityQuestion">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="SecurityQuestionDropDownList" runat="server"
                                        OnInit="SecurityQuestionDropDownList_Init">
                                        <asp:ListItem Value="" Text="None" />
                                        <asp:ListItem Value="What was your childhood nickname?">What was your childhood nickname?</asp:ListItem>
                                        <asp:ListItem Value="What is the name of your favorite childhood friend?">What is the name of your favorite childhood friend?</asp:ListItem>
                                        <asp:ListItem Value="What street did you live on in third grade?">What street did you live on in third grade?</asp:ListItem>
                                        <asp:ListItem Value="What was the name of your first stuffed animal?">What was the name of your first stuffed animal?</asp:ListItem>
                                        <asp:ListItem Value="What was your dream job as a child?">What was your dream job as a child?</asp:ListItem>
                                        <asp:ListItem Value="Who was your childhood hero?">Who was your childhood hero?</asp:ListItem>
                                        <asp:ListItem Value="What was the first concert you attended?">What was the first concert you attended?</asp:ListItem>
                                        <asp:ListItem Value="What is the middle name of your oldest child?">What is the middle name of your oldest child?</asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Security Answer" SortExpression="SecurityAnswer">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="150" Text='<%# Bind("SecurityAnswer") %>'  ID="SecurityAnswerTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
            
                             <asp:TemplateField ShowHeader="False">
                                 <EditItemTemplate>
                                <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                               <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" ValidationGroup="sum"  CommandName="Update"  Text="Save" ></asp:LinkButton>
                                </EditItemTemplate>
                                 <InsertItemTemplate>
                                  <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                  <asp:LinkButton ID="InsertLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" ValidationGroup="sum" CommandName="Insert" Text="Save"  ></asp:LinkButton>
                                 </InsertItemTemplate>
                            </asp:TemplateField>

                        </Fields>
                    </asp:DetailsView>
                </ContentTemplate>
            </asp:UpdatePanel>

              <asp:UpdateProgress ID="UserDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
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


    <asp:Panel ID="ModalPanel1" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:UpdatePanel runat="server" ID="UpdatePanel3" UpdateMode="Always" >
                <Triggers>
                  <%--  <asp:AsyncPostBackTrigger ControlID="ModalPopButton2" EventName="Click" />--%>
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="ModalLabel" runat="server" SkinID="ModalTitle" Text="Change Password"></asp:Label>
               <br /> <br />
                    <asp:Panel ID="ModalListPanel"  SkinID="ModalListPanel" runat="server">

                        <asp:Label ID="ErrorLabel"  runat="server" Text="Message will show here"></asp:Label>
                        <br /><br />

                        <asp:Label ID="NewPasswordLabel" runat="server" Text="New Password"></asp:Label>
                        <asp:TextBox ID="NewPasswordTextBox" TextMode="Password" MaxLength="70" runat="server"></asp:TextBox>

                        <asp:Label ID="ConfirmPasswordLabel" runat="server" Text="Confirm Password"></asp:Label>
                        <asp:TextBox ID="ConfirmPasswordTextBox" TextMode="Password" MaxLength="70"  runat="server"></asp:TextBox>

                      <asp:LinkButton ID="PasswordCancelButton" runat="server" CssClass="form-btn" CausesValidation="False" OnClientClick="CloseModal('BodyContent_ModalPanel1')" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                      <asp:LinkButton ID="PasswordSaveButton" runat="server" CssClass="form-btn" CausesValidation="True"  CommandName="Update"  Text="Save"  OnClick="PasswordSaveButton_Click" ></asp:LinkButton>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>

    
    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2" >
        <asp:LinkButton runat="server" ID="UpdateTab2" SkinID="TabTitle" OnClick="UpdateButton_Click" Text="View Users" OnClientClick="GoToTab(2,'Create User')" />
        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server" >
    
              <asp:ObjectDataSource ID="SearchObjectDataSource" runat="server" SelectMethod="GetUsersByFirstName" TypeName="C3App.BLL.UserBL">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" PropertyName="Text" Name="nameSearchString" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>

  
                    <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                        <asp:Panel ID="Panel5" runat="server" CssClass="filter">
                            <asp:Label ID="Label8" runat="server" Text="Search Filter"></asp:Label>
                            <asp:LinkButton runat="server" ID="SearchAllLinkButton" CssClass="search-label active" OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                        </asp:Panel>
                        <asp:Panel ID="Panel3" runat="server" CssClass="search"  DefaultButton="SearchButton">
                             <asp:Label ID="Label91" runat="server" Text="Search"></asp:Label>
                            <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                            <asp:LinkButton CssClass="search-btn" ID="SearchButton" runat="server" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                        </asp:Panel>
                    </asp:Panel>

                    <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">
                    
                        <asp:ObjectDataSource ID="UsersviewObjectDataSource" runat="server" SelectMethod="GetUsersByCompanyID" DeleteMethod="DeleteUser"
                            UpdateMethod="UpdateUser" TypeName="C3App.BLL.UserBL" DataObjectTypeName="C3App.DAL.User">
                      
                        </asp:ObjectDataSource>

                        <asp:UpdatePanel ID="upListView" runat="server" UpdateMode="Conditional">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="UpdateTab2" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:GridView ID="UsersGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                                    DataKeyNames="UserID" ShowHeader="false"
                                    DataSourceID="UsersviewObjectDataSource" GridLines="None">
                                    <EmptyDataTemplate>
                                        <p>
                                            No user Selected...
                                        </p>
                                    </EmptyDataTemplate>
                                  
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                 <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl='<%# Decryptdata(Convert.ToString(Eval("Image"))) %>' />

                                                <asp:LinkButton  ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("UserID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command"  CausesValidation="False" >
                                                    <%# Eval("FirstName")%>

                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>

                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdateProgress ID="UsersUpdateProgress" runat="server" AssociatedUpdatePanelID="upListView">
                            <ProgressTemplate>
                                <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                                <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                                    <h2>Loading...</h2>
                                    <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                                </asp:Panel>
                            </ProgressTemplate>
                        </asp:UpdateProgress>

                    </asp:Panel>

            <asp:Panel ID="MiniDetailsPanel" runat="server">
                <asp:UpdatePanel ID="miniDetails" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>

                        <asp:Panel ID="MiniDetailBasicPanel" CssClass="mini-detail-panel" runat="server">

                            <asp:Panel ID="MiniUserDetailBasic" runat="server">

                                <asp:ObjectDataSource ID="MiniUserObjectDataSource" runat="server"
                                    SelectMethod="GetUsersByID"
                                    TypeName="C3App.BLL.UserBL" DataObjectTypeName="C3App.DAL.User">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="UsersGridView" Type="Int64" Name="uid" PropertyName="SelectedValue" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:FormView ID="MiniUserFormView" runat="server" DataSourceID="MiniUserObjectDataSource"
                                    CssClass="mini-details-form"
                                    DataKeyNames="FirstName,UserID">
                                    <EmptyDataTemplate>
                                        <p>
                                            No user Selected...
                                        </p>
                                    </EmptyDataTemplate>
                                    <ItemTemplate>
                                        <%-- <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" />--%>

                                        <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl='<%# Decryptdata(Convert.ToString(Eval("Image"))) %>' />
                                        <asp:Panel ID="Panel2" runat="server">

                                            <asp:Label ID="Label2" CssClass="fullname" runat="server" Text='<%# String.Concat(Eval("FirstName"), " ", Eval("LastName"))%>'></asp:Label>
                                            <asp:Label ID="Label7" runat="server" CssClass="id-card" Text='<%# Eval("Designation") %>'></asp:Label>
                                            <asp:Label ID="Label5" runat="server" CssClass="office-building" Text='<%# Eval("Department") %>'></asp:Label>
                                            <asp:Label ID="Label3" runat="server" CssClass="phone" Text='<%# Eval("MobilePhone") %>'></asp:Label>
                                            <asp:Label ID="Label4" runat="server" CssClass="email" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>

                                        </asp:Panel>
                                    </ItemTemplate>
                                </asp:FormView>

                                <asp:Panel ID="Panel1" runat="server" CssClass="mini-detail-control-panel two-controls">
                                    <ul>
                                        <%-- <li>
                                                <asp:LinkButton ID="CalendarLinkButton" CssClass="control-btn" runat="server" PostBackUrl="#" >
                                                <i class="icon-calendar"></i>
                                                </asp:LinkButton>
                                            </li>--%>

                                     <%-- <li>
                                            <asp:LinkButton ID="ModalPopButton2" CssClass="control-btn" runat="server" OnClientClick="OpenModal('BodyContent_ModalCalendar')">
                                            <i class="icon-calendar"></i>
                                            </asp:LinkButton>
                                        </li>--%>

                                        <li>
                                            <asp:LinkButton ID="EditLinkButton" ToolTip="Edit" CssClass="control-btn" runat="server" CommandArgument="" OnClientClick="GoToTab(1,'User Details');" OnClick="EditLinkButton_Click">
                                                    <i class="icon-edit"></i>
                                            </asp:LinkButton>
                                        </li>
                                        <li>
                                            <div class="slide-confirm">
                                                <asp:LinkButton ID="DeleteLinkButton" ToolTip="Delete" CssClass="control-btn has-confirm" runat="server">
                                                    <i class="icon-trash"></i>                                                                                                  
                                                </asp:LinkButton>

                                                <asp:LinkButton ID="UserDeleteButton" runat="server" Text="Confirm" OnClick="UserDeleteButton_Click">
                                                </asp:LinkButton>
                                                <a href="#" class="slide-cancel">Cancel</a>
                                            </div>
                                        </li>
                                    </ul>
                                </asp:Panel>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="MiniDetailMorePanel" CssClass="mini-detail-more-panel" runat="server">

                            <asp:Panel ID="MiniUserDetailMore" runat="server">

                                <asp:DetailsView ID="MiniUserDetailsView" runat="server"
                                    CssClass="mini-details-more-form"
                                    FieldHeaderStyle-CssClass="fields-label"
                                    DataKeyNames="UserID"
                                    DataSourceID="MiniUserObjectDataSource" AutoGenerateRows="False">
                                    <EmptyDataTemplate>
                                        <p>
                                            No user Selected...
                                        </p>
                                    </EmptyDataTemplate>
                                    <Fields>
                                   <%--     <asp:BoundField DataField="Designation" HeaderText="Designation" SortExpression="Designation"></asp:BoundField>--%>
                                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender"></asp:BoundField>
                                        <asp:BoundField DataField="BirthDate" HeaderText="Birth Date" SortExpression="BirthDate" DataFormatString="{0:d}"></asp:BoundField>
                                      <%--  <asp:BoundField DataField="MaritalStatus" HeaderText="Marital Status" SortExpression="MaritalStatus"></asp:BoundField>--%>
                                 <%--       <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department"></asp:BoundField>--%>
                                        <asp:BoundField DataField="OfficePhone" HeaderText="Office Phone" SortExpression="OfficePhone"></asp:BoundField>
                                        <asp:BoundField DataField="OtherPhone" HeaderText="Other Phone" SortExpression="OtherPhone"></asp:BoundField>
                                        <asp:BoundField DataField="HomePhone" HeaderText="Home Phone" SortExpression="HomePhone"></asp:BoundField>
                                        <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax"></asp:BoundField>
                                        <asp:BoundField DataField="AlternateEmail" HeaderText="Alternate Email" SortExpression="AlternateEmail"></asp:BoundField>
                                        <asp:BoundField DataField="Street" HeaderText="Street" SortExpression="Street"></asp:BoundField>
                                        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City"></asp:BoundField>
                                        <asp:BoundField DataField="State" HeaderText="State" SortExpression="State"></asp:BoundField>
                                        <asp:BoundField HeaderText="Postal Code" DataField="PostalCode"></asp:BoundField>

                                        <asp:TemplateField HeaderText="Country" SortExpression="Country">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Country.CountryName") %>' ID="CountryLabel"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="Reports To" SortExpression="ReportsTo">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("User1.FirstName") %>' ID="ReportsToLabel"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Role" SortExpression="RoleID">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("ACLRole.Name") %>' ID="RoleLabel"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                            <ItemTemplate>
                                                <asp:Label runat="server" Text='<%# Eval("Team.Name") %>' ID="TeamLabel"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField HeaderText="Messenger Type" DataField="MessengerType"></asp:BoundField>
                                        <asp:BoundField HeaderText="Messenger ID" DataField="MessengerID"></asp:BoundField>
                                        <asp:BoundField HeaderText="Facebook ID" DataField="FacebookID"></asp:BoundField>
                                        <asp:BoundField HeaderText="National ID" DataField="NationalID"></asp:BoundField>
                                        <asp:BoundField HeaderText="Driving License" DataField="DrivingLicense"></asp:BoundField>
                                        <asp:BoundField HeaderText="Passport No" DataField="PassportNo"></asp:BoundField>
                                        <asp:BoundField HeaderText="Social Security No" DataField="SocialSecurityNo"></asp:BoundField>
                                    </Fields>
                                </asp:DetailsView>
                            </asp:Panel>
                        </asp:Panel>

                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="MiniDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="miniDetails">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel3" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent3" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </asp:Panel>
        </asp:Panel>

    </asp:Panel>
                         

        <div id="myModal" class="reveal-modal small">
              <asp:UpdatePanel runat="server" ID="UpdatePanel5" UpdateMode="Always">
                  <ContentTemplate>
                      <h4>
                          <asp:Literal ID="Literal1" runat="server" Text=""></asp:Literal></h4>
                      <a class="close-reveal-modal">&#215;</a>
                      <asp:Label ID="Label6" runat="server" Text=""></asp:Label>
                  </ContentTemplate>
              </asp:UpdatePanel>
          </div>

</asp:Content>
