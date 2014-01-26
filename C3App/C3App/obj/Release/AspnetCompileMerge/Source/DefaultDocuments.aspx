<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="DefaultDocuments.aspx.cs" Inherits="C3App.DefaultDocuments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">
        <asp:LinkButton runat="server" ID="DetailsPanelLinkButton" SkinID="TabTitle" OnClick="UpdateButton_Click" OnClientClick="GoToTab(1);" Text="Upload Documents"></asp:LinkButton>
        <asp:Panel ID="DetailsContentPanel" CssClass="tab-content no-left" runat="server">
            <asp:Panel runat="server" CssClass="details-panel-header">
                <asp:LinkButton runat="server" CssClass="header-upload-btn"><i class="icon-upload"></i></asp:LinkButton>
                <h2>Click to Upload Documents</h2>
                <h4>Uploading</h4>
                <div class="progress active"><span class="meter" style="width: 50%;"></span></div>
                <h2 class="title">Uploads History</h2>
            </asp:Panel>

            <asp:Panel runat="server" CssClass="details-form-order">
                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="DetailsPanelLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <div>
                            <table class="details-form-list">
                                <tbody>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img style="height: 60px; width: 60px;" src="Users/Images/Chrysanthemum.jpg">
                                            <a href="#" class="">Document Title</a>
                                            <span class="left time">Time</span>
                                            <span class="left date">Date</span>
                                            <span class="right title">Updated By</span>
                                            <br />
                                            <span class="right name">Rakib Jafor</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">
        <asp:LinkButton runat="server" ID="ViewPanelLinkButton" SkinID="TabTitle" OnClick="UpdateButton_Click" OnClientClick="GoToTab(2);" Text="View Documents"></asp:LinkButton>

        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">
            <asp:Panel ID="Panel1" SkinID="TabContent" runat="server">

                <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                    <asp:Panel ID="Panel2" runat="server" CssClass="filter">
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
                    <asp:Panel ID="Panel3" runat="server" CssClass="search">
                        <asp:Label ID="Label2" runat="server" Text="Search"></asp:Label>
                        <asp:TextBox ID="TextBox1" CssClass="datepicker" runat="server" AutoPostBack="false"></asp:TextBox>
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="search-btn" Text="Search"></asp:LinkButton>
                    </asp:Panel>
                </asp:Panel>

                <asp:Panel ID="ListPanel" CssClass="list-panel" runat="server">
                    <asp:UpdatePanel runat="server" ID="UpdatePanel5">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ViewPanelLinkButton" EventName="Click" />
                        </Triggers>
                        <ContentTemplate>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:Panel>

                <asp:UpdatePanel runat="server" ID="UpdatePanel6">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewPanelLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Panel ID="MiniDetailBasicPanel" SkinID="MiniDetailBasicPanel" runat="server">

                            <asp:Panel ID="Panel5" runat="server" CssClass="mini-detail-control-panel">

                                <asp:LinkButton ID="ModalPopButton2" CssClass="control-btn three" runat="server">
                                <i class="icon-calendar"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="LinkButton2" CssClass="control-btn three" runat="server" PostBackUrl="#">
                                <i class="icon-edit"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="LinkButton3" CssClass="control-btn three delete-btn" runat="server" PostBackUrl="#">
                                <i class="icon-trash"></i>                                                                   
                                </asp:LinkButton>

                            </asp:Panel>
                            <div class="delete-confirm">
                                <asp:LinkButton ID="LinkButton4" CssClass="" runat="server" PostBackUrl="#">
                                    Confirm                                                                   
                                </asp:LinkButton>
                                <asp:LinkButton ID="LinkButton5" CssClass="delete-cancel" runat="server" PostBackUrl="#">
                                    Cancel                                                                   
                                </asp:LinkButton>
                            </div>
                        </asp:Panel>

                        <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                            <asp:Panel runat="server" CssClass="mini-details-more-progress-panel">
                                Progress
                            </asp:Panel>
                            <asp:Panel runat="server" CssClass="mini-details-more-graph-panel">
                                Graph
                            </asp:Panel>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
</asp:Content>
