<%@ Page Title="Tasks Page" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Tasks.aspx.cs" Inherits="C3App.Tasks.Tasks" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="BodyContent">
    <!-- Task items  sd-->
    <asp:Panel ID="DetailsPanel" runat="server" SkinID="DetailsTab" tab-id="1">

        <asp:LinkButton ID="TaskDetailLinkButton" runat="server" SkinID="TabTitle" Text="Create Task" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Task');" OnClick="TaskDetailLinkButton_Click" />

        <asp:Panel ID="DetailsContentPanel" runat="server" SkinID="TabContent">
            <asp:UpdatePanel ID="TaskDetailsUpdatePanel" runat="server">

                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="TaskDetailLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>

                    <asp:ValidationSummary ID="TaskDetailValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                    <asp:ObjectDataSource ID="TaskDetailsObjectDataSource" runat="server"
                        OldValuesParameterFormatString="original_{0}"
                        TypeName="C3App.BLL.TaskBL"
                        DataObjectTypeName="C3App.DAL.Task"
                        InsertMethod="InsertOrUpdateTask"
                        SelectMethod="GetTaskByID"
                        UpdateMethod="InsertOrUpdateTask"
                        DeleteMethod="DeleteTaskByID"
                        OnInserted="TaskDetailsObjectDataSource_Inserted"
                        OnUpdated="TaskDetailsObjectDataSource_Updated">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditTaskID" Name="taskID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>

                    <asp:DetailsView ID="TaskDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="fields-label"
                        AutoGenerateRows="False"
                        DataSourceID="TaskDetailsObjectDataSource"
                        DataKeyNames="TaskID,CreatedTime,CreatedBy"
                        OnItemInserting="TaskDetailsView_ItemInserting"
                        OnItemUpdating="TaskDetailsView_ItemUpdating"
                        OnItemCommand="TaskDetailsView_ItemCommand"
                        OnDataBound="TaskDetailsView_DataBound"
                        DefaultMode="Insert">
                        <Fields>

                            <asp:TemplateField HeaderText="Subject" SortExpression="Subject">
                                <EditItemTemplate>
                                    <asp:TextBox ID="SubjectTextBox" runat="server" CssClass="required-field mask-name" Text='<%# Bind("Subject") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="SubjectRequiredValidator" runat="server" ControlToValidate="SubjectTextBox" ErrorMessage="Subject is Required" Text="*" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator ID="SubjectRegularExpression" runat="server" ControlToValidate="SubjectTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" Text="" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Subject" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Status" SortExpression="StatusID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TaskStatusObjectDataSource" runat="server" TypeName="C3App.BLL.TaskBL" SelectMethod="GetTaskStatuses" DataObjectTypeName="C3App.DAL.TaskStatus"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="StatusDropDownList1" runat="server" AppendDataBoundItems="true" DataSourceID="TaskStatusObjectDataSource" DataTextField="Value" DataValueField="TaskStatusID" OnInit="StatusDropDownList_Init" SelectedValue='<%# Eval("StatusID")==null ? "0" : Eval("StatusID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Start Date" SortExpression="StartDate">
                                <EditItemTemplate>
                                    <asp:TextBox ID="StartDateTextBox" runat="server" CssClass="datepicker" DataFormatString="{0:d}" Text='<%# Bind("StartDate","{0:d}") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Due Date" SortExpression="DueDate">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DueDateTextBox" runat="server" CssClass="datepicker" DataFormatString="{0:d}" Text='<%# Bind("DueDate","{0:d}") %>'></asp:TextBox>
                                    <asp:CompareValidator ID="DateCompareValidator" runat="server" Operator="GreaterThanEqual" Type="Date" ControlToValidate="DueDateTextBox" ControlToCompare="StartDateTextBox" ErrorMessage="Due Date must be greater than Start Date !" Text="*" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Parent Type">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ParentTypeDropDownList" runat="server" AppendDataBoundItems="true" OnInit="ParentTypeDropDownList_Init" SelectedValue='<%# Eval("ParentType")==null ? "None" : Eval("ParentType") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="None"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Accounts" Value="Accounts"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Teams" Value="Teams"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Users" Value="Users"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Contacts" Value="Contacts"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Opportunity" Value="Opportunity"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Parent Name" SortExpression="ParentID">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ParentNameTextBox" runat="server" CssClass="mask-name" SkinID="TextBoxWithButton" ReadOnly="true" Text='<%# Bind("ParentID") %>'></asp:TextBox>
                                    <asp:Button ID="ModalPopButton" runat="server" OnClick="ModalPopButton_Click" OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Contact" SortExpression="ContactID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="ContactObjectDataSource" runat="server" TypeName="C3App.BLL.ContactBL" SelectMethod="GetContacts" DataObjectTypeName="C3App.DAL.Contact"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="ContactDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="ContactObjectDataSource" DataTextField="FirstName" DataValueField="ContactID" OnInit="ContactDropDownList_Init" SelectedValue='<%# Eval("ContactID")==null ? "0" : Eval("ContactID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Priority" SortExpression="Priority">
                                <EditItemTemplate>
                                    <asp:TextBox ID="PriorityTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("Priority") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="PriorityLength" runat="server" ControlToValidate="PriorityTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" Text="" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Priority Field" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedTo">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignedUserObjectDataSource" runat="server" TypeName="C3App.BLL.UserBL" SelectMethod="GetUsersByCompanyID" DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssaigendUserDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="AssignedUserObjectDataSource"
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssaigendUserDropDownList_Init" OnSelectedIndexChanged="AssaigendUserDropDownList_SelectedIndexChanged" AutoPostBack="true"
                                        SelectedValue='<%# Eval("AssignedUserID")==null ? "0" : Eval("AssignedUserID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:Label ID="NotifyLabel" runat="server" Text="Notify user" Visible="False"></asp:Label>
                                    <asp:CheckBox ID="NotifyCheckBox" runat="server" Text="" Visible="False" OnCheckedChanged="NotifyCheckBox_CheckedChanged" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TeamObjectDataSource" runat="server" TypeName="C3App.BLL.TeamBL" SelectMethod="GetTeamsByCompanyID" DataObjectTypeName="C3App.DAL.Team"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamDropDownList" runat="server" DataSourceID="TeamObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("TeamID")==null ? "0" : Eval("TeamID") %>'
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False">
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>&nbsp;
                                    <asp:LinkButton ID="InsertLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" Text="Save" ValidationGroup="sum"></asp:LinkButton>
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

            <asp:UpdateProgress ID="TaskDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="TaskDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h4>Loading...</h4>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>


        <asp:Panel ID="ModalPanel1" runat="server" SkinID="ModalPopLeft">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

            <asp:UpdatePanel ID="ModalUpdatePanel" runat="server" UpdateMode="Always">
                <Triggers>
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="ModalTitleLabel" runat="server" SkinID="ModalTitle"></asp:Label>

                    <asp:Panel ID="ModalSearchPanel" runat="server" SkinID="ModalSearchPanel">

                        <asp:Panel ID="AccountSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="AccountSearchPane2" runat="server" CssClass="search">
                                <asp:Label ID="AccountSearchLabel" runat="server" Text="Search" />
                                <asp:TextBox ID="AccountSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="AccountSearch_Event"></asp:TextBox>
                                <asp:LinkButton ID="AccountSearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="AccountSearch_Event"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="TeamSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="TeamSearchPanel2" runat="server" CssClass="search">
                                <asp:Label ID="TeamSearchLabel" runat="server" Text="Search" />
                                <asp:TextBox ID="TeamSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="TeamSearch_Event"></asp:TextBox>
                                <asp:LinkButton ID="TeamSearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="TeamSearch_Event"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="UserSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="UserSearchPanel2" runat="server" CssClass="search">
                                <asp:Label ID="UserSearchLabel" runat="server" Text="Search" />
                                <asp:TextBox ID="UserSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="UserSearch_TextChanged"></asp:TextBox>
                                <asp:LinkButton ID="UserSearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="UserSearch_TextChanged"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="ContactSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="ContactSearchPanel2" runat="server" CssClass="search">
                                <asp:Label ID="ContactSearchLabel" runat="server" Text="Search" />
                                <asp:TextBox ID="ContactSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="ContactSearchTextBox_TextChanged"></asp:TextBox>
                                <asp:LinkButton ID="ContactSearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="ContactSearchTextBox_TextChanged"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="OpportunitySearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="OpportunitySearchPanel2" runat="server" CssClass="search">
                                <asp:Label ID="OpportunitySearchLabel" runat="server" Text="Search" />
                                <asp:TextBox ID="OpportunitySearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="OpportunitySearch_TextChanged"></asp:TextBox>
                                <asp:LinkButton ID="OpportunitySearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="OpportunitySearch_TextChanged"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                    </asp:Panel>

                    <asp:Panel ID="ModalListPanel" runat="server" SkinID="ModalListPanel">

                        <asp:UpdatePanel ID="AccountListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <asp:ObjectDataSource ID="AccountObjectDataSource" runat="server" SelectMethod="SearchAccount" TypeName="C3App.BLL.AccountBL">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="AccountSearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:GridView ID="AccountGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False" DataSourceID="AccountObjectDataSource" Visible="False" ShowHeader="False">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/user.jpg" />
                                                <asp:LinkButton ID="AccountListLinkButton" runat="server" CommandArgument='<%# Eval("AccountID") %>' CommandName="Select" OnCommand="AccountListLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="AccountEmail1Label" runat="server" Text='<%# Eval("PrimaryEmail") %>' />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <asp:UpdatePanel ID="TeamListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <asp:ObjectDataSource ID="TeamsObjectDataSource" runat="server" SelectMethod="GetTeamsByName" TypeName="C3App.BLL.TeamBL" DataObjectTypeName="C3App.DAL.Team">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="TeamSearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:GridView ID="TeamsGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False" Visible="false"
                                    DataKeyNames="Name,TeamID"
                                    DataSourceID="TeamsObjectDataSource" GridLines="None">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" CssClass="img-profile" ImageUrl="~/Users/Images/Chrysanthemum.jpg" />
                                                <asp:LinkButton ID="TeamListLinkButton" runat="server" CommandArgument='<%# Eval("TeamID") %>' CommandName="Select" OnCommand="TeamListLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <asp:UpdatePanel ID="UserListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <asp:ObjectDataSource ID="UserObjectDataSource" runat="server" SelectMethod="GetUsersByFirstName" TypeName="C3App.BLL.UserBL" DataObjectTypeName="C3App.DAL.User">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="UserSearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:GridView ID="UserGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                                    DataKeyNames="FirstName,UserID" ShowHeader="false"
                                    DataSourceID="UserObjectDataSource" GridLines="None">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" CssClass="img-profile" ImageUrl="~/Content/images/c3/user.jpg" />
                                                <asp:LinkButton ID="UserListLinkButton" runat="server" CommandArgument='<%# Eval("UserID") %>' CommandName="Select" OnCommand="UserListLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("FirstName")%>
                                                    <asp:Label ID="PrimaryEmailLabel" runat="server" Text='<%# Eval("PrimaryEmail") %>' />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <asp:UpdatePanel ID="ContactListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <asp:ObjectDataSource ID="ContactListObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Contact" TypeName="C3App.BLL.ContactBL" SelectMethod="GetContactByName">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ContactSearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:GridView ID="ContactListGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                                    DataKeyNames="FirstName,ContactID" ShowHeader="false"
                                    DataSourceID="ContactListObjectDataSource" GridLines="None">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/contact.jpg" />
                                                <asp:LinkButton ID="ContactListLinkButton" runat="server" CommandArgument='<%# Eval("ContactID") %>' CommandName="Select" OnCommand="ContactListLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("FirstName")%>
                                                    <asp:Label ID="EmailAddressLabel" runat="server" Text='<%# Eval("PrimaryEmail") %>' />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                        <asp:UpdatePanel ID="OpportunityUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <asp:ObjectDataSource ID="OpportunityListObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity" SelectMethod="SearchOpportunities" TypeName="C3App.BLL.OpportunityBL">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="OpportunitySearchTextBox" Name="search" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:GridView ID="OpportunityListGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                                    DataKeyNames="Name,OpportunityID" DataSourceID="OpportunityListObjectDataSource" GridLines="None" ShowHeader="False">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/opportunity.jpg" Height="60" Width="60" />
                                                <asp:LinkButton ID="OpportunityListLinkButton" runat="server" CommandArgument='<%# Eval("OpportunityID") %>' CommandName="Select" OnCommand="OpportunityListLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="AccountNameLabel" runat="server" Text='<%# Eval("Account.Name") %>' />
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

    </asp:Panel>


    <asp:Panel ID="ViewPanel" runat="server" SkinID="ViewTab" tab-id="2">
        <asp:LinkButton runat="server" ID="ViewTaskLinkButton" SkinID="TabTitle" OnClick="ViewTaskLinkButton_Click" Text="View Tasks" OnClientClick="GoToTab(2,'Create Task');" />
        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">


            <asp:Panel ID="SearchPanel" runat="server" SkinID="SearchPanel">

                <asp:Panel ID="SearchFilterPanel1" runat="server" CssClass="filter">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search Filter" />
                    <asp:LinkButton ID="SearchAllLinkButton" runat="server" CssClass="search-label active" Text="All" OnClick="SearchAllLinkButton_Click"></asp:LinkButton>
                    <asp:LinkButton ID="SearchNotStartedLinkButton" runat="server" CssClass="search-label active" Text="Not Started" OnClick="SearchNotStartedLinkButton_Click"></asp:LinkButton>
                    <asp:LinkButton ID="SearchInProgressLinkButton" runat="server" CssClass="search-label active" Text="In Progress" OnClick="SearchInProgressLinkButton_Click"></asp:LinkButton>
                    <asp:LinkButton ID="SearchCompletedLinkButton" runat="server" CssClass="search-label active" Text="Completed" OnClick="SearchCompletedLinkButton_Click"></asp:LinkButton>

                </asp:Panel>

                <asp:Panel ID="SearchFilterPanel2" runat="server" CssClass="search" DefaultButton="SearchLinkButton">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search" />
                    <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                    <asp:LinkButton ID="SearchLinkButton" runat="server" CssClass="search-btn" OnClick="SearchLinkButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>

            </asp:Panel>

            <asp:Panel ID="ListPanel" runat="server" SkinID="ListPanel">
                <asp:UpdatePanel ID="TaskListUpdatePanel" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewTaskLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchNotStartedLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchInProgressLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchCompletedLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>

                        <asp:ObjectDataSource ID="SearchTaskObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Task" TypeName="C3App.BLL.TaskBL" SelectMethod="GetTaskBySubject" UpdateMethod="InsertOrUpdateTask">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="SearchTextBox" Name="subjectSearch" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:ObjectDataSource ID="TaskListObjectDataSource" runat="server" SelectMethod="GetTasks" TypeName="C3App.BLL.TaskBL" DataObjectTypeName="C3App.DAL.Task"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="SearchNotStartedTaskObjectDataSource" runat="server" SelectMethod="GetNotStartedTask" TypeName="C3App.BLL.TaskBL" DataObjectTypeName="C3App.DAL.Task"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="SearchInProgressTaskObjectDataSource" runat="server" SelectMethod="GetInProgressTask" TypeName="C3App.BLL.TaskBL" DataObjectTypeName="C3App.DAL.Task"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="SearchCompletedTaskObjectDataSource" runat="server" SelectMethod="GetCompletedTask" TypeName="C3App.BLL.TaskBL" DataObjectTypeName="C3App.DAL.Task"></asp:ObjectDataSource>


                        <asp:GridView ID="TaskListGridView" runat="server" CssClass="list-form"
                            AutoGenerateColumns="False"
                            DataKeyNames="TaskID"
                            DataSourceID="TaskListObjectDataSource"
                            GridLines="None"
                            ShowHeader="false">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="TaskImage" runat="server" ImageUrl="~/Content/images/c3/task.jpg" Height="60" Width="60" />

                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("TaskID")+ ";" + Eval("AssignedUserID") + ";" + Eval("ParentID")+";"+Eval("ParentType")+";"+Eval("Subject") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                            <%--<asp:LinkButton ID="TaskListLinkButton" runat="server" CommandArgument='<%# Eval("TaskID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">--%>
                                            <%# Eval("Subject") %>&nbsp;<br />
                                            <asp:Label ID="CaseNumberLabel" runat="server" Text='<%# Eval("TaskStatus.Value") %>'></asp:Label>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdateProgress ID="TaskListUpdateProgress" runat="server" AssociatedUpdatePanelID="TaskListUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h4>Loading...</h4>
                            <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </asp:Panel>

            <asp:UpdatePanel ID="TaskMiniDetailsUpdatePanel" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="NotifyLinkButton" />
                </Triggers>
                <ContentTemplate>

                    <asp:Panel ID="MiniDetailBasicPanel" runat="server" CssClass="mini-detail-panel">

                        <asp:ObjectDataSource ID="TaskMiniDetailObjectDataSource" runat="server" TypeName="C3App.BLL.TaskBL" SelectMethod="GetTaskByID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TaskListGridView" Type="Int64" Name="taskID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:FormView ID="TaskMiniDetailFormView" runat="server" CssClass="mini-details-form" DataSourceID="TaskMiniDetailObjectDataSource" DataKeyNames="TaskID">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Image ID="UserImage" runat="server" CssClass="img-profile" ImageUrl="~/Content/images/c3/task.jpg" />
                                <asp:Panel ID="Panel1" runat="server">
                                    <asp:Label ID="SubjectLabel" runat="server" CssClass="fullname" Text='<%# Eval("Subject") %>'></asp:Label>
                                    <asp:Label ID="TaskStutasLabel" runat="server" CssClass="hourglass" Text='<%# Eval("TaskStatus.Value") %>'></asp:Label>
                                    <asp:Label ID="PriorityLabel" runat="server" CssClass="star" Text='<%# Eval("Priority") %>'></asp:Label>
                                    <asp:Label ID="StartDateLabel" runat="server" CssClass="start-date" Text='<%# Eval("StartDate","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                    <asp:Label ID="DueDateLabel" runat="server" CssClass="due-date" Text='<%# Eval("DueDate","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>

                        <asp:Panel ID="ButtonPanel" runat="server" CssClass="mini-detail-control-panel three-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="EditLinkButton" runat="server" Text="Edit" ToolTip="Edit" CssClass="control-btn" OnClientClick="GoToTab(1,'Task Details');" OnClick="EditLinkButton_Click">
                                            <i class="icon-edit"></i>
                                    </asp:LinkButton></li>
                                <li>
                                    <asp:Panel ID="TaskNotifyPanel" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="NotifyLinkButton" CssClass="control-btn has-confirm " runat="server" Text="Convert" ToolTip="Notify to User">
                                       <i class="icon-share-alt"></i></asp:LinkButton>
                                        <asp:LinkButton ID="NotifyConfirmLinkButton" runat="server" OnClick="NotifyLinkButton_Click">Notify</asp:LinkButton>
                                        <asp:LinkButton ID="NotifyCancelLinkButton" runat="server" class="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>
                                <li>
                                    <asp:Panel ID="DeleteConfirmPanel" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CssClass="control-btn has-confirm" Text="Delete" CommandArgument="TaskID" ToolTip="Delete">
                                            <i class="icon-trash"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="TaskDeleteLinkButton" runat="server" OnClick="DeleteLinkButton_Click">Confirm</asp:LinkButton>
                                        <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>

                            </ul>
                        </asp:Panel>
                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <asp:Panel ID="MiniTaskDetailMore" runat="server">

                            <asp:DetailsView ID="TaskMiniMoreDetailsView" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label"
                                AutoGenerateRows="False" DataSourceID="TaskMiniDetailObjectDataSource"
                                DataKeyNames="TaskID">
                                <EmptyDataTemplate>
                                    <p>Data Not Found</p>
                                </EmptyDataTemplate>
                                <Fields>
                                    <asp:BoundField DataField="ParentType" HeaderText="Parent Type" SortExpression="ParentType" />

                                    <asp:TemplateField HeaderText="Contact" SortExpression="ContactID">
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Contact.FirstName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Assigned User" SortExpression="AssignedUserID">
                                        <ItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("User.FirstName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Team.Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                </Fields>

                            </asp:DetailsView>

                        </asp:Panel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="miniDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="TaskMiniDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel5" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent5" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage5" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>


    </asp:Panel>


    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel4" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="MessageLiteral" runat="server" Text=""></asp:Literal></h4>
                <a class="close-reveal-modal">&#215;</a>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

