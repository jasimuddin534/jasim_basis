<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Calls.aspx.cs" Inherits="C3App.Calls.Calls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">


    <asp:Panel ID="DetailsPanel" runat="server" SkinID="DetailsTab" tab-id="1">

        <asp:LinkButton ID="CallDetailsLinkButton" runat="server" SkinID="TabTitle" CausesValidation="false" Text="Create Call" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Call');" OnClick="CallDetailsLinkButton_Click" />

        <asp:Panel ID="DetailsContentPanel" runat="server" SkinID="TabContent">
            <asp:UpdatePanel ID="CallsDetailsUpdatePanel" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="CallDetailsLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>

                    <asp:ValidationSummary ID="CallValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="sum" ShowValidationErrors="true" />

                    <asp:ObjectDataSource ID="CallDetailsObjectDataSource" runat="server"
                        TypeName="C3App.BLL.CallBL"
                        DataObjectTypeName="C3App.DAL.Call"
                        InsertMethod="InsertOrUpdateCall"
                        SelectMethod="GetCallByID"
                        UpdateMethod="InsertOrUpdateCall"
                        OnInserted="CallDetailsObjectDataSource_Inserted"
                        OnUpdated="CallDetailsObjectDataSource_Updated">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditCallID" Name="callID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>


                    <asp:DetailsView ID="CallDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="fields-label"
                        AutoGenerateRows="False" DataKeyNames="CallID,CompanyID,IsDeleted,Subject,CreatedBy,CreatedTime,ModifiedBy,ModifiedTime"
                        DataSourceID="CallDetailsObjectDataSource"
                        OnItemInserting="CallDetailsView_ItemInserting"
                        OnItemUpdating="CallDetailsView_ItemUpdating"
                        OnItemCommand="CallDetailsView_ItemCommand"
                        DefaultMode="Insert">
                        <Fields>
                            <asp:TemplateField HeaderText="Subject" SortExpression="Subject">
                                <EditItemTemplate>
                                    <asp:TextBox ID="SubjectTextBox" runat="server" CssClass="required-field mask-name" Text='<%# Bind("Subject") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="SubjectRequiredValidator" runat="server" ControlToValidate="SubjectTextBox" Display="None" ErrorMessage="Subject is Required" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator ID="SubjectRegularExpression" runat="server" ControlToValidate="SubjectTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Subject Field" Text="" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status" SortExpression="Status">
                                <EditItemTemplate>
                                    <asp:TextBox ID="StatusTextBox" runat="server" Text='<%# Bind("Status") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="StatusRegularExpression" runat="server" ControlToValidate="StatusTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Status Field" Text="" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Start Date" SortExpression="DateStart" ItemStyle-CssClass="inline-dates">
                                <EditItemTemplate>
                                    <asp:TextBox ID="StartDateTextBox" CssClass="datepicker required-field" runat="server" Text='<%# Bind("DateStart","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="StartDateRequiredValidator" runat="server" ControlToValidate="StartDateTextBox" Display="Static" ErrorMessage="Start date is required " Text="*" ValidationGroup="sum" />
                                    Start Time<asp:TextBox ID="StartTimeTextBox" runat="server" CssClass="required-field" Text='<%# Eval("DateStart","{0:HH:mm}")%>'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="StartTimeRequiredValidator" runat="server" ControlToValidate="StartTimeTextBox" Display="None" ErrorMessage="Start time is Required" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator ID="StartTimeTextLength" runat="server" ControlToValidate="StartTimeTextBox" Display="None"
                                        ValidationExpression="^[0-9]{1,2}:[0-5][0-9]{1,10}$" Text="" ErrorMessage="24 hours time format (hours & minutes) value are allowed in time filed like (22:30)" ValidationGroup="sum" />

                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="End Date" SortExpression="DateEnd" ItemStyle-CssClass="inline-dates">
                                <EditItemTemplate>
                                    <asp:TextBox ID="EndDateTextBox" CssClass="datepicker required-field" runat="server" Text='<%# Bind("DateEnd","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                    <asp:CompareValidator ID="DateCompareValidator" runat="server" Operator="GreaterThanEqual" Type="Date" ControlToValidate="EndDateTextBox" ControlToCompare="StartDateTextBox" ErrorMessage="End Date must be greater than Start Date !" Text="*" ValidationGroup="sum" />
                                    <asp:RequiredFieldValidator ID="EndDateRequiredValidator" runat="server" ControlToValidate="EndDateTextBox" Display="Static" ErrorMessage="End date is required " Text="*" ValidationGroup="sum" />
                                    End Time<asp:TextBox ID="EndTimeTextBox" runat="server" CssClass="required-field" Text='<%# Eval("DateEnd","{0:HH:mm}")%>' OnTextChanged="EndTimeTextBox_TextChanged" AutoPostBack="true"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="EndTimeRequiredValidator" runat="server" ControlToValidate="EndTimeTextBox" Display="None" ErrorMessage="End time is Required" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator ID="EndTimeTextLength" runat="server" ControlToValidate="EndTimeTextBox" Display="None"
                                        ValidationExpression="^[0-9]{1,2}:[0-5][0-9]{1,10}$" Text="" ErrorMessage="24 hours time format (hours & minutes) value are allowed in time filed like (10:30)" ValidationGroup="sum" />

                                </EditItemTemplate>
                            </asp:TemplateField>

                            
                            <asp:TemplateField HeaderText="Duration Hours" SortExpression="DurationHours">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DurationHoursTextBox" runat="server" CssClass="mask-money" Text='<%# Bind("DurationHours") %>' MaxLength="10" ReadOnly="true"></asp:TextBox>
                                    <%--<asp:RegularExpressionValidator ID="DurationHoursRangeValidator" runat="server" ControlToValidate="DurationHoursTextBox" Display="None"
                                        ErrorMessage="Duration Hours value must be number (0-9) and less thean 10 digit" ValidationExpression="^[0-9]{0,10}?$" ValidationGroup="sum" />--%>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Duration Minutes" SortExpression="DurationMinutes">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DurationMinutesTextBox" runat="server" CssClass="mask-money" Text='<%# Bind("DurationMinutes") %>' MaxLength="10" ReadOnly="true"></asp:TextBox>
                                    <%-- <asp:RegularExpressionValidator ID="DurationMinutesRangeValidator" runat="server" ControlToValidate="DurationMinutesTextBox" Display="None"
                                        ErrorMessage="Duration Minutes value must be number (0-9) and less thean 10 digit" ValidationExpression="^[0-9]{0,10}?$" ValidationGroup="sum" />--%>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Reminder Time" SortExpression="ReminderTime">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ReminderTimeTextBox" runat="server" CssClass="mask-money" Text='<%# Bind("ReminderTime") %>' MaxLength="10"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="ReminderTimeRangeValidator" runat="server" ControlToValidate="ReminderTimeTextBox" Display="None"
                                        ErrorMessage="Reminder Time value must be number (0-9) and less thean 10 digit" ValidationExpression="^[0-9]{0,10}?$" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignedToObjectDataSource" runat="server" TypeName="C3App.BLL.UserBL" SelectMethod="GetUsers" DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssaigendToDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="AssignedToObjectDataSource"
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssaigendToDropDownList_Init"
                                        SelectedValue='<%# Eval("AssignedUserID")==null ? "0" : Eval("AssignedUserID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TameNameObjectDataSource" runat="server" TypeName="C3App.BLL.TeamBL" SelectMethod="GetTeams" DataObjectTypeName="C3App.DAL.Team"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamNameDropDownList" runat="server" DataSourceID="TameNameObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("TeamID")==null ? "0" : Eval("TeamID") %>'
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamNameDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DescriptionText" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine"></asp:TextBox>
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

            <asp:UpdateProgress ID="CallDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="CallsDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h3>Loading....</h3>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>


    </asp:Panel>


    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">
        <asp:LinkButton ID="ViewCallLinkButton" runat="server" SkinID="TabTitle" OnClick="ViewCallLinkButton_Click" Text="View Calls" OnClientClick="GoToTab(2,'Create Call');" />


        <asp:Panel ID="CallViewContentPanel" runat="server" SkinID="TabContent">

            <asp:ObjectDataSource ID="SearchObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Call"
                TypeName="C3App.BLL.CallBL" SelectMethod="GetCallsBySubject">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" Name="callSubject" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>

            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">

                <asp:Panel ID="SearchFilterPanel" runat="server" CssClass="filter">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton ID="SearchAllLinkButton" runat="server" CssClass="search-label active" OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                </asp:Panel>

                <asp:Panel ID="TextSearchPanel" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                    <asp:LinkButton ID="SearchButton" runat="server" CssClass="search-btn" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>

            </asp:Panel>

            <asp:Panel ID="ListPanel" runat="server" SkinID="ListPanel">

                <asp:UpdatePanel ID="CallListUpdatePanel" runat="server" UpdateMode="Conditional">

                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewCallLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                    </Triggers>

                    <ContentTemplate>

                        <asp:ObjectDataSource ID="SearchAllCallsObjectDataSource" runat="server" SelectMethod="GetCalls" DataObjectTypeName="C3App.DAL.Call" TypeName="C3App.BLL.CallBL"></asp:ObjectDataSource>


                        <asp:GridView ID="CallListGridView" runat="server" CssClass="list-form"
                            AutoGenerateColumns="False"
                            DataKeyNames="CallID"
                            DataSourceID="SearchAllCallsObjectDataSource"
                            GridLines="None"
                            ShowHeader="false">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="CaseImage" runat="server" ImageUrl="~/Content/images/c3/calls.jpg" />
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("CallID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                            <%# Eval("Subject") %>&nbsp;<br />
                                            <asp:Label ID="CallStatusLabel" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdateProgress ID="CallListUpdateProgress" runat="server" AssociatedUpdatePanelID="CallListUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </asp:Panel>

            <asp:UpdatePanel ID="MiniDetailBasicUpdatePanel" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Panel ID="MiniDetailBasicPanel" runat="server" CssClass="mini-detail-panel">

                        <asp:ObjectDataSource ID="CallMiniDetailObjectDataSource" runat="server"
                            TypeName="C3App.BLL.CallBL"
                            SelectMethod="GetCallByID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="CallListGridView" Type="Int64" Name="callID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:FormView ID="CallMiniDetailFormView" runat="server" CssClass="mini-details-form"
                            DataSourceID="CallMiniDetailObjectDataSource"
                            DataKeyNames="CallID">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Image ID="CallImage" runat="server" CssClass="img-profile" ImageUrl="~/Content/images/c3/calls.jpg" />
                                <asp:Panel ID="CallMiniDetailBasicPanel" runat="server">
                                    <asp:Label ID="SubjectLabel" runat="server" CssClass="fullname" Text='<%# Eval("Subject") %>'></asp:Label>
                                    <asp:Label ID="StartDateLabel" runat="server" CssClass="start-date" Text='<%# Eval("DateStart","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                    <asp:Label ID="EndDateLabel" runat="server" CssClass="start-date" Text='<%# Eval("DateEnd","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                    <asp:Label ID="AssingedUserLabel" runat="server" CssClass="user" Text='<%# Eval("User.FirstName") %>'></asp:Label>
                                    <asp:Label ID="TeamNameLabel" runat="server" CssClass="team" Text='<%# Eval("Team.Name") %>'></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>


                        <asp:Panel ID="ButtonPanel" runat="server" CssClass="mini-detail-control-panel two-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="EditLinkButton" runat="server" Text="Edit" ToolTip="Edit" CssClass="control-btn" CommandArgument="CaseID" OnClientClick="GoToTab(1,'Call Details');" OnClick="EditLinkButton_Click">
                                            <i class="icon-edit"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:Panel ID="DeleteConfirmPanel" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CssClass="control-btn has-confirm" Text="Delete" CommandArgument="CallID" ToolTip="Delete">
                                            <i class="icon-trash"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="ConfirmLinkButton" runat="server" OnClick="DeleteLinkButton_Click">Confirm</asp:LinkButton>
                                        <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>
                            </ul>
                        </asp:Panel>

                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <asp:Panel ID="CallMiniDetailMore" runat="server">

                            <asp:DetailsView ID="CallMiniMoreDetailsView" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label"
                                DataSourceID="CallMiniDetailObjectDataSource" DataKeyNames="CallID"
                                AutoGenerateRows="False">
                                <EmptyDataTemplate>
                                    <p>Data Not Found</p>
                                </EmptyDataTemplate>
                                <FieldHeaderStyle CssClass="field-label" />
                                <Fields>
                                    <asp:BoundField DataField="DurationHours" HeaderText="Duration Hours" SortExpression="DurationHours"></asp:BoundField>
                                    <asp:BoundField DataField="DurationMinutes" HeaderText="Duration Minutes" SortExpression="DurationMinutes"></asp:BoundField>
                                    <asp:BoundField DataField="ReminderTime" HeaderText="Reminder Time" SortExpression="ReminderTime"></asp:BoundField>
                                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                                </Fields>
                            </asp:DetailsView>

                        </asp:Panel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="MiniDetailBasicUpdateProgress" runat="server" AssociatedUpdatePanelID="MiniDetailBasicUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel3" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent3" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </asp:Panel>


    </asp:Panel>

    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="MessageLiteral" runat="server" Text=""></asp:Literal></h4>
                <a class="close-reveal-modal">&#215;</a>
                <asp:Label ID="Label6" runat="server" Text=""></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

</asp:Content>
