<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/home/Public.Master" AutoEventWireup="true" CodeBehind="Activation.aspx.cs" Inherits="C3App.Activation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

<%-- <asp:Label ID="stausLabel" runat="server"  Text="Thank you.Your account has been activated !!"></asp:Label>--%>
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
        </div>
        <div class="right-border"></div>
        <div class="login-footer">
            All rights reserved 2012 &copy; Panacea Systems Ltd
        </div>      
    </div>
    <div id="myModal" class="reveal-modal small">
        <h2>
            <asp:Literal ID="Literal1" runat="server"></asp:Literal></h2>
        <a class="close-reveal-modal">&#215;</a>

        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    </div> 
</asp:Content>
