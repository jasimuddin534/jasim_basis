<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="AccountList.aspx.cs" Inherits="C3App.Accounts.AccountList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<%--<asp:Content ID="Content3" ContentPlaceHolderID="ContentTitle" runat="server">Account Details</asp:Content>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
   

     <asp:Label ID="Label1" runat="server" Text="Serch account information :  "></asp:Label>
     <br/>
         <asp:TextBox ID="searchTextBox" runat="server" AutoPostBack="True" OnTextChanged="searchTextBox_TextChanged"></asp:TextBox>
         <asp:Button ID="searchButton" runat="server" OnClick="searchButton_Click" Text="search" />
    
    <br />
    <br />

    <asp:ObjectDataSource runat="server" ID="accountsObjectDataSource" TypeName="C3App.BLL.AccountBL"
        DataObjectTypeName="C3App.DAL.Account" InsertMethod="InsertAccount" SelectMethod="SearchAccount">
         <SelectParameters>
              <asp:ControlParameter ControlID="searchTextBox" Name="search" PropertyName="Text" Type="String" />
          </SelectParameters>
    </asp:ObjectDataSource>
    
    
    <asp:GridView ID="accountsGridView" runat="server" AutoGenerateColumns="False" DataSourceID="accountsObjectDataSource">
        <Columns>
            <asp:TemplateField HeaderText="Accounts" SortExpression="Accounts">
            <ItemTemplate>
                 <a href ='<%#"AccountDetails.aspx?AccountID="+DataBinder.Eval(Container.DataItem,"AccountID") %>'> Select </a>
            </ItemTemplate>
             </asp:TemplateField>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            
        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
        <asp:BoundField DataField="BillingCity" HeaderText="BillingCity" SortExpression="BillingCity" />
        <asp:BoundField DataField="BillingState" HeaderText="BillingState" SortExpression="BillingState" />
        <asp:BoundField DataField="OfficePhone" HeaderText="Phone" SortExpression="OfficePhone" />
        <asp:BoundField DataField="AssignedUserID" HeaderText="Assigned To" SortExpression="AssignedUserID" />
        <asp:BoundField DataField="TeamID" HeaderText="Team" SortExpression="TeamID" />
           
            
        </Columns>
    </asp:GridView>

</asp:Content>
