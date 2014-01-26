<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/home/Public.Master" AutoEventWireup="true" CodeBehind="UserLogin.aspx.cs" Inherits="C3App.UserLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>


<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">
    <div class="login-content">
        <div class="left-content">
            <h1 class="content-title active"><a href="#">AETHER</h1>
            <h1 class="content-title"><a href="#">NEER</a></h1>
            <h1 class="content-title"><a href="#">REGISTER</a></h1>
            <h1 class="content-title"><a href="#">FACEBOOK</a></h1>
            <h1 class="content-title"><a href="#">TWITTER</a></h1>
            <h1 class="content-title fade">CLOUD</h1>
            <h1 class="content-title fade">CONTACT</h1>
            <h1 class="content-title fade">CENTER</h1>
        </div>
        <div class="right-content">
            <img class="logo" src="Content/themes/base/images/c3_logo_white.png"/>
            <div class="login-form-line"></div>
            <asp:Panel ID="Panel1" CssClass="login-form" runat="server">
                <asp:Label ID="UserNameLabel" CssClass="form-label" runat="server" Text="Username"></asp:Label>
                <asp:TextBox ID="UserNameTextBox" runat="server" Text=""></asp:TextBox>
                <asp:Label ID="PasswordLabel" CssClass="form-label" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="PasswordTextBox" runat="server" Text="" TextMode="Password"></asp:TextBox>
                <asp:Button ID="Submit"  CssClass="form-submit"  runat="server"  Text="" OnClick="SubmitButton_Click" />
                <a href="/Forgot.aspx" class="btn-forgot">Forgot Password</a>               
                <%--<a href="/UserRegister.aspx" class="btn-register">Register</a>--%>
            </asp:Panel>

        </div>
        <div class="right-border"></div>
        <div class="login-footer">
            All rights reserved <%= DateTime.Today.Year %> &copy; Panacea Systems Ltd
        </div>        
    </div>

    <div id="myModal" class="reveal-modal small">
        <h2>
        <asp:Literal ID="Literal1" runat="server"></asp:Literal></h2>
        <a class="close-reveal-modal">&#215;</a>
        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </div>
</asp:Content>
