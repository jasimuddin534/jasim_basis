<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/App_MasterPages/home/Public.Master" AutoEventWireup="true" CodeBehind="Public.aspx.cs" Inherits="C3App._Default" %>


<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">
    <div class="login-content">
        <div class="left-content">
            <h1 class="content-title active">AETHER</h1>
            <h1 class="content-title">NEER</h1>
            <h1 class="content-title">FACEBOOK</h1>
            <h1 class="content-title">TWITTER</h1>
            <h1 class="content-title fade">CLOUD</h1>
            <h1 class="content-title fade">CONTACT</h1>
            <h1 class="content-title fade">CENTER</h1>
        </div>
        <div class="right-content">
            <img class="logo" src="Content/themes/base/images/c3_logo_white.png"/>
            <div class="login-form-line"></div>
            <asp:Panel ID="Panel1" CssClass="login-form" runat="server">
                <asp:Label ID="Label76" CssClass="form-label" runat="server" Text="Username"></asp:Label>
                <asp:TextBox ID="TextBox1" runat="server" Text=""></asp:TextBox>
                <asp:Label ID="Label78" CssClass="form-label" runat="server" Text="Password"></asp:Label>
                <asp:TextBox ID="TextBox2" runat="server" Text=""></asp:TextBox>
                <asp:Button ID="Button1" CssClass="form-submit" runat="server" Text="" />
                <a href="/Forgot.aspx" class="btn-forgot">Forgot Password</a>               
                <a href="/Registration.aspx" class="btn-register">Register</a>
            </asp:Panel>

        </div>
        <div class="right-border"></div>
        <div class="login-footer">
            All rights reserved 2012 &copy; Panacea Systems Ltd
        </div>        
    </div>
</asp:Content>
