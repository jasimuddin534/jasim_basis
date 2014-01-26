<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="ModuleSelect.aspx.cs" Inherits="C3App.ModuleSelect" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    <div class="module-select">
        <div class="module-select-timeline">
            <div class="bullet one active" data-id="1">
                <span>TRIAL OR BUY?</span>
            </div>
            <div class="bullet two" data-id="2">
                <span>MODULE SELECTION</span>
            </div>
            <div class="bullet three" data-id="3">
                <span>PAYMENT METHOD</span>
            </div>
            <div class="bullet four" data-id="4">
                <span>PAYMENT INFO</span>
            </div>
            <div class="bullet five" data-id="5">
                <span>PAYMENT CONFIRMATION</span>
            </div>
            <div class="bullet-link"></div>
            <div class="bullet-link active"></div>
        </div>
        <div class="module-select-content">
            <div class="slides">
                <div data-id="1" class="slide-item active first">
                    <div class="vertical-center trial-buy">
                        <a href="#" class="big-btn left active">TRIAL</a>
                        <asp:Image ID="Image1" CssClass="logo" runat="server" ImageUrl="~/Content/themes/images/c3/logo-medium.png" />
                        <a href="#" class="big-btn right">BUY</a>
                    </div>
                </div>
                <div data-id="2" class="slide-item">
                    <div class="vertical-center module">
                        <h1>CLOUD + CRM = </h1>
                        <asp:Image ID="Image2" CssClass="logo" runat="server" ImageUrl="~/Content/themes/images/c3/logo-medium.png" />
                    </div>
                </div>
                <div data-id="3" class="slide-item">
                    <div class="vertical-center pay-method">
                        <a href="#" class="pay-option">
                            <asp:Image ID="Image4" runat="server" ImageUrl="~/Content/images/c3/cash.png" />
                            CASH
                        </a>
                        <a href="#" class="pay-option">
                            <asp:Image ID="Image5" runat="server" ImageUrl="~/Content/images/c3/cheque.png" />
                            CHEQUE
                        </a>
                        <a href="#" class="pay-option">
                            <asp:Image ID="Image6" runat="server" ImageUrl="~/Content/images/c3/credit-card.png" />
                            CREDIT CARD
                        </a>
                        <div class="text-help">
                            Please select either payment method.
                        </div>
                    </div>
                </div>
                <div data-id="4" class="slide-item">
                    <div class="scroll-bar pay-info">
                        <h2>Personal Info</h2>
                        <table>
                            <tbody>
                                <tr>
                                    <td class="field-header">Name</td>
                                    <td>
                                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="field-header">Description</td>
                                    <td>
                                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="field-header">Description</td>
                                    <td>
                                        <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="field-header">Description</td>
                                    <td>
                                        <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="field-header">Description</td>
                                    <td>
                                        <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="field-header">Description</td>
                                    <td>
                                        <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox></td>
                                </tr>
                            </tbody>
                        </table>

                        <h2>Billing Info</h2>
                        <table>
                            <tbody>
                                <tr>
                                    <td class="field-header">Name</td>
                                    <td>
                                        <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="field-header">Description</td>
                                    <td>
                                        <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="field-header">Description</td>
                                    <td>
                                        <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="field-header">Description</td>
                                    <td>
                                        <asp:TextBox ID="TextBox10" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="field-header">Description</td>
                                    <td>
                                        <asp:TextBox ID="TextBox11" runat="server"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="field-header">Description</td>
                                    <td>
                                        <asp:TextBox ID="TextBox12" runat="server"></asp:TextBox></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="scroll-bar-hide">
                    </div>
                </div>
                <div data-id="5" class="slide-item last">
                    <div class="vertical-center confirm">
                        <div class="full">
                            <a href="#" class="medium-btn">TRIAL</a>
                            <h1>CLOUD + CRM = </h1>
                            <asp:Image ID="Image3" CssClass="logo" runat="server" ImageUrl="~/Content/themes/images/c3/logo-medium.png" />
                        </div>
                        <a href="#" class="big-btn left active">CONFIRM</a>
                        <p>js no-flexbox flexbox-legacy canvas canvastext no-webgl no-touch geolocation postmessage no-websqldatabase indexeddb hashchange history</p>
                    </div>
                </div>
            </div>

            <a href="#" class="slide-control-btn left"></a>
            <a href="#" class="slide-control-btn right"></a>
            </a>
        </div>

        <script type='text/javascript'>
            $(window).load(function () {
                $(".slide-control-btn.right").click(function (e) {
                    e.preventDefault();
                    var self = $(this);
                    var element = '.slide-item';
                    var selector = $(element + '.active');
                    var nextSelector = selector.next('div' + element);
                    if (!selector.hasClass('last')) {
                        if (!self.is('animating')) {
                            self.addClass('animating');
                            if (nextSelector.attr('data-id') == '5') {
                                $('.slide-control-btn.right').hide();
                            }
                            if (nextSelector.attr('data-id') != '1') {
                                $('.slide-control-btn.left').show();
                            }
                            selector.animate({
                                left: '-110%'
                            }, function () {
                                $(this).removeClass('active');
                                self.removeClass('animating');
                            });
                            nextSelector.animate({
                                left: '0'
                            }, function () {
                                $(this).addClass('active');                                
                            });
                            var timeline = $(".module-select-timeline .bullet-link.active");
                            var dataIdTimeline = parseInt(selector.attr('data-id'));
                            var dataIdBullet = parseInt(selector.attr('data-id')) + 1;
                            var bullet = $(".module-select-timeline div.bullet[data-id='" + dataIdBullet + "']");
                            timeline.animate({
                                width: 21.25 * dataIdTimeline + '%'
                            }, function () {
                                bullet.animate({
                                    borderColor: '#D71E2F',
                                    backgroundColor: '#D71E2F'
                                });
                                bullet.addClass('active');
                            });
                        }
                    }
                })

                $(".slide-control-btn.left").click(function (e) {
                    e.preventDefault();
                    var self = $(this);
                    var element = '.slide-item';
                    var selector = $(element + '.active');
                    var prevSelector = selector.prev('div' + element);
                    if (!selector.hasClass('first')) {
                        if (!self.is('animating')) {
                            self.addClass('animating');
                            if (prevSelector.attr('data-id') == '1') {
                                $('.slide-control-btn.left').hide();
                            }
                            if (prevSelector.attr('data-id') != '5') {
                                $('.slide-control-btn.right').show();
                            }
                            selector.animate({
                                left: '110%'
                            }, function () {
                                $(this).removeClass('active');
                            });
                            prevSelector.animate({
                                left: '0'
                            }, function () {
                                $(this).addClass('active');                               
                            });
                            var timeline = $(".module-select-timeline .bullet-link.active");
                            var dataId = parseInt(selector.attr('data-id'));
                            var bullet = $(".module-select-timeline div.bullet[data-id='" + dataId + "']");
                            timeline.animate({
                                width: 21.25 * (dataId - 2) + '%'
                            }, function () {
                                bullet.animate({
                                    borderColor: '#000000',
                                    backgroundColor: '#C4C5C6'
                                });
                                bullet.removeClass('active');
                            });
                        }
                    }
                })
            });
        </script>
</asp:Content>
