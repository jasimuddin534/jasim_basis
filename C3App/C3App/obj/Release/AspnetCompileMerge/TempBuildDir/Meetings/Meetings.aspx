<%@ Page Title="Meeting Pate" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Meetings.aspx.cs" Inherits="C3App.Meetings.Meetings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    <asp:Panel ID="ViewPanel" runat="server" SkinID="ViewTab" tab-id="2">

        <asp:LinkButton runat="server" ID="ViewMeetingLinkButton" SkinID="TabTitle" OnClick="ViewMeetingLinkButton_Click" Text="Meeting Details" />

        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">



            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="FilterSearchPanel" runat="server" CssClass="filter">
                    <asp:Label ID="FilterSearchLabel" runat="server" Text="Search Filter" />
                    <asp:LinkButton ID="SearchAllLinkButton" runat="server" CssClass="search-label active" OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="SearchPanel2" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server" OnTextChanged="SearchTextBox_TextChanged"></asp:TextBox>
                    <asp:LinkButton ID="SearchButton" runat="server" CssClass="search-btn" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>




            <asp:Panel ID="CreateLinkButtonPanel" runat="server" SkinID="ListPanel">
                <asp:UpdatePanel ID="CreateLinkUpdatePanel" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Panel ID="OpenMeetingCreatePanel" runat="server" CssClass="meeting-create">
                            <asp:LinkButton ID="MeetingCreateLinkButton" runat="server" OnClick="MeetingCreateLinkButton_Click" CssClass="form-btn" OnClientClick="OpenModal('BodyContent_CreateMeetingModalPanel');">
                                <i class="icon-calendar"></i>
                            </asp:LinkButton>
                            <asp:Label ID="CreateMeetingLabel" runat="server" CssClass="btn-label">Click to Create Meetings</asp:Label>
                        </asp:Panel>
                        <asp:Calendar ID="MeetingCalendar" OnInit="MeetingCalendar_Init" SelectionMode="Day" CssClass="calendar-datepicker" runat="server" OnSelectionChanged="MeetingCalendar_SelectionChanged"></asp:Calendar>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="CreateLinkUpdateProgress" runat="server" AssociatedUpdatePanelID="CreateLinkUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                            <h4>Loading...</h4>
                            <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </asp:Panel>




            <asp:Panel ID="MinidetailsPanel" runat="server">
                <asp:UpdatePanel ID="MiniDetailsUpdatePanel" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>

                        <asp:Panel ID="MiniDetailBasicPanel" runat="server" CssClass="mini-detail-panel meeting-notify">

                            <asp:Label ID="TodaysMeetingLabel" CssClass="title" runat="server">Meeting Notification</asp:Label>


                            <asp:ObjectDataSource ID="TodayMeetingObjectDataSource" runat="server" SelectMethod="GetTodaysMeetings"
                                DataObjectTypeName="C3App.DAL.Meeting" TypeName="C3App.BLL.MeetingBL"></asp:ObjectDataSource>

                            <asp:GridView ID="ViewMeetingsGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False" GridLines="None"
                                OnInit="ViewMeetingsGridView_Init" ShowHeader="false">
                                <EmptyDataTemplate>
                                    <p>
                                        You have no scheduled meeting today...
                                    </p>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <%# Eval("Subject") %>
                                            <asp:Label ID="MeetingTimeLabel" runat="server" Text=' <%# Eval("StartDate","{0:hh:mm}")+ " - " + Eval("EndDate","{0:hh:mm}")%>' />
                                            <asp:Label ID="LocationLabel" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>

                        </asp:Panel>



                        <asp:Panel ID="MiniDetailMorePanel" runat="server" SkinID="MiniDetailMorePanel">
                            <asp:Panel ID="WeeklyMeetingPanel" runat="server">
                                <asp:ObjectDataSource ID="SearchMeetingBySubjectObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Meeting" SelectMethod="SearchMeeting"
                                    TypeName="C3App.BLL.MeetingBL">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="SearchTextBox" Name="search" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                                <asp:ObjectDataSource ID="WeekMeetingsObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Meeting"
                                    SelectMethod="GetWeeklyMeetings" TypeName="C3App.BLL.MeetingBL"></asp:ObjectDataSource>

                                <asp:UpdatePanel ID="upListView" runat="server" UpdateMode="Conditional">

                                    <ContentTemplate>

                                        <asp:GridView ID="WeeklyMeetingGridView" runat="server" CssClass="list-form calendar-form" AutoGenerateColumns="False"
                                            GridLines="None" ShowHeader="false" OnInit="WeeklyMeetingGridView_Init" OnSelectedIndexChanged="WeeklyMeetingGridView_SelectedIndexChanged">
                                            <EmptyDataTemplate>
                                                <p>Data Not Found</p>
                                            </EmptyDataTemplate>
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <table class="calendar-form">
                                                            <tbody>
                                                                <tr>                                                                    
                                                                    <td>
                                                                        <asp:Label ID="DateLabel" runat="server" Text='<%# Eval("StartDate","{0:dd}")%>' CssClass="date"></asp:Label>
                                                                        <asp:Label ID="MonthLabel" runat="server" Text='<%# Eval("StartDate","{0:MMM}")%>' CssClass="month"></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <ul class="event">
                                                                            <li>
                                                                                <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("MeetingID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                                                                    <asp:Label ID="EventLabel" runat="server" Text='<%# Eval("Subject") %>' CssClass="name"></asp:Label>
                                                                                    <asp:Label ID="EventTime" runat="server" Text='<%# Eval("StartDate","{0:hh:mm}")+ " - " + Eval("EndDate","{0:hh:mm}")%>' CssClass="time"></asp:Label>
                                                                                    <asp:Label ID="EventLocation" runat="server" Text='<%# Eval("Location") %>' CssClass="label"></asp:Label>
                                                                                    <asp:LinkButton ID="EditLinkButton" runat="server" CausesValidation="false" OnClick="EditLinkButton_Click" OnClientClick="OpenModal('BodyContent_CreateMeetingModalPanel')" Visible="false"><i class="icon-edit"></i></asp:LinkButton>
                                                                                </asp:LinkButton>
                                                                            </li>
                                                                        </ul>
                                                                    </td>                                                                    
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                                <%-- <asp:TemplateField>
                                        <ItemTemplate>
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <asp:Label runat="server" ID="DateLabel" CssClass="date" Text='<%# Eval("StartDate","{0:dd}")%>'></asp:Label>
                                                    <asp:Label runat="server" ID="MonthLabel" CssClass="month" Text='<%# Eval("StartDate","{0:MMM}")%>'></asp:Label>
                                                </td>
                                                <td>
                                                    <ul class="event">
                                                        <li>
                                                            <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("MeetingID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                                                <asp:Label runat="server" ID="SubjectLabel" CssClass="name" Text='<%# Eval("Subject")%>'></asp:Label>
                                                                <asp:Label runat="server" ID="TimeLabel" CssClass="time" Text='<%# Eval("StartDate","{0:hh:mm}")+ " - " + Eval("EndDate","{0:hh:mm}")%>'></asp:Label>
                                                                <asp:Label runat="server" ID="LocationLabel" CssClass="time" Text='<%# Eval("Location") %>'></asp:Label>
                                                            </asp:LinkButton>
                                                            <asp:LinkButton ID="EditLinkButton" runat="server" CausesValidation="false" OnClick="EditLinkButton_Click" OnClientClick="OpenModal('BodyContent_CreateMeetingModalPanel')" Visible="false"><i class="icon-edit"></i></asp:LinkButton>
                                                        </li
                                                    </ul>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </ItemTemplate>
                             </asp:TemplateField>--%>
                                            </Columns>
                                        </asp:GridView>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </asp:Panel>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdateProgress ID="MiniDetailMoreUpdateProgress" runat="server" AssociatedUpdatePanelID="MiniDetailsUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel1" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent1" runat="server" CssClass="loadingContent">
                            <h4>Loading...</h4>
                            <asp:Image ID="ProgressImage1" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </asp:Panel>




            <asp:Panel ID="CreateMeetingModalPanel" runat="server" CssClass="modal-pop right meeting-small">
                <asp:HyperLink ID="HyperLink3" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
                <asp:UpdatePanel ID="CreateMeetingUpdatePanel" runat="server" UpdateMode="Always">
                    <ContentTemplate>
                        <asp:Label ID="ModalTitleLabel" runat="server" SkinID="ModalTitle"></asp:Label>
                        <asp:Panel ID="CreatePanel" runat="server" SkinID="ModalListPanel">

                            <asp:ObjectDataSource ID="MeetingDetailsObjectDataSource" runat="server"
                                TypeName="C3App.BLL.MeetingBL" DataObjectTypeName="C3App.DAL.Meeting"
                                InsertMethod="InsertOrUpdateMeeting"
                                SelectMethod="GetMeetingByID"
                                UpdateMethod="InsertOrUpdateMeeting"
                                OnUpdated="MeetingDetailsObjectDataSource_Updated"
                                OnInserted="MeetingDetailsObjectDataSource_Inserted">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="EditMeetingID" Name="meetingID" Type="Int64"></asp:SessionParameter>
                                </SelectParameters>
                            </asp:ObjectDataSource>

                            <asp:ValidationSummary ID="MeetingValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="sum" ShowValidationErrors="True" />

                            <asp:DetailsView ID="MeetingDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="field-label"
                                AutoGenerateRows="False" DefaultMode="Insert" DataKeyNames="MeetingID,CompanyID,Subject,IsDeleted,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy"
                                OnItemCommand="MeetingDetailsView_ItemCommand"
                                OnItemInserting="MeetingDetailsView_ItemInserting"
                                OnItemUpdating="MeetingDetailsView_ItemUpdating"
                                OnItemUpdated="MeetingDetailsView_ItemUpdated"
                                OnItemInserted="MeetingDetailsView_ItemInserted"
                                DataSourceID="MeetingDetailsObjectDataSource"
                                OnDataBound="MeetingDetailsView_DataBound">
                                <Fields>
                                    <asp:TemplateField HeaderText="To">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="AttendeeTextBox" runat="server" ReadOnly="True" SkinID="TextBoxWithButton"></asp:TextBox>
                                            <asp:LinkButton ID="ModalPopButton" runat="server" OnClientClick="OpenModal('BodyContent_TargetListModalPanel')" SkinID="ButtonWithTextBox" Text="Select" />
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:TextBox ID="AttendeeTextBox" runat="server" ReadOnly="True" SkinID="TextBoxWithButton"></asp:TextBox>
                                            <asp:LinkButton ID="ModalPopButton" runat="server" OnClientClick="OpenModal('BodyContent_TargetListModalPanel')" SkinID="ButtonWithTextBox" Text="Select" />
                                        </InsertItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Subject">
                                        <EditItemTemplate>
                                            <asp:RequiredFieldValidator CssClass="input-validate" ID="SubjectRequiredValidator" runat="server"
                                                ControlToValidate="SubjectTextBox" ValidationGroup="sum" Text="*" ErrorMessage="Subject is required" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:TextBox ID="SubjectTextBox" CssClass="required-field" runat="server" Text='<%# Bind("Subject") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Location">
                                        <EditItemTemplate>
                                            <asp:RequiredFieldValidator CssClass="input-validate" ID="LocationRequiredValidator" runat="server"
                                                ControlToValidate="LocationTextBox" ValidationGroup="sum" Text="*" ErrorMessage="Location is required" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:TextBox ID="LocationTextBox" CssClass="required-field" runat="server" Text='<%# Bind("Location") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Start" SortExpression="StartDate" ItemStyle-CssClass="inline-dates">
                                        <EditItemTemplate>
                                            <asp:RequiredFieldValidator CssClass="input-validate" ID="StartDateRequiredValidator" runat="server" ErrorMessage="Start date is required"
                                                ControlToValidate="DateStartTextBox" ValidationGroup="sum" Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:TextBox ID="DateStartTextBox" CssClass="datepicker" runat="server" Text='<%# Bind("StartDate","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                            <i class="icon-calendar"></i>Time
                                            <asp:TextBox ID="StartTimeTextBox" Text='<%# Eval("StartDate","{0:hh:mm}")%>' runat="server"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="StartTimeTextLength" runat="server" ControlToValidate="StartTimeTextBox" Display="None"
                                                ValidationExpression="^[0-9]{1,2}:[0-5][0-9]{1,10}$" Text="" ErrorMessage="Only hour and minute format value are allowed in time filed like (10:30)" ValidationGroup="sum" />

                                            <asp:CheckBox runat="server" ID="AllDayCheckBox" AutoPostBack="True" OnCheckedChanged="AllDayCheckBox_CheckedChanged" />
                                            <asp:Label runat="server" ID="AllDayLabel" Text="All day"></asp:Label>
                                        </EditItemTemplate>
                                    </asp:TemplateField>


                                    <asp:TemplateField HeaderText="Ends" SortExpression="EndDate" ItemStyle-CssClass="inline-dates">
                                        <EditItemTemplate>
                                            <asp:RequiredFieldValidator CssClass="input-validate" ID="EndDateRequiredValidator" runat="server" ErrorMessage="End date is required"
                                                ControlToValidate="DateEndTextBox" ValidationGroup="sum" Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                            <asp:TextBox ID="DateEndTextBox" CssClass="datepicker" runat="server" Text='<%# Bind("EndDate","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                            <i class="icon-calendar"></i>Time
                                            <asp:TextBox ID="EndTimeTextBox" Text='<%# Eval("EndDate","{0:hh:mm}")%>' runat="server"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="EmdTimeTextLength" runat="server" ControlToValidate="EndTimeTextBox" Display="None"
                                                ValidationExpression="^[0-9]{1,2}:[0-5][0-9]{1,10}$" Text="" ErrorMessage="Only hour and minute format value are allowed in time filed like (10:30)" ValidationGroup="sum" />

                                            <asp:CompareValidator ID="DateComparevalidator" CssClass="input-validate" runat="server" ValidationGroup="sum" ControlToValidate="DateEndTextBox" ControlToCompare="DateStartTextBox"
                                                Operator="GreaterThanEqual" Type="date" Text="*" SetFocusOnError="True" Display="Dynamic" ErrorMessage="Enddate must be greater than startdate"></asp:CompareValidator>
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
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdateProgress ID="CreateMeetingUpdateProgress" runat="server" AssociatedUpdatePanelID="CreateMeetingUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h4>Loading...</h4>
                            <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </asp:Panel>



            <asp:Panel ID="TargetListModalPanel" runat="server" CssClass="modal-pop right meeting-big">
                <asp:HyperLink ID="HyperLinkClose" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

                <asp:UpdatePanel ID="MeetingTargetListUpdatePanel" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:Label ID="MeetingTargetLabel" runat="server" SkinID="ModalTitle">
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

                <asp:UpdateProgress ID="MeetingTargetListUpdateProgress" runat="server" AssociatedUpdatePanelID="MeetingTargetListUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel3" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent3" runat="server" CssClass="loadingContent">
                            <h4>Loading...</h4>
                            <asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

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
