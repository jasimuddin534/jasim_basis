<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="CompanySetup.aspx.cs" Inherits="C3App.CompanySetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <asp:Panel runat="server" CssClass="setup-container">
        <dl class="tabs">
            <dd class="active"><a href="#simple1">COMPANY</a></dd>
        <%-- <dd><a href="#simple2">PAYMENTS</a></dd>--%>
        </dl>
        <ul class="tabs-content">
            <li class="active" id="simple1Tab">
                <asp:Panel runat="server" CssClass="tab-header">
                    <img src="/Content/images/c3/setup_company_icon.png" />
                    <h1>SETUP COMPANY</h1>
                    <h5>This panel allows you to establish your company</h5>
                </asp:Panel>
                <ul class="accordion">
                    <li class="active">
                        <asp:Panel runat="server" CssClass="title">
                            <h5>Company Setup</h5>
                        </asp:Panel>
                        <asp:Panel runat="server" CssClass="content">
                        <asp:Panel runat="server" CssClass="clearfix">

                            <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Conditional">
                                <ContentTemplate>

                                       <asp:ValidationSummary ID="CompanyDetailsValidationSummary" runat="server" ValidationGroup="company" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                                    <center><h4><asp:Label ID="Label1" runat="server" Text=""></asp:Label></h4></center>

                                    <asp:ObjectDataSource ID="CompanyObjectDataSource" runat="server"
                                        DataObjectTypeName="C3App.DAL.Company"
                                        TypeName="C3App.BLL.UserBL"
                                        OnUpdated="CompanyObjectDataSource_Updated"
                                        SelectMethod="GetCompanyByID"
                                        UpdateMethod="CompanyUpdate"></asp:ObjectDataSource>

                                    <asp:DetailsView FieldHeaderStyle-CssClass="field-label" CssClass="details-form"
                                        ID="CompanyDetailsView" runat="server" DefaultMode="Edit"
                                        OnItemUpdating="CompanyDetailsView_ItemUpdating"
                                        OnItemUpdated="CompanyDetailsView_ItemUpdated"
                                        OnItemCommand="CompanyDetailsView_ItemCommand"
                                        DataKeyNames="CompanyID,CountryID,CreatedTime,CreatedBy,BankAccount"
                                        AutoGenerateRows="False" DataSourceID="CompanyObjectDataSource">

                                        <Fields>
                                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" ReadOnly="true"></asp:BoundField>
                                            <asp:TemplateField HeaderText="Type">
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

                                           <%-- <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email"></asp:BoundField>
                                            <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website"></asp:BoundField>
                                            <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone"></asp:BoundField>
                                            <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address"></asp:BoundField>--%>


                                            <asp:TemplateField HeaderText="Email" SortExpression="Email">
                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("Email") %>' CssClass="mask-email" ID="EmailTextBox"></asp:TextBox>
                                                    <asp:RegularExpressionValidator
                                                        ID="EmailRegularExpressionValidator"
                                                        runat="server"
                                                        ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*.{1,100}"
                                                        ControlToValidate="EmailTextBox" Text="*"
                                                        ErrorMessage="Email Address is not Valid!" ValidationGroup="company">
                                                    </asp:RegularExpressionValidator>
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Website" SortExpression="Website">
                                                <EditItemTemplate>
                                                    <asp:TextBox runat="server" MaxLength="100" Text='<%# Bind("Website") %>' ID="WebsiteTextBox"></asp:TextBox>
                                                    <asp:RegularExpressionValidator
                                                        ID="WebsiteRegularExpressionValidator"
                                                        runat="server"
                                                        ValidationExpression="^(ht|f)tp(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(\/?)([a-zA-Z0-9\-\.\?\,\'\/\\\+&amp;%\$#_]*)?$"
                                                        ControlToValidate="WebsiteTextBox" Text="*"
                                                        ErrorMessage="Website Address is not Valid!" ValidationGroup="company">
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
                                                        ErrorMessage="Phone Field is not Valid!" ValidationGroup="company">
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
                                                        ErrorMessage="Address Field is not Valid!" ValidationGroup="company">
                                                    </asp:RegularExpressionValidator>
                                                </EditItemTemplate>
                                            </asp:TemplateField>


                                            <asp:TemplateField ShowHeader="False">
                                                <EditItemTemplate>

                                                    <asp:LinkButton ID="UpdateLinkButton" runat="server" ValidationGroup="company" CausesValidation="True" CommandName="Update" Text="Save"></asp:LinkButton>
                                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>

                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                        </Fields>
                                    </asp:DetailsView>
                            </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        </asp:Panel>
                    </li>
                    <li>
                        <asp:Panel runat="server" CssClass="title">
                            <h5>Create Team</h5>
                        </asp:Panel>
                        <asp:Panel runat="server" CssClass="content">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <center><h4><asp:Label ID="Label2" runat="server" Text=""></asp:Label></h4></center>
                                      <asp:ValidationSummary ID="TeamsValidationSummary" runat="server" ValidationGroup="team" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                                    <asp:ObjectDataSource ID="TeamDetailsObjectDataSource" runat="server"
                                        DataObjectTypeName="C3App.DAL.Team" TypeName="C3App.BLL.TeamBL"
                                        OnInserted="TeamDetailsObjectDataSource_Inserted"
                                        InsertMethod="TeamsInsertOrUpdate">
                                    </asp:ObjectDataSource>
                                    <asp:DetailsView FieldHeaderStyle-CssClass="fields-label" CssClass="details-form" ID="TeamsDetailsView" runat="server" AutoGenerateRows="False"
                                        DataSourceID="TeamDetailsObjectDataSource" DefaultMode="Insert"
                                        OnItemInserting="TeamsDetailsView_ItemInserting"
                                        OnItemInserted="TeamsDetailsView_ItemInserted"
                                        OnItemCommand="TeamsDetailsView_ItemCommand"
                                        DataKeyNames="TeamID,CompanyID,CreatedTime,CreatedBy,TeamSetID">

                                        <EmptyDataTemplate>
                                            <p>
                                                No Data Found.
                                            </p>
                                        </EmptyDataTemplate>

                                        <Fields>
                                            <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                                <InsertItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="required-field mask-name" Text='<%# Bind("Name") %>' ID="NameTextBox"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="NameTextBoxRequiredFieldValidator" ControlToValidate="NameTextBox" Text="*" ErrorMessage="Team Name is Required!" ValidationGroup="team" />
                                                    <asp:RegularExpressionValidator
                                                        ID="TeamNameRegularExpressionValidator"
                                                        runat="server"
                                                        ValidationExpression="^[a-zA-Z''-'\s]{1,200}$"
                                                        ControlToValidate="NameTextBox" Text="*"
                                                        ErrorMessage="Some Special Characters are not supported in Team Name Field!" ValidationGroup="team">  
                                                    </asp:RegularExpressionValidator>
                                                </InsertItemTemplate>
                                            </asp:TemplateField>

                                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>

                                            <asp:TemplateField HeaderText="TeamSet">
                                                <EditItemTemplate>
                                                    <asp:ObjectDataSource ID="TeamSetObjectDataSource" runat="server"
                                                        TypeName="C3App.BLL.TeamBL"
                                                        DataObjectTypeName="C3App.DAL.TeamSet"
                                                        SelectMethod="GetTeamSetsByCompanyID"></asp:ObjectDataSource>

                                                    <asp:DropDownList ID="TeamSetDropDownList" runat="server"
                                                        DataSourceID="TeamSetObjectDataSource"
                                                        SelectedValue='<%# Bind("TeamSetID") %>'
                                                        DataTextField="TeamSetName" DataValueField="TeamSetID" OnInit="TeamSetDropDownList_Init">
                                                    </asp:DropDownList>
                                                </EditItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField ShowHeader="False">
                                                <InsertItemTemplate>

                                                    <asp:LinkButton ID="InsertLinkButton" runat="server" ValidationGroup="team" CausesValidation="True" CommandName="Insert" Text="Save and Add New"></asp:LinkButton>
                                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                                </InsertItemTemplate>
                                            </asp:TemplateField>

                                        </Fields>
                                    </asp:DetailsView>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </li>
                    <li>
                        <asp:Panel runat="server" CssClass="title">
                            <h5>Create User</h5>
                        </asp:Panel>
                        <asp:Panel runat="server" CssClass="content">
                            <asp:UpdatePanel runat="server" ID="UpdatePanel3" UpdateMode="Conditional">
                              <%--  <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="UserInsertButton" EventName="Click" />
                                </Triggers>--%>
                                <ContentTemplate>
                                    <center><h4><asp:Label ID="Label3" runat="server" Text=""></asp:Label></h4></center>
                                   <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="user" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />
                                    <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server"
                                        DataObjectTypeName="C3App.DAL.User" OnInserted="UsersObjectDataSource_Inserted"
                                        TypeName="C3App.BLL.UserBL"
                                        InsertMethod="InsertOrUpdate" SelectMethod="GetUsers">
                                    </asp:ObjectDataSource>

                                    <asp:DetailsView FieldHeaderStyle-CssClass="fields-label" CssClass="details-form" ID="UsersDetailsView" runat="server"
                                        DefaultMode="Insert"
                                        DataKeyNames="UserID,CompanyID,Image,IsAdmin,CountryID"
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
                                                <InsertItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("FirstName") %>' CssClass="required-field mask-name" ID="FirstNameTextBox"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="FirstNameTextBoxRequiredFieldValidator" ControlToValidate="FirstNameTextBox" Text="*" ErrorMessage="First Name is Required!" ValidationGroup="user" />

                                                    <asp:RegularExpressionValidator
                                                        ID="FirstNameRegularExpressionValidator"
                                                        runat="server"
                                                        ValidationExpression="^[a-zA-Z''-'\s]{1,200}$"
                                                        ControlToValidate="FirstNameTextBox" Text="*"
                                                        ErrorMessage="Some Special Characters are not supported in First Name Field!" ValidationGroup="user">  
                                                    </asp:RegularExpressionValidator>

                                                </InsertItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">
                                                <InsertItemTemplate>
                                                    <asp:TextBox runat="server" Text='<%# Bind("LastName") %>' CssClass="required-field mask-name" ID="LastNameTextBox"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="LastNameTextBoxRequiredFieldValidator" ControlToValidate="LastNameTextBox" Text="*" ErrorMessage="Last Name is Required!" ValidationGroup="user" />
                                                    <asp:RegularExpressionValidator
                                                        ID="LastNameRegularExpressionValidator"
                                                        runat="server"
                                                        ValidationExpression="^[a-zA-Z''-'\s]{1,200}$"
                                                        ControlToValidate="LastNameTextBox" Text="*"
                                                        ErrorMessage="Some Special Characters are not supported in Last Name Field!" ValidationGroup="user">  
                                                    </asp:RegularExpressionValidator>
                                                </InsertItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Password" SortExpression="Password">
                                                <InsertItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="required-field" value='<%# Eval("Password") %>' Text='<%# Bind("Password") %>' ID="PasswordTextBox" TextMode="Password"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="PasswordRequiredFieldValidator" ControlToValidate="PasswordTextBox" Text="*" ErrorMessage="Password Field is Required!" ValidationGroup="user" />
                                                </InsertItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Mobile Phone" SortExpression="MobilePhone">
                                                <InsertItemTemplate>
                                                    <asp:TextBox runat="server" CssClass="required-field mask-phone" Text='<%# Bind("MobilePhone") %>' ID="MobilePhoneTextBox"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="MobilePhoneTextBoxRequiredFieldValidator" ControlToValidate="MobilePhoneTextBox" Text="*" ErrorMessage="Mobile Phone number is Required!" ValidationGroup="user" />
                                                    <asp:RegularExpressionValidator
                                                        ID="MobilePhoneRegularExpressionValidator"
                                                        runat="server"
                                                        ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$"
                                                        ControlToValidate="MobilePhoneTextBox" Text="*"
                                                        ErrorMessage="MobilePhone number is not valid !" ValidationGroup="user">  
                                                    </asp:RegularExpressionValidator>
                                                </InsertItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Primary Email" SortExpression="PrimaryEmail">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txtPrimaryEmail" CssClass="required-field" runat="server" ></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="PrimaryEmailRequiredFieldValidator" ControlToValidate="txtPrimaryEmail" Text="*" ErrorMessage="Primary Email is Required!" ValidationGroup="user" />
                                                    <asp:RegularExpressionValidator
                                                        ID="PrimaryEmailRegularExpressionValidator"
                                                        runat="server"
                                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                        ControlToValidate="txtPrimaryEmail" Text="*"
                                                        ErrorMessage="Email Address is not Valid!" ValidationGroup="user">  
                                                    </asp:RegularExpressionValidator>

                                                </ItemTemplate>
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
                                                    <asp:RequiredFieldValidator runat="server" ID="CountryRequiredFieldValidator" ControlToValidate="CountryDropDownList" Text="*" ErrorMessage="Country Field is Required!" ValidationGroup="user" />
                                                </EditItemTemplate>
                                            </asp:TemplateField>

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



                                            <asp:TemplateField ShowHeader="False">
                                                <InsertItemTemplate>

                                                    <asp:LinkButton ID="InsertLinkButton" runat="server" CausesValidation="True" ValidationGroup="user" CommandName="Insert" Text="Save and Add New"></asp:LinkButton>
                                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                                </InsertItemTemplate>
                                            </asp:TemplateField>

                                        </Fields>
                                    </asp:DetailsView>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </li>
                </ul>
            </li>
    <%--        <li id="simple2Tab">This is simple tab 2 content. Now you see it!

            </li>--%>
        </ul>        
        <asp:Panel runat="server" CssClass="footer">
            <img src="/Content/images/c3/aether_footer_logo.png" />
            <asp:Label ID="Firstname" runat="server" CssClass="logged-in" Text=""></asp:Label>
            <%--<asp:LinkButton runat="server" PostBackUrl="#" CssClass="slide-control"></asp:LinkButton>--%>
            <asp:Panel runat="server" CssClass="footer-content">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
    <script type="text/javascript">
        $(window).load(function () {
            $('.slide-control').click(function (e) {
                e.preventDefault();
                if (!$(this).hasClass('active')) {
                    $(this).next('.footer-content').slideToggle(300, function () {
                        $(this).prev('.slide-control').addClass('active');
                    });
                } else {
                    $(this).next('.footer-content').slideToggle(300, function () {
                        $(this).prev('.slide-control').removeClass('active');
                    });
                }
            })
        })
        $('.accordion .content').click(function (e) {
            e.stopPropagation();
        })
    </script>
</asp:Content>
