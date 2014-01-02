<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Meetings2.aspx.cs" Inherits="C3App.Meetings.Meetings2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    
     <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">
        
        <asp:LinkButton ID="MeetingInsertLinkButton" runat="server" SkinID="TabTitle" Text="Create Meeting" CommandArgument="Insert" OnClientClick="GoToTab('1');" OnClick="MeetingInsertLinkButton_Click" />
        <asp:Label ID="MsgLabel" runat="server" Text=""></asp:Label>

        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">

            <asp:UpdatePanel runat="server" ID="MeetingDetailsUpdatePanel">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="MeetingInsertLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="MeetingEditButton" EventName="Click" />
                </Triggers>

                <ContentTemplate>
                    <asp:ObjectDataSource ID="MeetingDetailsObjectDataSource" runat="server"
                        TypeName="C3App.BLL.MeetingBL" DataObjectTypeName="C3App.DAL.Meeting"
                        SelectMethod="GetMeetingsByID" InsertMethod="InsertMeeting" UpdateMethod="UpdateMeeting">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditMeetingID" Name="meetingID" Type="Int32"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:DetailsView ID="MeetingDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="field-label" DataSourceID="MeetingDetailsObjectDataSource" AutoGenerateRows="False"
                         DataKeyNames="Subject,MeetingID,CreatedTime,CreatedBy"
                         OnItemCommand="MeetingDetailsView_ItemCommand"
                        OnItemInserting="MeetingDetailsView_ItemInserting"
                        OnItemUpdating="MeetingDetailsView_ItemUpdating"
                        OnItemUpdated="MeetingDetailsView_ItemUpdated"
                        OnItemInserted="MeetingDetailsView_ItemInserted">
                        <Fields>
                            <asp:TemplateField HeaderText="Subject">
                                <EditItemTemplate>
                                     <asp:RequiredFieldValidator CssClass="input-validate" ID="SubjectRequiredValidator" runat="server"
                                        ControlToValidate="SubjectTextBox" ForeColor="Red" ValidationGroup="sum"  Text="*" ErrorMessage="Input Subject " SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="SubjectTextBox" runat="server" Text='<%# Bind("Subject") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                           
                            <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location"></asp:BoundField>
                           
                             <asp:TemplateField HeaderText="Date & Time" SortExpression="DateStart">
                                 <EditItemTemplate>
                                     <asp:RequiredFieldValidator CssClass="input-validate" ID="DateTimeRequiredValidator" runat="server"
                                         ControlToValidate="DateStartTextBox" ForeColor="Red" ValidationGroup="sum" Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                     <asp:TextBox ID="DateStartTextBox" CssClass="datepicker" runat="server" OnInit="DateStartTextBox_Init" DataFormatString="{0:d}" SelectedValue='<%# Eval("DateStart") %>'></asp:TextBox>
                                 </EditItemTemplate>
                              </asp:TemplateField>
                            
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="HoursDropDownList" runat="server"  AutoPostBack="False" OnInit="HoursDropDownList_Init"  >
                                       </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField>
                                <EditItemTemplate>
                                   <asp:DropDownList ID="MinutesDropDownList" runat="server"  AutoPostBack="False" OnInit="MinutesDropDownList_Init">
                                     </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                             <asp:TemplateField>
                                <EditItemTemplate>
                                     <asp:DropDownList ID="PeriodDropDownList" runat="server"  AutoPostBack="False" OnInit="PeriodDropDownList_Init" >
                                         <asp:ListItem Text="AM" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="PM" Value="1"></asp:ListItem> 
                                        </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                              <asp:TemplateField HeaderText="Duration Hour" SortExpression="DurationHours">
                                    <EditItemTemplate>
                                        <asp:RequiredFieldValidator CssClass="input-validate" ID="DurationRequiredValidator" runat="server"
                                        ControlToValidate="DurationHoursTextBox" ForeColor="Red" ValidationGroup="sum"  Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                        <asp:TextBox ID="DurationHoursTextBox" runat="server" Text='<%# Bind("DurationHours","{0:d}") %>' OnInit="DurationHoursTextBox_Init" DataFormatString="{0:d}"></asp:TextBox>
                                       <%-- <asp:TextBox ID="DurationMinutesTextBox" runat="server" Text='<%# Bind("DurationMinutes","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>--%>
                                    </EditItemTemplate>
                              </asp:TemplateField>
                            
                             <asp:TemplateField>
                                <EditItemTemplate>
                                     <asp:DropDownList ID="DurationMinutesDropDownList" runat="server"  AutoPostBack="False" OnInit="DurationMinutesDropDownList_Init">
                                         </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                          
                            <%--<asp:BoundField DataField="DurationMinutes" HeaderText="Duration Minutes" DataFormatString="{0:d}" SortExpression="DurationMinutes"></asp:BoundField>--%>
                            
                             <asp:TemplateField HeaderText="Meeting Status" SortExpression="StatusID">
                                <EditItemTemplate>
                                     <asp:RequiredFieldValidator CssClass="input-validate" ID="MeetingStatusRequiredValidator" runat="server"
                                        ControlToValidate="MeetingStatusDropDownList" ForeColor="Red" ValidationGroup="sum"  Text="*" SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                                    <asp:ObjectDataSource ID="MeetingStatusObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.MeetingStatus" SelectMethod="GetMeetingStatuses" TypeName="C3App.BLL.MeetingBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="MeetingStatusDropDownList" runat="server" AppendDataBoundItems="true" AutoPostBack="False" DataSourceID="MeetingStatusObjectDataSource" 
                                        DataTextField="Value" DataValueField="MeetingStatusID" OnInit="MeetingStatusDropDownList_Init" SelectedValue='<%# Eval("StatusID")==null ? "0" : Eval("StatusID") %>'>
                                        <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                              <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.User" SelectMethod="GetUsers" TypeName="C3App.BLL.UserBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="UsersDropDownList" runat="server" AppendDataBoundItems="true" AutoPostBack="False" DataSourceID="UsersObjectDataSource" DataTextField="FirstName" DataValueField="UserID" OnInit="UsersDropDownList_Init" SelectedValue='<%# Eval("AssignedUserID")==null ? "0" : Eval("AssignedUserID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                          
                             <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TeamsObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Team" SelectMethod="GetTeams" TypeName="C3App.BLL.TeamBL"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsDropDownList" runat="server" AppendDataBoundItems="true" AutoPostBack="False" DataSourceID="TeamsObjectDataSource" 
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init" SelectedValue='<%# Eval("TeamID")==null ? "0" : Eval("TeamID") %>'>
                                        <asp:ListItem  Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            
                               <asp:TemplateField HeaderText="Reminder Time">
                                <EditItemTemplate>
                                     <asp:DropDownList ID="ReminderTimesDropDownList" runat="server"  AutoPostBack="False" OnInit="ReminderTimesDropDownList_Init">
                                       <%-- <asp:ListItem Text="None" Value="0"></asp:ListItem>
                                       <%-- <asp:ListItem Text="15 minutes" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="30 minutes" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="45 minutes" Value="3"></asp:ListItem>
                                        <asp:ListItem Text="1 Hour" Value="4"></asp:ListItem> --%>
                                     </asp:DropDownList>
                                   
                                </EditItemTemplate>
                            </asp:TemplateField>
                           
                           
                             <asp:TemplateField HeaderText="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DescriptionTextBox" runat="server" TextMode="MultiLine" Text='<%# Bind("Description") %>'></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            
                           <%--  <asp:TemplateField ShowHeader="False">
                               
                                <EditItemTemplate>
                                    <asp:DropDownList ID="MeetingGroupDropDownList" runat="server" AppendDataBoundItems="true" OnInit="MeetingGroupDropDownList_Init" >
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value=""></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Accounts" Value="Accounts"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Teams" Value="Teams"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Users" Value="Users"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Contacts" Value="Contacts"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Opportunity" Value="Opportunity"></asp:ListItem>
                                    </asp:DropDownList>

                                    <asp:TextBox ID="MeetingGroupTextBox" runat="server" ReadOnly="true" SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton" runat="server" OnClick="ModalPopButton_Click" OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                               
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
                            
                            <asp:TemplateField HeaderText="Attendee">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AttendeeTextBox" Text="" runat="server" ReadOnly="True" SkinID="TextBoxWithButton"></asp:TextBox>
                                    <asp:Button ID="ModalPopButton2" runat="server" OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                    
                                </EditItemTemplate>
                            </asp:TemplateField>
                            

                             <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Update" ValidationGroup="sum" Text="Update"></asp:LinkButton>
                                <asp:LinkButton ID="CancelLinkButton1" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="InsertLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" ValidationGroup="sum" Text="Insert"></asp:LinkButton>
                                  <asp:LinkButton ID="CancelLinkButton2" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                </InsertItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                       
                    </asp:DetailsView>
                </ContentTemplate>
            </asp:UpdatePanel>
             <asp:UpdateProgress ID="UpdateProgress3" runat="server">
            <ProgressTemplate>
                Loading...</ProgressTemplate>
        </asp:UpdateProgress>
        </asp:Panel>
         
        <%--  <asp:Panel ID="ModalPanel1" SkinID="ModalPopLeft" runat="server">
            <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

            <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
               
                <ContentTemplate>
                    <asp:Label ID="ModalLabel" runat="server" SkinID="ModalTitle" Text=""></asp:Label>

                    <asp:Panel ID="ModalSearchPanel" runat="server" Visible="False" SkinID="ModalSearchPanel">
                        <asp:Label ID="Label12" runat="server" Text="Search"></asp:Label>
                        <asp:TextBox ID="MeetingGroupSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="MeetingGroupSearchTextBox_TextChanged"></asp:TextBox>
                        <asp:LinkButton ID="MeetingGroupSearchLinkButton" CssClass="search-btn modal-search" runat="server" Text="Search" OnClick="MeetingGroupSearchLinkButton_Click">
                            <i class="icon-search"></i>
                        </asp:LinkButton>
                    </asp:Panel>

                    <asp:Panel ID="ModalListPanel" SkinID="ModalListPanel" runat="server">

                        <asp:ObjectDataSource ID="OpportunityListObjectDataSource" runat="server" SelectMethod="SearchOpportunities" TypeName="C3App.BLL.OpportunityBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="MeetingGroupSearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="AccountListObjectDataSource" runat="server" SelectMethod="GetAccountForMeeting" TypeName="C3App.BLL.AccountBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="MeetingGroupSearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="ContactListObjectDataSource" runat="server" SelectMethod="GetContactByName" TypeName="C3App.BLL.ContactBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="MeetingGroupSearchTextBox" PropertyName="Text" Name="nameSearchString" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        
                        <asp:ObjectDataSource ID="TeamListObjectDataSource" runat="server" SelectMethod="GetTeamsByName" TypeName="C3App.BLL.TeamBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="MeetingGroupSearchTextBox" PropertyName="Text" Name="nameSearchString" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="UserListObjectDataSource" runat="server" SelectMethod="GetUsersByFirstName" TypeName="C3App.BLL.UserBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="MeetingGroupSearchTextBox" PropertyName="Text" Name="nameSearchString" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:UpdatePanel ID="MeetingGroupListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="MeetingGroupGridView" runat="server" AutoGenerateColumns="False"
                                    CssClass="list-form" ShowHeader="False">
                                    <Columns>--%>
                                        <%--<asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/opportunity.jpg"/>
                                                <asp:LinkButton ID="SelectOpportunityList" runat="server" CommandArgument='<%# Eval("OpportunityID") %>' CommandName="Select" OnCommand="SelectOpportunityList_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Account.Name") %>'></asp:Label>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                   <%-- </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>--%>
         
         
         <%-- Create Attendee --%>
          <asp:Panel ID="ModalPanel1" SkinID="ModalPopLeft" runat="server">
            <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink> 
             <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Always">
                
                <ContentTemplate>
                    <asp:Label ID="ModalLabel" runat="server" SkinID="ModalTitle" Text="Select Atendee"></asp:Label>

                    <asp:Panel ID="ModalSearchPanel" SkinID="ModalSearchPanel" runat="server">
                        <asp:Label ID="Label12" runat="server" Text="Search"></asp:Label>
                        <asp:TextBox ID="SearchUserTextBox" runat="server" AutoPostBack="true"></asp:TextBox>
                        <asp:LinkButton ID="SearchUserLinkButton" runat="server" CssClass="search-btn">
                        <i class="icon-search"></i>
                        </asp:LinkButton>
                    </asp:Panel>


                    <asp:Panel ID="ModalListPanel" SkinID="ModalListPanel" runat="server">
                        <asp:ObjectDataSource ID="UserObjectDataSource" runat="server"
                            SelectMethod="GetUsersByFirstName" TypeName="C3App.BLL.UserBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="SearchUserTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:GridView ID="UsersGridView" runat="server" class="list-form"
                            AutoGenerateColumns="False" ShowHeader="false"
                            DataKeyNames="UserID" GridLines="None"
                            DataSourceID="UserObjectDataSource">

                            <EmptyDataTemplate>
                                <p>
                                    No attendee found...
                                </p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/user.jpg" />
                                         <asp:LinkButton  ID="SelectUserButton" runat="server" CommandName="Select" OnCommand="SelectAttendee_Command"  CausesValidation="False" >
                                                    <%# Eval("FirstName")%>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                          </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
         
         

    </asp:Panel>
    
    
     <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">
        <asp:LinkButton runat="server" ID="UpdateTab2" SkinID="TabTitle" Text="View Meetings" OnClientClick="GoToTab('2')" />
        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">
            
              <asp:ObjectDataSource ID="SearchObjectDataSource" runat="server" SelectMethod="SearchMeeting" TypeName="C3App.BLL.MeetingBL" DataObjectTypeName="C3App.DAL.Meeting">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>
            
            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="Panel5" runat="server" CssClass="filter">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="SearchAllLinkButton" CssClass="search-label active"  OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="SearchPanel2" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server" OnTextChanged="SearchTextBox_TextChanged"></asp:TextBox>
                    <asp:LinkButton CssClass="search-btn" ID="SearchButton" runat="server" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>


                    <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">
                        

                        <asp:UpdatePanel ID="ViewMeetingsUpdatepanel" runat="server" UpdateMode="Conditional">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="UpdateTab2" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:ObjectDataSource ID="MeetingsViewObjectDataSource" runat="server"
                                    TypeName="C3App.BLL.MeetingBL" DataObjectTypeName="C3App.DAL.Meeting" SelectMethod="GetMeetings">
                                 </asp:ObjectDataSource>
                                <asp:GridView ID="ViewMeetingsGridView" DataSourceID="MeetingsViewObjectDataSource"
                                    runat="server" CssClass="list-form" AutoGenerateColumns="False" GridLines="None"
                                    DataKeyNames="MeetingID" ShowHeader="false" >
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="Image" runat="server" ImageUrl="~/Content/images/c3/calendar.jpg" />
                                                <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("MeetingID") %>' CommandName="Select" CausesValidation="False" OnCommand="SelectLinkButton_Command">                                                    
                                                    <%# Eval("Subject") %> 
                                                    <asp:Label ID="LocationLabel" runat="server" Text='<%# Eval("Location") %>'></asp:Label>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </asp:Panel>

                   

                       
                        <asp:UpdatePanel ID="miniMeetingDetailsUpdatePanel" runat="server" UpdateMode="Conditional">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="UpdateTab2" EventName="Click" />
                            </Triggers>
                            <ContentTemplate>
                                 <asp:Panel ID="MiniDetailBasicPanel" SkinID="MiniDetailBasicPanel" runat="server">
                                <asp:ObjectDataSource ID="MiniMeetingObjectDataSource" runat="server"
                                    SelectMethod="GetMeetingsByID" TypeName="C3App.BLL.MeetingBL" DataObjectTypeName="C3App.DAL.Meeting">
                                <SelectParameters>
                                <asp:ControlParameter ControlID="ViewMeetingsGridView" Type="Int64" Name="meetingID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                 </asp:ObjectDataSource>
                                <asp:FormView ID="MiniMeetingsFormView" CssClass="mini-details-form"
                                      DataKeyNames="MeetingID" runat="server" DataSourceID="MiniMeetingObjectDataSource">
                                    <EmptyDataTemplate>
                                        <p>
                                            No meeting selected...
                                        </p>
                                    </EmptyDataTemplate>
                                    <ItemTemplate>
                                        <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/calendar.jpg" />
                                        <asp:Panel ID="Panel3" runat="server">
                                            <asp:Label ID="SubjectLabel" CssClass="subject" runat="server" Text='<%# Bind("Subject") %>'></asp:Label>
                                            <asp:Label ID="LocationLabel" CssClass="location" runat="server" Text='<%# Bind("Location") %>'></asp:Label>
                                            <asp:Label ID="DurationHoursLabel" CssClass="durationhours" runat="server" Text='<%# Bind("DurationHours") %>'></asp:Label>
                                            <asp:Label ID="DurationMinutesLabel" CssClass="durationminutes" runat="server" Text='<%# Bind("DurationMinutes") %>'></asp:Label>
                                        </asp:Panel>
                                    </ItemTemplate>
                                    
                                </asp:FormView>
                                <asp:Panel ID="ButtonPanel" runat="server" CssClass="mini-detail-control-panel three-controls">
                                    <ul>
                                        <li>
                                            <asp:LinkButton ID="ModalPopButton2" CssClass="control-btn" runat="server" OnClientClick="OpenModal('BodyContent_ModalCalendar')">
                                            <i class="icon-calendar"></i>
                                            </asp:LinkButton>
                                        </li>
                                        <li>
                                            <asp:LinkButton ID="MeetingEditButton" runat="server" Text="Edit" CssClass="control-btn" CommandArgument="" OnClientClick="GoToTab(1,'Meeting Details');" OnClick="MeetingsEditButton_Click">
                                            <i class="icon-edit"></i>
                                            </asp:LinkButton>
                                        </li>
                                        <li>
                                            <asp:LinkButton ID="DeleteButton" runat="server" CssClass="control-btn has-confirm" Text="Delete">
                                            <i class="icon-trash"></i>
                                            </asp:LinkButton>
                                            <asp:Panel ID="Panel4" runat="server" CssClass="slide-confirm">
                                                <asp:LinkButton ID="LinkButton3" runat="server" OnClick="DeleteButton_Click">Confirm</asp:LinkButton>
                                                <asp:LinkButton ID="LinkButton4" runat="server" CssClass="slide-cancel">Cancel</asp:LinkButton>
                                            </asp:Panel>
                                        </li>
                                    </ul>
                                </asp:Panel>

                            <%--</ContentTemplate>
                        </asp:UpdatePanel>--%>

                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                Loading...</ProgressTemplate>
                        </asp:UpdateProgress>
                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <asp:DetailsView ID="miniMeetingDetailsView" DataSourceID="MiniMeetingObjectDataSource" AutoGenerateRows="False" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label">
                            <EmptyDataTemplate>
                                <p>
                                     No meeting selected...
                                </p>
                            </EmptyDataTemplate>
                            <Fields>
                                 <asp:TemplateField HeaderText="Asssigned To">
                                    <ItemTemplate>
                                        <asp:Label ID="AssignedUserLabel" runat="Server" Text='<%# Eval("User.FirstName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Team Name">
                                    <ItemTemplate>
                                        <asp:Label ID="AssignedUserLabel" runat="Server" Text='<%# Eval("Team.Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                 <asp:TemplateField HeaderText="Meeting Status">
                                    <ItemTemplate>
                                        <asp:Label ID="MeetingStatusLabel" runat="Server" Text='<%# Eval("MeetingStatus.Value") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location"></asp:BoundField>
                                <asp:BoundField DataField="DurationHours" HeaderText="Duration Hours" SortExpression="DurationHours"></asp:BoundField>
                                
                                
                                <asp:BoundField DataField="DurationMinutes" HeaderText="Duration Minutes" SortExpression="DurationMinutes"></asp:BoundField>
                                <asp:BoundField DataField="DateStart" HeaderText="Date Start" SortExpression="DateStart"></asp:BoundField>
                               
                                <asp:BoundField DataField="ReminderTime" HeaderText="Reminder Time" SortExpression="ReminderTime"></asp:BoundField>
                                <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                               
                            </Fields>
                            <Fields>
                               
                            </Fields>
                        </asp:DetailsView>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
          <%-- start Calendar in Formview--%>
         <asp:Panel ID="ModalCalendar" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
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
        <asp:UpdatePanel runat="server" ID="UpdatePanel3" UpdateMode="Always">
            <ContentTemplate>

                <h4>
                    <asp:Literal ID="MsgLiteral" runat="server" Text=""></asp:Literal>
                </h4>
                <!-- Edit this for the alert title -->
                <a class="close-reveal-modal">&#215;</a>
                <asp:Label ID="alertLabel" runat="server" Text=""></asp:Label>
                <!-- Place your Content Here -->

            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
