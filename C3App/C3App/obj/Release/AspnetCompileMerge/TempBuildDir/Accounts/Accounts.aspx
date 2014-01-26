<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Accounts.aspx.cs" Inherits="C3App.Accounts.Accounts" %>

<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">

    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">

        <%--<asp:Button ID="Button1" runat="server" CommandName="ShowPanel" CommandArgument="DetailsView" OnClick="ShowPanel" OnClientClick="ShowPanel()" Text="ButtonNew" />--%>
        <%--<asp:LinkButton ID="AccountInsertLinkButton" runat="server" SkinID="TabTitle" Text="Create Account" CommandArgument="Insert" OnClientClick="GoToTab('1');" OnClick="AccountInsertLinkButton_Click" />--%>
        <asp:LinkButton runat="server" ID="AccountInsertLinkButton" SkinID="TabTitle" OnClientClick="GoToTab(1, 'Create Account');" Text="Create Account" OnClick="AccountInsertLinkButton_Click"></asp:LinkButton>
        <asp:Label ID="MsgLabel" runat="server" Text=""></asp:Label>
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">

            <asp:UpdatePanel runat="server" ID="AccountDetailsUpdatePanel" >

                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="AccountInsertLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <asp:ValidationSummary ID="AccountsValidationSummary" runat="server" ValidationGroup="sum" ShowSummary="true" DisplayMode="BulletList" ShowValidationErrors="True" />
                    <asp:ObjectDataSource ID="AccountsDetailsObjectDataSource" runat="server"
                        TypeName="C3App.BLL.AccountBL" DataObjectTypeName="C3App.DAL.Account"
                        InsertMethod="InsertAccount"
                        UpdateMethod="UpdateAccount" SelectMethod="GetAccountByID">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditAccountID" Name="accountID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>

                    <asp:DetailsView ID="AccountDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="field-label" 
                        DataSourceID="AccountsDetailsObjectDataSource" DefaultMode="Insert" AutoGenerateRows="False"
                        DataKeyNames="AccountID,CreatedTime,CreatedBy"  
                        OnItemInserting="AccountDetailsView_ItemInserting"
                        OnItemUpdating="AccountDetailsView_ItemUpdating"
                        OnItemCommand="AccountDetailsView_ItemCommand"
                        OnItemUpdated="AccountDetailsView_ItemUpdated"
                        OnItemInserted="AccountDetailsView_ItemInserted">
                        <EmptyDataTemplate>
                            <p>
                                No data found.<br/>Please,select an account from list to edit..
                            </p>
                        </EmptyDataTemplate>
                        
                        <Fields>
                            
                           <asp:DynamicField DataField="Name" HeaderText="Account Name" ValidationGroup="sum" />
                             <asp:DynamicField DataField="Website" HeaderText="Website" ValidationGroup="sum" />
                              <asp:TemplateField HeaderText="Account Type" SortExpression="AccountTypesID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AccountTypeObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.AccountType" SelectMethod="GetAccountTypes" TypeName="C3App.BLL.AccountBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AccountTypeDropDownList" runat="server" AppendDataBoundItems="true" AutoPostBack="False" DataSourceID="AccountTypeObjectDataSource" DataTextField="Value" DataValueField="AccountTypeID" OnInit="AccountTypeDropDownList_Init" SelectedValue='<%# Eval("AccountTypesID")==null ? "0" : Eval("AccountTypesID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                              <asp:TemplateField HeaderText="Parent company" SortExpression="Companies.Name">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="ParentCompanyObjectDataSource" runat="server" SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="ParentCompanyDropDownList" runat="server" AppendDataBoundItems="true" AutoPostBack="False" DataSourceID="ParentCompanyObjectDataSource" DataTextField="Name"
                                        DataValueField="AccountID" OnInit="ParentCompanyDropDownList_Init" SelectedValue='<%# Eval("ParentID")==null ? "0" : Eval("ParentID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="Employees" HeaderText="References" ValidationGroup="sum" />
                            <asp:DynamicField DataField="Ownership" HeaderText="Ownership" ValidationGroup="sum" />
                            <asp:DynamicField DataField="OfficePhone" HeaderText="Phone" ValidationGroup="sum" />
                            <asp:DynamicField DataField="Fax" HeaderText="Fax" ValidationGroup="sum" />
                            <asp:DynamicField DataField="AlternatePhone" HeaderText="Alternate Phone" ValidationGroup="sum" />
                             <asp:DynamicField DataField="PrimaryEmail" HeaderText="Primary Email address" ValidationGroup="sum" />
                            <asp:DynamicField DataField="AlternateEmail" HeaderText="Alternate Email" ValidationGroup="sum" />
                            <asp:DynamicField DataField="AnnualRevenue" HeaderText="Annual Revenue" ValidationGroup="sum" />
                             <asp:DynamicField DataField="Rating" HeaderText="Rating" ValidationGroup="sum" />
                            <asp:DynamicField DataField="SICCode" HeaderText="SIC Code" ValidationGroup="sum" />
                             <asp:TemplateField HeaderText="Industry" SortExpression="IndustryID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="IndustryObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.CompanyType" SelectMethod="GetIndustries" TypeName="C3App.BLL.AccountBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="IndustriesDropDownList" runat="server" AppendDataBoundItems="true" AutoPostBack="False" DataSourceID="IndustryObjectDataSource"
                                        DataTextField="Value" DataValueField="CompanyTypeID" OnInit="IndustriesDropDownList_Init" SelectedValue='<%# Eval("IndustryID")==null ? "0" : Eval("IndustryID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                             
                            <asp:DynamicField DataField="BillingStreet" HeaderText="Billing Street" ValidationGroup="sum" />
                             <asp:DynamicField DataField="BillingCity" HeaderText="Billing City" ValidationGroup="sum" />
                            <asp:DynamicField DataField="BillingState" HeaderText="Billing State" ValidationGroup="sum" />
                            <asp:DynamicField DataField="BillingPost" HeaderText="Billing Postal Code" ValidationGroup="sum" />
                            <asp:TemplateField HeaderText="Billing Country" SortExpression="BillingCountry">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="BillingCountriesObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Country" SelectMethod="GetCountries" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="BillingCountriesDropDownList" runat="server" AppendDataBoundItems="true" AutoPostBack="False" DataSourceID="BillingCountriesObjectDataSource" DataTextField="CountryName" DataValueField="CountryID" OnInit="BillingCountriesDropDownList_Init" SelectedValue='<%# Eval("BillingCountry")==null ? "0" : Eval("BillingCountry") %>'>
                                        <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="ShippingStreet" HeaderText="Shipping Street" ValidationGroup="sum" />
                             <asp:DynamicField DataField="ShippingCity" HeaderText="Shipping City" ValidationGroup="sum" />
                             <asp:DynamicField DataField="ShippingState" HeaderText="Shipping State" ValidationGroup="sum" />
                            <asp:DynamicField DataField="ShippingPost" HeaderText="Shipping Postal Code" ValidationGroup="sum" />
                            <asp:TemplateField HeaderText="Shipping Country" SortExpression="ShippingCountry">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="ShippingCountriesObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Country" SelectMethod="GetCountries" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="ShippingCountriesDropDownList" runat="server" AppendDataBoundItems="true" AutoPostBack="False" DataSourceID="ShippingCountriesObjectDataSource" DataTextField="CountryName" DataValueField="CountryID" OnInit="ShippingCountriesDropDownList_Init" SelectedValue='<%# Eval("ShippingCountry")==null ? "0" : Eval("ShippingCountry") %>'>
                                        <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.User" SelectMethod="GetUsers" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="UsersDropDownList" runat="server" AppendDataBoundItems="true" AutoPostBack="True" DataSourceID="UsersObjectDataSource" DataTextField="FirstName" DataValueField="UserID" OnInit="UsersDropDownList_Init" 
                                        OnSelectedIndexChanged="UsersDropDownList_SelectedIndexChanged" SelectedValue='<%# Eval("AssignedUserID")==null ? "0" : Eval("AssignedUserID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                             <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:Label runat="server" Text="Notify user" Visible="False" ID="NotifyLabel"></asp:Label>
                                   <asp:CheckBox runat="server" ID="NotifyCheckBox" Text="" Visible="False"/>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TeamsObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Team" SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsDropDownList" runat="server" AppendDataBoundItems="true" AutoPostBack="False" DataSourceID="TeamsObjectDataSource"
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init" SelectedValue='<%# Eval("TeamID")==null ? "0" : Eval("TeamID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                             <asp:DynamicField DataField="Description" HeaderText="Description" ValidationGroup="sum" />
                            
                             <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                 <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Update" Text="Save"  ValidationGroup="sum"></asp:LinkButton>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton2" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="InsertLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" Text="Save" ValidationGroup="sum"></asp:LinkButton>
                                </InsertItemTemplate>
                            </asp:TemplateField>

                            <%-- end --%>
                          <%-- <asp:TemplateField HeaderText="Account Name" >
                                <EditItemTemplate>
                                     <asp:RequiredFieldValidator CssClass="input-validate" ID="NameRequiredValidator" runat="server"
                                        ControlToValidate="NameTextBox" ValidationGroup="sum" ErrorMessage="Account name required"  Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="NameTextBox"  CssClass="required-field" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        
                            <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website" />--%>
                          
                            <%--<asp:BoundField DataField="Employees" HeaderText="References" SortExpression="Employees" />
                            <asp:BoundField DataField="Ownership" HeaderText="Ownership" SortExpression="Ownership" />--%>
                            <%--<asp:BoundField DataField="OfficePhone" HeaderText="Phone" SortExpression="OfficePhone" />
                            <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax" />
                            <asp:BoundField DataField="AlternatePhone" HeaderText="Alternate Phone" SortExpression="AlternatePhone" />
                            <asp:TemplateField HeaderText="Primary Email address" SortExpression="PrimaryEmail">
                                <EditItemTemplate>
                                    <asp:RegularExpressionValidator ID="Email1AddressValidator" CssClass="input-validate" runat="server" ControlToValidate="Email1TextBox" Text="*"
                                        Display="Dynamic" ErrorMessage="Invalid E-mail address" ValidationGroup="sum" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" SetFocusOnError="True">
                                    </asp:RegularExpressionValidator>
                                    <asp:TextBox ID="Email1TextBox" runat="server" Text='<%# Bind("PrimaryEmail") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Alternate Email address" SortExpression="AlternateEmail">
                                <EditItemTemplate>
                                    <asp:RegularExpressionValidator ID="Email2AddressValidator" CssClass="input-validate" runat="server" ControlToValidate="Email2TextBox" Text="*"
                                        Display="Dynamic" ErrorMessage="Invalid E-mail address" ValidationGroup="sum" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" SetFocusOnError="True">
                                    </asp:RegularExpressionValidator>
                                    <asp:TextBox ID="Email2TextBox" runat="server" Text='<%# Bind("AlternateEmail") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField HeaderText="Rating" SortExpression="Rating">
                                <Edititemtemplate>
                                    <asp:RangeValidator id="RatingValidator" ControlToValidate="RatingTextBox" Display="Dynamic"
                                         MinimumValue="0" MaximumValue="10" Type="Integer" ErrorMessage="Rate between 0 to 10" ValidationGroup="sum" CssClass="input-validate" Text="" runat="server" >
                                    </asp:RangeValidator>
                                    <asp:TextBox ID="RatingTextBox" runat="server" Text='<%# Bind("Rating") %>'></asp:TextBox>
                               </Edititemtemplate>
                            </asp:TemplateField>                            
                           
                          <asp:BoundField DataField="SICCode" HeaderText="SIC Code" SortExpression="SICCode" />

                            <asp:TemplateField HeaderText="Annual Revenue" SortExpression="AnnualRevenue">
                                <edititemtemplate>
                                    <asp:RegularExpressionValidator ID="AnnualRevenueRangeValidator" CssClass="input-validate" runat="server" ControlToValidate="AnnualRevenueTextBox" Text="*"
                                        Display="Dynamic" ErrorMessage="Annual Revenue must be decimal number" ValidationGroup="sum" ValidationExpression="^\d{1,15}(?:\.\d\d)?$" SetFocusOnError="True">
                                    </asp:RegularExpressionValidator>
                                    <asp:TextBox ID="AnnualRevenueTextBox" runat="server" Text='<%# Bind("AnnualRevenue") %>'></asp:TextBox>
                                </edititemtemplate>
                            </asp:TemplateField>                                                     
                            
                           <asp:TemplateField HeaderText="Billing Street" SortExpression="BillingStreet">
                                <EditItemTemplate>
                                    <asp:TextBox ID="BillingStreetTextBox" runat="server" TextMode="MultiLine" Text='<%# Bind("BillingStreet") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="BillingCity" HeaderText="Billing City" SortExpression="BillingCity" />
                            <asp:BoundField DataField="BillingState" HeaderText="Billing State" SortExpression="BillingState" />
                            <asp:BoundField DataField="BillingPost" HeaderText="Billing Postal Code" SortExpression="BillingPost" />--%>
                            
                           <%-- <asp:TemplateField HeaderText="Shipping Street" SortExpression="ShippingStreet">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ShippingStreetTextBox" runat="server" TextMode="MultiLine" Text='<%# Bind("ShippingStreet") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ShippingCity" HeaderText="Shipping City" SortExpression="ShippingCity" />
                            <asp:BoundField DataField="ShippingState" HeaderText="Shipping State" SortExpression="ShippingState" />
                            <asp:BoundField DataField="ShippingPost" HeaderText="Shipping Postal Code" SortExpression="ShippingPost" />--%>
                            
                         <%--   <asp:TemplateField HeaderText="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DescriptionTextBox" runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
                        </Fields>
                    </asp:DetailsView>
                </ContentTemplate>
            </asp:UpdatePanel>
             <asp:UpdateProgress ID="AccountDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="AccountDetailsUpdatePanel">
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
        <%--<asp:LinkButton runat="server" ID="UpdateTab2" SkinID="TabTitle" Text="View Accounts" OnClick="UpdateButton_Click" OnClientClick="GoToTab('2')" />--%>
        <asp:LinkButton runat="server" ID="UpdateTab2" SkinID="TabTitle"  OnClick="UpdateButton_Click" OnClientClick="GoToTab(2,'Create Account');" Text="View Accounts"></asp:LinkButton>
        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">
           
            <asp:ObjectDataSource ID="SearchObjectDataSource" runat="server" SelectMethod="SearchAccount" TypeName="C3App.BLL.AccountBL" DataObjectTypeName="C3App.DAL.Account">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
            
            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="Panel5" runat="server" CssClass="filter">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="SearchAllLinkButton" CssClass="search-label active"  OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                    <asp:LinkButton runat="server" ID="BankingIndustrySearchButton" CssClass="search-label active"  OnClick="BankingIndustrySearchButton_Click">Banking</asp:LinkButton>
                     <asp:LinkButton runat="server" ID="ApparelIndustrySearchButton" CssClass="search-label active"  OnClick="ApparelIndustrySearchButton_Click">Apparel</asp:LinkButton>
                     <asp:LinkButton runat="server" ID="CustomerAccountTypeSearchButton" CssClass="search-label active"  OnClick="CustomerAccountTypeSearchButton_Click">Customer</asp:LinkButton>

                </asp:Panel>
                <asp:Panel ID="SearchPanel2" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server" OnTextChanged="SearchTextBox_TextChanged"></asp:TextBox>
                    <asp:LinkButton CssClass="search-btn" ID="SearchButton" runat="server" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>
            
               <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">

                   <asp:UpdatePanel ID="ViewAccountsUpdatepanel" runat="server" UpdateMode="Conditional">
                       <Triggers>
                           <asp:AsyncPostBackTrigger ControlID="UpdateTab2" EventName="Click" />
                           <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                           <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="BankingIndustrySearchButton" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="ApparelIndustrySearchButton" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="CustomerAccountTypeSearchButton" EventName="Click" />
                       </Triggers>
                       <ContentTemplate>
                           
                           <asp:ObjectDataSource ID="AccountsViewObjectDataSource" runat="server"
                               TypeName="C3App.BLL.AccountBL" SelectMethod="GetAccounts">
                           </asp:ObjectDataSource>
                           
                            <asp:ObjectDataSource ID="BankingIndustryObjectDataSource" runat="server"
                               TypeName="C3App.BLL.AccountBL" SelectMethod="GetAccountsByBankingIndustry">
                           </asp:ObjectDataSource>
                           
                            <asp:ObjectDataSource ID="ApparelIndustryObjectDataSource" runat="server"
                               TypeName="C3App.BLL.AccountBL" SelectMethod="GetAccountsByApparelIndustry">
                           </asp:ObjectDataSource>
                           
                            <asp:ObjectDataSource ID="CustomerAccountTypeObjectDataSource" runat="server"
                               TypeName="C3App.BLL.AccountBL" SelectMethod="GetAccountsByCustomerAccountType">
                           </asp:ObjectDataSource>

                           <asp:GridView ID="ViewAccountsGridView" DataSourceID="AccountsViewObjectDataSource"
                               runat="server" CssClass="list-form" AutoGenerateColumns="False" GridLines="None"
                               DataKeyNames="AccountID" ShowHeader="false">
                               <EmptyDataTemplate>
                                   <p>
                                       No Account found...
                                   </p>
                               </EmptyDataTemplate>
                               <Columns>
                                   <asp:TemplateField>
                                       <ItemTemplate>
                                           <asp:Image ID="Image" runat="server" ImageUrl="~/Content/images/c3/account.jpg" />
                                            <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("AccountID")+ ";" + Eval("AssignedUserID") + ";" + Eval("Name") %>' CommandName="Select" CausesValidation="False" OnCommand="SelectLinkButton_Command">
                                               <%# Eval("Name") %>
                                               <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                           </asp:LinkButton>
                                       </ItemTemplate>
                                   </asp:TemplateField>
                               </Columns>
                           </asp:GridView>
                       </ContentTemplate>
                   </asp:UpdatePanel>
                         <asp:UpdateProgress ID="ViewAccountUpdateProgress" runat="server" AssociatedUpdatePanelID="ViewAccountsUpdatepanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel1" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent1" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage1" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
                    </asp:Panel>
                   
            <asp:UpdatePanel ID="miniAccountDetailsUpdatePanel" runat="server" UpdateMode="Conditional">
                         
                <ContentTemplate>
                    <asp:Panel ID="MiniDetailBasicPanel" SkinID="MiniDetailBasicPanel" runat="server">
                        <asp:ObjectDataSource ID="MiniAccountObjectDataSource" runat="server"
                            TypeName="C3App.BLL.AccountBL" DataObjectTypeName="C3App.DAL.Account" SelectMethod="GetAccountByID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ViewAccountsGridView" Type="Int64" Name="accountID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:FormView ID="MiniAccountsFormView" CssClass="mini-details-form" runat="server" DataSourceID="MiniAccountObjectDataSource"
                            DataKeyNames="AccountID">
                            <EmptyDataTemplate>
                                <p>
                                    No Account selected...
                                </p>
                            </EmptyDataTemplate>

                            <ItemTemplate>
                                <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/account.jpg" />
                                <asp:Panel ID="Panel3" runat="server">
                                    <asp:Label ID="NameLabel" CssClass="fullname" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                    <asp:Label ID="OfficePhoneLabel" runat="server" CssClass="phone" Text='<%# Bind("OfficePhone") %>'></asp:Label>
                                    <asp:Label ID="PrimaryEmailLabel" runat="server" CssClass="email" Text='<%# Bind("PrimaryEmail") %>'></asp:Label>
                                    <asp:Label ID="WebsiteLabel" CssClass="globe" runat="server" Text='<%# Bind("Website") %>'></asp:Label>
                                    <asp:Label ID="IndustryLabel" runat="server" CssClass="royal-building" Text='<%# Bind("CompanyType.Value") %>'></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:Panel ID="ButtonPanel" runat="server" CssClass="mini-detail-control-panel four-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="ModalPopButton2" CssClass="control-btn" runat="server" OnClientClick="OpenModal('BodyContent_ModalCalendar')">
                                            <i class="icon-calendar"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="EditLinkButton" runat="server" Text="Edit" CssClass="control-btn" CommandArgument="" OnClientClick="GoToTab(1,'Account Details');" OnClick="AccountEditButton_Click">
                                            <i class="icon-edit"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                     <asp:Panel ID="Panel1" runat="server" CssClass="slide-confirm">
                                    <asp:LinkButton ID="NotifyLinkButton" CssClass="control-btn has-confirm " runat="server" Text="Convert">
                                       <i class="icon-share-alt"></i></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton1" runat="server" OnClientClick="GoToTab(2);" OnClick="NotifyLinkButton_Click">Notify</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton2" runat="server" class="slide-cancel">Cancel</asp:LinkButton>

                                    </asp:Panel>
                                </li>
                                <li>
                                     <asp:Panel ID="Panel6" runat="server" CssClass="slide-confirm">
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
                        <asp:DetailsView ID="miniAccountDetailsView" DataSourceID="MiniAccountObjectDataSource"
                            DataKeyNames="AccountID" AutoGenerateRows="False" runat="server"
                            CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label">
                            <EmptyDataTemplate>
                                <p>
                                    No Account selected...
                                </p>
                            </EmptyDataTemplate>
                            <Fields>

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
                                <asp:BoundField DataField="AlternatePhone" HeaderText="Alternate Phone" SortExpression="AlternatePhone"></asp:BoundField>
                                <asp:BoundField DataField="AlternateEmail" HeaderText="Other Email" SortExpression="AlternateEmail"></asp:BoundField>
                                <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax"></asp:BoundField>
                                <asp:BoundField DataField="AnnualRevenue" HeaderText="Annual Revenue" SortExpression="AnnualRevenue"></asp:BoundField>
                                <asp:BoundField DataField="Rating" HeaderText="Rating" SortExpression="Rating"></asp:BoundField>
                                <asp:BoundField DataField="Employees" HeaderText="References" SortExpression="Employees"></asp:BoundField>
                                <asp:BoundField DataField="BillingStreet" HeaderText="Billing  Street" SortExpression="BillingStreet"></asp:BoundField>
                                <asp:BoundField DataField="BillingCity" HeaderText="Billing City" SortExpression="BillingCity"></asp:BoundField>
                                <asp:BoundField DataField="BillingState" HeaderText="Billing State" SortExpression="BillingState"></asp:BoundField>
                                <asp:TemplateField HeaderText="Billing Country">
                                    <ItemTemplate>
                                        <asp:Label ID="BillingCountryLabel" runat="Server" Text='<%# Eval("Country.CountryName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ShippingStreet" HeaderText="Shipping Street" SortExpression="ShippingStreet"></asp:BoundField>
                                <asp:BoundField DataField="ShippingCity" HeaderText="Shipping City" SortExpression="ShippingCity"></asp:BoundField>
                                <asp:BoundField DataField="ShippingState" HeaderText="Shipping State" SortExpression="ShippingState"></asp:BoundField>
                                <asp:TemplateField HeaderText="Shipping Country">
                                    <ItemTemplate>
                                        <asp:Label ID="ShippingCountryLabel" runat="Server" Text='<%# Eval("Country1.CountryName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="SICCode" HeaderText="SIC Code" SortExpression="SICCode"></asp:BoundField>
                                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                            </Fields>
                        </asp:DetailsView>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <%-- start Calendar in Formview--%>
         <asp:Panel ID="ModalCalendar" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label4" runat="server" SkinID="ModalTitle" Text="Mini Calendar"></asp:Label>
            <%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="modal-create-btn" Text="Create" PostBackUrl="javascript:void(0)" OnClientClick="OpenCreateModal('BodyContent_Panel112')"></asp:LinkButton>--%>
            <asp:Panel ID="Panel4" SkinID="ModalListPanel" runat="server">
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

        <asp:Panel ID="Panel112" SkinID="ModalCreatePanelRight" runat="server">
            <asp:HyperLink ID="HyperLink12" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label32" runat="server" SkinID="ModalTitle" Text="Create Panel"></asp:Label>
        </asp:Panel>
        <%-- End Calendar in Formview--%>
    </asp:Panel>
    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel3" UpdateMode="Always">
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


