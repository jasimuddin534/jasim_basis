<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="C3App.UserProfile" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
     <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">
        <asp:LinkButton ID="UserInsertButton" runat="server" SkinID="TabTitle" Text="User Profile" CommandArgument="Insert" OnClientClick="GoToTab(1,'User Profile');" OnClick="UserEditButton_Click" />
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">

<%--           <ajaxToolkit:ToolkitScriptManager ID="scriptManager1" runat="server" />--%>

            <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
               
                <ContentTemplate>

                    <table>
                        <tr>
                            <td style="width: 180px;">
                                <asp:Image ID="UserImage" Width="100px" CssClass="img-profile" runat="server" /></td>
                            <td>
                                <ajaxToolkit:AjaxFileUpload ID="AjaxFileUpload1"
                                    ThrobberID="myThrobber" OnUploadComplete="AjaxFileUpload1_UploadComplete"
                                    ContextKeys="fred"
                                    AllowedFileTypes="jpg,jpeg,gif,bmp"
                                    MaximumNumberOfFiles="1"
                                    runat="server" />
                            </td>
                        </tr>
                    </table>


                   <asp:ValidationSummary ID="UsersValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                    <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server"
                         DataObjectTypeName="C3App.DAL.User" OnUpdated="UsersObjectDataSource_Updated"
                        TypeName="C3App.BLL.UserBL"
                        SelectMethod="GetUsersByID"
                        InsertMethod="InsertOrUpdate"
                        UpdateMethod="InsertOrUpdate">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="UserID" Name="uid" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    
                    <asp:DetailsView FieldHeaderStyle-CssClass="fields-label" CssClass="details-form" ID="UsersDetailsView" runat="server"
                        OnItemUpdating="UsersDetailsView_ItemUpdating" DefaultMode="Edit" 
                        DataKeyNames="UserID,CompanyID,PrimaryEmail,Password,PasswordSalt,CreatedTime,ActivationID,CreatedBy,Image,IsAdmin,RoleID,IsEmployee,TeamID,TeamsetID,IsActive,IsLockedOut,FailedPasswordAttemptCount,LastLockoutDate"                        
                        OnItemUpdated="UsersDetailsView_ItemUpdated"
                        OnItemCommand="UsersDetailsView_ItemCommand"
                        AutoGenerateRows="False" DataSourceID="UsersObjectDataSource">
                        <EmptyDataTemplate>
                            <p>
                                No Data Found.
                            </p>
                        </EmptyDataTemplate>
                        <Fields>
                            <asp:TemplateField HeaderText="First Name" SortExpression="FirstName">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" CssClass="required-field mask-name" Text='<%# Bind("FirstName") %>' ID="FirstNameTextBox" MaxLength="30"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="FirstNameTextBoxRequiredFieldValidator" ControlToValidate="FirstNameTextBox" Text="*" ErrorMessage="First Name is Required!" ValidationGroup="sum" />

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
                                    <asp:TextBox runat="server" CssClass="required-field mask-name" Text='<%# Bind("LastName") %>' MaxLength="30" ID="LastNameTextBox"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="LastNameTextBoxRequiredFieldValidator" ControlToValidate="LastNameTextBox" Text="*" ErrorMessage="Last Name is Required!" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator
                                        ID="LastNameRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,200}$"
                                        ControlToValidate="LastNameTextBox" Text="*"
                                        ErrorMessage="Some Special Characters are not supported in Last Name Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                         <%--   <asp:TemplateField HeaderText="Password" SortExpression="Password">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" value='<%# Eval("Password") %>' Text='<%# Bind("Password") %>' ID="PasswordTextBox" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="PasswordRequiredFieldValidator" ControlToValidate="PasswordTextBox" Text="*" ErrorMessage="Password Field is Required!" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
                            
                             <asp:TemplateField HeaderText="Password" SortExpression="Password">
                              
                                <EditItemTemplate>
                                    <asp:TextBox ID="PasswordTextBox" CssClass="required-field input-with-btn" value='<%# Eval("Password") %>'  TextMode="Password"   runat="server" ReadOnly="True"  OnLoad="PasswordTextBox_Load" ></asp:TextBox>
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
                                    <asp:TextBox runat="server" Text='<%# Bind("Designation") %>' CssClass="mask-name" MaxLength="50" ID="DesignationTextBox"></asp:TextBox>
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
                                    <asp:TextBox runat="server" Text='<%# Bind("Department") %>'  CssClass="mask-name" MaxLength="50" ID="DepartmentTextBox"></asp:TextBox>
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
                                    <asp:TextBox runat="server" MaxLength="25" Text='<%# Bind("OfficePhone") %>'  CssClass="mask-phone" ID="OfficePhoneTextBox"></asp:TextBox>
                                  <asp:RegularExpressionValidator
                                        ID="OfficePhoneRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="OfficePhoneTextBox" Text="*"
                                        ErrorMessage="Only numbers are allowed in OfficePhone Field!" ValidationGroup="sum">  
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
                                        ErrorMessage="Only numbers are allowed in MobilePhone Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Other Phone" SortExpression="OtherPhone">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="40" Text='<%# Bind("OtherPhone") %>'  CssClass="mask-phone" ID="OtherPhoneTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="OtherPhoneRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="OtherPhoneTextBox" Text="*"
                                        ErrorMessage="Only numbers are allaowed in OtherPhone Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Home Phone" SortExpression="HomePhone">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="40" Text='<%# Bind("HomePhone") %>' CssClass="mask-phone" ID="HomePhoneTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="HomePhoneRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="HomePhoneTextBox" Text="*"
                                        ErrorMessage="Only numbers are allowed in HomePhone Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Fax" SortExpression="Fax">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="40" Text='<%# Bind("Fax") %>'  CssClass="mask-phone" ID="FaxTextBox"></asp:TextBox>
                                    <asp:RegularExpressionValidator
                                        ID="FaxRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                        ControlToValidate="FaxTextBox" Text="*"
                                        ErrorMessage="Only numbers are allowed in Fax Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Primary Email" SortExpression="PrimaryEmail">
                                <ItemTemplate>
                                    <asp:Label ID="PrimaryEmail" runat="server" Text='<%#Eval("PrimaryEmail") %>'></asp:Label>
                                    <asp:TextBox ID="txtPrimaryEmail" CssClass="required-field mask-email" MaxLength="100" runat="server" OnInit="txtPrimaryEmail_Init"></asp:TextBox>
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
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("AlternateEmail") %>' CssClass="mask-email" ID="AlternateEmailTextBox"></asp:TextBox>
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
                                    <asp:TextBox runat="server" MaxLength="150" Text='<%# Bind("Street") %>'  CssClass="mask-street" ID="StreetTextBox"></asp:TextBox>
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
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("City") %>' CssClass="mask-name" ID="CityTextBox"></asp:TextBox>
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
                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("State") %>'  CssClass="mask-name" ID="StateTextBox"></asp:TextBox>
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
                         
                       

                          <%--  <asp:TemplateField HeaderText="Primary Email" SortExpression="PrimaryEmail">
                                <ItemTemplate>
                                    <asp:Label ID="PrimaryEmail" runat="server" Text='<%#Eval("PrimaryEmail") %>'></asp:Label>
                                    <asp:TextBox ID="txtPrimaryEmail" runat="server" OnInit="txtPrimaryEmail_Init"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="PrimaryEmailRequiredFieldValidator" ControlToValidate="txtPrimaryEmail" Text="*" ErrorMessage="Primary Email is Required!"  ValidationGroup="sum"  />
                                    <asp:RegularExpressionValidator
                                        ID="PrimaryEmailRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                        ControlToValidate="txtPrimaryEmail" Text="*"
                                        ErrorMessage="Email Address is not Valid!" ValidationGroup="sum"  >  
                                    </asp:RegularExpressionValidator>

                                </ItemTemplate>
                            </asp:TemplateField>--%>

              

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
                                     <asp:RequiredFieldValidator runat="server" ID="CountryRequiredFieldValidator" ControlToValidate="CountryDropDownList" Text="*" ErrorMessage="Country Field is Required!"  ValidationGroup="sum"  />
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
                                    <asp:TextBox runat="server" MaxLength="25"  Text='<%# Bind("MessengerID") %>' ID="MessengerIDTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Facebook ID" SortExpression="FacebookID">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="25" Text='<%# Bind("FacebookID") %>' ID="FacebookIDTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="National ID" SortExpression="NationalID">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50" Text='<%# Bind("NationalID") %>' ID="NationalIDTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Driving License" SortExpression="DrivingLicense">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50" Text='<%# Bind("DrivingLicense") %>' ID="DrivingLicenseTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Passport No" SortExpression="PassportNo">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50" Text='<%# Bind("PassportNo") %>' ID="PassportNoTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Social Security No" SortExpression="SocialSecurityNo">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" MaxLength="50" Text='<%# Bind("SocialSecurityNo") %>'  ID="SocialSecurityNoTextBox"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            

                            <asp:TemplateField HeaderText="Security Question">
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
                            </asp:TemplateField>

                             <asp:TemplateField ShowHeader="False">
                                 <EditItemTemplate>
                                <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                               <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" ValidationGroup="sum"  CommandName="Update"  Text="Save" ></asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>

                        </Fields>
                    </asp:DetailsView>
       
                </ContentTemplate>
            </asp:UpdatePanel>

                <asp:UpdateProgress ID="UserProfileUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>


         
        <asp:Panel ID="ModalPanel1" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
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

                        <asp:Label ID="OldPasswordLabel" runat="server" Text="Old Password"></asp:Label>
                        <asp:TextBox ID="OldPasswordTextBox" TextMode="Password"  MaxLength="70" runat="server"></asp:TextBox>

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
