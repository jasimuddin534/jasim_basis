<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="C3App.Reports.Reports" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">

        <asp:LinkButton runat="server" ID="DetailsPanelLinkButton" SkinID="TabTitle" OnClientClick="GoToTab(1, 'Create Report');" Text="Create Report"></asp:LinkButton>



        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">
            <%--           <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="Panel1" runat="server" CssClass="filter">
                    <asp:Label ID="Label3" runat="server" Text="Search Filter"></asp:Label>
                    <a href="#" class="search-label active">All</a>
                </asp:Panel>
                <asp:Panel ID="Panel2" runat="server" CssClass="search">
                    <asp:Label ID="Label4" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="TextBox1" CssClass="validate" runat="server" AutoPostBack="false"></asp:TextBox>
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="search-btn" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>--%>
            <asp:Panel ID="Panel3" runat="server" CssClass="list-report">
                <asp:UpdatePanel ID="upListView" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewPanelLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Panel ID="Panel4" runat="server" CssClass="list-report-left">
                            <span class="field-label">ModuleName:</span>
                            <asp:DropDownList ID="modulename" runat="server" AutoPostBack="true" OnSelectedIndexChanged="modulename_SelectedIndexChanged">
                                <asp:ListItem Value="0" Text="--Select--" />
                                <asp:ListItem Value="Accounts" Text="Accounts" />
                                <asp:ListItem Value="Campaigns" Text="Campaigns" />
                                <asp:ListItem Value="Cases" Text="Cases" />
                                <asp:ListItem Value="Contacts" Text="Contacts" />
                                <asp:ListItem Value="Documents" Text="Documents" />
                                <asp:ListItem Value="Invoices" Text="Invoices" />
                                <asp:ListItem Value="Leads" Text="Leads" />
                                <asp:ListItem Value="Meetings" Text="Meetings" />
                                <asp:ListItem Value="Opportunities" Text="Opportunities" />
                                <asp:ListItem Value="Orders" Text="Orders" />
                                <asp:ListItem Value="Products" Text="Products" />
                                <asp:ListItem Value="Tasks" Text="Tasks" />
                            </asp:DropDownList>
                            <br>
                            <span class="field-label">Field:</span>
                            <asp:DropDownList ID="colname" runat="server" AppendDataBoundItems="true" OnSelectedIndexChanged="colname_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Value="0" Text="--Select--" />
                            </asp:DropDownList>
                            <br>
                            <span class="field-label">Operator:</span>
                            <asp:DropDownList ID="OperatorDropdown" runat="server" OnSelectedIndexChanged="OperatorDropdown_SelectedIndexChanged" AutoPostBack="true">
                                <asp:ListItem Value="0" Text="--Select--" />
                                <asp:ListItem Value="Equals" Text="Equals" />
                                <asp:ListItem Value="Not Equal" Text="Not Equal" />
                                <asp:ListItem Value="Greater than Equal" Text="Greater than Equal" />
                                <asp:ListItem Value="Less than Equal" Text="Less than Equal" />
                                <asp:ListItem Value="Total" Text="Total" />
                                <asp:ListItem Value="Max" Text="Max" />
                                <asp:ListItem Value="Min" Text="Min" />
                                <asp:ListItem Value="Contains" Text="Contains" />
                                <asp:ListItem Value="Not Contains" Text="Not Contains" />
                            </asp:DropDownList>
                            <br>
                            <span class="field-label">Keyword:</span>
                            <asp:TextBox ID="KeywordTextBox" runat="server"></asp:TextBox>

                            <asp:DropDownList ID="KeywordDropDownList" runat="server" Visible="false"></asp:DropDownList>

                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                            <asp:HiddenField ID="ModuleNameHiddenField" runat="server" />
                            <asp:HiddenField ID="HiddenField1" runat="server" />
                            <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                            <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                            <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Update" Text="Run" OnClick="UpdateLinkButton_Click"></asp:LinkButton>
                            <asp:LinkButton ID="Button1" Visible="false" CssClass="form-btn" runat="server" Text="Export to Excel" OnClick="Button1_Click">
                            </asp:LinkButton>
                        </asp:Panel>
                        <asp:Panel ID="Panel5" runat="server" CssClass="list-report-right">
                            <asp:Panel ID="Panel6" runat="server" CssClass="div-box">
                                <span class="title">Available</span>
                                <asp:ListBox ID="ListBox1" runat="server" SelectionMode="Multiple"></asp:ListBox>
                            </asp:Panel>
                            <asp:Panel ID="Panel7" runat="server" CssClass="div-control">
                                <asp:LinkButton ID="SelectLinkButton" runat="server" OnClick="SelectLinkButton_Click">
                                <i class="icon-arrow-right"></i> 
                                </asp:LinkButton>
                                <asp:LinkButton ID="DeselectLinkButton" runat="server" OnClick="DeselectLinkButton_Click">
                                <i class="icon-arrow-left"></i>
                                </asp:LinkButton>
                            </asp:Panel>
                            <asp:Panel ID="Panel9" runat="server" CssClass="div-box">
                                <span class="title">Display</span>
                                <asp:ListBox ID="ListBox2" runat="server" SelectionMode="Multiple"></asp:ListBox>
                            </asp:Panel>
                            <asp:Label ID="lbltxt" runat="server" ForeColor="Red" Text=""></asp:Label>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>

            <asp:Panel ID="Panel8" runat="server" CssClass="details-report">
                <asp:UpdatePanel ID="upGridView" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewPanelLinkButton" EventName="Click" />
                        <asp:PostBackTrigger ControlID="Button1" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Label ID="Label5" runat="server" Text="Report" CssClass="title"></asp:Label>
                        <asp:Panel ID="Panel10" runat="server" CssClass="details-report-content">



                            <asp:GridView ID="ReportGridView" runat="server" CssClass="report-form" GridLines="Vertical">
                                <AlternatingRowStyle BackColor="#DCDCDC"></AlternatingRowStyle>
                                <EmptyDataTemplate>
                                    <p>
                                        No Data Found
                                    </p>
                                </EmptyDataTemplate>
                                <FooterStyle BackColor="#CCCCCC" ForeColor="Black"></FooterStyle>

                                <HeaderStyle BackColor="#d71e2f" Font-Bold="True" ForeColor="White"></HeaderStyle>

                                <PagerStyle HorizontalAlign="Center" BackColor="#999999" ForeColor="Black"></PagerStyle>

                                <RowStyle BackColor="#EEEEEE" ForeColor="Black"></RowStyle>

                                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White"></SelectedRowStyle>

                                <SortedAscendingCellStyle BackColor="#F1F1F1"></SortedAscendingCellStyle>

                                <SortedAscendingHeaderStyle BackColor="#0000A9"></SortedAscendingHeaderStyle>

                                <SortedDescendingCellStyle BackColor="#CAC9C9"></SortedDescendingCellStyle>

                                <SortedDescendingHeaderStyle BackColor="#000065"></SortedDescendingHeaderStyle>
                            </asp:GridView>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
        </asp:Panel>

    </asp:Panel>

    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">
        <asp:LinkButton runat="server" ID="ViewPanelLinkButton" SkinID="TabTitle" OnClientClick="GoToTab(2, 'Create Report');" Text="View Reports"></asp:LinkButton>

        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="DetailsPanelLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <asp:Panel ID="Panel1" SkinID="TabContent" runat="server">
                        <asp:Panel CssClass="full-tab-content" runat="server">
                            <div class="column-3">
                                <h4 class="font-light">Reports For Product</h4>
                                <ul class="nav vertical margined">
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportsforProduct.aspx" target="_blank" class="button block">Search by Product Name</a>
                                    </li>
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportsforProduct.aspx" target="_blank" class="button block">Search by Product Category</a>
                                    </li>
                                </ul>
                            </div>

                            <div class="column-3">
                                <h4 class="font-light">Reports For Order</h4>
                                <ul class="nav vertical margined">
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportsforOrder.aspx" target="_blank" class="button block">Search by Order Name</a>
                                    </li>
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportsforOrder.aspx" target="_blank" class="button block">Search by Product Name</a>
                                    </li>
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportsforOrder.aspx" target="_blank" class="button block">Search by Customer Name</a>
                                    </li>
                                </ul>
                            </div>

                            <div class="column-3">
                                <h4 class="font-light">Reports For Invoice</h4>
                                <ul class="nav vertical margined">
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportFromView.aspx" target="_blank" class="button block">Search by Invoice Date</a>
                                    </li>
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportFromView.aspx" target="_blank" class="button block">Search by Invoice Status</a>
                                    </li>
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportFromView.aspx" target="_blank" class="button block">Search by Order Name</a>
                                    </li>
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportFromView.aspx" target="_blank" class="button block">Search by Customer Name</a>
                                    </li>
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportFromView.aspx" target="_blank" class="button block">Search by Product Name</a>
                                    </li>
                                    <li>
                                        <a href="http://localhost:60243/Reports/ReportFromView.aspx" target="_blank" class="button block">Search by Product Category</a>
                                    </li>
                                </ul>
                            </div>
                        </asp:Panel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>


    </asp:Panel>


</asp:Content>
