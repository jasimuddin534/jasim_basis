<%@ Page Title="Manage Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="TimeTrexApp.Account.Manage" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="Panel1" runat="server" CssClass="row">
        <asp:Label ID="Label1" runat="server" CssClass="page-title"><%: Title %></asp:Label>
    </asp:Panel>

    <asp:Panel ID="Panel2" runat="server" CssClass="row">
        <section id="passwordForm">
            <asp:PlaceHolder runat="server" ID="successMessage" Visible="false" ViewStateMode="Disabled">
                <p class="message-success"><%: SuccessMessage %></p>
            </asp:PlaceHolder>

            <p>You're logged in as <strong><%: User.Identity.Name %></strong>.</p>

            <asp:PlaceHolder runat="server" ID="setPassword" Visible="false">
                <p>
                    You do not have a local password for this site. Add a local
                password so you can log in without an external login.
                </p>
                    <ul class="form-vertical">
                        <li>
                            <asp:Label runat="server" AssociatedControlID="password">Password</asp:Label>
                            <asp:TextBox runat="server" ID="password" TextMode="Password" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="password"
                                CssClass="field-validation-error" ErrorMessage="The password field is required."
                                Display="Dynamic" ValidationGroup="SetPassword" />

                            <asp:ModelErrorMessage runat="server" ModelStateKey="NewPassword" AssociatedControlID="password"
                                CssClass="field-validation-error" SetFocusOnError="true" />

                        </li>
                        <li>
                            <asp:Label runat="server" AssociatedControlID="confirmPassword">Confirm password</asp:Label>
                            <asp:TextBox runat="server" ID="confirmPassword" TextMode="Password" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="confirmPassword"
                                CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The confirm password field is required."
                                ValidationGroup="SetPassword" />
                            <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="confirmPassword"
                                CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The password and confirmation password do not match."
                                ValidationGroup="SetPassword" />
                        </li>
                    </ul>
                    <asp:Button runat="server" Text="Set Password" ValidationGroup="SetPassword" OnClick="setPassword_Click" CssClass="form-button" />
            </asp:PlaceHolder>

            <asp:PlaceHolder runat="server" ID="changePassword" Visible="false">
                <h3>Change password</h3>
                <asp:ChangePassword runat="server" CancelDestinationPageUrl="~/" ViewStateMode="Disabled" RenderOuterTable="false" SuccessPageUrl="Manage.aspx?m=ChangePwdSuccess">
                    <ChangePasswordTemplate>
                        <p class="validation-summary-errors">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                            <ul class="form-vertical">
                                <li>
                                    <asp:Label runat="server" ID="CurrentPasswordLabel" AssociatedControlID="CurrentPassword">Current password</asp:Label>
                                    <asp:TextBox runat="server" ID="CurrentPassword" CssClass="passwordEntry" TextMode="Password" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="CurrentPassword"
                                        CssClass="field-validation-error" ErrorMessage="The current password field is required."
                                        ValidationGroup="ChangePassword" />
                                </li>
                                <li>
                                    <asp:Label runat="server" ID="NewPasswordLabel" AssociatedControlID="NewPassword">New password</asp:Label>
                                    <asp:TextBox runat="server" ID="NewPassword" CssClass="passwordEntry" TextMode="Password" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="NewPassword"
                                        CssClass="field-validation-error" ErrorMessage="The new password is required."
                                        ValidationGroup="ChangePassword" />
                                </li>
                                <li>
                                    <asp:Label runat="server" ID="ConfirmNewPasswordLabel" AssociatedControlID="ConfirmNewPassword">Confirm new password</asp:Label>
                                    <asp:TextBox runat="server" ID="ConfirmNewPassword" CssClass="passwordEntry" TextMode="Password" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmNewPassword"
                                        CssClass="field-validation-error" Display="Dynamic" ErrorMessage="Confirm new password is required."
                                        ValidationGroup="ChangePassword" />
                                    <asp:CompareValidator runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                                        CssClass="field-validation-error" Display="Dynamic" ErrorMessage="The new password and confirmation password do not match."
                                        ValidationGroup="ChangePassword" />
                                </li>
                            </ul>
                            <asp:Button runat="server" CommandName="ChangePassword" Text="Change password" ValidationGroup="ChangePassword" CssClass="form-button" />
                    </ChangePasswordTemplate>
                </asp:ChangePassword>
            </asp:PlaceHolder>
        </section>
    </asp:Panel>
</asp:Content>
