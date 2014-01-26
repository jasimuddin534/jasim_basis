<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Modules.aspx.cs" Inherits="C3App.Administration.Modules.Modules" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    <br /><br /><br />

        <div style="width:95%;height:90%;overflow:auto;">
              <asp:EntityDataSource ID="ModuleEntityDataSource" runat="server" ConnectionString="name=C3Entities" DefaultContainerName="C3Entities" EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True" EntitySetName="Modules"></asp:EntityDataSource>

            <asp:GridView ID="ModuleGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="ModuleID" DataSourceID="ModuleEntityDataSource" CellPadding="4" ForeColor="#333333" GridLines="None" AllowPaging="True">
        <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
        <Columns>
            <asp:CommandField ShowEditButton="True"></asp:CommandField>
            <asp:BoundField DataField="ModuleID" HeaderText="ModuleID" SortExpression="ModuleID" ReadOnly="True"></asp:BoundField>
            <asp:BoundField DataField="ModuleName" HeaderText="ModuleName" SortExpression="ModuleName"></asp:BoundField>
            <asp:BoundField DataField="DisplayName" HeaderText="DisplayName" SortExpression="DisplayName"></asp:BoundField>
            <asp:BoundField DataField="ModuleOrder" HeaderText="ModuleOrder" SortExpression="ModuleOrder"></asp:BoundField>
            <asp:BoundField DataField="RelativePath" HeaderText="RelativePath" SortExpression="RelativePath"></asp:BoundField>
            <asp:BoundField DataField="ParentID" HeaderText="ParentID" SortExpression="ParentID"></asp:BoundField>
            <asp:CheckBoxField DataField="ShowInMenu" HeaderText="ShowInMenu" SortExpression="ShowInMenu"></asp:CheckBoxField>
            <asp:CheckBoxField DataField="IsActive" HeaderText="IsActive" SortExpression="IsActive"></asp:CheckBoxField>
            <asp:CheckBoxField DataField="IsDeleted" HeaderText="IsDeleted" SortExpression="IsDeleted"></asp:CheckBoxField>

            <asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy" SortExpression="CreatedBy"></asp:BoundField>
            <asp:BoundField DataField="CreatedTime" HeaderText="CreatedTime" SortExpression="CreatedTime"></asp:BoundField>
            <asp:BoundField DataField="ModifiedBy" HeaderText="ModifiedBy" SortExpression="ModifiedBy"></asp:BoundField>

        </Columns>

        <EditRowStyle BackColor="#2461BF"></EditRowStyle>

        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White"></FooterStyle>

        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White"></HeaderStyle>

        <PagerStyle HorizontalAlign="Center" BackColor="#2461BF" ForeColor="White"></PagerStyle>

        <RowStyle BackColor="#EFF3FB"></RowStyle>

        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333"></SelectedRowStyle>

        <SortedAscendingCellStyle BackColor="#F5F7FB"></SortedAscendingCellStyle>

        <SortedAscendingHeaderStyle BackColor="#6D95E1"></SortedAscendingHeaderStyle>

        <SortedDescendingCellStyle BackColor="#E9EBEF"></SortedDescendingCellStyle>

        <SortedDescendingHeaderStyle BackColor="#4870BE"></SortedDescendingHeaderStyle>
    </asp:GridView>

        </div>

<%--    <br /><br /><br />

    <div style="width:35%;height:55%;overflow:auto;">

  
    <asp:DetailsView ID="ModuleDetailsView" runat="server" Height="50px" Width="325px" DataSourceID="ModuleEntityDataSource" AutoGenerateRows="False" DataKeyNames="ModuleID" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal">
        <AlternatingRowStyle BackColor="#F7F7F7"></AlternatingRowStyle>

        <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7"></EditRowStyle>
        <Fields>
            <asp:BoundField DataField="ModuleName" HeaderText="ModuleName" SortExpression="ModuleName"></asp:BoundField>
                <asp:BoundField DataField="DisplayName" HeaderText="DisplayName" SortExpression="DisplayName"></asp:BoundField>
            <asp:BoundField DataField="ModuleOrder" HeaderText="ModuleOrder" SortExpression="ModuleOrder"></asp:BoundField>
            <asp:BoundField DataField="RelativePath" HeaderText="RelativePath" SortExpression="RelativePath"></asp:BoundField>
            <asp:BoundField DataField="ParentID" HeaderText="ParentID" SortExpression="ParentID"></asp:BoundField>
            <asp:CheckBoxField DataField="ShowInMenu" HeaderText="ShowInMenu" SortExpression="ShowInMenu"></asp:CheckBoxField>
            <asp:CheckBoxField DataField="IsActive" HeaderText="IsActive" SortExpression="IsActive"></asp:CheckBoxField>
            <asp:BoundField DataField="CreatedTime" HeaderText="CreatedTime" SortExpression="CreatedTime"></asp:BoundField>
            <asp:BoundField DataField="ModifiedTime" HeaderText="ModifiedTime" SortExpression="ModifiedTime"></asp:BoundField>

            <asp:CommandField ShowInsertButton="True"></asp:CommandField>
        </Fields>
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C"></FooterStyle>

        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7"></HeaderStyle>

        <PagerStyle HorizontalAlign="Right" BackColor="#E7E7FF" ForeColor="#4A3C8C"></PagerStyle>

        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C"></RowStyle>
    </asp:DetailsView>
    
        </div>--%>

</asp:Content>
