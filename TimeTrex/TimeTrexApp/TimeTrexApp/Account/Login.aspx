<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TimeTrexApp.Account.Login" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <asp:Panel ID="Panel1" runat="server" CssClass="row">
        <asp:Label ID="Label1" runat="server" CssClass="page-title"><%: Title %></asp:Label>
    </asp:Panel>

    <asp:Panel ID="Panel2" runat="server" CssClass="row">
        <asp:Login ID="login" runat="server" ViewStateMode="Disabled" RenderOuterTable="false" OnLoggedIn="Login_LoggedIn">
            <LayoutTemplate>
                <p class="validation-summary-errors">
                    <asp:Literal runat="server" ID="FailureText" />
                </p>
                    <ul class="form-vertical">
                        <li>
                            <asp:Label ID="Label2" runat="server" AssociatedControlID="UserName">User name</asp:Label>
                            <asp:TextBox runat="server" ID="UserName" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="UserName" CssClass="field-validation-error" ErrorMessage="The user name field is required." />
                        </li>
                        <li>
                            <asp:Label ID="Label3" runat="server" AssociatedControlID="Password">Password</asp:Label>
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Password" CssClass="field-validation-error" ErrorMessage="The password field is required." />
                        </li>                       
                    </ul>
                    <asp:Button ID="Login" runat="server" CommandName="Login" Text="Log in" CssClass="form-button" />
            </LayoutTemplate>
        </asp:Login>
    </asp:Panel>
</asp:Content>
