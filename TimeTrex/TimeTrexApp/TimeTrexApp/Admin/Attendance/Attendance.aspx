<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Attendance.aspx.cs" Inherits="TimeTrexApp.Attendance.Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="Panel4" runat="server" CssClass="row">
        <asp:Label ID="Label1" runat="server" CssClass="page-title">All TimeSheet</asp:Label>
    </asp:Panel>

    <asp:Panel runat="server" CssClass="row">
        <asp:Label ID="Label2" runat="server" CssClass="form-label">Select Employee</asp:Label>
        <asp:DropDownList ID="EmployeeDropDownList" runat="server" CssClass="form-input" AutoPostBack="true" OnSelectedIndexChanged="EmployeeDropDownList_SelectedIndexChanged">
            <asp:ListItem Value="0" Text="--Select--" />
        </asp:DropDownList>
    </asp:Panel>




    <asp:Panel ID="Panel2" runat="server" CssClass="row">
        <asp:Label ID="Label4" runat="server" CssClass="form-label">Select Year</asp:Label>
        <asp:DropDownList ID="YearDropDownList" runat="server" CssClass="form-input" AutoPostBack="true" OnSelectedIndexChanged="YearDropDownList_SelectedIndexChanged">
            <asp:ListItem Value="0" Text="--Select--" />
        </asp:DropDownList>
    </asp:Panel>



    <asp:Panel ID="Panel1" runat="server" CssClass="row">
        <asp:Label ID="Label3" runat="server" CssClass="form-label">Select Month</asp:Label>
        <asp:DropDownList ID="MonthDropDownList" runat="server" CssClass="form-input" AutoPostBack="true" OnSelectedIndexChanged="MonthDropDownList_SelectedIndexChanged">
            <asp:ListItem Value="0" Text="--Select--" />

        </asp:DropDownList>
    </asp:Panel>




    <%--<asp:Panel ID="Panel1" runat="server" CssClass="row">
    <asp:GridView ID="DailyAttendanceListGridView" runat="server" CssClass="form-grid"></asp:GridView>
</asp:Panel>

<asp:Panel ID="Panel2" runat="server" CssClass="row">
    <asp:GridView ID="DailyAttendanceGridView" runat="server" CssClass="form-grid"></asp:GridView>
</asp:Panel>--%>

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
