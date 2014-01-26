<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Administration.aspx.cs" Inherits="C3App.Administration.Administration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <asp:Panel ID="Panel1" runat="server" CssClass="setup-container">
        <dl class="tabs">
            <dd class="active"><a href="#simple1">ADMIN</a></dd>
        </dl>
        <ul class="tabs-content">
            <li class="active" id="simple1Tab">
                <asp:Panel ID="Panel2" runat="server" CssClass="tab-header">
                    <img src="/Content/images/c3/administration_icon.png" />
                    <h1>ADMINISTRATION</h1>
                    <h5>This panel allows you to change settings.</h5>
                </asp:Panel>
                <ul class="accordion">
                    <li class="active">
                        <asp:Panel ID="Panel3" runat="server" CssClass="title">
                            <h5>Manage Users</h5>
                        </asp:Panel>
                        <asp:Panel ID="Panel4" runat="server" CssClass="content">
                            <a href="../Users/Users.aspx?ShowPanel=DetailsPanel"><i class="icon-user"></i><span><i class="icon-plus"></i></span>Create User</a>
                            <a href="../Users/Users.aspx?ShowPanel=ViewPanel"><i class="icon-user"></i><span><i class="icon-search"></i></span>View Users</a>
                        </asp:Panel>
                    </li>
                    <li>
                        <asp:Panel ID="Panel6" runat="server" CssClass="title">
                            <h5>Manage Roles</h5>
                        </asp:Panel>
                        <asp:Panel ID="Panel7" runat="server" CssClass="content">
                            <a href="ACLRoles/ACLRoles.aspx?ShowPanel=DetailsPanel"><i class="icon-cog"></i><span><i class="icon-plus"></i></span>Create Role</a>
                            <a href="ACLRoles/ACLRoles.aspx?ShowPanel=ViewPanel"><i class="icon-cog"></i><span><i class="icon-search"></i></span>View Roles</a>
                        </asp:Panel>
                    </li>
                    <li>
                        <asp:Panel ID="Panel8" runat="server" CssClass="title">
                            <h5>Manage Teams</h5>
                        </asp:Panel>
                        <asp:Panel ID="Panel9" runat="server" CssClass="content">
                            <a href="../Users/Teams.aspx?ShowPanel=DetailsPanel"><i class="icon-group"></i><span><i class="icon-plus"></i></span>Create Team</a>
                            <a href="../Users/Teams.aspx?ShowPanel=ViewPanel"><i class="icon-group"></i><span><i class="icon-search"></i></span>View Teams</a>
                        </asp:Panel>
                    </li>

                    <li>
                        <asp:Panel ID="Panel5" runat="server" CssClass="title">
                            <h5>Company Settings</h5>
                        </asp:Panel>
                        <asp:Panel ID="Panel12" runat="server" CssClass="content">
                            <a href="../Users/Company.aspx?ShowPanel=DetailsPanel"><i class="icon-group"></i><span><i class="icon-plus"></i></span>Company Settings</a>
                        </asp:Panel>
                    </li>
                </ul>
            </li>            
        </ul>
        <asp:Panel ID="Panel10" runat="server" CssClass="footer">
            <img src="/Content/images/c3/aether_footer_logo.png" />
            <asp:Label ID="Firstname" runat="server" CssClass="logged-in" Text=""></asp:Label>
        <%-- <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="#" CssClass="slide-control"></asp:LinkButton>--%>
            <asp:Panel ID="Panel11" runat="server" CssClass="footer-content">
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
    <script type="text/javascript">
        $(window).load(function () {
            $('.slide-control').click(function (e) {
                e.preventDefault();
                if (!$(this).hasClass('active')) {
                    $(this).next('.footer-content').slideToggle(300, function () {
                        $(this).prev('.slide-control').addClass('active');
                    });
                } else {
                    $(this).next('.footer-content').slideToggle(300, function () {
                        $(this).prev('.slide-control').removeClass('active');
                    });
                }
            })
        })
        $('.accordion .content').click(function (e) {
            e.stopPropagation();
        })
    </script>
</asp:Content>
