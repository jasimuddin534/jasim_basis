<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Opportunities.aspx.cs" Inherits="C3App.Opportunities.Opportunities" %>

<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">

    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">

        <%--<asp:Button ID="accountSearchButton" runat="server" CommandName="ShowPanel" CommandArgument="DetailsView" OnClick="ShowPanel" OnClientClick="ShowPanel()" Text="ButtonNew" />--%>
        <%--        <asp:LinkButton ID="OpportunityInsertLinkButton" runat="server" SkinID="TabTitle" Text="Opportunity Details" CommandArgument="Insert" OnClientClick="GoToTab(1);" OnClick="OpportunityInsertLinkButton_Click" />--%>
        <asp:LinkButton ID="OpportunityInsertLinkButton" runat="server" SkinID="TabTitle" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Opportunity');" OnClick="OpportunityInsertButton_Click">Create Opportunity</asp:LinkButton>
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">

            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <%--                    <asp:AsyncPostBackTrigger ControlID="UpdateTab1" EventName="Click" />--%>
                    <asp:AsyncPostBackTrigger ControlID="OpportunityInsertLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />

                </Triggers>
                <ContentTemplate>
                    <%-- 
                        Place your DetialsPanel Content Here 
                    --%>

                    <asp:ValidationSummary ID="OpportunityValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                    <asp:Label ID="message" runat="server" Visible="False" Text="Label"></asp:Label>

                    <asp:ObjectDataSource ID="OpportunityDetailsObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity" DeleteMethod="DeleteOpportunity" InsertMethod="InsertOpportunity" SelectMethod="OpportunityByID" TypeName="C3App.BLL.OpportunityBL" UpdateMethod="UpdateOpportunity" OnInserted="OpportunityDetailsObjectDataSource_Inserted" OnUpdated="OpportunityDetailsObjectDataSource_Updated">
                        <%-- <SelectParameters>
                            <asp:QueryStringParameter Name="opportunityId" QueryStringField="OpportunityID" Type="Int32" />
                        </SelectParameters>--%>
                        <SelectParameters>
                            <asp:SessionParameter SessionField="OpportunityID" Name="opportunityId" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>

                    <asp:DetailsView CssClass="details-form" FieldHeaderStyle-CssClass="field-label" ID="OpportunityDetailsView" runat="server" AutoGenerateRows="False"
                        DataSourceID="OpportunityDetailsObjectDataSource" OnItemInserting="OpportunityDetailsView_ItemInserting"
                        DataKeyNames="Name,OpportunityID,CompanyID,CreatedTime,createdBy,AccountID" OnItemUpdating="OpportunityDetailsView_ItemUpdating"
                        OnItemCommand="OpportunityDetailsView_ItemCommand" OnItemInserted="OpportunityDetailsView_ItemInserted"
                        OnItemUpdated="OpportunityDetailsView_ItemUpdated" DefaultMode="Insert">
                        <Fields>
                            <asp:DynamicField DataField="Name" HeaderText="Opportunity Name" SortExpression="Name" ValidationGroup="sum"></asp:DynamicField>
                            <%--<asp:TemplateField HeaderText="Account Name" SortExpression="AccountID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AccountsDataSource" runat="server" DataObjectTypeName="C3App.DAL.Account" SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AccountsDropDownList" runat="server" DataSourceID="AccountsDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("AccountID")==null ? "-1" : Eval("AccountID") %>'
                                        DataTextField="Name" DataValueField="AccountID" OnInit="AccountsDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="AccountsDataSource" runat="server" DataObjectTypeName="C3App.DAL.Account" SelectMethod="GetAccounts" TypeName="C3App.BLL.AccountBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AccountsDropDownList" runat="server" DataSourceID="AccountsDataSource" AppendDataBoundItems="True"
                                        DataTextField="Name" DataValueField="AccountID" OnInit="AccountsDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Account Name" SortExpression="Account.Name">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AccountNameTextBox" runat="server" ReadOnly="True" Text='<%# Eval("Account.Name") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton212" runat="server" CommandArgument="Accounts" OnClick="SelectButton_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                    <asp:RequiredFieldValidator ID="AccountNameRequiredValidator" runat="server" ControlToValidate="AccountNameTextBox" Display="Static"
                                        ErrorMessage="Account Name is Required" Text="*" ForeColor="Red" ValidationGroup="sum" />

                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="AccountNameTextBox" runat="server" ReadOnly="True" Text='<%# Bind("AccountID") %>' SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton2" runat="server" CommandArgument="Accounts" OnClick="SelectButton_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                    <asp:RequiredFieldValidator ID="AccountNameRequiredValidator" runat="server" ControlToValidate="AccountNameTextBox" Display="Static"
                                        ErrorMessage="Account Name is Required" Text="*" ForeColor="Red" ValidationGroup="sum" />

                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="AccountID" runat="server" Text='<%# Eval("Account.Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Type" SortExpression="OpportunityTypeID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="OpportunityTypesDataSource" runat="server" DataObjectTypeName="C3App.DAL.OpportunityType" SelectMethod="GetOpportunityTypes" TypeName="C3App.BLL.OpportunityBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="OpportunityTypesDropDownList" runat="server" DataSourceID="OpportunityTypesDataSource"
                                        AppendDataBoundItems="True" SelectedValue='<%# Eval("OpportunityTypeID")==null ? "-1" : Eval("OpportunityTypeID") %>'
                                        DataTextField="Value" DataValueField="OpportunityTypeID" OnInit="OpportunityTypesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="OpportunityTypesDataSource" runat="server" DataObjectTypeName="C3App.DAL.OpportunityType" SelectMethod="GetOpportunityTypes" TypeName="C3App.BLL.OpportunityBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="OpportunityTypesDropDownList" runat="server" DataSourceID="OpportunityTypesDataSource" AppendDataBoundItems="True"
                                        DataTextField="Value" DataValueField="OpportunityTypeID" OnInit="OpportunityTypesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Lead Source" SortExpression="LeadSourceID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="LeadSourcesDataSource" runat="server" DataObjectTypeName="C3App.DAL.LeadSource" SelectMethod="GetLeadSources" TypeName="C3App.BLL.LeadBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="leadSourcesDropDownList" runat="server" DataSourceID="LeadSourcesDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("LeadSourceID")==null ? "-1" : Eval("LeadSourceID") %>'
                                        DataTextField="Value" DataValueField="LeadSourceID" OnInit="LeadSourcesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="LeadSourcesDataSource" runat="server" DataObjectTypeName="C3App.DAL.LeadSource" SelectMethod="GetLeadSources" TypeName="C3App.BLL.LeadBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="leadSourcesDropDownList" runat="server" DataSourceID="LeadSourcesDataSource" AppendDataBoundItems="True"
                                        DataTextField="Value" DataValueField="LeadSourceID" OnInit="LeadSourcesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Currency" SortExpression="CurrencyID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CurrenciesDataSource" runat="server" DataObjectTypeName="C3App.DAL.Currency" SelectMethod="GetCurrencies" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CurrenciesDropDownList" runat="server" DataSourceID="CurrenciesDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Bind("CurrencyID") %>'
                                        DataTextField="Name" DataValueField="CurrencyID" OnInit="CurrenciesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="CurrenciesDataSource" runat="server" DataObjectTypeName="C3App.DAL.Currency" SelectMethod="GetCurrencies" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CurrenciesDropDownList" runat="server" DataSourceID="CurrenciesDataSource" AppendDataBoundItems="True"
                                        DataTextField="Name" DataValueField="CurrencyID" OnInit="CurrenciesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:TemplateField HeaderText="Amount" SortExpression="Amount">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("Amount") %>' ID="AmountTextBox"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("Amount") %>' ID="AmountTextBox"></asp:TextBox>--%>
                            <%--                                    <asp:RequiredFieldValidator ID="AmountRequiredValidator" runat="server" ControlToValidate="AmountTextBox" Display="Static"
                                        ErrorMessage="Amount is Required" Text="*" ForeColor="Red" ValidationGroup="sum" />--%>
                            <%--  </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("Amount") %>' ID="AmountTextBox"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:DynamicField DataField="Amount" HeaderText="Amount" SortExpression="Amount" ValidationGroup="sum" />


                            <asp:TemplateField HeaderText="Date Enclosed" SortExpression="DateEnclosed">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("DateEnclosed", "{0:d}") %>' CssClass="datepicker" ID="TextBox2"></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox runat="server" Text='<%# Bind("DateEnclosed") %>' CssClass="datepicker" ID="TextBox2"></asp:TextBox>
                                </InsertItemTemplate>

                            </asp:TemplateField>

                            <asp:DynamicField DataField="NextStep" HeaderText="Next Step" SortExpression="NextStep" ValidationGroup="sum" />
                            <asp:DynamicField DataField="Probability" HeaderText="Probability(%)" SortExpression="Probability" ValidationGroup="sum" />
                            <asp:TemplateField HeaderText="Sales Stage" SortExpression="SalesStageID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="SalesStagesDataSource" runat="server" DataObjectTypeName="C3App.DAL.OpportunitySalesStage" SelectMethod="GetOpportunitySalesStages" TypeName="C3App.BLL.OpportunityBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="SalesStagesDropDownList" runat="server" DataSourceID="SalesStagesDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("SalesStageID")==null ? "-1" : Eval("SalesStageID") %>'
                                        DataTextField="Value" DataValueField="OpportunitySalesStageID" OnInit="SalesStagesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="SalesStagesDataSource" runat="server" DataObjectTypeName="C3App.DAL.OpportunitySalesStage" SelectMethod="GetOpportunitySalesStages" TypeName="C3App.BLL.OpportunityBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="SalesStagesDropDownList" runat="server" DataSourceID="SalesStagesDataSource" AppendDataBoundItems="True"
                                        DataTextField="Value" DataValueField="OpportunitySalesStageID" OnInit="SalesStagesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Campaign Name" SortExpression="CampaignID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CampaignNamesDataSource" runat="server" DataObjectTypeName="C3App.DAL.Campaign" SelectMethod="GetCampaigns" TypeName="C3App.BLL.CampaignBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CampaignNamesDropDownList" runat="server" DataSourceID="CampaignNamesDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("CampaignID")==null ? "-1" : Eval("CampaignID") %>'
                                        DataTextField="Name" DataValueField="CampaignID" OnInit="CampaignNamesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="CampaignNamesDataSource" runat="server" DataObjectTypeName="C3App.DAL.Campaign" SelectMethod="GetCampaigns" TypeName="C3App.BLL.CampaignBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CampaignNamesDropDownList" runat="server" DataSourceID="CampaignNamesDataSource" AppendDataBoundItems="True"
                                        DataTextField="Name" DataValueField="CampaignID" OnInit="CampaignNamesDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Teams" SortExpression="TeamID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TeamsDataSource" runat="server" DataObjectTypeName="C3App.DAL.Team" SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsDropDownList" runat="server" DataSourceID="TeamsDataSource" AppendDataBoundItems="True"
                                        SelectedValue='<%# Eval("TeamID")==null ? "-1" : Eval("TeamID") %>'
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="TeamsDataSource" runat="server" DataObjectTypeName="C3App.DAL.Team" SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsDropDownList" runat="server" DataSourceID="TeamsDataSource" AppendDataBoundItems="True"
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignTODataSource" runat="server" DataObjectTypeName="C3App.DAL.User" SelectMethod="GetUsers" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssignedToDropDownList" runat="server" DataSourceID="AssignTODataSource" AppendDataBoundItems="True" AutoPostBack="True"
                                        SelectedValue='<%# Eval("AssignedUserID")==null ? "-1" : Eval("AssignedUserID") %>'
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssignedToDropDownList_Init" OnSelectedIndexChanged="AssignedToDropDownList_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="AssignTODataSource" runat="server" DataObjectTypeName="C3App.DAL.User" SelectMethod="GetUsers" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssignedToDropDownList" runat="server" DataSourceID="AssignTODataSource" AppendDataBoundItems="True" AutoPostBack="True"
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssignedToDropDownList_Init" OnSelectedIndexChanged="AssignedToDropDownList_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <InsertItemTemplate>
                                    <asp:Label runat="server" ID="NotifyLabel" Text="Notify User" Visible="False"></asp:Label>
                                    <asp:CheckBox runat="server" ID="NotifyCheckBox" Visible="False" />
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:Label runat="server" ID="NotifyLabel" Text="Notify User" Visible="False"></asp:Label>
                                    <asp:CheckBox runat="server" ID="NotifyCheckBox" Visible="False" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:TextBox>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Update" Text="Save" ValidationGroup="sum"></asp:LinkButton>&nbsp;
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="LinkButton4" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="LinkButton3" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" ValidationGroup="sum" Text="Save"></asp:LinkButton>&nbsp;
                                </InsertItemTemplate>
                            </asp:TemplateField>

                        </Fields>
                    </asp:DetailsView>

                    <br />

                </ContentTemplate>

            </asp:UpdatePanel>

            <asp:UpdateProgress ID="OpportunityDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>
        <asp:Panel ID="ModalPanel1" SkinID="ModalPopLeft" runat="server">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

            <asp:UpdatePanel runat="server" ID="UpdatePanel3" UpdateMode="Always">
                <Triggers>
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="ModalLabel" runat="server" SkinID="ModalTitle" Text="Select Account"></asp:Label>
                    <asp:LinkButton ID="CreateAccountButton" runat="server" CssClass="modal-create-btn" Text="Create" OnClientClick="OpenCreateModal('BodyContent_ModalPanel291')" />


                    <asp:Panel ID="ModalSearchPanel" SkinID="ModalSearchPanel" runat="server">
                        <%--                    Search Panel--%>
                        <%-- 
                            Place your Search Panel Content Here 
                        --%>
                        <asp:Panel ID="AccountSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="Panel6" runat="server" CssClass="search">
                                <asp:Label ID="Label12" runat="server" Text="Search"></asp:Label>
                                <asp:TextBox ID="AccountSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="AccountSearchTextBox_TextChanged"></asp:TextBox>
                            </asp:Panel>
                        </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="ModalListPanel" SkinID="ModalListPanel" runat="server">
                        <asp:ObjectDataSource ID="AccountObjectDataSource" runat="server" SelectMethod="SearchAccount" TypeName="C3App.BLL.AccountBL">

                            <SelectParameters>
                                <asp:ControlParameter ControlID="AccountSearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:UpdatePanel ID="AccountList" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="AccountGridView" runat="server" AutoGenerateColumns="False" DataSourceID="AccountObjectDataSource" Visible="False"
                                    CssClass="list-form" ShowHeader="False">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" Height="60" Width="60" />
                                                <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("AccountID") %>' CommandName="Select" OnCommand="AccountSelectLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>

                                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>

                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>

        </asp:Panel>
                <asp:Panel ID="ModalPanel291" SkinID="ModalCreatePanelLeft" runat="server">
            <asp:HyperLink ID="HyperLink11" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label31" runat="server" SkinID="ModalTitle" Text="Create Panel">
            </asp:Label>
            <asp:Panel ID="Panel8" runat="server" CssClass="modal-create-content">
                <asp:UpdatePanel runat="server" ID="CreateUpdatePanel" UpdateMode="Conditional">
                    <Triggers>
                    </Triggers>
                    <ContentTemplate>
                        <asp:Panel runat="server" ID="AccountPanel">
                            <asp:ObjectDataSource ID="AccountsDetailsObjectDataSource" runat="server"
                                TypeName="C3App.BLL.AccountBL" DataObjectTypeName="C3App.DAL.Account"
                                InsertMethod="InsertAccount" SelectMethod="GetAccounts" OnInserted="AccountsDetailsObjectDataSource_Inserted"></asp:ObjectDataSource>

                            <asp:ValidationSummary ID="ValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="avs" />
                            <br />
                            <asp:DetailsView ID="AccountDetailsView" runat="server" CssClass="details-form"
                                FieldHeaderStyle-CssClass="field-label"
                                DataSourceID="AccountsDetailsObjectDataSource"
                                DataKeyNames="AccountID"
                                AutoGenerateRows="False"
                                OnItemInserting="AccountDetailsView_ItemInserting"
                                OnItemInserted="AccountDetailsView_ItemInserted"
                                DefaultMode="Insert">
                                <Fields>
                                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="NameText" runat="server"  CssClass="required-field"  Text='<%# Bind("Name") %>'>
                                            </asp:TextBox><asp:RequiredFieldValidator ID="NameRequiredValidator" runat="server" ControlToValidate="NameText" Display="none" ErrorMessage="Name is Required" Text="*" ValidationGroup="avs" />
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="PrimaryEmail" HeaderText="Email Address" SortExpression="PrimaryEmail" />
                                    <asp:BoundField DataField="OfficePhone" HeaderText="Office Phone No" SortExpression="OfficePhone" />
                                    <asp:BoundField DataField="Website" HeaderText="Web Site" SortExpression="Website" />
                                    <asp:TemplateField ShowHeader="False">
                                        <InsertItemTemplate>
                                            <asp:LinkButton ID="InsertLinkButton2" runat="server" CssClass="form-btn" CausesValidation="true" CommandName="Insert" Text="Save" ValidationGroup="avs"></asp:LinkButton>&nbsp;
                                        </InsertItemTemplate>
                                    </asp:TemplateField>
                                </Fields>
                            </asp:DetailsView>
                        </asp:Panel>

                    </ContentTemplate>

                </asp:UpdatePanel>
            </asp:Panel>

        </asp:Panel>



    </asp:Panel>



    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">

        <asp:LinkButton runat="server" ID="OpportunityEditLinksButton" SkinID="TabTitle" OnClick="UpdateButton_Click" Text="View Opportunities" OnClientClick="GoToTab(2,'Create Opportunity')" />

        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">

            <%--    <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="OpportunityEditLinksButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>--%>
            <asp:ObjectDataSource ID="opportunitySearchObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity" InsertMethod="InsertOpportunity" SelectMethod="SearchOpportunities" TypeName="C3App.BLL.OpportunityBL">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" Name="search" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>
            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="Panel12" runat="server" CssClass="filter">
                    <asp:Label ID="Label8" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="SearchAllLinkButton" CssClass="search-label active" OnClick="SearchAllButton_Click">All</asp:LinkButton>
                    <asp:LinkButton runat="server" ID="TopOpportunityLinkButton" CssClass="search-label active" OnClick="TopOpportunityButton_Click">Top</asp:LinkButton>
                    <asp:LinkButton runat="server" ID="ProspectingOpportinityLinkButton" CssClass="search-label active" OnClick="ProspectingOpportunityButton_Click">Prospecting</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="Panel453543" runat="server" CssClass="search" DefaultButton="SearchLinkButton">
                    <asp:Label ID="Label91" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                    <asp:LinkButton ID="SearchLinkButton" runat="server" Text="search" CssClass="search-btn" OnClick="SearchButton_Click" />
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">

                <%-- 
                            Place your ListPanel Content Here 
                --%>

                <asp:ObjectDataSource ID="OpportunityListObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity"
                    InsertMethod="InsertOpportunity" SelectMethod="GetOpportunities" TypeName="C3App.BLL.OpportunityBL"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="TopOpportunityObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity"
                    InsertMethod="InsertOpportunity" SelectMethod="GetTopOpportunities" TypeName="C3App.BLL.OpportunityBL"></asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ProspectingObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity"
                    InsertMethod="InsertOpportunity" SelectMethod="GetProspectingOpportunities" TypeName="C3App.BLL.OpportunityBL"></asp:ObjectDataSource>


                <asp:UpdatePanel ID="upListView" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="OpportunityEditLinksButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="TopOpportunityLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="ProspectingOpportinityLinkButton" EventName="Click" />

                    </Triggers>
                    <ContentTemplate>
<%--                        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Click" />--%>
                        <asp:GridView ID="OpportunityGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                            DataKeyNames="OpportunityID" DataSourceID="OpportunityListObjectDataSource" GridLines="None" ShowHeader="False">
                            <EmptyDataTemplate>
                                <p>
                                    No Opportunities found.
                                </p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/opportunity.jpg" />
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("OpportunityID") %>' CommandName="Select" OnCommand="OpportunitySelectLinkButton_Command" CausesValidation="False">
                                            <%# Eval("Name")%>

                                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("Account.Name") %>'></asp:Label>

                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>

                            </Columns>

                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="OpportunityUpdateProgress" runat="server" AssociatedUpdatePanelID="upListView" DynamicLayout="true" DisplayAfter="0">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </asp:Panel>
            <asp:UpdatePanel ID="miniDetails" runat="server" UpdateMode="Conditional">
                <ContentTemplate>

                    <asp:Panel ID="MiniDetailBasicPanel" SkinID="MiniDetailBasicPanel" runat="server">

                        <asp:ObjectDataSource ID="MiniObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity" InsertMethod="InsertOpportunity" SelectMethod="OpportunityByID" TypeName="C3App.BLL.OpportunityBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="OpportunityGridView" Name="opportunityId" PropertyName="SelectedValue" Type="Int64" />
                            </SelectParameters>

                        </asp:ObjectDataSource>


                        <asp:FormView ID="MiniOpportunityFormView" CssClass="mini-details-form" runat="server" DataSourceID="MiniObjectDataSource"
                            DataKeyNames="OpportunityID">

                            <EmptyDataTemplate>
                                <p>
                                    No Opportunity selected.
                                </p>
                            </EmptyDataTemplate>

                            <ItemTemplate>

                                <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/opportunity.jpg" />
                                <asp:Panel runat="server">
                                    <asp:Label CssClass="fullname" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                    <asp:Label CssClass="royal-building" runat="server" Text='<%# Eval("OpportunityType.Value") %>'></asp:Label>
                                    <asp:Label runat="server" CssClass="chat-arrow-right" Text='<%# Eval("LeadSource.Value") %>'></asp:Label>
                                    <asp:Label runat="server" CssClass="amount" Text='<%# Eval("Amount") %>'></asp:Label>
                                    <asp:Label runat="server" CssClass="circle-arrow-right" Text='<%# Eval("NextStep") %>'></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>

                        <asp:Panel ID="Panel5" runat="server" CssClass="mini-detail-control-panel four-controls">
                            <ul>

                                <li>
                                    <asp:LinkButton ID="CalenderLinkButton" CssClass="control-btn" runat="server" OnClientClick="OpenModal('BodyContent_ModalCalendar')">
                                            <i class="icon-calendar"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:LinkButton CssClass="control-btn " ID="EditLinkButton" runat="server" Text="Edit" CommandArgument=""
                                        OnClientClick="GoToTab(1, 'Opportunity Details');" OnClick="OpportunityEditButton_Click">
                                        <i class="icon-edit"></i>
                                    </asp:LinkButton>
                                </li>
                             
                                <li>
                                     <asp:Panel ID="Panel9" runat="server" CssClass="slide-confirm">
                                    <asp:LinkButton CssClass="control-btn has-confirm " ID="SendMailLinkButton" runat="server" Text="Mail"
                                        OnClientClick="GoToTab(2);">
                                        <i class="icon-share-alt"></i>
                                    </asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton8" runat="server" OnClientClick="GoToTab(2);" OnClick="SendMailButton_Click">Notify</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton9" runat="server" class="slide-cancel">Cancel</asp:LinkButton>

                                    </asp:Panel>
                                </li>
                                   <li>
                                    <asp:Panel ID="Panel7" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton CssClass="control-btn has-confirm " ID="DeleteLinkButton" runat="server" Text="Delete"
                                            OnClientClick="GoToTab(2);">
                                        <i class="icon-trash"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton5" runat="server" OnClientClick="GoToTab(2);" OnClick="OpportunityDeleteButton_Click">Confirm</asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton6" runat="server" class="slide-cancel">Cancel</asp:LinkButton>

                                    </asp:Panel>
                                </li>
                            </ul>

                        </asp:Panel>
                    </asp:Panel>




                    <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <%--                            MiniDetailMorePanel--%>
                        <%-- 
                                Place your MiniDetailMorePanel Content Here 
                        --%>
                        <asp:DetailsView ID="MiniMoreDetailsView" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label" AutoGenerateColumns="False"
                            DataSourceID="MiniObjectDataSource" AutoGenerateRows="False">
                            <EmptyDataTemplate>
                                <p>
                                    No Opportunity selected.
                                </p>
                            </EmptyDataTemplate>

                            <Fields>
                                <asp:TemplateField HeaderText="Sales Stage" SortExpression="SalesStageID">

                                    <ItemTemplate>
                                        <asp:Label runat="server" Text='<%# Eval("OpportunitySalesStage.Value") %>' ID="SaleStageLabel"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount"></asp:BoundField>
                                <asp:BoundField DataField="NextStep" HeaderText="Next Step" SortExpression="NextStep"></asp:BoundField>
                                <asp:BoundField DataField="Probability" HeaderText="Probability" SortExpression="Probability"></asp:BoundField>
                                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                                <asp:BoundField DataField="DateEnclosed" HeaderText="Date Enclosed" SortExpression="DateEnclosed"></asp:BoundField>

                            </Fields>
                        </asp:DetailsView>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="MiniDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="miniDetails">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel3" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent3" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

            <asp:Panel ID="ModalPanel2" SkinID="ModalPopRight" runat="server">
                <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

                <asp:UpdatePanel runat="server" ID="UpdatePanel4">
                    <Triggers>
                        <%--                                    <asp:AsyncPostBackTrigger ControlID="ModalPopButton2" EventName="Click" />--%>
                    </Triggers>
                    <ContentTemplate>
                        <asp:Label ID="Label2" runat="server" SkinID="ModalTitle" Text="Modal Title"></asp:Label>
                        <asp:Panel ID="Panel2" SkinID="ModalCreatePanel" runat="server">
                            Create Panel
                        <%-- 
                            Place your Create Panel Content Here 
                        --%>
                        </asp:Panel>
                        <asp:Panel ID="Panel3" SkinID="ModalSearchPanel" runat="server">
                            Search Panel
                        <%-- 
                            Place your Search Panel Content Here 
                        --%>
                        </asp:Panel>
                        <asp:Panel ID="Panel4" SkinID="ModalListPanel" runat="server">

                            <%-- 
                            Place your List Panel Content Here 
                            --%>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </asp:Panel>

        </asp:Panel>
        <%-- start Calendar in Formview--%>
        <asp:Panel ID="ModalCalendar" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink3" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label4" runat="server" SkinID="ModalTitle" Text="Mini Calendar"></asp:Label>
            <%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="modal-create-btn" Text="Create" PostBackUrl="javascript:void(0)" OnClientClick="OpenCreateModal('BodyContent_Panel112')"></asp:LinkButton>--%>
            <asp:Panel ID="Panel1" SkinID="ModalListPanel" runat="server">
                <table class="calendar-form">
                    <tbody>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                        <a href="#" class="open-btn"><i class="icon-external-link"></i></a>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="date">02</span>
                                <span class="month">JAN</span>
                            </td>
                            <td>
                                <ul class="event">
                                    <li>
                                        <span class="name">Event Name</span>
                                        <span class="time">Time</span>
                                        <span class="label">Attendees: </span><span class="attendees">Tawsif, Jakia Nisa, Yasin Pavel</span>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </asp:Panel>
        </asp:Panel>

        <asp:Panel ID="Panel112" SkinID="ModalCreatePanelRight" runat="server">
            <asp:HyperLink ID="HyperLink12" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label32" runat="server" SkinID="ModalTitle" Text="Create Panel"></asp:Label>
        </asp:Panel>
        <%-- End Calendar in Formview--%>
    </asp:Panel>



    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel78" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="Literal1" runat="server" Text=""></asp:Literal></h4>
                <a class="close-reveal-modal">&#215;</a>
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
