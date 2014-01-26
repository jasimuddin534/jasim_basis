<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="inouts.aspx.cs" Inherits="TimeTrexApp.Admin.Attendance.inouts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <asp:Panel ID="Panel4" runat="server" CssClass="row">
        <asp:Label ID="pagetitle" runat="server" CssClass="page-title"></asp:Label>
    </asp:Panel>
 

     <asp:Panel ID="Panel3" runat="server" CssClass="row"> 
        <asp:GridView ID="inoutsGridView" runat="server" CssClass="form-grid" >
            <EmptyDataTemplate>
                <p>
                    No Record Found...
                </p>
            </EmptyDataTemplate>
        </asp:GridView>
         <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
    </asp:Panel>

    <asp:Panel ID="Panel1" runat="server">
        <div style="text-align: center">
            <input type="button" value="Back" onclick="window.history.back(); return true;">
        </div>
    </asp:Panel>
</asp:Content>
