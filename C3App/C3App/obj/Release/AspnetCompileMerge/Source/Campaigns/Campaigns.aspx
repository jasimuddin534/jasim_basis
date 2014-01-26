<%@ Page Title="Campaigns Page" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Campaigns.aspx.cs" Inherits="C3App.Campaigns.Campaigns" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>


<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="BodyContent">

    <%--sjdfk--%>
    <asp:Panel ID="DetailsPanel" runat="server" SkinID="DetailsTab" tab-id="1">

        <asp:LinkButton ID="CampaignDetailsLinkButton" runat="server" SkinID="TabTitle" Text="Create Campaign" CausesValidation="false" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Capmaign')" OnClick="CampaignDetailsLinkButton_Click" />
        <asp:Panel ID="DetailsContentPanel" runat="server" SkinID="TabContent">
            <asp:UpdatePanel ID="CampaignDetailsUpdatePanel" runat="server">

                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="CampaignDetailsLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                </Triggers>

                <ContentTemplate>

                    <asp:ValidationSummary ID="CampaignValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="sum" ShowValidationErrors="true" />

                    <asp:ObjectDataSource ID="CampaignObjectDataSource" runat="server"
                        OldValuesParameterFormatString="original_{0}"
                        TypeName="C3App.BLL.CampaignBL"
                        DataObjectTypeName="C3App.DAL.Campaign"
                        InsertMethod="InsertOrUpdateCampaign"
                        OnInserted="CampaignObjectDataSource_Inserted"
                        SelectMethod="GetCampaignByID"
                        UpdateMethod="InsertOrUpdateCampaign"
                        OnUpdated="CampaignObjectDataSource_Updated"
                        DeleteMethod="DeleteCampaignByID">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditCampaignID" Name="campaignID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>

                    <asp:DetailsView ID="CampaignDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="fields-label" AutoGenerateRows="False"
                        DataSourceID="CampaignObjectDataSource"
                        DataKeyNames="CampaignID,CreatedTime,Timestamp,CreatedBy,CompanyID"
                        OnItemInserting="CampaignDetailsView_ItemInserting"
                        OnItemUpdating="CampaignDetailsView_ItemUpdating"
                        OnItemCommand="CampaignDetailsView_ItemCommand"
                        DefaultMode="Insert">
                        <Fields>

                            <asp:TemplateField HeaderText="Campaign Name" SortExpression="Name">
                                <EditItemTemplate>
                                    <asp:TextBox ID="CampaignNameText" runat="server" CssClass="required-field mask-name" Text='<%# Bind("Name") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="CampaignNameRequiredValidator" runat="server" ControlToValidate="CampaignNameText" Display="Static" ErrorMessage="Campaign name is required" Text="*" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator ID="CampaignNameTextLength" runat="server" ControlToValidate="CampaignNameText" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" Text="" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Campaign Name Field " ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Campaign Status">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CampaignStatusObjectDataSource" runat="server" TypeName="C3App.BLL.CampaignBL" SelectMethod="GetCampaignStatus" DataObjectTypeName="C3App.DAL.CampaignStatus"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CampaignStatusDropDownList" runat="server" DataSourceID="CampaignStatusObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("CampaignStatusID")==null ? "0" : Eval("CampaignStatusID") %>'
                                        DataTextField="Value" DataValueField="CampaignStatusID" OnInit="CampaignStatusDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Start Date" SortExpression="StartDate">
                                <EditItemTemplate>
                                    <asp:TextBox ID="StartDateTextBox" CssClass="datepicker required-field" runat="server" Text='<%# Bind("StartDate","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="StartDateRequiredValidator" runat="server" ControlToValidate="StartDateTextBox" Display="Static" ErrorMessage="Start date is required " Text="*" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="End Date" SortExpression="EndDate">
                                <EditItemTemplate>
                                    <asp:TextBox ID="EndDateTextBox" CssClass="datepicker required-field" runat="server" Text='<%# Bind("EndDate","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="EndDateRequiredValidator" runat="server" ControlToValidate="EndDateTextBox" Display="Static" ErrorMessage="End date is required " Text="*" ValidationGroup="sum" />
                                    <asp:CompareValidator ID="DateCompareValidator" runat="server" Operator="GreaterThanEqual" Type="Date" ControlToValidate="EndDateTextBox" ControlToCompare="StartDateTextBox" ErrorMessage="End Date must be greater than Start Date !" Text="*" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Campaign Type">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CampaignTypeObjectDataSource" runat="server" TypeName="C3App.BLL.CampaignBL" SelectMethod="GetCampaignTypes" DataObjectTypeName="C3App.DAL.CampaignType"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CampaignTypeDropDownList" runat="server" DataSourceID="CampaignTypeObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("CampaignTypeID")==null ? "0" : Eval("CampaignTypeID") %>'
                                        DataTextField="Value" DataValueField="CampaignTypeID" OnInit="CampaignTypeDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Refer URL" SortExpression="ReferURL">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ReferURLTextBox" runat="server" Text='<%# Bind("ReferURL") %>' MaxLength="255"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="ReferURLValidator" runat="server" ControlToValidate="ReferURLTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" Text="" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Refer URL Field" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Currency">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CurrencyObjectDataSource" runat="server" TypeName="C3App.BLL.UserBL" SelectMethod="GetCurrencies" DataObjectTypeName="C3App.DAL.Currency"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CurrencyDropDownList" runat="server" DataSourceID="CurrencyObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("CurrencyID")==null ? "0" : Eval("CurrencyID") %>'
                                        DataTextField="Name" DataValueField="CurrencyID" OnInit="CurrencyDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Impressions" SortExpression="Impressions">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ImpressionsTextBox" runat="server" CssClass="mask-money" Text='<%# Bind("Impressions") %>' MaxLength="10"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="ImpressionsRangeValidator" runat="server" ControlToValidate="ImpressionsTextBox" Display="None"
                                        ErrorMessage="Impressions value must be number (0-9) and less thean 10 digit" ValidationExpression="^[0-9]{0,10}?$" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Budget" SortExpression="Budget">
                                <EditItemTemplate>
                                    <asp:TextBox ID="BudgetTextBox" runat="server" CssClass="mask-money" Text='<%# Bind("Budget") %>' MaxLength="18"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="BudgetRangeValidator" runat="server" ControlToValidate="BudgetTextBox" Display="None"
                                        ErrorMessage="Budget must be decimal value and less thean 18 digit (like 000000000000000000 / 000000000000000.00)." ValidationExpression="^[0-9]{0,15}(\.[0-9]{1,2})?$" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Actual Cost" SortExpression="ActualCost">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ActualCostTextBox" runat="server" CssClass="mask-money" Text='<%# Bind("ActualCost") %>' MaxLength="18"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="ActualCostValidator" runat="server" ControlToValidate="ActualCostTextBox" Display="None"
                                        ErrorMessage="Actual Cost must be decimal value and less thean 18 digit (like 000000000000000000 / 000000000000000.00)." ValidationExpression="^(?:\d{1,18}|\d{1,15}\.\d\d)$" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Expected Revenue" SortExpression="ExpectedRevenue">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ExpectedRevenueTextBox" runat="server" CssClass="mask-money" Text='<%# Bind("ExpectedRevenue") %>' MaxLength="18"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="ExpectedRevenueValidator" runat="server" ControlToValidate="ExpectedRevenueTextBox" Display="None"
                                        ErrorMessage="Expected Revenue must be decimal value and less thean 18 digit (like 000000000000000000 / 000000000000000.00)." ValidationExpression="^(?:\d{1,18}|\d{1,15}\.\d\d)$" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Expected Cost" SortExpression="ExpectedCost">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ExpectedCostTextBox" runat="server" CssClass="mask-money" Text='<%# Bind("ExpectedCost") %>' MaxLength="18"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="ExpectedCostValidator" runat="server" ControlToValidate="ExpectedCostTextBox" Display="None"
                                        ErrorMessage="Expected Cost must be decimal value and less thean 18 digit (like 000000000000000000 / 000000000000000.00)." ValidationExpression="^(?:\d{1,18}|\d{1,15}\.\d\d)$" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Objective" SortExpression="Objective">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ObjectiveText" runat="server" Text='<%# Bind("Objective") %>' TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Content" SortExpression="Content">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ContentText" runat="server" Text='<%# Bind("Content") %>' TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Assigned To">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignedUserObjectDataSource" runat="server" TypeName="C3App.BLL.UserBL" SelectMethod="GetUsers" DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssignedUserDropDownList" runat="server" DataSourceID="AssignedUserObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("AssignedUserID")==null ? "0" : Eval("AssignedUserID") %>'
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssignedUserDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Teams">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TameNameObjectDataSource" runat="server" TypeName="C3App.BLL.TeamBL" SelectMethod="GetTeams" DataObjectTypeName="C3App.DAL.Team"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamNameDropDownList" runat="server" DataSourceID="TameNameObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("TeamID")==null ? "0" : Eval("TeamID") %>'
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamNameDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False">
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>&nbsp;                                           
                                    <asp:LinkButton ID="InsertLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" Text="Save" ValidationGroup="sum" on></asp:LinkButton>
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>&nbsp;
                                            <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Update" Text="Save" ValidationGroup="sum"></asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>

                        </Fields>
                    </asp:DetailsView>

                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="CampaignDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="CampaignDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>





    </asp:Panel>
















    <asp:Panel ID="ViewPanel" runat="server" SkinID="ViewTab" tab-id="2">

        <asp:LinkButton runat="server" ID="ViewCampaignLinkButton" SkinID="TabTitle" OnClick="ViewCampaignLinkButton_Click" Text="View Campaigns" OnClientClick="GoToTab(2,'Create Campaign')" />

        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">

            <asp:ObjectDataSource ID="SearchCampaignObjectDataSource" runat="server"
                DataObjectTypeName="C3App.DAL.Campaign"
                TypeName="C3App.BLL.CampaignBL"
                DeleteMethod="DeleteCampaignByID"
                SelectMethod="GetCampaignByName"
                UpdateMethod="InsertOrUpdateCampaign">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>

            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">

                <asp:Panel ID="FilterSearchPanel" runat="server" CssClass="filter">
                    <asp:Label ID="FilterSearchLabel" runat="server" Text="Search Filter" />
                    <asp:LinkButton ID="SearchAllLinkButton" runat="server" CssClass="search-label active" OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                    <asp:LinkButton ID="SearchActiveCampaignLinkButton" runat="server" CssClass="search-label active" OnClick="SearchActiveCampaignLinkButton_Click">Active</asp:LinkButton>
                </asp:Panel>

                <asp:Panel ID="SearchPanel2" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                    <asp:LinkButton ID="SearchButton" runat="server" CssClass="search-btn" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="ListPanel" runat="server" SkinID="ListPanel">
                <asp:UpdatePanel ID="CampaignListUpdatePanel" runat="server" UpdateMode="Conditional">

                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewCampaignLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchActiveCampaignLinkButton" EventName="Click" />
                    </Triggers>

                    <ContentTemplate>


                        <asp:ObjectDataSource ID="CampaignListObjectDataSource" runat="server" SelectMethod="GetCampaigns" TypeName="C3App.BLL.CampaignBL" DataObjectTypeName="C3App.DAL.Campaign"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="SearchActiveCampaignsObjectDataSource" runat="server" SelectMethod="GetActiveCampaigns" TypeName="C3App.BLL.CampaignBL" DataObjectTypeName="C3App.DAL.Campaign"></asp:ObjectDataSource>

                        <asp:GridView ID="CampaignsGridView" runat="server" CssClass="list-form"
                            AutoGenerateColumns="False"
                            DataKeyNames="CampaignID"
                            DataSourceID="CampaignListObjectDataSource"
                            GridLines="None"
                            ShowHeader="false">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="CampaignImage" runat="server" ImageUrl="~/Content/images/c3/campaign.jpg" />
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("CampaignID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                            <%# Eval("Name") %>
                                            <asp:Label ID="CampaignStatusLabel" runat="server" Text='<%# Eval("CampaignStatus.Value") %>'></asp:Label>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdateProgress ID="CampaignListUpdateProgress" runat="server" AssociatedUpdatePanelID="CampaignListUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </asp:Panel>

            <asp:UpdatePanel ID="MiniDetailsUpdatePanel" runat="server" UpdateMode="Conditional">

                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="CampaignRunLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="DeleteLinkButton" EventName="Click" />
                </Triggers>

                <ContentTemplate>

                    <asp:Panel ID="MiniDetailBasicPanel" runat="server" CssClass="mini-detail-panel">

                        <asp:ObjectDataSource ID="MiniCampaignsObjectDataSource" runat="server"
                            TypeName="C3App.BLL.CampaignBL"
                            SelectMethod="GetCampaignByID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="CampaignsGridView" Type="Int32" Name="campaignID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:FormView ID="MiniCampaignFormView" runat="server" CssClass="mini-details-form"
                            DataSourceID="MiniCampaignsObjectDataSource"
                            DataKeyNames="CampaignID,CreatedTime,CreatedBy,CompanyID,ModifiedTime,ModifiedBy">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Image ID="CampaignImage" runat="server" CssClass="img-profile" ImageUrl="~/Content/images/c3/campaign.jpg" />
                                <asp:Panel ID="CampaignBasicPanel" runat="server">
                                    <asp:Label ID="CampaignNameLabel" runat="server" CssClass="fullname" Text='<%# Eval("Name") %>'></asp:Label>
                                    <asp:Label ID="StartDateLabel" runat="server" CssClass="start-date" Text='<%# Eval("StartDate","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                    <asp:Label ID="CampaignStatusLabel" runat="server" CssClass="hourglass" Text='<%# Eval("CampaignStatus.Value") %>'></asp:Label>
                                    <asp:Label ID="CampaignTypeLabel" runat="server" CssClass="megaphone-tag" Text='<%# Eval("CampaignType.Value") %>'></asp:Label>
                                    <asp:Label ID="BudgetLabel" runat="server" CssClass="amount" Text='<%# Eval("Budget") %>'></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>

                        </asp:FormView>


                        <asp:Panel ID="ButtonPanel" runat="server" CssClass="mini-detail-control-panel four-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="EditLinkButton" runat="server" Text="Edit" ToolTip="Edit" CssClass="control-btn" CommandArgument="CampaignID" OnClientClick="GoToTab(1,'Campaign Details');" OnClick="EditLinkButton_Click">
                                            <i class="icon-edit"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="CampaignRunLinkButton" runat="server" CssClass="control-btn" ToolTip="Run Campaign" OnClientClick="OpenModal('BodyContent_RunCampaignModalPanel');"><i class="icon-share-alt"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton ID="CampaignTargetLinkButton" runat="server" CssClass="control-btn" ToolTip="Campaign Summary" OnClientClick="OpenModal('BodyContent_CampaignTargetModalPanel')" OnClick="CampaignTargetLinkButton_Click">
                                            <i class="icon-user"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:Panel ID="DeleteConfirmPanel" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CssClass="control-btn has-confirm" Text="Delete" CommandArgument="CampaignID" ToolTip="Delete">
                                            <i class="icon-trash"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="ConfirmLinkButton" runat="server" OnClick="DeleteLinkButton_Click">Confirm</asp:LinkButton>
                                        <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>

                            </ul>
                        </asp:Panel>

                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" runat="server" SkinID="MiniDetailMorePanel">
                        <asp:Panel ID="MiniCampaignDetailMore" runat="server">

                            <asp:DetailsView ID="MiniMoreDetailsView" runat="server" FieldHeaderStyle-CssClass="field-label" CssClass="mini-details-more-form" AutoGenerateRows="False"
                                DataSourceID="MiniCampaignsObjectDataSource"
                                DataKeyNames="Name,CampaignID,CreatedTime,CreatedBy,CompanyID,ModifiedTime,ModifiedBy">
                                <EmptyDataTemplate>
                                    <p>Data Not Found</p>
                                </EmptyDataTemplate>
                                <FieldHeaderStyle CssClass="field-label" />
                                <Fields>
                                    <asp:TemplateField HeaderText="Campaign End Date" SortExpression="EndDate">
                                        <ItemTemplate>
                                            <asp:Label ID="EndDateLabel" runat="server" Text='<%# Eval("EndDate","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                        <ItemTemplate>
                                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Eval("User.FirstName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                        <ItemTemplate>
                                            <asp:Label ID="TeamLabel" runat="server" Text='<%# Eval("Team.Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Currency" SortExpression="CurrencyID">
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("Currency.Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Impressions" HeaderText="Impressions" SortExpression="Impressions" />
                                    <asp:BoundField DataField="ActualCost" HeaderText="Actual Cost" SortExpression="ActualCost" />
                                    <asp:BoundField DataField="ExpectedCost" HeaderText="Expected Cost" SortExpression="ExpectedCost" />
                                    <asp:BoundField DataField="ExpectedRevenue" HeaderText="Expected Revenue" SortExpression="ExpectedRevenue" />
                                    <asp:BoundField DataField="ReferURL" HeaderText="Refer URL" SortExpression="ReferURL" />
                                    <asp:BoundField DataField="Objective" HeaderText="Objective" SortExpression="Objective" />
                                    <asp:BoundField DataField="Content" HeaderText="Content" SortExpression="Content" />
                                </Fields>
                            </asp:DetailsView>
                        </asp:Panel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="MinidetailsUpdateprogress" runat="server" AssociatedUpdatePanelID="MiniDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="progressoverlaypanel3" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="progressoverlaycontent3" runat="server" CssClass="loadingcontent">
                        <h2>loading...</h2>
                        <asp:Image ID="progressimage3" runat="server" ImageUrl="~/content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

            <asp:Panel ID="RunCampaignModalPanel" runat="server" CssClass="modal-pop right meeting-small">
                <asp:HyperLink ID="HyperLink3" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
                <asp:UpdatePanel ID="RunCampaignUpdatePanel" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                        <asp:Label ID="ModalTitleLabel" runat="server" SkinID="ModalTitle" Text="Run Campaign"></asp:Label>
                        <asp:Panel ID="CampaignTargetPanel" runat="server" SkinID="ModalListPanel">

                            <asp:DetailsView ID="CampaignTargetDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="field-label"
                                AutoGenerateRows="False" DefaultMode="Insert">
                                <Fields>
                                    <asp:TemplateField HeaderText="Target Type">
                                        <EditItemTemplate>
                                            <asp:DropDownList CssClass="with-btn" ID="TargetTypeDropDownList" runat="server" SkinID="TextBoxWithButton" AppendDataBoundItems="true" OnInit="TargetTypeDropDownList_Init" ViewStateMode="Disabled">
                                                <asp:ListItem Enabled="true" Selected="True" Text="Contacts" Value="Contacts"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:Button ID="TargetListPopButton" runat="server" OnClientClick="OpenModal('BodyContent_TargetListModalPanel')" CssClass="modal-pop-form-btn with-input" Text="Select" />
                                            <asp:HiddenField ID="EmailHiddenField" Value="" runat="server" />
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Target / To " SortExpression="TargetID">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TargetTextBox" runat="server" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ShowHeader="False">
                                        <InsertItemTemplate>
                                            <asp:LinkButton ID="CampaignTargetInsertLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" Text="Run" OnClick="CampaignTargetInsertLinkButton_Click"></asp:LinkButton>&nbsp;&nbsp;&nbsp;
                                            <asp:LinkButton ID="CampaignTargetCancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" Text="Cancel" OnClick="CampaignTargetCancelLinkButton_Click"></asp:LinkButton>
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                            </asp:DetailsView>

                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="RunCampaignUpdateProgress" runat="server" AssociatedUpdatePanelID="RunCampaignUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="progressoverlaypanel4" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="progressoverlaycontent4" runat="server" CssClass="loadingcontent">
                            <h2>loading...</h2>
                            <asp:Image ID="progressimage4" runat="server" ImageUrl="~/content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </asp:Panel>



            <asp:Panel ID="TargetListModalPanel" runat="server" CssClass="modal-pop right meeting-big">
                <asp:HyperLink ID="HyperLinkClose" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

                <asp:UpdatePanel ID="RunCampaingUpdatePanel" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                        <asp:Label ID="RunCampaingLabel" runat="server" SkinID="ModalTitle">
                            <asp:TextBox ID="SearchContactTextBox" runat="server" AutoPostBack="true"></asp:TextBox>
                            <asp:LinkButton ID="IssueLinkButton" runat="server" Text="Done" OnClick="IssueLinkButton_Click"></asp:LinkButton>
                            <asp:CheckBox ID="SelectAllCheckBox" runat="server" OnCheckedChanged="SelectAllCheckBox_CheckedChanged" AutoPostBack="true" Text="Select All" />



                        </asp:Label>
                        <asp:Panel ID="ContactListModalPanel" runat="server" SkinID="ModalListPanel">

                            <asp:ObjectDataSource ID="ContactsObjectDataSource" runat="server"
                                SelectMethod="GetContactByName" TypeName="C3App.BLL.ContactBL">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="SearchContactTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <asp:GridView ID="ContactGridView" runat="server" class="list-form"
                                AutoGenerateColumns="False" ShowHeader="false"
                                DataKeyNames="ContactID" GridLines="None"
                                DataSourceID="ContactsObjectDataSource">
                                <EmptyDataTemplate>
                                    <p>No Data Found.</p>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Image ID="ContactImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/contact.jpg" />
                                            <asp:LinkButton ID="SelectContactButton" runat="server" CommandName="Select" CausesValidation="False">
                                                <%# Eval("FirstName")%>
                                                <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                            </asp:LinkButton>
                                            <asp:CheckBox runat="server" ID="ContactCheckBox" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </asp:Panel>


        </asp:Panel>


        <asp:Panel ID="CampaignTargetModalPanel" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label4" runat="server" SkinID="ModalTitle" Text="Campaign Summary"></asp:Label>
            <asp:Panel ID="Panel9" SkinID="ModalListPanel" runat="server">

                <asp:ObjectDataSource ID="CampaignTargetObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Contact"
                    TypeName="C3App.BLL.ContactBL" SelectMethod="GetContactByCampaignTargets">
                    <SelectParameters>
                        <asp:Parameter Name="campaignType" Type="String" DefaultValue="Contacts"></asp:Parameter>
                        <asp:SessionParameter SessionField="EditCampaignID" Name="campaignID" Type="Int64"></asp:SessionParameter>
                    </SelectParameters>
                </asp:ObjectDataSource>

                <asp:UpdatePanel runat="server" ID="CampaignSummaryUpdatePanel" UpdateMode="Conditional">
                    <ContentTemplate>

                        <asp:GridView ID="CampaignTargetGridView" runat="server" class="list-form"
                            AutoGenerateColumns="False" ShowHeader="false" GridLines="None"
                            DataSourceID="CampaignTargetObjectDataSource">
                            <EmptyDataTemplate>
                                <p>No Data Found.</p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField HeaderText="Target Name">
                                    <ItemTemplate>
                                        <asp:Image ID="ContactImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/contact.jpg" />
                                        <asp:LinkButton ID="SelectContactButton" runat="server" CommandName="Select" CausesValidation="False">
                                            <%# string.Concat(Eval("FirstName")," ",Eval("LastName"))%>
                                            <asp:Label ID="EmailLabel" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </asp:Panel>
        </asp:Panel>
    </asp:Panel>

    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="MessageLiteral" runat="server" Text=""></asp:Literal>
                </h4>
                <a class="close-reveal-modal">&#215;</a>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>

