<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Employee.aspx.cs" Inherits="TimeTrexApp.Employee.Employee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

 <asp:Panel ID="Panel4" runat="server" CssClass="row">        
      <asp:Label ID="Label2" runat="server" CssClass="page-title">Employee List</asp:Label>
  </asp:Panel>

    <asp:Panel ID="Panel3" runat="server" CssClass="row">
    <asp:GridView ID="EmployeeListGridView" runat="server" CssClass="form-grid"></asp:GridView>
</asp:Panel>

</asp:Content>
