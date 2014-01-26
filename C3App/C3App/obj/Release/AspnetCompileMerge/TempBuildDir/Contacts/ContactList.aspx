<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="ContactList.aspx.cs" Inherits="C3App.Contacts.ContactList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <p>
Enter any part of Contact to see all Contacts: <asp:TextBox ID="SearchTextBox" runat="server" AutoPostBack="true"></asp:TextBox>
        <asp:Button ID="SearchButton" runat="server" Text="Search" />
    </p>

    <h4>Contacts List</h4>

    <asp:ObjectDataSource ID="ContactsObjectDataSource" runat="server" 
        DataObjectTypeName="C3App.DAL.Contact"
        TypeName="C3App.BLL.ContactBL"
        DeleteMethod="DeleteContact"
        SelectMethod="GetContactByName"
        UpdateMethod="UpdateContact">
         <SelectParameters>
            <asp:ControlParameter ControlID="SearchTextBox" Name="nameSearchString" PropertyName="Text"
                Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>

    <asp:GridView ID="ContactsGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ContactID,CreatedTime" OnRowUpdating="ContactsGridView_RowUpdating"
 DataSourceID="ContactsObjectDataSource">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
             <asp:TemplateField HeaderText="Contacts" SortExpression="Contacts">
            <ItemTemplate>
                 <a href ='<%#"ContactDetails.aspx?ContactID="+DataBinder.Eval(Container.DataItem,"ContactID") %>'> Select </a>
            </ItemTemplate>
             </asp:TemplateField>
            <asp:TemplateField HeaderText="Name" SortExpression="FirstName">
                <EditItemTemplate>
                    <asp:TextBox ID="FirstNameTxt" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Bind("FirstName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
         
            <asp:TemplateField HeaderText="Account" SortExpression="Account.Name">
                <EditItemTemplate>
                <asp:ObjectDataSource ID="AccountNameObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" 
                        SelectMethod="GetAccounts" 
                        DataObjectTypeName="C3App.DAL.Account">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="AccountNameDropDownList" runat="server" DataSourceID="AccountNameObjectDataSource"
                        DataTextField="Name" DataValueField="AccountID" OnInit="AccountNameDropDownList_Init">
                    </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>              
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Account.Name") %>'></asp:Label>
                   </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Title" SortExpression="Title">
                <EditItemTemplate>
                    <asp:TextBox ID="TitleTxt" runat="server" Text='<%# Bind("Title") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="TitleLabel" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Team" SortExpression="Team.Name">
                <EditItemTemplate>
                <asp:ObjectDataSource ID="TeamNameObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" 
                        SelectMethod="GetTeams" 
                        DataObjectTypeName="C3App.DAL.Team">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="TeamNameDropDownList" runat="server" DataSourceID="TeamNameObjectDataSource"
                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamNameDropDownList_Init">
                    </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>              
                    <asp:Label ID="TeamLabel" runat="server" Text='<%# Eval("Team.Name") %>'></asp:Label>
                   </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Assigned" SortExpression="User.UserName">
                <EditItemTemplate>
                <asp:ObjectDataSource ID="UserNameObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" 
                        SelectMethod="GetUsers" 
                        DataObjectTypeName="C3App.DAL.User">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="UserNameDropDownList" runat="server" DataSourceID="UserNameObjectDataSource"
                        DataTextField="UserName" DataValueField="UserID" OnInit="UserNameDropDownList_Init">
                    </asp:DropDownList>
                    </EditItemTemplate>
                    <ItemTemplate>              
                    <asp:Label ID="UserLabel" runat="server" Text='<%# Eval("User.UserName") %>'></asp:Label>
                   </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Phone" SortExpression="OfficePhone">
                <EditItemTemplate>
                    <asp:TextBox ID="OfficePhoneTxt" runat="server" Text='<%# Bind("OfficePhone") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="OfficePhoneLabel" runat="server" Text='<%# Bind("OfficePhone") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Email" SortExpression="EmailAddress">
                <EditItemTemplate>
                    <asp:TextBox ID="EmailAddressTxt" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="EmailAddressLabel" runat="server" Text='<%# Bind("EmailAddress") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Modified Time" SortExpression="ModifiedTime">
                <EditItemTemplate>
                    <asp:TextBox ID="ModifiedTimeTxt" runat="server" Text='<%# Bind("ModifiedTime") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ModifiedTimeLabel" runat="server" Text='<%# Bind("ModifiedTime") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>
