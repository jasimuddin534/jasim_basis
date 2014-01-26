<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="CampaignList.aspx.cs" Inherits="C3App.Campaigns.CampaignList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    Enter any part of Campaign name to see all Campaigns: 
    <asp:TextBox ID="SearchTextBox" runat="server" AutoPostBack="true"></asp:TextBox> 
     <asp:Button ID="SearchButton" runat="server" Text="Search" />

    <h4>Campaigns List</h4>
     <asp:ObjectDataSource ID="CampaignsObjectDataSource" runat="server" 
        DataObjectTypeName="C3App.DAL.Campaign"
        TypeName="C3App.BLL.CampaignBL"
        DeleteMethod="DeleteCampaign"
        SelectMethod="GetCampaignsName"
        UpdateMethod="UpdateCampaign">  
         <SelectParameters>
            <asp:ControlParameter ControlID="SearchTextBox" Name="nameSearchString" PropertyName="Text"
                Type="String" />
        </SelectParameters>  
    </asp:ObjectDataSource>

    <asp:GridView ID="CampaignGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="CampaignID"
                  DataSourceID="CampaignsObjectDataSource">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Name" SortExpression="Name">
                <EditItemTemplate>
                    <asp:TextBox ID="NameTxt" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Campaign Status" SortExpression="CampaignStatus.Value">
                <EditItemTemplate>
                    <asp:TextBox ID="CampaignStatusTxt" runat="server" Text='<%# Bind("CampaignStatusID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="CampaignStatusLabel" runat="server" Text='<%# Eval("CampaignStatus.Value") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            
             <asp:TemplateField HeaderText="Campaign Type" SortExpression="CampaignType.Value">
                <EditItemTemplate>
                    <asp:TextBox ID="CampaignTypeTxt" runat="server" Text='<%# Bind("CampaignTypeID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="CampaignTypeLabel" runat="server" Text='<%# Eval("CampaignType.Value") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="End Date" SortExpression="EndDate">
                <EditItemTemplate>
                    <asp:TextBox ID="EndDateTxt" runat="server" Text='<%# Bind("EndDate") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="EndDateLabel" runat="server" Text='<%# Bind("EndDate") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Assigned" SortExpression="User.UserName">
                <EditItemTemplate>
                    <asp:TextBox ID="AssignedUserTxt" runat="server" Text='<%# Bind("AssignedUserID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="AssignedUserIDLabel" runat="server" Text='<%# Eval("User.UserName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Team Set" SortExpression="TeamSet.TeamSetName">
                <EditItemTemplate>
                    <asp:TextBox ID="TeamSetIDTxt" runat="server" Text='<%# Bind("TeamSetID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="TeamSetIDLabel" runat="server" Text='<%# Eval("TeamSet.TeamSetName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
           
        </Columns>
     </asp:GridView>


</asp:Content>
