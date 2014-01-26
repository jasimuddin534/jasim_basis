<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="CampaignDetails.aspx.cs" Inherits="C3App.Campaigns.CampaignDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

     <h3>Add New Campaign</h3>

    <asp:ObjectDataSource ID="CampaignObjectDataSource" runat="server" 
        TypeName="C3App.BLL.CampaignBL" DataObjectTypeName="C3App.DAL.Campaign" InsertMethod="InsertCampaign"
        SelectMethod="GetCampaigns">
    </asp:ObjectDataSource>

    <asp:DetailsView ID="CampaignDetailsView" runat="server" AutoGenerateRows="False" DefaultMode="Insert" 
        DataSourceID="CampaignObjectDataSource" OnItemInserting="CampaignDetailsView_ItemInserting">
        <Fields>

             <asp:TemplateField HeaderText="Campaign Name" SortExpression="Name">
                <EditItemTemplate>
                    <asp:TextBox ID="NameTxt" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="NameTxt" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="NameRequiredValidator" runat="server" 
                        ControlToValidate="NameTxt" ForeColor="Red" ErrorMessage=" Name Required ">
                    </asp:RequiredFieldValidator>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

         <asp:TemplateField HeaderText="Campaign Status">
                <InsertItemTemplate>
                    <asp:ObjectDataSource ID="CampaignStatusObjectDataSource" runat="server" TypeName="C3App.BLL.CampaignBL" SelectMethod="GetCampaignStatus" 
                        DataObjectTypeName="C3App.DAL.CampaignStatus">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="CampaignStatusDropDownList" runat="server" DataSourceID="CampaignStatusObjectDataSource"
                        DataTextField="Value" DataValueField="CampaignStatusID" OnInit="CampaignStatusDropDownList_Init">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="CampaignStatusRequiredValidator" runat="server" 
                        ControlToValidate="CampaignStatusDropDownList" ForeColor="Red" ErrorMessage=" Campaign Status Required ">
                    </asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Start Date" SortExpression="StartDate">
                <EditItemTemplate>
                    <asp:TextBox ID="StartDateTxt" runat="server" Text='<%# Bind("StartDate") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="StartDateTxt" runat="server" Text='<%# Bind("StartDate") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="StartDateLabel" runat="server" Text='<%# Bind("StartDate") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="End Date" SortExpression="EndDate">
                <EditItemTemplate>
                    <asp:TextBox ID="EndDateTxt" runat="server" Text='<%# Bind("EndDate") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="EndDateTxt" runat="server" Text='<%# Bind("EndDate") %>'></asp:TextBox>
                     <asp:RequiredFieldValidator ID="EndDateRequiredValidator" runat="server" 
                        ControlToValidate="EndDateTxt" ForeColor="Red" ErrorMessage="End Date Required ">
                    </asp:RequiredFieldValidator>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="EndDateLabel" runat="server" Text='<%# Bind("EndDate") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Campaign Type">
                <InsertItemTemplate>
                    <asp:ObjectDataSource ID="CampaignTypeObjectDataSource" runat="server" TypeName="C3App.BLL.CampaignBL" SelectMethod="GetCampaignTypes" 
                        DataObjectTypeName="C3App.DAL.CampaignType">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="CampaignTypeDropDownList" runat="server" DataSourceID="CampaignTypeObjectDataSource"
                        DataTextField="Value" DataValueField="CampaignTypeID" OnInit="CampaignTypeDropDownList_Init">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="CampaignTypeRequiredValidator" runat="server" 
                        ControlToValidate="CampaignTypeDropDownList" ForeColor="Red" ErrorMessage="Campaign Type Required ">
                    </asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Currency">
                <InsertItemTemplate>
                    <asp:ObjectDataSource ID="CurrencyObjectDataSource" runat="server" TypeName="C3App.BLL.CampaignBL" SelectMethod="GetCurrencys" 
                        DataObjectTypeName="C3App.DAL.Currency">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="CurrencyDropDownList" runat="server" DataSourceID="CurrencyObjectDataSource"
                        DataTextField="Name" DataValueField="CurrencyID" OnInit="CurrencyDropDownList_Init">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="CurrencyRequiredValidator" runat="server" 
                        ControlToValidate="CurrencyDropDownList" ForeColor="Red" ErrorMessage="Currency Required ">
                    </asp:RequiredFieldValidator>
                </InsertItemTemplate>
            </asp:TemplateField>

             <asp:TemplateField HeaderText="Budget" SortExpression="Budget">
                <EditItemTemplate>
                    <asp:TextBox ID="BudgetTxt" runat="server" Text='<%# Bind("Budget") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="BudgetTxt" runat="server" Text='<%# Bind("Budget") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="BudgetLabel" runat="server" Text='<%# Bind("Budget") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Expected Revenue" SortExpression="ExpectedRevenue">
                <EditItemTemplate>
                    <asp:TextBox ID="ExpectedRevenueTxt" runat="server" Text='<%# Bind("ExpectedRevenue") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="ExpectedRevenueTxt" runat="server" Text='<%# Bind("ExpectedRevenue") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ExpectedRevenueLabel" runat="server" Text='<%# Bind("ExpectedRevenue") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Assigned To">
                <InsertItemTemplate>
                    <asp:ObjectDataSource ID="AssignedUserObjectDataSource" runat="server" TypeName="C3App.BLL.CampaignBL" SelectMethod="GetUsers" 
                        DataObjectTypeName="C3App.DAL.User">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="AssignedUserDropDownList" runat="server" DataSourceID="AssignedUserObjectDataSource"
                        DataTextField="UserName" DataValueField="UserID" OnInit="AssignedUserDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate>
            </asp:TemplateField>

               <asp:TemplateField HeaderText="Teams">
                <InsertItemTemplate>
                    <asp:ObjectDataSource ID="TameNameObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" SelectMethod="GetTeam" 
                        DataObjectTypeName="C3App.DAL.Team">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="TeamNameDropDownList" runat="server" DataSourceID="TameNameObjectDataSource"
                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamNameDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate>
            </asp:TemplateField>     

            <asp:TemplateField HeaderText="Impressions" SortExpression="Impressions">
                <EditItemTemplate>
                    <asp:TextBox ID="ImpressionsTxt" runat="server" Text='<%# Bind("Impressions") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="ImpressionsTxt" runat="server" Text='<%# Bind("Impressions") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ImpressionsLabel" runat="server" Text='<%# Bind("Impressions") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Actual Cost" SortExpression="ActualCost">
                <EditItemTemplate>
                    <asp:TextBox ID="ActualCostTxt" runat="server" Text='<%# Bind("ActualCost") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="ActualCostTxt" runat="server" Text='<%# Bind("ActualCost") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ActualCostLabel" runat="server" Text='<%# Bind("ActualCost") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Expected Cost" SortExpression="ExpectedCost">
                <EditItemTemplate>
                    <asp:TextBox ID="ExpectedCostTxt" runat="server" Text='<%# Bind("ExpectedCost") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="ExpectedCostTxt" runat="server" Text='<%# Bind("ExpectedCost") %>'></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ExpectedCostLabel" runat="server" Text='<%# Bind("ExpectedCost") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField HeaderText="Objective" SortExpression="Objective">
                <EditItemTemplate>
                    <asp:TextBox ID="ObjectiveTxt" runat="server" Text='<%# Bind("Objective") %>' TextMode="MultiLine" ></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="ObjectiveTxt" runat="server" Text='<%# Bind("Objective") %>' TextMode="MultiLine" ></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ObjectiveLabel" runat="server" Text='<%# Bind("Objective") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Content" SortExpression="Content">
                <EditItemTemplate>
                    <asp:TextBox ID="ContentTxt" runat="server" Text='<%# Bind("Content") %>' TextMode="MultiLine"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="ContentTxt" runat="server" Text='<%# Bind("Content") %>' TextMode="MultiLine" ></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="ContentLabel" runat="server" Text='<%# Bind("Content") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField ShowHeader="False">
                <InsertItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="New" Text="New"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>

        </Fields>
     </asp:DetailsView>

</asp:Content>
