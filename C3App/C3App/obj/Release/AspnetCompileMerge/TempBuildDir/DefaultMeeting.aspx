<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="DefaultMeeting.aspx.cs" Inherits="C3App.DefaultMeeting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">

    <script type="text/javascript">
        $(document).ready(function () {
            function showLoading(val) {
                if (!val) {
                    val = '.container-wrapper';
                }
                $(val).append('<div class="loading-back"></div>');
                $(val + " .loading-back").show();
            }
            function hideLoading(val) {
                $(val + " .loading-back").fadeOut('fast');
            }
        });
    </script>
    <%--<asp:GridView ID="GridView2" runat="server" DataSourceID="ObjectDataSource1"></asp:GridView>--%>
    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">

        <asp:LinkButton runat="server" ID="DetailsPanelLinkButton" SkinID="TabTitle" OnClick="UpdateButton_Click" OnClientClick="GoToTab(1, 'Create Default');" Text="Create Default"></asp:LinkButton>

        <asp:Panel ID="Panel1" runat="server" class="notify success">
            <h3>
                <asp:Literal runat="server" ID="notifyHeading" Text="Heading"></asp:Literal></h3>
            <asp:Label runat="server" ID="notifyMessage"></asp:Label>
        </asp:Panel>
        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetUsers" TypeName="C3App.BLL.TestBL"></asp:ObjectDataSource>
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="DetailsPanelLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>

                    <asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="UsersObjectDataSource" CssClass="details-form" FieldHeaderStyle-CssClass="field-label">
                        <Fields>
                        </Fields>
                    </asp:DetailsView>

                    <a href="#" class="form-btn"><i class="icon-ok"></i>SAVE</a>
                    <a href="#" class="form-btn"><i class="icon-remove"></i>CANCEL</a>
                    <asp:LinkButton ID="ModalPopButton22" CssClass="control-btn" runat="server" OnClientClick="OpenModal('BodyContent_ModalPanel4')" Text="Open" />

                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:LinkButton ID="LinkButton156" CssClass="control-btn" runat="server" PostBackUrl="javascript:void(0);" OnClientClick="controlAlert('open');">
                                        <i class="icon-search"></i>
            </asp:LinkButton>
        </asp:Panel>       
        <asp:Panel ID="Panel291" SkinID="ModalCreatePanelLeft" runat="server">
            <asp:HyperLink ID="HyperLink11" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label31" runat="server" SkinID="ModalTitle" Text="Create Panel"></asp:Label>
            <asp:Panel ID="Panel2" runat="server" CssClass="modal-create-content">
                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
                <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox>
                <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>
                <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox>
                <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>
                <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
                <asp:Label ID="Label8" runat="server" Text="Label"></asp:Label>
                <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox>
                <asp:Label ID="Label9" runat="server" Text="Label"></asp:Label>
                <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
                <asp:Label ID="Label10" runat="server" Text="Label"></asp:Label>
                <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
                <asp:LinkButton ID="LinkButton2" runat="server" Text="Save" OnClientClick="CloseModals(['BodyContent_Panel291','BodyContent_ModalPanel4'])" PostBackUrl="javascript:void(0)"></asp:LinkButton>
                <asp:LinkButton ID="LinkButton3" runat="server" Text="Cancel" OnClientClick="CloseCreateModal('BodyContent_Panel291')" PostBackUrl="javascript:void(0)"></asp:LinkButton>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>

    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">

        <asp:LinkButton runat="server" ID="ViewPanelLinkButton" SkinID="TabTitle" OnClick="UpdateButton_Click" OnClientClick="GoToTab(2, 'Create Default');" Text="List View"></asp:LinkButton>

        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">

            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="Panel3" runat="server" CssClass="filter">
                    <asp:Label ID="Label11" runat="server" Text="Search Filter"></asp:Label>
                    <a href="#" class="search-label active">All</a>
                    <a href="#" class="search-label">Department</a>
                    <a href="#" class="search-label">Sales</a>
                    <a href="#" class="search-label">Marketing</a>
                    <a href="#" class="search-label">Oppertunities</a>
                    <a href="#" class="search-label">Leads</a>
                    <a href="#" class="search-label">Projects</a>
                    <a href="#" class="search-label">Custom</a>
                </asp:Panel>
                <asp:Panel ID="Panel4" runat="server" CssClass="search">
                    <asp:Label ID="Label12" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="TextBox10" CssClass="datepicker" runat="server" AutoPostBack="false"></asp:TextBox>
                    <asp:LinkButton ID="LinkButton4" runat="server" CssClass="search-btn" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="ListPanel" CssClass="list-panel" runat="server">
                <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server" SelectMethod="GetUsers" TypeName="C3App.BLL.TestBL"></asp:ObjectDataSource>
                <asp:UpdatePanel runat="server" ID="UpdatePanel5">
                    <Triggers>
                        <%-- Trigger --%>
                        <asp:AsyncPostBackTrigger ControlID="CreateLinkButton1" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="LinkButton1" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Panel runat="server" CssClass="meeting-create">
                            <asp:Label runat="server" CssClass="title">Create Meetings/Appointments</asp:Label>
                            <asp:LinkButton ID="CreateLinkButton1" runat="server" CssClass="form-btn" OnClientClick="OpenModal('BodyContent_ModalPanel2');">
                                <i class="icon-calendar"></i>
                            </asp:LinkButton>
                            <asp:Label runat="server" CssClass="btn-label">Click to Create Meetings</asp:Label>
                        </asp:Panel>
                        <asp:Panel runat="server" CssClass="calendar-datepicker"></asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
            <asp:Panel ID="Panel5" runat="server" CssClass="list-details-panel">
                <asp:UpdatePanel runat="server" ID="UpdatePanel6">
                    <Triggers>
                        <%-- Trigger --%>
                        <asp:AsyncPostBackTrigger ControlID="ViewPanelLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Panel ID="MiniDetailBasicPanel" CssClass="mini-detail-panel meeting-notify" runat="server">
                            <asp:Label runat="server" CssClass="title">Meeting Notification</asp:Label>
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
                            
                        </asp:Panel>

                        <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
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
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
        </asp:Panel>
        <!-- New modal for meeting module -->
        <asp:Panel ID="ModalPanel2" CssClass="modal-pop right meeting-small" runat="server">
            <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>            
                <asp:Panel ID="Panel491" SkinID="ModalListPanel" runat="server">
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="form-btn" OnClientClick="OpenModal('BodyContent_ModalPanel4');">
                        Open
                    </asp:LinkButton>
                    <!-- place your content here-->
                </asp:Panel>
        </asp:Panel>
        <asp:Panel ID="ModalPanel4" CssClass="modal-pop right meeting-big" runat="server">
            <asp:HyperLink ID="HyperLink80" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Panel ID="Panel6" SkinID="ModalListPanel" runat="server">
                <!-- Place your content here -->
            </asp:Panel>
        </asp:Panel>

    </asp:Panel>

</asp:Content>
