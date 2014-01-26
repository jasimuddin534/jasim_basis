<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="AccountDetails.aspx.cs" Inherits="C3App.Accounts.AccountDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    
    

    <asp:ObjectDataSource ID="accountsDetailsDataSource" runat="server" TypeName="C3App.BLL.AccountBL" DataObjectTypeName="C3App.DAL.Account" SelectMethod="AccountById" DeleteMethod="DeleteAccount" InsertMethod="InsertAccount"  UpdateMethod="UpdateAccount">
        <SelectParameters>
            <asp:QueryStringParameter Name="accountId" QueryStringField="AccountID" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:DetailsView ID="accountsDetailsView" runat="server" DataSourceID="accountsDetailsDataSource" DataKeyNames="AccountID,CompanyID,CreatedTime,createdBy" AutoGenerateRows="False" ForeColor="black" OnItemInserting="accountsDetailsView_ItemInserting" OnItemUpdating="accountsDetailsView_ItemUpdating" OnItemCommand="accountsDetailsView_ItemCommand">
        <Fields>
            <asp:BoundField DataField="Name" HeaderText="Account Name" SortExpression="Name"></asp:BoundField>
             <asp:BoundField DataField="Website" HeaderText="Website" SortExpression="Website"></asp:BoundField>
           <%-- <asp:BoundField DataField="ParentID" HeaderText="Member of" SortExpression="ParentID"></asp:BoundField>--%>
            
            <asp:TemplateField HeaderText="Member Of" SortExpression="AccountID">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("AccountID") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    
                    <asp:ObjectDataSource runat="server" ID="accountsDetailsDataSource6" TypeName="C3App.BLL.AccountBL" SelectMethod="GetAccounts"  DataObjectTypeName="C3App.DAL.Account"></asp:ObjectDataSource>
                    <asp:DropDownList runat="server" ID="memberOfID" DataSourceID="accountsDetailsDataSource6"
                        DataTextField="Name" DataValueField="AccountID" AutoPostBack="False" OnInit="memberOfDDL_Init" />

                    </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("IndustryID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="Employees" HeaderText="Employees" SortExpression="Employees"></asp:BoundField>
            <asp:BoundField DataField="Ownership" HeaderText="Ownership" SortExpression="Ownership"></asp:BoundField>
            
            
             <asp:TemplateField HeaderText="Industry" SortExpression="IndustryID">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("IndustryID") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    
                    <asp:ObjectDataSource runat="server" ID="accountsDetailsDataSource4" TypeName="C3App.BLL.AccountBL" SelectMethod="GetIndustry"  DataObjectTypeName="C3App.DAL.CompanyType"></asp:ObjectDataSource>
                    <asp:DropDownList runat="server" ID="UserID" DataSourceID="accountsDetailsDataSource4"
                        DataTextField="Value" DataValueField="CompanyTypeID" AutoPostBack="False" OnInit="industryDDL_Init" />

                    </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("IndustryID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            
             <asp:TemplateField HeaderText="Type" SortExpression="AccountTypesID">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("AccountTypesID") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                     <asp:ObjectDataSource runat="server" ID="accountsDetailsDataSource1" TypeName="C3App.BLL.AccountBL" SelectMethod="GetAccountType"  DataObjectTypeName="C3App.DAL.AccountType"></asp:ObjectDataSource>
                    <asp:DropDownList runat="server" ID="accountTypeDDL" DataSourceID="accountsDetailsDataSource1"
                        DataTextField="Value" DataValueField="AccountTypeID" AutoPostBack="False" OnInit="accountTypeDDL_Init" />
                   
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("AccountTypesID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            
            <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                <EditItemTemplate>
                   <%-- <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TeamID") %>'></asp:TextBox>--%>
                </EditItemTemplate>
                <InsertItemTemplate>
                     <asp:ObjectDataSource runat="server" ID="accountsDetailsDataSource2" TypeName="C3App.BLL.AccountBL" SelectMethod="GetTeams"  DataObjectTypeName="C3App.DAL.Team"></asp:ObjectDataSource>
                    <asp:DropDownList runat="server" ID="teamDDL" DataSourceID="accountsDetailsDataSource2"
                        DataTextField="Name" DataValueField="TeamID" AutoPostBack="False" OnInit="teamDDL_Init" />
                   <%-- <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("TeamID") %>'></asp:TextBox>--%>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("TeamID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            

            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("AssignedUserID") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                     <asp:ObjectDataSource runat="server" ID="accountsDetailsDataSource3" TypeName="C3App.BLL.AccountBL" SelectMethod="Getuser"  DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                    <asp:DropDownList runat="server" ID="usersDDL" DataSourceID="accountsDetailsDataSource3"
                        DataTextField="UserName" DataValueField="UserID" AutoPostBack="False" OnInit="usersDDL_Init" />

                    <%--<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("AssignedUserID") %>'></asp:TextBox>--%>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("AssignedUserID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            
            <asp:BoundField DataField="OfficePhone" HeaderText="Phone" SortExpression="OfficePhone"></asp:BoundField>
            <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax"></asp:BoundField>
            <asp:BoundField DataField="AlternatePhone" HeaderText="Other Phone" SortExpression="AlternatePhone"></asp:BoundField>
            
            <asp:BoundField DataField="Email1" HeaderText="Email" SortExpression="Email1"></asp:BoundField>
            <asp:BoundField DataField="Email2" HeaderText="Other Email Address" SortExpression="Email2"></asp:BoundField>
           <asp:BoundField DataField="Rating" HeaderText="Rating" SortExpression="Rating"></asp:BoundField>
            <asp:BoundField DataField="SICCode" HeaderText="SIC Code" SortExpression="SICCode"></asp:BoundField>
            <asp:BoundField DataField="AnnualRevenue" HeaderText="Annual Revenue" SortExpression="AnnualRevenue"></asp:BoundField>
            
            
        <%--    /*Address info*/--%>
            
             <asp:BoundField DataField="BillingStreet" HeaderText="Billing Street" SortExpression="BillingStreet"></asp:BoundField>
            <asp:BoundField DataField="BillingCity" HeaderText="City" SortExpression="BillingCity"></asp:BoundField>
            <asp:BoundField DataField="BillingState" HeaderText="State" SortExpression="BillingState"></asp:BoundField>
            <asp:BoundField DataField="BillingPost" HeaderText="Postal Code" SortExpression="BillingPost"></asp:BoundField>
            <asp:BoundField DataField="BillingCountry" HeaderText="Country" SortExpression="BillingCountry"></asp:BoundField>
            
            <asp:BoundField DataField="ShippingStreet" HeaderText="ShippingStreet" SortExpression="ShippingStreet"></asp:BoundField>
            <asp:BoundField DataField="ShippingCity" HeaderText="City" SortExpression="ShippingCity"></asp:BoundField>
            <asp:BoundField DataField="ShippingState" HeaderText="State" SortExpression="ShippingState"></asp:BoundField>
            <asp:BoundField DataField="ShippingPost" HeaderText="Postal Code" SortExpression="ShippingPost"></asp:BoundField>
            <asp:BoundField DataField="ShippingCountry" HeaderText="Country" SortExpression="ShippingCountry"></asp:BoundField>

            <%-- Description --%>
            
            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
            
            
            <asp:CommandField  ShowInsertButton="True" InsertText="Insert" />
             </Fields>
        

    </asp:DetailsView>
    <asp:Button ID="updateButton" runat="server" Text="Update" Visible="False" OnClick="updateButton_Click"/>
    <asp:Button ID="deleteButton" runat="server" Text="Delete" Visible="False" OnClick="deleteButton_Click" />
    
     <br />
    
    
    
    
  
</asp:Content>
