<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Leads1.aspx.cs" Inherits="C3App.Leads.Leads1" %>

<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">

    <asp:Panel ID="DetailsPanel" SkinID="InactiveTab" runat="server" tab-id="1">

        <asp:Button runat="server" ID="UpdateTab1" SkinID="TabTitle" OnClick="UpdateButton_Click" Text="Tab1" OnClientClick="GoToTab('1')" />

        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">

            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="UpdateTab1" EventName="Click" />
                      <asp:AsyncPostBackTrigger ControlID="LeadInsertButton" EventName="Click" />

                </Triggers>
                <ContentTemplate>
                    <%-- 
                        Place your DetialsPanel Content Here 
                    --%>
                    <asp:ObjectDataSource ID="LeadsObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Lead" InsertMethod="InsertLeads" SelectMethod="leadByID" 
                        TypeName="C3App.BLL.LeadBL" UpdateMethod="UpdateLeads">
                        
                        
                         <SelectParameters>
                            <asp:SessionParameter SessionField="LeadID" Name="LeadID" Type="Int32"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>
               
                    <asp:DetailsView ID="LeadsDetailsView" runat="server"  AutoGenerateRows="False" DataSourceID="LeadsObjectDataSource"  OnItemInserting="LeadDetailsView_ItemInserting" DataKeyNames="LeadID,CompanyID,CreatedTime" OnItemUpdating="LeadDetailsView_ItemUpdating" >
                        <Fields>
                            <asp:TemplateField HeaderText="Lead Source" SortExpression="LeadSourceID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="LeadsourcesDataSource" runat="server" 
                                        DataObjectTypeName="C3App.DAL.LeadSource" SelectMethod="GetLeadSources" TypeName="C3App.BLL.LeadBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="LeadSourcesDropDownList" runat="server" DataSourceID="LeadsourcesDataSource" 
                                        DataTextField="Value" DataValueField="LeadSourceID" OnInit="leadSourcesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="LeadsourcesDataSource" runat="server" DataObjectTypeName="C3App.DAL.LeadSource" 
                                        SelectMethod="GetLeadSources" TypeName="C3App.BLL.LeadBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="LeadSourcesDropDownList" runat="server" DataSourceID="LeadsourcesDataSource" 
                                        DataTextField="Value" DataValueField="LeadSourceID" OnInit="leadSourcesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="LeadSourceDescripsion" HeaderText="Lead Source Descripsion" SortExpression="LeadSourceDescripsion" />
                            <asp:BoundField DataField="ReferredBy" HeaderText="ReferredBy" SortExpression="ReferredBy" />
                            <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="ContactsDataSource" runat="server" 
                                        DataObjectTypeName="C3App.DAL.Contact" SelectMethod="GetContacts" TypeName="C3App.BLL.ContactBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="ContactsDropDownList" runat="server" 
                                        DataSourceID="ContactsDataSource" DataTextField="FirstName" DataValueField="ContactID" OnInit="ContactsDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="ContactsDataSource" runat="server" DataObjectTypeName="C3App.DAL.Contact" 
                                        SelectMethod="GetContacts" TypeName="C3App.BLL.ContactBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="ContactsDropDownList" runat="server" DataSourceID="ContactsDataSource" 
                                        DataTextField="FirstName" DataValueField="ContactID" OnInit="ContactsDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                            <asp:TemplateField HeaderText="Account Name" SortExpression="AccountID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AccountsDataSource" runat="server" DataObjectTypeName="C3App.DAL.Account" 
                                        SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AccountsDropDownList" runat="server" DataSourceID="AccountsDataSource" 
                                        DataTextField="Name" DataValueField="AccountID" OnInit="AccountsDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="AccountsDataSource" runat="server" DataObjectTypeName="C3App.DAL.Account" 
                                        SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AccountsDropDownList" runat="server" DataSourceID="AccountsDataSource" 
                                        DataTextField="Name" DataValueField="AccountID" OnInit="AccountsDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                            <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
                            <asp:CheckBoxField DataField="DoNotCall" HeaderText="DoNotCall" SortExpression="DoNotCall" />
                            <asp:TemplateField HeaderText="Teams" SortExpression="TeamID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TeamDataSource" runat="server" DataObjectTypeName="C3App.DAL.Team" 
                                        SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsDropDownList" runat="server" DataSourceID="TeamDataSource" 
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="TeamDataSource" runat="server" DataObjectTypeName="C3App.DAL.Team" 
                                        SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsDropDownList" runat="server" DataSourceID="TeamDataSource" 
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignToDataSource" runat="server" DataObjectTypeName="C3App.DAL.User" 
                                        SelectMethod="GetUserList" TypeName="C3App.DAL.UserRepository"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssignedToDropDownList" runat="server" DataSourceID="AssignToDataSource" 
                                        DataTextField="UserName" DataValueField="UserID" OnInit="AssignedToUsersDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="AssignToDataSource" runat="server" DataObjectTypeName="C3App.DAL.User" 
                                        SelectMethod="GetUserList" TypeName="C3App.DAL.UserRepository"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssignedToDropDownList" runat="server" DataSourceID="AssignToDataSource" 
                                        DataTextField="UserName" DataValueField="UserID" OnInit="AssignedToUsersDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website" />
                            <asp:TemplateField HeaderText="Status" SortExpression="LeadStatusID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="LeadStatusesDataSource" runat="server" DataObjectTypeName="C3App.DAL.LeadStatus" 
                                        SelectMethod="GetLeadStatus" TypeName="C3App.BLL.LeadBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="LeadStatusesDropDownList" runat="server" DataSourceID="LeadStatusesDataSource" 
                                        DataTextField="Value" DataValueField="LeadStatusID" OnInit="LeadStatusesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="LeadStatusesDataSource" runat="server" DataObjectTypeName="C3App.DAL.LeadStatus" 
                                        SelectMethod="GetLeadStatus" TypeName="C3App.BLL.LeadBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="LeadStatusesDropDownList" runat="server" DataSourceID="LeadStatusesDataSource"
                                         DataTextField="Value" DataValueField="LeadStatusID" OnInit="LeadStatusesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="StatusDescription" HeaderText="Status Description" SortExpression="StatusDescription" />
                            <asp:BoundField DataField="PhoneWork" HeaderText="Office Phone" SortExpression="PhoneWork" />
                            <asp:BoundField DataField="PhoneMobile" HeaderText="Mobile Phone" SortExpression="PhoneMobile" />
                            <asp:BoundField DataField="PhoneHome" HeaderText="Home Phone" SortExpression="PhoneHome" />
                            <asp:BoundField DataField="PhoneOther" HeaderText="Other Phone" SortExpression="PhoneOther" />
                            <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax" />
                            <asp:BoundField DataField="Email1" HeaderText="Email Address" SortExpression="Email1" />
                            <asp:CheckBoxField DataField="EmailOptOut" HeaderText="EmailOptOut" SortExpression="EmailOptOut" />
                            <asp:BoundField DataField="Email2" HeaderText="Other Email Address" SortExpression="Email2" />
                            <asp:CheckBoxField DataField="InvalidEmail" HeaderText="InvalidEmail" SortExpression="InvalidEmail" />
                            <asp:BoundField DataField="PrimaryAddressStreet" HeaderText="PrimaryStreet" SortExpression="PrimaryAddressStreet" />
                            <asp:BoundField DataField="PrimaryAddressCity" HeaderText="City" SortExpression="PrimaryAddressCity" />
                            <asp:BoundField DataField="PrimaryAddressState" HeaderText="State" SortExpression="PrimaryAddressState" />
                            <asp:BoundField DataField="PrimaryAddressPostalCode" HeaderText="Postal Code" SortExpression="PrimaryAddressPostalCode" />
                            <asp:BoundField DataField="PrimaryAddressCountry" HeaderText="Country" SortExpression="PrimaryAddressCountry" />
                            <asp:BoundField DataField="ALTAddressStreet" HeaderText="Alternate Street" SortExpression="ALTAddressStreet" />
                            <asp:BoundField DataField="ALTAddressCity" HeaderText="City" SortExpression="ALTAddressCity" />
                            <asp:BoundField DataField="ALTAddressState" HeaderText="State" SortExpression="ALTAddressState" />
                            <asp:BoundField DataField="ALTAddressPostalCode" HeaderText="Postal Code" SortExpression="ALTAddressPostalCode" />
                            <asp:BoundField DataField="ALTAddressCountry" HeaderText="Country" SortExpression="ALTAddressCountry" />
                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                        </Fields>
                    </asp:DetailsView>
                    
                     </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>

    </asp:Panel>

    <asp:Panel ID="ViewPanel" SkinID="InactiveTab" runat="server" tab-id="2">

        <asp:Button runat="server" ID="UpdateTab2" SkinID="TabTitle" OnClick="UpdateButton_Click" Text="Tab2" OnClientClick="GoToTab('2')" />        

        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">

            <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="UpdateTab2" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                        SearchPanel
                        <%-- 
                            Place your SearchPanel Content Here 
                        --%>
                         <asp:Label ID="Label2" runat="server" Text="Enter any part of Leads Name :  "></asp:Label>
                        <asp:TextBox ID="SearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="SearchTextBox_TextChanged"></asp:TextBox>
                        <asp:Button ID="SearchButton" runat="server" OnClick="SearchButton_Click" Text="Search" />
                    </asp:Panel>

                    <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">
                        ListPanel
                        <%-- 
                            Place your ListPanel Content Here 
                        --%>
                                                                         <asp:Button ID="LeadInsertButton" runat="server" Text="Create New Lead" CommandArgument="Insert" OnClientClick="GoToTab(1);" 
                             OnClick="LeadInsertButton_Click"   />

                         <asp:ObjectDataSource ID="ListPanelObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Lead" DeleteMethod="DeleteLeads" SelectMethod="SearchLeads" TypeName="C3App.BLL.LeadBL" >
                            <SelectParameters>
                                <asp:ControlParameter ControlID="SearchTextBox" Name="search" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:GridView ID="LeadsGridView" runat="server" AutoGenerateColumns="False"
                            DataKeyNames="Email1,LeadID"
                            DataSourceID="ListPanelObjectDataSource" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>

                                <%--  <asp:ImageField HeaderText="Image" DataImageUrlField="Image" ControlStyle-Width="28" ControlStyle-Height="28" />--%>

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" Text="" CommandName="Select" CausesValidation="False">
                   
                   
                     <%# Eval("Contact.FirstName") %>  
                                            <%# Eval("Account.Name") %>
                        <br />
                       <%# Eval("Email1") %>
                                        </asp:LinkButton>
                                    </ItemTemplate>

                                </asp:TemplateField>
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>

                    </asp:Panel>

                    <asp:Panel ID="MiniDetialPanel" SkinID="MiniDetailPanel" runat="server">

                        <asp:Panel ID="MiniDetailBasicPanel" SkinID="MiniDetailBasicPanel" runat="server">
                            MiniDetailPanel
                            <%-- 
                                Place your MiniDetailPanel Content Here 
                            --%>
                             <asp:ObjectDataSource ID="MiniLeadsObjectDataSource" runat="server"
                                DataObjectTypeName="C3App.DAL.Lead" DeleteMethod="DeleteLeads"
                                 SelectMethod="SearchLeads" TypeName="C3App.BLL.LeadBL"
                                UpdateMethod="UpdateLeads">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="LeadsGridView" Name="search" Type="String" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:ObjectDataSource>



                            <asp:FormView ID="MiniLeadsFormView" runat="server" DataSourceID="MiniLeadsObjectDataSource"
                                DataKeyNames="Email1,LeadID">

                                <EmptyDataTemplate>
                                    <p>
                                        No Lead selected.
                                    </p>
                                </EmptyDataTemplate>

                                <ItemTemplate>
                                    <b>Account Name: </b>
                                    <%# Eval("Account.Name") %>
                                    <br />

                                    <b>Title: </b>
                                    <%# Eval("Title") %>
                                    <br />
                                    <b>City: </b>
                                    <%# Eval("PrimaryAddressCity") %>
                                    <br />
                                    <b>Country: </b>
                                    <%# Eval("PrimaryAddressCountry") %>
                               <asp:Button ID="OpportunityEditButton" runat="server" Text="Edit" CommandArgument='<%# Eval("LeadID") %>' OnClientClick="GoToTab(1);" 
                                   OnClick="LeadEditButton_Click"   />
                                   <asp:Button ID="DeleteButton" runat="server" Text="Delete" Visible="False"  OnClientClick="GoToTab(2);" OnClick="deleteButton1_Click" />

                                </ItemTemplate>
                            </asp:FormView>
                            <asp:Button runat="server" ID="ModalPopButton1" SkinID="ModalPopButton" OnClick="UpdateButton_Click" Text="Open Modal Left" OnClientClick="OpenModal('BodyContent_ModalPanel1')" />
                            <asp:Button runat="server" ID="ModalPopButton2" SkinID="ModalPopButton" OnClick="UpdateButton_Click" Text="Open Modal Right" OnClientClick="OpenModal('BodyContent_ModalPanel2')" />
                        </asp:Panel>

                        <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                            MiniDetailMorePanel
                            <%-- 
                                Place your MiniDetailMorePanel Content Here 
                            --%>
                             <asp:DetailsView ID="MiniMoreLeadsDetailsView" runat="server" AutoGenerateRows="False" DataSourceID="MiniLeadsObjectDataSource"
                                 DataKeyNames="Email1,LeadID">
                                <EmptyDataTemplate>
                                    <p>
                                        No course selected.
                                    </p>
                                </EmptyDataTemplate>
                                <Fields>
                                    
                                    <asp:BoundField DataField="LeadSourceDescripsion" HeaderText="LeadSourceDescripsion" SortExpression="LeadSourceDescripsion" />
                                    <asp:BoundField DataField="ReferredBy" HeaderText="ReferredBy" SortExpression="ReferredBy" />
                                    <asp:BoundField DataField="Email1" HeaderText="Primary Email" SortExpression="Email1" />
                                    <asp:TemplateField HeaderText="Account Name" SortExpression="Account.Name">
                                       
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Eval("Account.Name") %>' ID="Label1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Assigned User" SortExpression="User.UserName">
                                        
                                        <ItemTemplate>
                                            <asp:Label runat="server" Text='<%# Eval("User.UserName") %>' ID="Label2"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="CreatedTime" HeaderText="CreatedTime" SortExpression="CreatedTime" />
                                    <asp:BoundField DataField="ModifiedTime" HeaderText="ModifiedTime" SortExpression="ModifiedTime" />
                                </Fields>
                            </asp:DetailsView>
                        </asp:Panel>

                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>

    </asp:Panel>

    <asp:Panel ID="ModalPanel1" SkinID="ModalPopLeft" runat="server">
        <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

        <asp:UpdatePanel runat="server" ID="UpdatePanel3">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ModalPopButton1" EventName="Click" />
            </Triggers>
            <ContentTemplate>
                <asp:Label ID="ModalLabel" runat="server" SkinID="ModalTitle" Text="Modal Title"></asp:Label>
                <asp:Panel ID="ModalCreatePanel" SkinID="ModalCreatePanel" runat="server">
                    Create Panel
                        <%-- 
                            Place your Create Panel Content Here 
                        --%>
                </asp:Panel>
                <asp:Panel ID="ModalSearchPanel" SkinID="ModalSearchPanel" runat="server">
                    Search Panel
                        <%-- 
                            Place your Search Panel Content Here 
                        --%>
                </asp:Panel>
                <asp:Panel ID="ModalListPanel" SkinID="ModalListPanel" runat="server">
                    List Panel
                        <%-- 
                            Place your List Panel Content Here 
                        --%>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>

    </asp:Panel>

    <asp:Panel ID="ModalPanel2" SkinID="ModalPopRight" runat="server">
        <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

        <asp:UpdatePanel runat="server" ID="UpdatePanel4">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="ModalPopButton2" EventName="Click" />
            </Triggers>
            <ContentTemplate>
                <asp:Label ID="Label1" runat="server" SkinID="ModalTitle" Text="Modal Title"></asp:Label>
                <asp:Panel ID="Panel2" SkinID="ModalCreatePanel" runat="server">
                    Create Panel
                        <%-- 
                            Place your Create Panel Content Here 
                        --%>
                </asp:Panel>
                <asp:Panel ID="Panel3" SkinID="ModalSearchPanel" runat="server">
                    Search Panel
                        <%-- 
                            Place your Search Panel Content Here 
                        --%>
                </asp:Panel>
                <asp:Panel ID="Panel4" SkinID="ModalListPanel" runat="server">
                    List Panel
                        <%-- 
                            Place your List Panel Content Here 
                        --%>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>

    </asp:Panel>

</asp:Content>
