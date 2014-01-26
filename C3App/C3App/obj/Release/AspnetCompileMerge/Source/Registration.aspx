<%@ Page Language="C#" MasterPageFile="~/App_MasterPages/home/Public.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="C3App._Default" %>

<asp:Content ID="HeadContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">
    <script type="text/javascript">
        var slideLeft = '';
        var activeSlide = '-1';
        function GoToSlide(value) {

            if (value == 0) { slideLeft = '17%' }
            else if (value == 1) { slideLeft = '50%' }
            else if (value == 2) { slideLeft = '83.5%' }

            if (value == activeSlide) {
                return false;
            } else {
                $(".form-tab.active").removeClass("active");
                $(".reg-form-back").animate({
                    left: slideLeft
                }, function () {
                    activeSlide = value;
                    $(".form-tab:eq(" + value + ")").addClass("active");
                });
            }
        }
    </script>
    <div class="reg-content">
        <div class="reg-form-back"></div>
        <div class="reg-form-line"></div>
        <div class="reg-left-content">
            <img class="logo" src="Content/themes/base/images/c3_logo_white.png" />
            <h1 class="reg-title">REGISTER</h1>
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
                <input type="text" value="FIRST NAME" />
                <input type="text" value="LAST NAME" />
                <input type="text" value="COMPANY NAME" />
                <a href="#" class="form-next-btn" onclick="GoToSlide(1);"></a>
            </div>
            <div class="form-tab middle">
                <input type="text" value="STREET" />
                <input type="text" value="STREET" />
                <input type="text" value="CITY" />
                <input type="text" value="STATE" />
                <input type="text" value="POSTAL CODE" />
                <input type="text" value="COUNTRY" />
                <input type="text" value="TELEPHONE" />
                <input type="text" value="MOBILE" />
                <input type="text" value="EMAIL" />
                <a href="#" class="form-next-btn" onclick="GoToSlide(2);"></a>
            </div>
            <div class="form-tab right">
                <img src="Content/themes/base/images/recaptcha.gif" width="200px;"/>
                <input type="submit" class="form-submit" value="SUBMIT" />
            </div>
        </div>
        <div class="reg-nav">
            <ul>
                <li><a href="#" onclick="GoToSlide(0);">NAME</a></li>
                <li><a href="#" onclick="GoToSlide(1);">CONTACT</a></li>
                <li><a href="#" onclick="GoToSlide(2);">FINISH</a></li>
            </ul>
        </div>
    </div>
</asp:Content>
