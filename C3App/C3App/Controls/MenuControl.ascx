<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MenuControl.ascx.cs" Inherits="C3App.UserControls.MenuControl" %>
<ul>
    <li class="dropdown">
        <asp:Button ID="Button1" runat="server" Text="Home" PostBackUrl="~/Default.aspx?ShowPanel=DetailsPanel" />
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">Marketing</a>
        <ul>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Campaign</a>
                <ul>
                    <li>
                        <asp:Button ID="Button2" runat="server" Text="Create Campaign" PostBackUrl="~/Campaigns/Campaigns.aspx?ShowPanel=DetailsPanel" />
                    <li>
                        <asp:Button ID="Button3" runat="server" Text="View Campaign" PostBackUrl="~/Campaigns/Campaigns.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Accounts</a>
                <ul>
                    <li>
                        <asp:Button ID="Button16" runat="server" Text="Create Account" PostBackUrl="~/Accounts/Accounts.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button17" runat="server" Text="View Accounts" PostBackUrl="~/Accounts/Accounts.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Contacts</a>
                <ul>
                    <li>
                        <asp:Button ID="Button19" runat="server" Text="Create Contact" PostBackUrl="~/Contacts/Contacts.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button20" runat="server" Text="View Contacts" PostBackUrl="~/Contacts/Contacts.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Leads</a>
                <ul>
                    <li>
                        <asp:Button ID="Button22" runat="server" Text="Create Lead" PostBackUrl="~/Leads/Leads.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button23" runat="server" Text="View Leads" PostBackUrl="~/Leads/Leads.aspx?ShowPanel=ViewPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button24" runat="server" Text="Convert Leads" />
                    </li>
                </ul>
            </li>
        </ul>
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">Sales</a>
        <ul>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Accounts</a>
                <ul>
                    <li>
                        <asp:Button ID="Button4" runat="server" Text="Create Account" PostBackUrl="~/Accounts/Accounts.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button5" runat="server" Text="View Accounts" PostBackUrl="~/Accounts/Accounts.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Contacts</a>
                <ul>
                    <li>
                        <asp:Button ID="Button6" runat="server" Text="Create Contact" PostBackUrl="~/Contacts/Contacts.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button7" runat="server" Text="View Contacts" PostBackUrl="~/Contacts/Contacts.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Leads</a>
                <ul>
                    <li>
                        <asp:Button ID="Button8" runat="server" Text="Create Lead" PostBackUrl="~/Leads/Leads.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button9" runat="server" Text="View Leads" PostBackUrl="~/Leads/Leads.aspx?ShowPanel=ViewPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button10" runat="server" Text="Convert Leads" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Opportunities</a>
                <ul>
                    <li>
                        <asp:Button ID="Button26" runat="server" Text="Create Opportunity" PostBackUrl="~/Opportunities/Opportunities.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button27" runat="server" Text="View Opportunities" PostBackUrl="~/Opportunities/Opportunities.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
        </ul>
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">Orders</a>
        <ul>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Products</a>
                <ul>
                    <li>
                        <asp:Button ID="Button30" runat="server" Text="Create Product" PostBackUrl="~/Products/Products.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button31" runat="server" Text="View Products" PostBackUrl="~/Products/Products.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Orders</a>
                <ul>
                    <li>
                        <asp:Button ID="Button33" runat="server" Text="Create Order" PostBackUrl="~/Orders/Orders.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button34" runat="server" Text="View Orders" PostBackUrl="~/Orders/Orders.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Invoices</a>
                <ul>
                    <li>
                        <asp:Button ID="Button36" runat="server" Text="Create Invoice" PostBackUrl="~/Invoices/Invoices.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button37" runat="server" Text="View Invoices" PostBackUrl="~/Invoices/Invoices.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
        </ul>
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">Supports</a>
        <ul>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Cases</a>
                <ul>
                    <li>
                        <asp:Button ID="Button39" runat="server" Text="Create Case" PostBackUrl="~/Cases/Cases.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button40" runat="server" Text="View Cases" PostBackUrl="~/Cases/Cases.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
        </ul>
    </li>
    <li class="dropdown">
        <a href="javascript:void(0)">Administraion</a>
        <ul>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Company Settings</a>
                <ul>
                    <li>
                        <asp:Button ID="Button14" runat="server" Text="Create User" PostBackUrl="~/Users/Company.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button25" runat="server" Text="View Users" PostBackUrl="~/Users/Company.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Manage Users</a>
                <ul>
                    <li>
                        <asp:Button ID="Button11" runat="server" Text="Create User" PostBackUrl="~/Users/Users.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button12" runat="server" Text="View Users" PostBackUrl="~/Users/Users.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Manage Roles</a>
                <ul>
                    <li>
                        <asp:Button ID="Button21" runat="server" Text="Create Role" PostBackUrl="~/Administration/ACLRoles/ACLRoles.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button13" runat="server" Text="View Roles" PostBackUrl="~/Administration/ACLRoles/ACLRoles.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
            <li class="dropdown submenu">
                <a href="javascript:void(0)">Manage Teams</a>
                <ul>
                    <li>
                        <asp:Button ID="Button15" runat="server" Text="Create Team" PostBackUrl="~/Users/Teams.aspx?ShowPanel=DetailsPanel" />
                    </li>
                    <li>
                        <asp:Button ID="Button18" runat="server" Text="View Teams" PostBackUrl="~/Users/Teams.aspx?ShowPanel=ViewPanel" />
                    </li>
                </ul>
            </li>
        </ul>
    </li>
</ul>
