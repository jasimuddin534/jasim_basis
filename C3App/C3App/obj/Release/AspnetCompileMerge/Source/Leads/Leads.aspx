<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Leads.aspx.cs" Inherits="C3App.Leads.Leads" %>

<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">

    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">

        <%--        <asp:LinkButton ID="LeadInsertButton" runat="server" SkinID="TabTitle" Text="Lead Details" CommandArgument="Insert" OnClientClick="GoToTab(1);" OnClick="LeadInsertButton_Click"  >--%>
        <asp:LinkButton ID="LeadInsertButton" runat="server" SkinID="TabTitle" Text="" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Lead');" OnClick="LeadInsertButton_Click">Create Lead</asp:LinkButton>
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">

            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <%--                    <asp:AsyncPostBackTrigger ControlID="UpdateTab1" EventName="Click" />--%>
                    <asp:AsyncPostBackTrigger ControlID="LeadInsertButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />


                </Triggers>
                <ContentTemplate>
                    <asp:ValidationSummary ID="LeadsValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                    <%-- 
                        Place your DetialsPanel Content Here 
                    --%>
                    <asp:Label ID="message" runat="server" Visible="False" Text="AccountLabel"></asp:Label>
                    <asp:ObjectDataSource ID="LeadsObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Lead" InsertMethod="InsertLeads" SelectMethod="GetLeadByID" TypeName="C3App.BLL.LeadBL" DeleteMethod="DeleteLeads" UpdateMethod="UpdateLeads" OnInserted="LeadsObjectDataSource_Inserted" OnUpdated="LeadsObjectDataSource_Updated">

                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditLeadID" Name="LeadID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>

                    <asp:DetailsView ID="LeadsDetailsView" CssClass="details-form" FieldHeaderStyle-CssClass="field-label" runat="server" AutoGenerateRows="False"
                        DataSourceID="LeadsObjectDataSource" OnItemInserting="LeadDetailsView_ItemInserting"
                        DataKeyNames="LeadID,CompanyID,ContactID,AccountID,CreatedTime,createdBy,FirstName,LastName,AccountName"
                        OnItemUpdating="LeadDetailsView_ItemUpdating" OnItemInserted="LeadsDetailsView_ItemInserted" 
                        OnItemUpdated="LeadsDetailsView_ItemUpdated" OnItemCommand="LeadsDetailsView_ItemCommand" DefaultMode="Insert">
                        <Fields>


                            <%-- here goes comment      <asp:CommandField ShowInsertButton="True" />
                            <asp:CommandField ShowEditButton="True" />--%>
                            <asp:TemplateField HeaderText="Lead Source" SortExpression="LeadSourceID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="LeadsourcesDataSource" runat="server" DataObjectTypeName="C3App.DAL.LeadSource" SelectMethod="GetLeadSources" TypeName="C3App.BLL.LeadBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="LeadSourcesDropDownList" runat="server" DataSourceID="LeadsourcesDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("LeadSourceID")==null ? "-1" : Eval("LeadSourceID") %>'
                                        DataTextField="Value" DataValueField="LeadSourceID" OnInit="leadSourcesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="LeadsourcesDataSource" runat="server" DataObjectTypeName="C3App.DAL.LeadSource"
                                        SelectMethod="GetLeadSources" TypeName="C3App.BLL.LeadBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="LeadSourcesDropDownList" runat="server" DataSourceID="LeadsourcesDataSource" AppendDataBoundItems="True"
                                        DataTextField="Value" DataValueField="LeadSourceID" OnInit="leadSourcesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("LeadSourceID") %>' ID="Label6"></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Lead Source Description" SortExpression="LeadSourceDescripsion">
                                <EditItemTemplate>
                                    <asp:TextBox ID="LeadSourceDescTextBox" runat="server" CssClass="mask-street" TextMode="MultiLine" Text='<%# Bind("LeadSourceDescripsion") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="LeadSourceDescTextBox" runat="server" CssClass="mask-street" TextMode="MultiLine" Text='<%# Bind("LeadSourceDescripsion") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LeadSourceDescLabel" runat="server" TextMode="MultiLine" Text='<%# Bind("LeadSourceDescripsion") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="ReferredBy" HeaderText="Referred By" ValidationGroup="sum" />
                            <%--                             <asp:DynamicField  DataField="FirstName" HeaderText="First Name" ReadOnly="True" SortExpression="FirstName" ValidationGroup="sum" />--%>
                            <asp:TemplateField HeaderText="Contact Name" SortExpression="FirstName">
                                <EditItemTemplate>

                                    <asp:TextBox ID="ContactNameTextBox" runat="server"  ReadOnly="True" Text='<%# Eval("FirstName") +" "+   Eval("LastName")%>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button runat="server" ID="ModalPopButton1" SkinID="ButtonWithTextBox" CommandArgument="Contacts" OnClick="ModalSelectButton_Click"
                                        Text="Select" OnClientClick="OpenModal('BodyContent_ModalPanel1')" />
                                    <asp:RequiredFieldValidator ID="FirstNameRequiredValidator" runat="server" ControlToValidate="ContactNameTextBox" Display="Static"
                                        ErrorMessage="Contac tName is Required" Text="*" ForeColor="Red" ValidationGroup="sum" />
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="ContactNameTextBox" runat="server"  CssClass="required-field" ReadOnly="True" Text='<%# Bind("FirstName") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button runat="server" ID="ModalPopButton1" SkinID="ButtonWithTextBox" CommandArgument="Contacts" OnClick="ModalSelectButton_Click"
                                        Text="Select" OnClientClick="OpenModal('BodyContent_ModalPanel1')" />
                                    <asp:RequiredFieldValidator ID="FirstNameRequiredValidator" runat="server" ControlToValidate="ContactNameTextBox" Display="Static"
                                        ErrorMessage="Contact Name is Required" Text="*" ForeColor="Red" ValidationGroup="sum" />

                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="ContactNameTextBox" runat="server" Text='<%# Eval("FirstName") +" "+   Eval("LastName")%>'></asp:Label>


                                </ItemTemplate>
                            </asp:TemplateField>

                            <%-- <asp:TemplateField HeaderText="Last Name" SortExpression="LastName">
                                <EditItemTemplate>

                                    <asp:TextBox ID="LastNameTextBox" runat="server" ReadOnly="True" ValidationGroup="sum" Text='<%# Bind("LastName") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="LastNameTextBox" runat="server" ReadOnly="True" ValidationGroup="sum" Text='<%# Bind("LastName") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LastNameTextBox" runat="server" Text='<%# Bind("LastName") %>'></asp:Label>

                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Account Name" SortExpression="AccountName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AccountNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("AccountName") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton2" runat="server" CommandArgument="Accounts" OnClick="ModalSelectButton_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                    <asp:RequiredFieldValidator ID="AccountNameRequiredValidator" runat="server" ControlToValidate="AccountNameTextBox" Display="Static"
                                        ErrorMessage="Account Name is Required" Text="*" ForeColor="Red" ValidationGroup="sum" />

                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="AccountNameTextBox" runat="server"  CssClass="required-field" ReadOnly="True" Text='<%# Bind("AccountName") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton2" runat="server" CommandArgument="Accounts" OnClick="ModalSelectButton_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                    <asp:RequiredFieldValidator ID="AccountNameRequiredValidator" runat="server" ControlToValidate="AccountNameTextBox" Display="Static"
                                        ErrorMessage="Account Name is Required" Text="*" ForeColor="Red" ValidationGroup="sum" />

                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="AccountName" runat="server" Text='<%# Bind("AccountName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:DynamicField DataField="Title" HeaderText="Designation" SortExpression="Title" ValidationGroup="sum" />
                            <asp:DynamicField DataField="Department" HeaderText="Department" SortExpression="Department" ValidationGroup="sum" />

                            <asp:DynamicField DataField="Website" HeaderText="Website" SortExpression="Website" ValidationGroup="sum"/>
                            <asp:TemplateField HeaderText="Lead Status" SortExpression="LeadStatusID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="LeadStatusesDataSource" runat="server" DataObjectTypeName="C3App.DAL.LeadStatus" SelectMethod="GetLeadStatus" TypeName="C3App.BLL.LeadBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="LeadStatusesDropDownList" runat="server" DataSourceID="LeadStatusesDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("LeadStatusID")==null ? "-1" : Eval("LeadStatusID") %>'
                                        DataTextField="Value" DataValueField="LeadStatusID" OnInit="LeadStatusesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="LeadStatusesDataSource" runat="server" DataObjectTypeName="C3App.DAL.LeadStatus" SelectMethod="GetLeadStatus" TypeName="C3App.BLL.LeadBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="LeadStatusesDropDownList" runat="server" DataSourceID="LeadStatusesDataSource" AppendDataBoundItems="True"
                                        DataTextField="Value" DataValueField="LeadStatusID" OnInit="LeadStatusesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Lead Status Description" SortExpression="StatusDescription">
                                <EditItemTemplate>
                                    <asp:TextBox ID="LeadStatusDescTextBox" runat="server" CssClass="mask-street" TextMode="MultiLine" Text='<%# Bind("StatusDescription") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="LeadStatusDescTextBox" runat="server" CssClass="mask-street" TextMode="MultiLine" Text='<%# Bind("StatusDescription") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="LeadStatusDescLabel" runat="server" TextMode="MultiLine" Text='<%# Bind("StatusDescription") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="PhoneWork" HeaderText="Office Phone" SortExpression="PhoneWork" ValidationGroup="sum" />
                            <asp:DynamicField DataField="PhoneMobile" HeaderText="Mobile Phone" SortExpression="PhoneMobile" ValidationGroup="sum" />
                            <asp:DynamicField DataField="PhoneHome" HeaderText="Home Phone" SortExpression="PhoneHome" ValidationGroup="sum"/>
                            <asp:DynamicField DataField="PhoneOther" HeaderText="Other Phone" SortExpression="PhoneOther" ValidationGroup="sum"/>
                            <asp:DynamicField DataField="Fax" HeaderText="Fax" SortExpression="Fax" ValidationGroup="sum"/>
                            <asp:DynamicField DataField="PrimaryEmail" HeaderText="Primary Email " SortExpression="PrimaryEmail" ValidationGroup="sum" />
                            <asp:DynamicField DataField="AlternateEmail" HeaderText="Other Email" SortExpression="AlternateEmail" ValidationGroup="sum"/>
                            <asp:DynamicField DataField="PrimaryStreet" HeaderText="Primary Street" SortExpression="PrimaryStreet" ValidationGroup="sum"/>
                               
                            <asp:DynamicField DataField="PrimaryCity" HeaderText="Primary City" SortExpression="PrimaryCity" ValidationGroup="sum"/>
                            <asp:DynamicField DataField="PrimaryState" HeaderText="Primary State" SortExpression="PrimaryState" ValidationGroup="sum"/>
                            <asp:DynamicField DataField="PrimaryPostalCode" HeaderText="Primary Postal Code" SortExpression="PrimaryPostalCode" ValidationGroup="sum"/>
                            <asp:TemplateField HeaderText="Primary Country" SortExpression="PrimaryCountry">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="PrimaryCountryDataSource" runat="server" DataObjectTypeName="C3App.DAL.Country" SelectMethod="GetCountries" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="PrimaryCountryDropDownList" runat="server" DataSourceID="PrimaryCountryDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("PrimaryCountry")==null ? "-1" : Eval("PrimaryCountry") %>'
                                        DataTextField="CountryName" DataValueField="CountryID" OnInit="PrimaryCountryDropDownList_Init">
                                    </asp:DropDownList>

                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="PrimaryCountryDataSource" runat="server" DataObjectTypeName="C3App.DAL.Country" SelectMethod="GetCountries" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="PrimaryCountryDropDownList" runat="server" DataSourceID="PrimaryCountryDataSource" AppendDataBoundItems="True"
                                        DataTextField="CountryName" DataValueField="CountryID" OnInit="PrimaryCountryDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("PrimaryCountry") %>' ID="Label7"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:DynamicField DataField="AlternateStreet" HeaderText="Alternate Street" SortExpression="AlternateStreet" ValidationGroup="sum"/>
                               
                            <asp:DynamicField DataField="AlternateCity" HeaderText="Alternate City" SortExpression="AlternateCity" ValidationGroup="sum"/>
                            <asp:DynamicField DataField="AlternateState" HeaderText="Alternate State" SortExpression="AlternateState" ValidationGroup="sum"/>
                            <asp:DynamicField DataField="AlternatePostalCode" HeaderText="Alternate Postal Code" SortExpression="AlternatePostalCode" ValidationGroup="sum"/>
                            <asp:TemplateField HeaderText="Alternate Country" SortExpression="ALTCountry">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AltCountryDataSource" runat="server" DataObjectTypeName="C3App.DAL.Country" SelectMethod="GetCountries" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AltCountryDropDownList" runat="server" DataSourceID="AltCountryDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("AlternateCountry")==null ? "-1" : Eval("AlternateCountry") %>'
                                        DataTextField="CountryName" DataValueField="CountryID" OnInit="AltCountryDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="AltCountryDataSource" runat="server" DataObjectTypeName="C3App.DAL.Country" SelectMethod="GetCountries" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AltCountryDropDownList" runat="server" DataSourceID="AltCountryDataSource" AppendDataBoundItems="True"
                                        DataTextField="CountryName" DataValueField="CountryID" OnInit="AltCountryDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>

                            <asp:CheckBoxField DataField="EmailOptOut" HeaderText="Email Opt Out" SortExpression="EmailOptOut" />
                            <asp:CheckBoxField DataField="InvalidEmail" HeaderText="Invalid Email" SortExpression="InvalidEmail" />
                            <asp:CheckBoxField DataField="DoNotCall" HeaderText="Do Not Call" SortExpression="DoNotCall" />
                            <asp:TemplateField HeaderText="Teams" SortExpression="TeamID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TeamDataSource" runat="server" DataObjectTypeName="C3App.DAL.Team" SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsDropDownList" runat="server" DataSourceID="TeamDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("TeamID")==null ? "-1" : Eval("TeamID") %>'
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="TeamDataSource" runat="server" DataObjectTypeName="C3App.DAL.Team" SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsDropDownList" runat="server" DataSourceID="TeamDataSource" AppendDataBoundItems="True"
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignToDataSource" runat="server" DataObjectTypeName="C3App.DAL.User" SelectMethod="GetUsers" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssignedToDropDownList" runat="server" DataSourceID="AssignToDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("AssignedUserID")==null ? "-1" : Eval("AssignedUserID") %>'
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssignedToUsersDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="AssignToDataSource" runat="server" DataObjectTypeName="C3App.DAL.User" SelectMethod="GetUsers" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssignedToDropDownList" runat="server" DataSourceID="AssignToDataSource" AppendDataBoundItems="True"
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssignedToUsersDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                                <ItemTemplate></ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Update" Text="Save" ValidationGroup="sum"></asp:LinkButton>&nbsp;
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="LinkButton4" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton3" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" Text="Save" ValidationGroup="sum"></asp:LinkButton>&nbsp;
                                </InsertItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                    </asp:DetailsView>


                    <%--                    <asp:Button ID="UpdateButton" runat="server" Text="Update" Visible="False" OnClick="UpdateaccountSearchButton_Click" />--%>
                </ContentTemplate>
            </asp:UpdatePanel>
                             <asp:UpdateProgress ID="LeadDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
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
                    <asp:LinkButton ID="CreateButton" runat="server" CssClass="modal-create-btn" Text="Create" OnClientClick="OpenCreateModal('BodyContent_ModalPanel291')" OnClick="ModalCreateButton_Click" />

                    <asp:Panel ID="ModalSearchPanel" SkinID="ModalSearchPanel" runat="server">
                        <%--                    Search Panel--%>
                        <%-- 
                            Place your Search Panel Content Here 
                        --%>
                        <asp:Panel ID="AccountSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="Panel4" runat="server" CssClass="search">
                                <asp:Label ID="Label12" runat="server" Text="Search"></asp:Label>
                                <asp:TextBox ID="AccountSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="AccountSearchTextBox_TextChanged"></asp:TextBox>
                                <asp:LinkButton ID="accountSearchLinkButton" CssClass="search-btn modal-search" runat="server" OnClick="accountSearchButton_Click"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>
                        <asp:Panel ID="ContactSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="Panel5" runat="server" CssClass="search">
                                <asp:Label ID="Label13" runat="server" Text="Search"></asp:Label>
                                <asp:TextBox ID="ContactSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="ContactSearchTextBox_TextChanged"></asp:TextBox>
                                <asp:LinkButton ID="ContactLinkButton" CssClass="search-btn modal-search" runat="server" OnClick="ContactButton_Click"><i class="icon-search"></i></asp:LinkButton>
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
                                                <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("ContactID") %>' CommandName="Select" OnCommand="SelectContactLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("FirstName") +" "+   Eval("LastName")%>

                                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>

                                                </asp:LinkButton>
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
                                                <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("AccountID") %>' CommandName="Select" OnCommand="SelectAccountLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>

                                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>

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

        <asp:Panel ID="ModalPanel291" SkinID="ModalCreatePanelLeft" runat="server">
            <asp:HyperLink ID="HyperLink11" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label31" runat="server" SkinID="ModalTitle" Text="Create Panel">
            </asp:Label>
            <asp:Panel ID="Panel8" runat="server" CssClass="modal-create-content">
                <asp:UpdatePanel runat="server" ID="CreateUpdatePanel" UpdateMode="Conditional">
                    <Triggers>
                    </Triggers>
                    <ContentTemplate>
                        <asp:Panel runat="server" ID="AccountPanel" Visible="False">
                            <asp:ObjectDataSource ID="AccountsDetailsObjectDataSource" runat="server"
                                TypeName="C3App.BLL.AccountBL" DataObjectTypeName="C3App.DAL.Account"
                                InsertMethod="InsertAccount" SelectMethod="GetAccounts" OnInserted="AccountsDetailsObjectDataSource_Inserted"></asp:ObjectDataSource>

                            <asp:ValidationSummary ID="ValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="avs" />
                            <br />
                            <asp:DetailsView ID="AccountDetailsView" runat="server" CssClass="details-form"
                                FieldHeaderStyle-CssClass="field-label"
                                DataSourceID="AccountsDetailsObjectDataSource"
                                DataKeyNames="AccountID"
                                AutoGenerateRows="False"
                                OnItemInserting="AccountDetailsView_ItemInserting"
                                OnItemInserted="AccountDetailsView_ItemInserted"
                                DefaultMode="Insert">
                                <Fields>
                                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="NameText" runat="server"  CssClass="required-field"  Text='<%# Bind("Name") %>'>
                                            </asp:TextBox><asp:RequiredFieldValidator ID="NameRequiredValidator" runat="server" ControlToValidate="NameText" Display="none" ErrorMessage="Name is Required" Text="*" ValidationGroup="avs" />
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="PrimaryEmail" HeaderText="Email Address" SortExpression="PrimaryEmail" />
                                    <asp:BoundField DataField="OfficePhone" HeaderText="Office Phone No" SortExpression="OfficePhone" />
                                    <asp:BoundField DataField="Website" HeaderText="Web Site" SortExpression="Website" />
                                    <asp:TemplateField ShowHeader="False">
                                        <InsertItemTemplate>
                                            <asp:LinkButton ID="InsertLinkButton2" runat="server" CssClass="form-btn" CausesValidation="true" CommandName="Insert" Text="Save" ValidationGroup="avs"></asp:LinkButton>&nbsp;
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                            </asp:DetailsView>
                        </asp:Panel>

                        <asp:Panel runat="server" ID="ContactPanel" Visible="False">


                            <asp:ObjectDataSource ID="ContactDetailsCreateObjectDataSource" runat="server"
                                TypeName="C3App.BLL.ContactBL" DataObjectTypeName="C3App.DAL.Contact"
                                InsertMethod="InsertContact" SelectMethod="GetContacts" OnInserted="ContactDetailsCreateObjectDataSource_Inserted"></asp:ObjectDataSource>

                            <asp:ValidationSummary ID="contactValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="avs" />
                            <br />

                            <asp:DetailsView ID="ContactDetailsView" runat="server" CssClass="details-form"
                                FieldHeaderStyle-CssClass="field-label"
                                DataSourceID="ContactDetailsCreateObjectDataSource"
                                DataKeyNames="ContactID"
                                AutoGenerateRows="False"
                                OnItemInserting="ContactDetailsView_ItemInserting"
                                OnItemInserted="ContactDetailsView_ItemInserted"
                                DefaultMode="Insert">
                                <Fields>
                                    <asp:TemplateField HeaderText="First Name" SortExpression="FirstName">
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="NameText" runat="server" CssClass="required-field" Text='<%# Bind("FirstName") %>'>
                                            </asp:TextBox><asp:RequiredFieldValidator ID="NameRequiredValidator" runat="server"  ControlToValidate="NameText" Display="none" ErrorMessage="Name is Required" Text="*" ValidationGroup="avs" />
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name" SortExpression="LastName" />
                                    <asp:BoundField DataField="PrimaryEmail" HeaderText="Email" SortExpression="PrimaryEmail" />
                                    <asp:BoundField DataField="MobilePhone" HeaderText="Mobile Phone" SortExpression="MobilePhone" />
                                    <asp:TemplateField ShowHeader="False">
                                        <InsertItemTemplate>
                                            <asp:LinkButton ID="InsertLinkButton21" runat="server" CssClass="form-btn" CausesValidation="true" CommandName="Insert" Text="Save" ValidationGroup="avs"></asp:LinkButton>&nbsp;
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                            </asp:DetailsView>
                        </asp:Panel>
                    </ContentTemplate>

                </asp:UpdatePanel>
            </asp:Panel>

        </asp:Panel>




    </asp:Panel>

    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">

        <asp:LinkButton runat="server" ID="LeadEditLinksButton" SkinID="TabTitle" OnClick="UpdateButton_Click" Text="View Leads" OnClientClick="GoToTab(2,'Create Lead')" />

        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">

            <asp:ObjectDataSource ID="LeadSearchObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Lead" DeleteMethod="DeleteLeads" InsertMethod="InsertLeads" SelectMethod="SearchLeads" TypeName="C3App.BLL.LeadBL" UpdateMethod="UpdateLeads">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" Name="search" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="Panel12" runat="server" CssClass="filter">
                    <asp:Label ID="Label8" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="SearchAllLinkButton" CssClass="search-label active" OnClick="SearchAllButton_Click">All</asp:LinkButton>
                    <asp:LinkButton runat="server" ID="SearchNewLeadLinkButton" CssClass="search-label active" OnClick="SearchNewLead_Click">New</asp:LinkButton>
                    <asp:LinkButton runat="server" ID="AssignedLeadLinkButton" CssClass="search-label active" OnClick="AssignedLead_Click">Assigned</asp:LinkButton>
                    <asp:LinkButton runat="server" ID="ConvertedLeadLinkButton" CssClass="search-label active" OnClick="ConvertedLead_Click">Converted</asp:LinkButton>
                    <asp:LinkButton runat="server" ID="importButton" CssClass="search-label active" Text="Import" OnClick="ImportButton_Click"/>


                </asp:Panel>

<%--                  <asp:Panel ID="NewLeadPanel" runat="server" CssClass="filter">
                    <asp:Label ID="Label5" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="SearchNewLeadLinkButton" CssClass="search-label active" OnClick="SearchNewLead_Click">New</asp:LinkButton>
                </asp:Panel>
                    <asp:Panel ID="AssignedLeadPanel" runat="server" CssClass="filter">
                    <asp:Label ID="Label14" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="AssignedLeadLinkButton" CssClass="search-label active" OnClick="AssignedLead_Click">Assigned</asp:LinkButton>
                </asp:Panel>
                   <asp:Panel ID="ConvertedLeadPanel" runat="server" CssClass="filter">
                    <asp:Label ID="Label15" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="ConvertedLeadLinkButton" CssClass="search-label active" OnClick="ConvertedLead_Click">New</asp:LinkButton>
                </asp:Panel>--%>


                <asp:Panel ID="Panel3" runat="server" CssClass="search" DefaultButton="SearchLinkButton">
                     <asp:Label ID="Label91" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                    <asp:LinkButton ID="SearchLinkButton" runat="server" OnClick="SearchButton_Click" CssClass="search-btn" Text="Search" />
                </asp:Panel>
            </asp:Panel>
            <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">
                <asp:ObjectDataSource ID="ListPanelObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Lead" DeleteMethod="DeleteLeads" InsertMethod="InsertLeads" SelectMethod="GetLeads" TypeName="C3App.BLL.LeadBL" UpdateMethod="UpdateLeads"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="NewLeadObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Lead" DeleteMethod="DeleteLeads" InsertMethod="InsertLeads" SelectMethod="GetNewLeads" TypeName="C3App.BLL.LeadBL" UpdateMethod="UpdateLeads"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="AssignedLeadsObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Lead" DeleteMethod="DeleteLeads" InsertMethod="InsertLeads" SelectMethod="GetAssignedLeads" TypeName="C3App.BLL.LeadBL" UpdateMethod="UpdateLeads"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ConvertedLeadsObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Lead" DeleteMethod="DeleteLeads" InsertMethod="InsertLeads" SelectMethod="GetConvertedLeads" TypeName="C3App.BLL.LeadBL" UpdateMethod="UpdateLeads"></asp:ObjectDataSource>
                <asp:UpdatePanel ID="upListView" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="LeadEditLinksButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchNewLeadLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="AssignedLeadLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="ConvertedLeadLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:GridView ID="LeadsGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                            DataKeyNames="LeadID"
                            DataSourceID="ListPanelObjectDataSource" GridLines="None" ShowHeader="False">
                            <EmptyDataTemplate>
                                <p>
                                    No Leads found.
                                </p>
                            </EmptyDataTemplate>
                            <Columns>


                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/lead.jpg" />
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("LeadID") + ";" + Eval("ContactID")%>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                            <%# Eval("FirstName") +" "+   Eval("LastName")%>
                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="LeadUpdateProgress" runat="server" AssociatedUpdatePanelID="upListView" DynamicLayout="true" DisplayAfter="0">
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

                        <asp:ObjectDataSource ID="MiniLeadsObjectDataSource" runat="server"
                            DataObjectTypeName="C3App.DAL.Lead" DeleteMethod="DeleteLeads"
                            InsertMethod="InsertLeads" SelectMethod="GetLeadByID" TypeName="C3App.BLL.LeadBL"
                            UpdateMethod="UpdateLeads">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="LeadsGridView" Name="LeadID" Type="Int64" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>



                        <asp:FormView ID="MiniLeadsFormView" runat="server" CssClass="mini-details-form" DataSourceID="MiniLeadsObjectDataSource"
                            DataKeyNames="LeadID">

                            <EmptyDataTemplate>
                                <p>
                                    No Lead selected.
                                </p>
                            </EmptyDataTemplate>

                            <ItemTemplate>
                                <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/lead.jpg" />
                                <asp:Panel ID="Panel1" runat="server">
                                    <asp:Label ID="Label7" CssClass="fullname" runat="server" Text='<%# Eval("FirstName") +" "+   Eval("LastName")%>'></asp:Label>
                                    <asp:Label ID="Label8" CssClass="royal-building" runat="server" Text='<%# Eval("AccountName") %>'></asp:Label>
                                    <asp:Label ID="Label9" runat="server" CssClass="id-card" Text='<%# Eval("Title") %>'></asp:Label>
                                    <asp:Label ID="Label10" runat="server" CssClass="phone" Text='<%# Eval("Department") %>'></asp:Label>
                                    <asp:Label ID="Label11" runat="server" CssClass="email" Text='<%# Eval("LeadSource.Value") %>'></asp:Label>
                                </asp:Panel>

                            </ItemTemplate>
                        </asp:FormView>
                        <asp:Panel ID="Panel2" runat="server" CssClass="mini-detail-control-panel four-controls">
                            <ul>

                                <li>
                                    <asp:LinkButton ID="MeetingSummaryLinkButton" CssClass="control-btn" runat="server" OnClick="ShowMeetings_Click" OnClientClick="OpenModal('BodyContent_MeetingInviteeModalPanel')">
                                            <i class="icon-calendar"></i>
                                        </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="EditLinkButton" CssClass="control-btn " runat="server" Text="Edit" CommandArgument="" OnClientClick="GoToTab(1,'Lead Details');"
                                        OnClick="LeadEditButton_Click"> <i class="icon-edit"></i> 
                                    </asp:LinkButton>
                                </li>
                                <li>
                                                                        <asp:Panel ID="Panel6" runat="server" CssClass="slide-confirm">
                                    <asp:LinkButton ID="DeleteLinkButton" CssClass="control-btn has-confirm " runat="server" Text="Delete">
                                       <i class="icon-trash"></i></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton5" runat="server" OnClientClick="GoToTab(2);" OnClick="deleteButton1_Click">Delete</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton6" runat="server" class="slide-cancel">Cancel</asp:LinkButton>

                                    </asp:Panel>
                                </li>
                                <li>
                                   <asp:Panel ID="Panel7" runat="server" CssClass="slide-confirm">
                                    <asp:LinkButton ID="ConvertLinkButton" CssClass="control-btn has-confirm " runat="server" Text="Convert">
                                       <i class="icon-share-alt"></i></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton7" runat="server" OnClientClick="GoToTab(2);" OnClick="ConvertButton_Click">Convert</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton8" runat="server" class="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>
                            </ul>
                        </asp:Panel>


                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <%--                            MiniDetailMorePanel--%>
                        <%-- 
                                Place your MiniDetailMorePanel Content Here 
                        --%>
                        <asp:DetailsView ID="MiniMoreLeadsDetailsView" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label"
                            AutoGenerateRows="False" DataSourceID="MiniLeadsObjectDataSource"
                             DataKeyNames="LeadID">
                            <EmptyDataTemplate>
                                <p>
                                    No Leads selected.
                                </p>
                            </EmptyDataTemplate>
                            <Fields>
                                <asp:TemplateField HeaderText="Lead Status" SortExpression="LeadStatusID">

                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("LeadStatus.Value") %>' ID="Label1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Assigned User" SortExpression="AssignedUserID">

                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("User.FirstName") %>' ID="Label2"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Team" SortExpression="TeamID">

                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("Team.Name") %>' ID="Label3"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="PhoneWork" HeaderText="Phone Work" SortExpression="PhoneWork" />
                                <asp:BoundField DataField="AlternateEmail" HeaderText="Other Email" SortExpression="AlternateEmail" />
                                <asp:BoundField DataField="PrimaryStreet" HeaderText="Primary Street" SortExpression="PrimaryStreet" />
                                <asp:BoundField DataField="PrimaryState" HeaderText="Primary State" SortExpression="PrimaryState" />
                                <asp:BoundField DataField="PrimaryCity" HeaderText="Primary City" SortExpression="PrimaryCity" />
                                <asp:BoundField DataField="PrimaryPostalCode" HeaderText="Primary Postal Code" SortExpression="PrimaryPostalCode" />
                                <asp:TemplateField HeaderText="Primary Country" SortExpression="PrimaryCountry">

                                    <ItemTemplate>
                                        <asp:Label ID="PrimaryCountryLabel" runat="server" Text='<%# Eval("Country.CountryName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="AlternateStreet" HeaderText="Alternate Street" SortExpression="AlternateStreet" />
                                <asp:BoundField DataField="AlternateState" HeaderText="Alternate State" SortExpression="AlternateState" />
                                <asp:BoundField DataField="AlternateCity" HeaderText="Alternate City" SortExpression="AlternateCity" />
                                <asp:BoundField DataField="AlternatePostalCode" HeaderText="Alternate Postal Code" SortExpression="AlternatePostalCode" />
                                <asp:TemplateField HeaderText="Alternate Country" SortExpression="AlternateCountry">
                                    <ItemTemplate>
                                        <asp:Label ID="AlternateCountryLabel" runat="server" Text='<%# Eval("Country1.CountryName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
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
<%--        <asp:Panel ID="ModalCalendar" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label4" runat="server" SkinID="ModalTitle" Text="Mini Calendar"></asp:Label>
            <asp:Panel ID="Panel9" SkinID="ModalListPanel" runat="server">
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
        </asp:Panel>--%>

<%--        <asp:Panel ID="Panel112" SkinID="ModalCreatePanelRight" runat="server">
            <asp:HyperLink ID="HyperLink12" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label32" runat="server" SkinID="ModalTitle" Text="Create Panel"></asp:Label>
        </asp:Panel>--%>
                <asp:Panel ID="MeetingInviteeModalPanel" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label4" runat="server" SkinID="ModalTitle" Text="Meetings Summary"></asp:Label>
                    <asp:Panel ID="Panel9" SkinID="ModalListPanel" runat="server">

<%--                <asp:Label ID="TodaysMeetingLabel" CssClass="list-title" runat="server" > Meeting Notification</asp:Label>

                <asp:ObjectDataSource ID="MeetingInviteeObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Meeting"
                    TypeName="C3App.BLL.MeetingBL" SelectMethod="GetMeetingsByInvitee">
                    <SelectParameters>
                        <asp:Parameter Name="inviteeType" Type="String" DefaultValue="Leads"></asp:Parameter>
                        <asp:SessionParameter SessionField="EditContactID" Name="inviteeID" Type="Int64"></asp:SessionParameter>
                    </SelectParameters>
                </asp:ObjectDataSource>--%>

                <asp:ObjectDataSource ID="WeeklyMeetingObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Meeting"
                    TypeName="C3App.BLL.MeetingBL" SelectMethod="GetWeeklyMeetingsByInvitee">
                    <SelectParameters>
                        <asp:Parameter Name="inviteeType" Type="String" DefaultValue="Leads"></asp:Parameter>
                        <asp:SessionParameter SessionField="EditContactID" Name="inviteeID" Type="Int64"></asp:SessionParameter>
                    </SelectParameters>
                </asp:ObjectDataSource>

<%--                <asp:UpdatePanel runat="server" ID="MeetingSummaryUpdatePanel" UpdateMode="Conditional">
                    <ContentTemplate>

                        <asp:GridView ID="MeetingsInvitedGridView" runat="server" CssClass="list-form meeting-noftify" AutoGenerateColumns="False" 
                            GridLines="None" DataSourceID="MeetingInviteeObjectDataSource">
                                <EmptyDataTemplate>
                                    <p>
                                        You have no scheduled meeting today...
                                    </p>
                                </EmptyDataTemplate>
                                
                                <Columns>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                                <%# Eval("Subject") %>
                                            <asp:Label ID="MeetingTimeLabel" runat="server" Text=' <%# Eval("StartDate","{0:hh:mm}")+ " - " + Eval("EndDate","{0:hh:mm}")%>'/>
                                            <asp:Label ID="LocationLabel" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                          </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>

                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>--%>
                
                  <asp:UpdatePanel runat="server" ID="WeeklymeetingUpdatePanel" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:GridView ID="WeeklyMeetingGridView" runat="server" CssClass="list-form calendar-form"  AutoGenerateColumns="False" 
                            GridLines="None" ShowHeader="False" DataSourceID="WeeklyMeetingObjectDataSource">
                                <EmptyDataTemplate>
                                    <p>
                                        You have no scheduled meeting...
                                    </p>
                                </EmptyDataTemplate> 

                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <table >
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <asp:Label runat="server" ID="DateLabel" CssClass="date"  Text='<%# Eval("StartDate","{0:dd}")%>'></asp:Label>
                                                            <asp:Label runat="server" ID="MonthLabel" CssClass="month"  Text='<%# Eval("StartDate","{0:MMM}")%>'></asp:Label>
                                                        </td>
                                                        <td>
                                                            <ul class="event">
                                                                <li>
                                                                    <asp:Label runat="server" ID="SubjectLabel" CssClass="name" Text='<%# Eval("Subject")%>'></asp:Label>
                                                                    <asp:Label runat="server" ID="TimeLabel" CssClass="time"  Text='<%# Eval("StartDate","{0:hh:mm}")+ " - " + Eval("EndDate","{0:hh:mm}")%>'></asp:Label>
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

<%--                             <asp:Label ID="TodaysMeetingLabel" CssClass="title" runat="server" >Meeting Notification</asp:Label>--%>
<%--                            <asp:ObjectDataSource ID="MiniMeetingObjectDataSource" runat="server"
                                SelectMethod="GetTodaysMeetings" TypeName="C3App.BLL.MeetingBL" DataObjectTypeName="C3App.DAL.Meeting">
                               </asp:ObjectDataSource>--%>

<%--                            <asp:GridView ID="ViewMeetingsGridView"
                                runat="server" CssClass="list-form" AutoGenerateColumns="False" GridLines="None" OnInit="ViewMeetingsGridView_Init"
                                DataKeyNames="MeetingID" ShowHeader="false">
                                <EmptyDataTemplate>
                                    <p>
                                        You have no scheduled meeting today...
                                    </p>
                                </EmptyDataTemplate>
                                
                                <Columns>

                                    <asp:TemplateField>
                                        <ItemTemplate>
                                                <%# Eval("Subject") %>
                                            <asp:Label ID="MeetingTimeLabel" runat="server" Text=' <%# Eval("StartDate","{0:hh:mm}")+ " - " + Eval("EndDate","{0:hh:mm}")%>'/>
                                            <asp:Label ID="LocationLabel" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                          </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>--%>

            </asp:Panel>
        </asp:Panel>

    </asp:Panel>
    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel78" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="Literal1" runat="server" Text=""></asp:Literal></h4>
                <a class="close-reveal-modal">&#215;</a>
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>

