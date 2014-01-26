<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="TimeTrexApp.Attendance.Attendance1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="Panel4" runat="server" CssClass="row">
        <asp:Label ID="Label1" runat="server" CssClass="page-title">My TimeSheet</asp:Label>
    </asp:Panel>

    <asp:Panel ID="Panel1" runat="server" CssClass="row">
        <asp:Label ID="Label3" runat="server" CssClass="form-label">Select Month</asp:Label>
        <asp:DropDownList ID="MonthDropDownList" runat="server" CssClass="form-input" AutoPostBack="true" OnSelectedIndexChanged="MonthDropDownList_SelectedIndexChanged">
        </asp:DropDownList>
    </asp:Panel>

    <asp:Panel ID="Panel3" runat="server" CssClass="row">
        <asp:GridView ID="DailyAttendanceGridViewByCard" runat="server" CssClass="form-grid" OnRowDataBound="DailyAttendanceGridViewByCard_RowDataBound">
            <EmptyDataTemplate>
                <p>
                    No Record Found...
                </p>
            </EmptyDataTemplate>
        </asp:GridView>
    </asp:Panel>


</asp:Content>
