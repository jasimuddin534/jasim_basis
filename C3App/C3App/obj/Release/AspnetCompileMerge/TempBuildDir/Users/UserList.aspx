<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="C3App.Users.UserList" %>



<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

     <a class="title" href="javascript:void(0)">User List</a>
    <div class="tab-content">
     
    Enter any part of the name or leave the box blank to see all names:
    <br /> <br />
    <asp:TextBox ID="SearchTextBox" runat="server" AutoPostBack="true"></asp:TextBox>
     <asp:Button ID="SearchButton" runat="server" Text="Search" />           

    <br />
    <a href ="UserDetails.aspx?UserID=0"> Create New User</a>

        <br /> <br />
    <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server"  SelectMethod="GetUsersByFirstName"  DeleteMethod="DeleteUser"
         UpdateMethod="UpdateUser" TypeName="C3App.BLL.UserBL" DataObjectTypeName="C3App.DAL.User">
         
        <SelectParameters>
            <asp:ControlParameter ControlID="SearchTextBox" Name="nameSearchString" PropertyName="Text"
                Type="String" />
        </SelectParameters>

    </asp:ObjectDataSource>

    <asp:ValidationSummary ID="UsersValidationSummary" runat="server" 
        ShowSummary="true" DisplayMode="BulletList"  />

    <asp:GridView ID="UsersGridView" runat="server" AutoGenerateColumns="False" DataSourceID="UsersObjectDataSource"  CellPadding="4" ForeColor="#333333" GridLines="None" >
        <AlternatingRowStyle BackColor="White" />
        <Columns>

             <asp:TemplateField HeaderText="FirstName" SortExpression="FirstName">
            <ItemTemplate>
                 <a href ='<%#"UserDetails.aspx?UserID="+DataBinder.Eval(Container.DataItem,"UserID") %>'> <%#Eval("FirstName") %>  </a>
            </ItemTemplate>
             </asp:TemplateField>
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="MobilePhone" HeaderText="MobilePhone" SortExpression="MobilePhone" />
            <asp:BoundField DataField="PrimaryEmail" HeaderText="PrimaryEmail" SortExpression="PrimaryEmail" />
            <asp:BoundField DataField="Street" HeaderText="Street" SortExpression="Street" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
            <asp:BoundField DataField="PostalCode" HeaderText="PostalCode" SortExpression="PostalCode" />
            <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
         <asp:BoundField DataField="CompanyID" HeaderText="CompanyID" SortExpression="CompanyID" />
            <asp:BoundField DataField="RoleID" HeaderText="RoleID" SortExpression="RoleID" />
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
       </div>

</asp:Content>
