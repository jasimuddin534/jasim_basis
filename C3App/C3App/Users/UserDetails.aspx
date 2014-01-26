<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="UserDetails.aspx.cs" Inherits="C3App.Users.UserDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    
    <a class="title" href="javascript:void(0)">Create/Modify Users</a>
   <div class="tab-content">
   
        <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.User"
        OldValuesParameterFormatString="original_{0}"
        TypeName="C3App.BLL.UserBL"
        SelectMethod="GetUsersByID"
        InsertMethod="InsertOrUpdate"
        UpdateMethod="InsertOrUpdate">

        <SelectParameters>
            <asp:QueryStringParameter Name="uid" QueryStringField="UserID" Type="Int64" />
        </SelectParameters>

    </asp:ObjectDataSource>
    
      
    <asp:DetailsView FieldHeaderStyle-CssClass="form-fields-header" CssClass="form-fields" ID="UsersDetailsView" runat="server"
         OnItemDeleted="UsersDetailsView_ItemDeleted"
         OnItemUpdating="UsersDetailsView_ItemUpdating"
         DataKeyNames="UserID,CompanyID,PrimaryEmail,Password,CreatedTime,ActivationID,CreatedBy"
         OnItemUpdated="UsersDetailsView_ItemUpdated"
         OnItemCommand="UsersDetailsView_ItemCommand"
         OnItemInserting="UsersDetailsView_ItemInserting"
         OnItemInserted="UsersDetailsView_ItemInserted"
        AutoGenerateRows="False" DataSourceID="UsersObjectDataSource">
        <Fields>
            <asp:CommandField ShowEditButton="true" />
            <asp:BoundField DataField="UserName" HeaderText="UserName" SortExpression="UserName" />
            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
            <asp:TemplateField HeaderText="Gender">
                <EditItemTemplate>
                    <asp:DropDownList ID="GenderDropDownList" runat="server"
                        OnInit="GenderDropDownList_Init">
                        <asp:ListItem Value="Male">Male</asp:ListItem>
                        <asp:ListItem Value="Female">Female</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>


            <asp:BoundField DataField="DOB" HeaderText="DOB" SortExpression="DOB" Visible="false" />
            <asp:BoundField DataField="MaritalStatus" HeaderText="MaritalStatus" SortExpression="MaritalStatus" />
            <asp:CheckBoxField DataField="IsActive" HeaderText="IsActive" SortExpression="IsActive" />
            <asp:CheckBoxField DataField="IsEmployee" HeaderText="IsEmployee" SortExpression="IsEmployee" />
            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
            <asp:BoundField DataField="Department" HeaderText="Department" SortExpression="Department" />

            <asp:TemplateField HeaderText="ReportsTo">
                <EditItemTemplate>
                    <asp:ObjectDataSource ID="ReportsToObjectDataSource" runat="server"
                        TypeName="C3App.BLL.UserBL"
                        DataObjectTypeName="C3App.DAL.User"
                        SelectMethod="GetUsers"></asp:ObjectDataSource>

                    <asp:DropDownList ID="ReportsToDropDownList" runat="server"
                        DataSourceID="ReportsToObjectDataSource"
                        DataTextField="FirstName" DataValueField="UserID" OnInit="ReportsToDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="OfficePhone" HeaderText="OfficePhone" SortExpression="OfficePhone" />
            <asp:BoundField DataField="MobilePhone" HeaderText="MobilePhone" SortExpression="MobilePhone" />
            <asp:BoundField DataField="OtherPhone" HeaderText="OtherPhone" SortExpression="OtherPhone" />
            <asp:BoundField DataField="HomePhone" HeaderText="HomePhone" SortExpression="HomePhone" />
            <asp:BoundField DataField="Fax" HeaderText="Fax" SortExpression="Fax" />

            <asp:TemplateField HeaderText="PrimaryEmail" SortExpression="PrimaryEmail">
                <ItemTemplate>
                    <asp:Label ID="PrimaryEmail" runat="server" Text='<%#Eval("PrimaryEmail") %>'></asp:Label>
                    <asp:TextBox ID="txtPrimaryEmail" runat="server" OnInit="txtPrimaryEmail_Init"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:BoundField DataField="OtherEmail" HeaderText="OtherEmail" SortExpression="OtherEmail" />
            <asp:BoundField DataField="Street" HeaderText="Street" SortExpression="Street" />
            <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
            <asp:BoundField DataField="State" HeaderText="State" SortExpression="State" />
            <asp:BoundField DataField="PostalCode" HeaderText="PostalCode" SortExpression="PostalCode" />

            <asp:TemplateField HeaderText="Country">
                <EditItemTemplate>
                    <asp:ObjectDataSource ID="CountryObjectDataSource" runat="server"
                        TypeName="C3App.BLL.UserBL"
                        DataObjectTypeName="C3App.DAL.Country"
                        SelectMethod="GetCountries"></asp:ObjectDataSource>

                    <asp:DropDownList ID="CountryDropDownList" runat="server"
                        DataSourceID="CountryObjectDataSource"
                        DataTextField="CountryName" DataValueField="CountryID" OnInit="CountryDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>

               <asp:TemplateField HeaderText="Company" SortExpression="Company">
                <ItemTemplate>
                    <asp:Label ID="Company" runat="server" Text='<%#Eval("CompanyID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>


            <asp:BoundField DataField="MessengerType" HeaderText="MessengerType" SortExpression="MessengerType" />
            <asp:BoundField DataField="MessengerID" HeaderText="MessengerID" SortExpression="MessengerID" />
            <asp:BoundField DataField="FacebookID" HeaderText="FacebookID" SortExpression="FacebookID" />
            <asp:CheckBoxField DataField="IsDeleted" HeaderText="IsDeleted" SortExpression="IsDeleted" />
            <asp:CheckBoxField DataField="IsAdmin" HeaderText="IsAdmin" SortExpression="IsAdmin" />
            <asp:BoundField DataField="NationalID" HeaderText="NationalID" SortExpression="NationalID" />
            <asp:BoundField DataField="DrivingLicense" HeaderText="DrivingLicense" SortExpression="DrivingLicense" />
            <asp:BoundField DataField="PassportNo" HeaderText="PassportNo" SortExpression="PassportNo" />
            <asp:BoundField DataField="SocialSecurityNo" HeaderText="SocialSecurityNo" SortExpression="SocialSecurityNo" />


            <asp:TemplateField HeaderText="Role">
                <EditItemTemplate>
                    <asp:ObjectDataSource ID="RoleObjectDataSource" runat="server"
                        TypeName="C3App.BLL.ACLRoleBL"
                        DataObjectTypeName="C3App.DAL.ACLRole"
                        SelectMethod="GetRolesByCompanyID"></asp:ObjectDataSource>

                    <asp:DropDownList ID="RoleDropDownList" runat="server"
                        DataSourceID="RoleObjectDataSource"
                        DataTextField="RoleName" DataValueField="RoleID" OnInit="RoleDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>

            
             <asp:BoundField DataField="SecurityQuestion" HeaderText="SecurityQuestion" SortExpression="SecurityQuestion" />
             <asp:BoundField DataField="SecurityAnswer" HeaderText="SecurityAnswer" SortExpression="SecurityAnswer" />
           
 
        </Fields>
    </asp:DetailsView>



    <asp:ValidationSummary ID="UsersValidationSummary" runat="server"
        ShowSummary="true" DisplayMode="BulletList" />



        </div>

</asp:Content>
