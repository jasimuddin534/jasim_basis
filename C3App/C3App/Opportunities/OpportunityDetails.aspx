<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="OpportunityDetails.aspx.cs" Inherits="C3App.Opportunities.OpportunityDetails" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
     <div>
    
         <asp:ObjectDataSource ID="opportunityDetailsObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity" DeleteMethod="DeleteOpportunity" InsertMethod="InsertOpportunity" SelectMethod="OpportunityByID" TypeName="C3App.BLL.OpportunityBL" UpdateMethod="UpdateOpportunity">
             <SelectParameters>
                 <asp:QueryStringParameter Name="opportunityId" QueryStringField="OpportunityID" Type="Int32" />
             </SelectParameters>
         </asp:ObjectDataSource>
         <asp:DetailsView ID="opportunityDetailsView" runat="server" AutoGenerateRows="False" DataSourceID="opportunityDetailsObjectDataSource" Height="16px" OnItemInserting="opportunityDetailsDetailsView_ItemInserting"  Width="112px" AllowPaging="True" DataKeyNames="OpportunityID,CompanyID,CreatedTime,createdBy" OnItemUpdating="opportunityDetailsView_ItemUpdating" OnItemCommand="opportunityDetailsView_ItemCommand"  >
             <Fields>
                <asp:BoundField DataField="Name" HeaderText="Opportunity Name" SortExpression="Name" />
               
                <asp:TemplateField HeaderText="AccountName" SortExpression="AccountID">
                     <EditItemTemplate>
                    <asp:ObjectDataSource ID="accountDataSource" runat="server" 
                        SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL" 
                        DataObjectTypeName="C3App.DAL.Account" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="accountDropDownList" runat="server" 
                        DataSourceID="accountDataSource"
                        DataTextField="Name" DataValueField="AccountID" 
                        OnInit="accountDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate> 
                     <InsertItemTemplate>
                    <asp:ObjectDataSource ID="accountDataSource" runat="server" 
                        SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL" 
                        DataObjectTypeName="C3App.DAL.Account" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="accountDropDownList" runat="server" 
                        DataSourceID="accountDataSource"
                        DataTextField="Name" DataValueField="AccountID" 
                        OnInit="accountDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate> 
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Type" SortExpression="OpportunityTypeID">
                  <EditItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource1" runat="server" 
                        SelectMethod="GetOpportunityTypes" TypeName="C3App.BLL.OpportunityBL" 
                        DataObjectTypeName="C3App.DAL.OpportunityType" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="opportunityTypeDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource1"
                        DataTextField="Value" DataValueField="OpportunityTypeID" 
                        OnInit="opportunityTypeDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>  
                    <InsertItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource1" runat="server" 
                        SelectMethod="GetOpportunityTypes" TypeName="C3App.BLL.OpportunityBL" 
                        DataObjectTypeName="C3App.DAL.OpportunityType" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="opportunityTypeDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource1"
                        DataTextField="Value" DataValueField="OpportunityTypeID" 
                        OnInit="opportunityTypeDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate>  
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Lead Source" SortExpression="LeadSourceID">
                   <EditItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource2" runat="server" 
                        SelectMethod="GetLeadSources" TypeName="C3App.BLL.LeadBL" 
                         DataObjectTypeName="C3App.DAL.LeadSource" >

                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="leadSourceDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource2"
                         DataTextField="Value" DataValueField="LeadSourceID"
                        OnInit="leadSourceDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate> 
                    <InsertItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource2" runat="server" 
                        SelectMethod="GetLeadSources" TypeName="C3App.BLL.LeadBL" 
                         DataObjectTypeName="C3App.DAL.LeadSource" >

                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="leadSourceDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource2"
                         DataTextField="Value" DataValueField="LeadSourceID"
                        OnInit="leadSourceDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate> 
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Teams" SortExpression="TeamID">
                     <EditItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource3" runat="server" 
                        SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL" 
                        DataObjectTypeName="C3App.DAL.Team" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="teamsDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource3"
                        DataTextField="Name" DataValueField="TeamID" 
                        OnInit="teamsDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>
                     <InsertItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource3" runat="server" 
                        SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL" 
                        DataObjectTypeName="C3App.DAL.Team" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="teamsDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource3"
                        DataTextField="Name" DataValueField="TeamID" 
                        OnInit="teamsDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                     <EditItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource4" runat="server" 
                        SelectMethod="GetUserList" TypeName="C3App.DAL.UserRepository" 
                        DataObjectTypeName="C3App.DAL.User" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="assignedToDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource4"
                        DataTextField="UserName" DataValueField="UserID" 
                        OnInit="assignedToDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>
                    <InsertItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource4" runat="server" 
                        SelectMethod="GetUserList" TypeName="C3App.DAL.UserRepository" 
                        DataObjectTypeName="C3App.DAL.User" >
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="assignedToDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource4"
                        DataTextField="UserName" DataValueField="UserID" 
                        OnInit="assignedToDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Currency" SortExpression="CurrencyID">
                 <EditItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource5" runat="server" 
                        SelectMethod="GetCurrencies" TypeName="C3App.BLL.UserBL" 
                         DataObjectTypeName="C3App.DAL.Currency">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="currencyDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource5"
                         DataTextField="Name" DataValueField="CurrencyID"
                        OnInit="currencyDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>  
                     <InsertItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource5" runat="server" 
                        SelectMethod="GetCurrencies" TypeName="C3App.BLL.UserBL" 
                         DataObjectTypeName="C3App.DAL.Currency">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="currencyDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource5"
                         DataTextField="Name" DataValueField="CurrencyID"
                        OnInit="currencyDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate>  
                </asp:TemplateField>
                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                <asp:BoundField DataField="DateEnclosed" HeaderText="DateEnclosed" SortExpression="DateEnclosed" />
                <asp:BoundField DataField="NextStep" HeaderText="NextStep" SortExpression="NextStep" />
                <asp:BoundField DataField="Probability" HeaderText="Probability(%)" SortExpression="Probability" />
                <asp:TemplateField HeaderText="Sales Stage" SortExpression="SalesStageID">
                   <EditItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource6" runat="server" 
                        SelectMethod="GetOpportunitySalesStages" TypeName="C3App.BLL.OpportunityBL" 
                         DataObjectTypeName="C3App.DAL.OpportunitySalesStage">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="salesStageDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource6"
                         DataTextField="Value" DataValueField="OpportunitySalesStageID"
                        OnInit="salesStageDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate> 
                     <InsertItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource6" runat="server" 
                        SelectMethod="GetOpportunitySalesStages" TypeName="C3App.BLL.OpportunityBL" 
                         DataObjectTypeName="C3App.DAL.OpportunitySalesStage">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="salesStageDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource6"
                         DataTextField="Value" DataValueField="OpportunitySalesStageID"
                        OnInit="salesStageDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate>  
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Campaign Name" SortExpression="CampaignID">
                 <EditItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource7" runat="server" 
                        SelectMethod="GetCampaigns" TypeName="C3App.BLL.CampaignBL" 
                         DataObjectTypeName="C3App.DAL.Campaign">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="CampaignNameDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource7"
                         DataTextField="Name" DataValueField="CampaignID"
                        OnInit="CampaignNameDropDownList_Init">
                    </asp:DropDownList>
                </EditItemTemplate>  
                    <InsertItemTemplate>
                    <asp:ObjectDataSource ID="opportunityDataSource7" runat="server" 
                        SelectMethod="GetCampaigns" TypeName="C3App.BLL.CampaignBL" 
                         DataObjectTypeName="C3App.DAL.Campaign">
                    </asp:ObjectDataSource>
                    <asp:DropDownList ID="CampaignNameDropDownList" runat="server" 
                        DataSourceID="opportunityDataSource7"
                         DataTextField="Name" DataValueField="CampaignID"
                        OnInit="CampaignNameDropDownList_Init">
                    </asp:DropDownList>
                </InsertItemTemplate>  
                </asp:TemplateField>
                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
              
<%--                <asp:CommandField ShowInsertButton="True" />--%>
            </Fields>
         </asp:DetailsView>
    
         <asp:Button ID="updateButton" runat="server" Text="Update" Visible="False" OnClick="updateButton_Click"/>
         <asp:Button ID="deleteButton" runat="server" Text="Delete" Visible="False" OnClick="deleteButton_Click" />
    
         <br />
    
    </div>
        </asp:Content>
