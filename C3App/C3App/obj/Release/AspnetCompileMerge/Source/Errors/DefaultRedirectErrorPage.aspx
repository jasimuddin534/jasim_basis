<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="DefaultRedirectErrorPage.aspx.cs" Inherits="C3App.Errors.DefaultRedirectErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <h2>
      DefaultRedirect Error Page</h2>
    Standard error message suitable for all unhandled errors. 
    The original exception object is not available.<br />
    <br />
    Return to the <a href='~/Dashboard.aspx'> Default Page</a>
</asp:Content>
