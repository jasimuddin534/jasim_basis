<%@ Page Language="C#" MasterPageFile="~/App_MasterPages/home/Public.Master" AutoEventWireup="true" CodeBehind="Forgot.aspx.cs" Inherits="C3App.Forgot" %>

<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">

    <div class="reg-content">
        <div class="reg-form-back"></div>
        <div class="reg-form-line"></div>
        <div class="reg-left-content">
            <a href="/UserLogin.aspx"><img class="logo" src="Content/themes/base/images/c3_logo_white.png" /></a>
            <h1 class="reg-title">FORGOT PASSWORD</h1>
        </div>
        <div class="reg-right-content">
            <a href="#" class="content-title active">AETHER</a>
            <a href="#" class="content-title">FACEBOOK</a>
            <a href="#" class="content-title">TWITTER</a>
            <a href="#" class="content-title fade">CLOUD</a>
            <a href="#" class="content-title fade">CONTACT</a>
            <a href="#" class="content-title fade">CENTER</a>
        </div>
        <div class="reg-form">
            <div class="form-tab left">
                <asp:TextBox ID="EmailTextBox" runat="server" placeholder="EMAIL ADDRESS"></asp:TextBox>
                <asp:LinkButton ID="SubmitLinkButton" CssClass="form-next-btn" runat="server" Text="" OnClick="EmailAddressButton_Click" />
                <asp:Label ID="SubmitLabel" runat="server" Text=""></asp:Label>
            </div>
            <div class="form-tab middle">
                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="SubmitLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Label ID="Label3" runat="server" CssClass="input-label"  Text="Security Question"></asp:Label>
                        <asp:Label ID="SecurityQuestionLabel" runat="server" CssClass="input-label ques" Text=""></asp:Label>
                        <asp:Label ID="Label26" runat="server" CssClass="input-label"  Text="Security Answer"></asp:Label>
                        <asp:TextBox ID="SecurityAnswerTextBox" placeholder="Security Answer" runat="server"></asp:TextBox>
                        <asp:LinkButton ID="AnswerLinkButton" CssClass="form-next-btn" runat="server" OnClick="SecurityAnswerButton_Click" />
                        <asp:Label ID="AnswerLabel" runat="server" Text=""></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>

            </div>

            <div class="form-tab right">
                <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="AnswerLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                       <%-- <asp:Label ID="Label2" runat="server" CssClass="input-label"  Text="Date of Birth"></asp:Label>--%>
                        <%--<asp:TextBox ID="BirthTextBox" class="datepicker" runat="server" placeholder="DATE OF BIRTH" ></asp:TextBox>--%>
                        <asp:Button ID="SubmitButton" CssClass="form-submit" runat="server" Text="SUBMIT" OnClick="SubmitButton_Click" />
                         <asp:Button runat="server" class="form-submit right" Text="Cancel" ID="cancel" OnClick="cancel_Click"></asp:Button>
                        <asp:Label ID="emailSentLabel" runat="server" Text=""></asp:Label>
                    </ContentTemplate>
                </asp:UpdatePanel>

     
            </div>
        </div>
        <div class="reg-nav">
            <ul>
                <li><a href="#" >EMAIL</a></li>
                <li><a href="#" >QUESTION</a></li>
                <li><a href="#">FINISH</a></li>
            </ul>
        </div>
    </div>

    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel3"  UpdateMode="Always">
            <ContentTemplate>
                <h2><asp:Literal ID="Literal1" runat="server" Text=""></asp:Literal></h2>
                <asp:LinkButton ID="CloseLinkButton" class="close-reveal-modal" runat="server">&#215;</asp:LinkButton>
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

               <asp:UpdateProgress ID="ForgotUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

</asp:Content>

