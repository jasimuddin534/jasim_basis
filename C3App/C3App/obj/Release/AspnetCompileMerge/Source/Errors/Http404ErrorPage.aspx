<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Http404ErrorPage.aspx.cs" Inherits="C3App.Errors.Http404ErrorPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <h2>
      HTTP 404 Error Page</h2>
    Standard error message suitable for file not found errors. 
    The original exception object is not available, 
    but the original requested URL is in the query string.<br />
    <br />
    Return to the <a href='Default.aspx'> Default Page</a>
</asp:Content>
