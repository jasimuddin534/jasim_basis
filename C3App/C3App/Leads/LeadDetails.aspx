<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="LeadDetails.aspx.cs" Inherits="C3App.Leads.LeadDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DataObjectTypeName="C3App.DAL.Lead" InsertMethod="InsertLeads" SelectMethod="GetLeads" TypeName="C3App.BLL.LeadBL" DeleteMethod="DeleteLeads" UpdateMethod="UpdateLeads"></asp:ObjectDataSource>
    <asp:DetailsView ID="leadDetailsView" runat="server" AutoGenerateRows="False" DataSourceID="ObjectDataSource1" Height="49px" Width="733px"  OnItemInserting="leadDetailsView_ItemInserting" DataKeyNames="LeadID,CompanyID,CreatedTime" OnItemUpdating="leadDetailsView_ItemUpdating"  >
        <Fields>
            <asp:TemplateField HeaderText="Lead Source" SortExpression="LeadSourceID">
                <EditItemTemplate>
                    <asp:ObjectDataSource ID="leadsourceDataSource2" runat="server" 
                        SelectMethod="GetLeadSources" TypeName="C3App.BLL.LeadBL" 
                         DataObjectTypeName="C3App.DAL.LeadSource" >

                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="leadSourceDropDownList" runat="server" 
                        DataSourceID="leadsourceDataSource2"
                         DataTextField="Value" DataValueField="LeadSourceID"
                        OnInit="leadSourceDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate> 
                    <InsertItemTemplate>
                    <asp:ObjectDataSource ID="leadsourceDataSource2" runat="server" 
                        SelectMethod="GetLeadSources" TypeName="C3App.BLL.LeadBL" 
                         DataObjectTypeName="C3App.DAL.LeadSource" >

                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="leadSourceDropDownList" runat="server" 
                        DataSourceID="leadsourceDataSource2"
                         DataTextField="Value" DataValueField="LeadSourceID"
                        OnInit="leadSourceDropDownList_Init">
                    </asp:DropDownList>


                </InsertItemTemplate> 
            </asp:TemplateField>
            <asp:BoundField DataField="LeadSourceDescripsion" HeaderText="Lead Source Descripsion" SortExpression="LeadSourceDescripsion" />
            <asp:BoundField DataField="ReferredBy" HeaderText="ReferredBy" SortExpression="ReferredBy" />
            <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
                <EditItemTemplate>
                    <asp:ObjectDataSource ID="contactDataSource" runat="server" 
                        SelectMethod="GetContacts" TypeName="C3App.BLL.ContactBL" 
                        DataObjectTypeName="C3App.DAL.Contact" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="contactDropDownList" runat="server" 
                        DataSourceID="contactDataSource"
                        DataTextField="FirstName" DataValueField="ContactID" 
                        OnInit="contactDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate> 
                     <InsertItemTemplate>
                    <asp:ObjectDataSource ID="contactDataSource" runat="server" 
                        SelectMethod="GetContacts" TypeName="C3App.BLL.ContactBL" 
                        DataObjectTypeName="C3App.DAL.Contact" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="contactDropDownList" runat="server" 
                        DataSourceID="contactDataSource"
                        DataTextField="FirstName" DataValueField="ContactID" 
                        OnInit="contactDropDownList_Init">
                    </asp:DropDownList><asp:TextBox ID="TextBox1" Text='<%# Eval("FirstName") %>' runat="server"></asp:TextBox><asp:Button  runat="server" ID="button" Text="Select"/>  
                </InsertItemTemplate> 
                   
            </asp:TemplateField>
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
            <asp:TemplateField HeaderText="Account Name" SortExpression="AccountID">
                <EditItemTemplate>
                    <asp:ObjectDataSource ID="accountDataSource" runat="server" 
                        SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL" 
                        DataObjectTypeName="C3App.DAL.Account" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="accountDropDownList" runat="server" 
                        DataSourceID="accountDataSource"
                        DataTextField="Name" DataValueField="AccountID" 
                        OnInit="accountDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate> 
                     <InsertItemTemplate>
                    <asp:ObjectDataSource ID="accountDataSource" runat="server" 
                        SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL" 
                        DataObjectTypeName="C3App.DAL.Account" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="accountDropDownList" runat="server" 
                        DataSourceID="accountDataSource"
                        DataTextField="Name" DataValueField="AccountID" 
                        OnInit="accountDropDownList_Init">
                    </asp:DropDownList><asp:TextBox ID="TextBox2" runat="server"></asp:TextBox><asp:Button runat="server" ID="button1" Text="Select"/>  
                </InsertItemTemplate> 
            </asp:TemplateField>
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />
            <asp:CheckBoxField DataField="DoNotCall" HeaderText="DoNotCall" SortExpression="DoNotCall" />
            <asp:TemplateField HeaderText="Teams" SortExpression="TeamID">
                <EditItemTemplate>
                    <asp:ObjectDataSource ID="teamDataSource3" runat="server" 
                        SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL" 
                        DataObjectTypeName="C3App.DAL.Team" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="teamsDropDownList" runat="server" 
                        DataSourceID="teamDataSource3"
                        DataTextField="Name" DataValueField="TeamID" 
                        OnInit="teamsDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>
                     <InsertItemTemplate>
                    <asp:ObjectDataSource ID="teamDataSource3" runat="server" 
                        SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL" 
                        DataObjectTypeName="C3App.DAL.Team" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="teamsDropDownList" runat="server" 
                        DataSourceID="teamDataSource3"
                        DataTextField="Name" DataValueField="TeamID" 
                        OnInit="teamsDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
               <EditItemTemplate>
                    <asp:ObjectDataSource ID="AssignToDataSource4" runat="server" 
                        SelectMethod="GetUserList" TypeName="C3App.DAL.UserRepository" 
                        DataObjectTypeName="C3App.DAL.User" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="assignedToDropDownList" runat="server" 
                        DataSourceID="AssignToDataSource4"
                        DataTextField="UserName" DataValueField="UserID" 
                        OnInit="assignedToDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>
                    <InsertItemTemplate>
                    <asp:ObjectDataSource ID="AssignToDataSource4" runat="server" 
                        SelectMethod="GetUserList" TypeName="C3App.DAL.UserRepository" 
                        DataObjectTypeName="C3App.DAL.User" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="assignedToDropDownList" runat="server" 
                        DataSourceID="AssignToDataSource4"
                        DataTextField="UserName" DataValueField="UserID" 
                        OnInit="assignedToDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website"/>
            <asp:TemplateField HeaderText="Status" SortExpression="LeadStatusID">
                <EditItemTemplate>
                     <asp:ObjectDataSource ID="leadStatusDataSource4" runat="server" 
                        SelectMethod="GetLeadStatus" TypeName="C3App.BLL.LeadBL" 
                        DataObjectTypeName="C3App.DAL.LeadStatus" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="leadStatusDropDownList" runat="server" 
                        DataSourceID="leadStatusDataSource4"
                        DataTextField="Value" DataValueField="LeadStatusID" 
                        OnInit="leadStatusDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>
                <InsertItemTemplate>
                     <asp:ObjectDataSource ID="leadStatusDataSource4" runat="server" 
                        SelectMethod="GetLeadStatus" TypeName="C3App.BLL.LeadBL" 
                        DataObjectTypeName="C3App.DAL.LeadStatus" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="leadStatusDropDownList" runat="server" 
                        DataSourceID="leadStatusDataSource4"
                        DataTextField="Value" DataValueField="LeadStatusID" 
                        OnInit="leadStatusDropDownList_Init">
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
            <asp:BoundField DataField="PrimaryAddressCountry"  HeaderText="Country" SortExpression="PrimaryAddressCountry"/>
            <asp:BoundField DataField="ALTAddressStreet" HeaderText="Alternate Street" SortExpression="ALTAddressStreet" />
            <asp:BoundField DataField="ALTAddressCity" HeaderText="City" SortExpression="ALTAddressCity" />
            <asp:BoundField DataField="ALTAddressState" HeaderText="State" SortExpression="ALTAddressState" />
            <asp:BoundField DataField="ALTAddressPostalCode" HeaderText="Postal Code" SortExpression="ALTAddressPostalCode" />
            <asp:BoundField DataField="ALTAddressCountry" HeaderText="Country" SortExpression="ALTAddressCountry" />
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
            <asp:CommandField ShowInsertButton="True"/>
            <asp:CommandField ShowEditButton="True"/>
        </Fields>
    </asp:DetailsView>

         <asp:Button ID="updateButton" runat="server" Text="Update" Visible="False" OnClick="updateButton_Click"/>
         <asp:Button ID="deleteButton" runat="server" Text="Delete" Visible="False" OnClick="deleteButton_Click" />
    
         </asp:Content>
