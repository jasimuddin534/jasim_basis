    <%@ Page Title="Home Page" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="C3App._Default" %>

<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="HeadContent">
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
                        
            $(".validate").mask(makeMaskVal('9', 5), { placeholder: " " });
        });
    </script>
    <%--<asp:GridView ID="GridView2" runat="server" DataSourceID="ObjectDataSource1"></asp:GridView>--%>
    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">

        <asp:LinkButton runat="server" ID="DetailsPanelLinkButton" SkinID="TabTitle" OnClick="UpdateButton_Click" OnClientClick="GoToTab(1, 'Create Default');" Text="Create Default"></asp:LinkButton>

        <asp:Panel runat="server" class="notify success">
            <h3>
                <asp:Literal runat="server" ID="notifyHeading" Text="Heading"></asp:Literal></h3>
            <asp:Label runat="server" ID="notifyMessage"></asp:Label>
        </asp:Panel>
        <asp:ObjectDataSource runat="server" SelectMethod="GetUsers" TypeName="C3App.BLL.TestBL"></asp:ObjectDataSource>
        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="DetailsPanelLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>

                    <asp:DetailsView runat="server" DataSourceID="UsersObjectDataSource" CssClass="details-form" FieldHeaderStyle-CssClass="field-label">
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
        <asp:Panel ID="ModalPanel4" Child-Modal="BodyContent_Panel291" SkinID="ModalPopLeft" runat="server">
            <asp:HyperLink ID="HyperLink22" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:UpdatePanel runat="server" ID="UpdatePanel41">
                <Triggers>
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="Label291" runat="server" SkinID="ModalTitle" Text="Modal Title"></asp:Label>
                    <asp:LinkButton runat="server" CssClass="modal-create-btn" Text="Create" PostBackUrl="javascript:void(0)" OnClientClick="OpenCreateModal('BodyContent_Panel291')"></asp:LinkButton>
                    <asp:Panel ID="Panel391" SkinID="ModalSearchPanel" runat="server">
                        <asp:Label runat="server" Text="Name"></asp:Label>
                        <asp:TextBox runat="server"></asp:TextBox>

                        <a href="#" class="search-btn modal-search" onclick="OpenCreatePanel()">Search</a>
                    </asp:Panel>
                    <asp:Label runat="server" Text="List Title" CssClass="list-title"></asp:Label>
                    <asp:Panel ID="Panel491" SkinID="ModalListPanel" runat="server">
                        <asp:UpdatePanel runat="server" ID="UpdatePanel591">
                            <Triggers>
                                <%-- Trigger --%>
                                <%--<asp:AsyncPostBackTrigger ControlID="ViewPanelLinkButton" EventName="Click" />--%>
                            </Triggers>
                            <ContentTemplate>
                                <table cellspacing="0" style="border-collapse: collapse;" id="BodyContent_GridView11" class="list-form">
                                    <tbody>
                                        <tr>
                                            <th scope="col">&nbsp;</th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_0">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl02$SelectLinkButton','')">Bob<span>wilson@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_1">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl03$SelectLinkButton','')">Tawsif<span>tawsif@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_0">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl02$SelectLinkButton','')">Bob<span>wilson@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_1">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl03$SelectLinkButton','')">Tawsif<span>tawsif@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_0">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl02$SelectLinkButton','')">Bob<span>wilson@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_1">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl03$SelectLinkButton','')">Tawsif<span>tawsif@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>


                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <asp:Panel ID="Panel291" SkinID="ModalCreatePanelLeft" runat="server">
            <asp:HyperLink ID="HyperLink11" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label31" runat="server" SkinID="ModalTitle" Text="Create Panel"></asp:Label>
            <asp:Panel runat="server" CssClass="modal-create-content">
                <asp:Label runat="server" Text="Label"></asp:Label>
                <asp:TextBox runat="server"></asp:TextBox>
                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
                <asp:TextBox runat="server"></asp:TextBox>
                <asp:Label runat="server" Text="Label"></asp:Label>
                <asp:TextBox runat="server"></asp:TextBox>
                <asp:Label runat="server" Text="Label"></asp:Label>
                <asp:TextBox runat="server"></asp:TextBox>
                <asp:Label runat="server" Text="Label"></asp:Label>
                <asp:TextBox runat="server"></asp:TextBox>
                <asp:Label runat="server" Text="Label"></asp:Label>
                <asp:TextBox runat="server"></asp:TextBox>
                <asp:Label runat="server" Text="Label"></asp:Label>
                <asp:TextBox runat="server"></asp:TextBox>
                <asp:Label runat="server" Text="Label"></asp:Label>
                <asp:TextBox runat="server"></asp:TextBox>
                <asp:LinkButton runat="server" Text="Save" OnClientClick="CloseModals(['BodyContent_Panel291','BodyContent_ModalPanel4'])" PostBackUrl="javascript:void(0)"></asp:LinkButton>
                <asp:LinkButton runat="server" Text="Cancel" OnClientClick="CloseCreateModal('BodyContent_Panel291')" PostBackUrl="javascript:void(0)"></asp:LinkButton>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>

    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">

        <asp:LinkButton runat="server" ID="ViewPanelLinkButton" SkinID="TabTitle" OnClick="UpdateButton_Click" OnClientClick="GoToTab(2, 'Create Default');" Text="List View"></asp:LinkButton>

        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">

            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel runat="server" CssClass="filter">
                    <asp:Label ID="Label1" runat="server" Text="Search Filter"></asp:Label>
                    <a href="#" class="search-label active">All</a>
                    <a href="#" class="search-label">Department</a>
                    <a href="#" class="search-label">Sales</a>
                    <a href="#" class="search-label">Marketing</a>
                    <a href="#" class="search-label">Oppertunities</a>
                    <a href="#" class="search-label">Leads</a>
                    <a href="#" class="search-label">Projects</a>
                    <a href="#" class="search-label">Custom</a>
                </asp:Panel>
                <asp:Panel runat="server" CssClass="search">
                    <asp:Label ID="Label2" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox CssClass="validate" runat="server" AutoPostBack="false"></asp:TextBox>
                    <asp:LinkButton runat="server" CssClass="search-btn" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="ListPanel" CssClass="list-panel" runat="server">
                <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server" SelectMethod="GetUsers" TypeName="C3App.BLL.TestBL"></asp:ObjectDataSource>
                <asp:UpdatePanel runat="server" ID="UpdatePanel5">
                    <Triggers>
                        <%-- Trigger --%>
                        <asp:AsyncPostBackTrigger ControlID="ViewPanelLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:GridView CssClass="list-form" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="UserID"
                            DataSourceID="UsersObjectDataSource" GridLines="None">

                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="UserImage" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" Height="60" Width="60" />
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("UserID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False"><%# Eval("FirstName")%>
                                        
                                            <asp:Label runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                                                                 
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
            <asp:Panel runat="server" CssClass="list-details-panel">
            <asp:UpdatePanel runat="server" ID="UpdatePanel6">
                <Triggers>
                    <%-- Trigger --%>
                    <asp:AsyncPostBackTrigger ControlID="ViewPanelLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <asp:Panel ID="MiniDetailBasicPanel" SkinID="MiniDetailBasicPanel" runat="server">

                        <asp:ObjectDataSource runat="server" SelectMethod="GetUsers" TypeName="C3App.BLL.TestBL"></asp:ObjectDataSource>

                        <asp:FormView runat="server" DataSourceID="UsersObjectDataSource" CssClass="mini-details-form">
                            <EmptyDataTemplate>
                                <p>
                                    No User selected.
                                </p>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" />
                                <asp:Panel runat="server">
                                    <asp:Label CssClass="fullname" runat="server" Text='<%# Eval("FirstName") %>'></asp:Label>
                                    <asp:Label CssClass="company" runat="server" Text='<%# Eval("CompanyName") %>'></asp:Label>
                                    <asp:Label runat="server" CssClass="address" Text='<%# Eval("Address") %>'></asp:Label>
                                    <asp:Label runat="server" CssClass="email" Text='<%# Eval("Email") %>'></asp:Label>
                                    <asp:Label runat="server" CssClass="phonenumber" Text='<%# Eval("PhoneNumber") %>'></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>

                        <asp:Panel runat="server" CssClass="mini-detail-control-panel three-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="ModalPopButton2" CssClass="control-btn" runat="server" OnClientClick="OpenModal('BodyContent_ModalCalendar')">
                                        <i class="icon-calendar"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <%--<asp:LinkButton CssClass="control-btn" runat="server" PostBackUrl="#" OnClientClick="GoToTab(1, 'Default Details');">
                                        <i class="icon-edit"></i>
                                    </asp:LinkButton>--%>
                                    <asp:LinkButton ID="LinkButton1" CssClass="control-btn has-confirm" runat="server" PostBackUrl="#">
                                        <i class="icon-trash"></i>                                                                                                  
                                    </asp:LinkButton>
                                    <div class="slide-confirm">
                                        <a href="#">Confirm</a>
                                        <a href="#" class="slide-cancel">Cancel</a>
                                    </div>
                                </li>
                                <li>
                                    <asp:LinkButton CssClass="control-btn has-confirm" runat="server" PostBackUrl="#">
                                        <i class="icon-trash"></i>                                                                                                  
                                    </asp:LinkButton>
                                    <div class="slide-confirm">
                                        <i class="icon-trash"></i>
                                        <a href="#">Confirm</a>
                                        <a href="#" class="slide-cancel">Cancel</a>
                                    </div>
                                </li>
                            </ul>
                        </asp:Panel>
                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <asp:ObjectDataSource runat="server" SelectMethod="GetUsers" TypeName="C3App.BLL.TestBL"></asp:ObjectDataSource>

                        <asp:DetailsView runat="server" DataSourceID="UsersObjectDataSource" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label">
                            <Fields>
                            </Fields>
                        </asp:DetailsView>

                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
            </asp:Panel>
        </asp:Panel>
        <asp:Panel ID="ModalPanel2" SkinID="ModalPopRight" runat="server">
            <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:UpdatePanel runat="server" ID="UpdatePanel4">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ModalPopButton2" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="Label29" runat="server" SkinID="ModalTitle" Text="Modal Title"></asp:Label>
                    <asp:LinkButton ID="LinkButton3" runat="server" CssClass="modal-create-btn" Text="Create" PostBackUrl="javascript:void(0)" OnClientClick="OpenCreateModal('BodyContent_Panel112')"></asp:LinkButton>
                    <asp:Panel ID="Panel29" SkinID="ModalCreatePanel" runat="server">
                    </asp:Panel>
                    <asp:Panel ID="Panel39" SkinID="ModalSearchPanel" runat="server">
                        <asp:Label runat="server" Text="Name"></asp:Label>
                        <asp:TextBox runat="server"></asp:TextBox>

                        <asp:Label runat="server" Text="Email"></asp:Label>
                        <asp:TextBox runat="server"></asp:TextBox>

                        <asp:LinkButton runat="server" CssClass="search-btn">
                        <i class="icon-search"></i>
                        </asp:LinkButton>
                    </asp:Panel>
                    <asp:Label runat="server" Text="List Title" CssClass="list-title"></asp:Label>
                    <asp:Panel ID="Panel49" SkinID="ModalListPanel" runat="server">
                        <asp:UpdatePanel runat="server" ID="UpdatePanel59">
                            <Triggers>
                                <%-- Trigger --%>
                                <%--<asp:AsyncPostBackTrigger ControlID="ViewPanelLinkButton" EventName="Click" />--%>
                            </Triggers>
                            <ContentTemplate>
                                <table cellspacing="0" style="border-collapse: collapse;" id="BodyContent_GridView11" class="list-form">
                                    <tbody>
                                        <tr>
                                            <th scope="col">&nbsp;</th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_0">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl02$SelectLinkButton','')">Bob<span>wilson@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_1">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl03$SelectLinkButton','')">Tawsif<span>tawsif@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_0">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl02$SelectLinkButton','')">Bob<span>wilson@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_1">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl03$SelectLinkButton','')">Tawsif<span>tawsif@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_0">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl02$SelectLinkButton','')">Bob<span>wilson@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg" id="BodyContent_GridView11_UserImage_1">
                                                <a href="javascript:__doPostBack('ctl00$BodyContent$GridView11$ctl03$SelectLinkButton','')">Tawsif<span>tawsif@yahoo.com</span></a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>


                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <asp:Panel ID="ModalCalendar" SkinID="ModalPopRightBig" runat="server">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label4" runat="server" SkinID="ModalTitle" Text="Mini Calendar"></asp:Label>
            <%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="modal-create-btn" Text="Create" PostBackUrl="javascript:void(0)" OnClientClick="OpenCreateModal('BodyContent_Panel112')"></asp:LinkButton>--%>
            <asp:Panel ID="Panel4" SkinID="ModalListPanel" runat="server">
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
    </asp:Panel>

</asp:Content>
