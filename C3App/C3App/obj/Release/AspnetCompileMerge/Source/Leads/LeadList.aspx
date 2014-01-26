<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="LeadList.aspx.cs" Inherits="C3App.Leads.LeadList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <asp:Label ID="Label1" runat="server" Text="Enter any part of Leads Name :  "></asp:Label>
         <asp:TextBox ID="searchTextBox" runat="server" AutoPostBack="True" OnTextChanged="searchTextBox_TextChanged"></asp:TextBox>
         <asp:Button ID="searchButton" runat="server" OnClick="searchButton_Click" Text="search" />

    <asp:ObjectDataSource ID="leadObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Lead" DeleteMethod="DeleteLeads" InsertMethod="InsertLeads" SelectMethod="GetLeads" TypeName="C3App.BLL.LeadBL" UpdateMethod="UpdateLeads">
        <%-- <SelectParameters>
                         <asp:ControlParameter ControlID="SearchTextBox" Name="search" PropertyName="Text" Type="String" />
                     </SelectParameters>--%>
    </asp:ObjectDataSource>

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="leadObjectDataSource">
       <Columns>
           
           <%-- <asp:TemplateField HeaderText="Name" SortExpression="Contact.FirstName">
               
                <ItemTemplate>
                    <asp:AccountLabel ID="FirstNameAccountLabel" runat="server" Text='<%# Eval("Contact.FirstName")%>'>

                </asp:AccountLabel>

                </ItemTemplate>
            </asp:TemplateField>--%>
           <asp:BoundField DataField="FirstName" HeaderText="Name" SortExpression="FirstName"/>
            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ShowSelectButton="True"></asp:CommandField>
           

            <asp:TemplateField HeaderText="AccountName" SortExpression="Account.Name">
                <ItemTemplate>
                    <asp:Label ID="FirstNameLabel1" runat="server" Text='<%# Eval("Account.Name")%>'>

                </asp:Label>

                </ItemTemplate>
            </asp:TemplateField>
           
           
           <asp:BoundField DataField="Email1" HeaderText="Email Address" SortExpression="Email1"></asp:BoundField>
           
             <asp:BoundField DataField="PhoneWork" HeaderText="Phone" SortExpression="PhoneWork"></asp:BoundField>
            <asp:TemplateField HeaderText="Assigned User" SortExpression="User.UserName">
                <ItemTemplate>
                                 <asp:label ID="userlabel" runat="server" Text='<%# Eval("User.UserName") %>'></asp:label>
                             </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Team" SortExpression="Team.Name">
                <ItemTemplate>
                                 <asp:label ID="teamlabel" runat="server" Text='<%# Eval("Team.Name") %>'></asp:label>
                             </ItemTemplate>
            </asp:TemplateField>
           
           
        </Columns>
    </asp:GridView>
    


</asp:Content>
