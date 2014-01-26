<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="ACLRoleList.aspx.cs" Inherits="C3App.Administration.ACLRoles.ACLRoleList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    
      <a href="ACLRoleDetails.aspx?RoleID=0">Create Role</a>

    <asp:ObjectDataSource ID="ACLRolesObjectDataSource" runat="server" 
     SelectMethod="GetRolesByCompanyID" TypeName="C3App.BLL.ACLRoleBL">

    </asp:ObjectDataSource>


    <asp:GridView ID="ACLRolesGridView" runat="server" 
         DataKeyNames="RoleID"
        DataSourceID="ACLRolesObjectDataSource" AutoGenerateColumns="False">

        <Columns>
            
            <asp:TemplateField HeaderText="RoleName" SortExpression="RoleName">
                <ItemTemplate>
                    <a href='<%#"ACLRoleDetails.aspx?RoleID="+DataBinder.Eval(Container.DataItem,"RoleID") %>'><%#Eval("RoleName") %>  </a>
                </ItemTemplate>
            </asp:TemplateField>
            
            
             <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
        </Columns>
    </asp:GridView>


</asp:Content>
