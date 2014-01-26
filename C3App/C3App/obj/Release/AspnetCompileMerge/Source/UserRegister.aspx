<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/home/Public.Master" AutoEventWireup="true" CodeBehind="UserRegister.aspx.cs" Inherits="C3App.UserRegister" %>

<%@ Register TagPrefix="recaptcha" Namespace="Recaptcha" Assembly="Recaptcha" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script type="text/javascript">
        var RecaptchaOptions = {
            theme: 'blackglass'
        };

 </script>
</asp:Content>


<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">
    <div class="reg-content">
        <div class="reg-form-back"></div>
        <div class="reg-form-line"></div>
        <div class="reg-left-content">
            <a href="/UserLogin.aspx"><img class="logo" src="Content/themes/base/images/c3_logo_white.png" /></a>
            <h1 class="reg-title">REGISTER</h1>
        </div>
        <div class="reg-right-content">
            <a href="#" class="content-title active">AETHER</a>
            <a href="#" class="content-title">FACEBOOK</a>
            <a href="#" class="content-title">TWITTER</a>
            <h1 class="content-title fade">CLOUD</h1>
            <h1 class="content-title fade">CONTACT</h1>
            <h1 class="content-title fade">CENTER</h1>
        </div>

 <asp:ValidationSummary ID="UserRegistrationValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

        <div class="reg-form">
            <div class="form-tab left">
                <asp:TextBox ID="FirstNameTextBox" CssClass="mask-name" runat="server" placeholder="First Name"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="FirstNameTextBoxRequiredFieldValidator" ControlToValidate="FirstNameTextBox" Text="*" ErrorMessage="First Name is Required!" ValidationGroup="sum" />
               
                 <asp:TextBox ID="LastNameTextBox" runat="server" CssClass="mask-name" placeholder="Last Name"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="LastNameTextBoxRequiredFieldValidator" ControlToValidate="LastNameTextBox" Text="*" ErrorMessage="Last Name is Required!" ValidationGroup="sum" />

                <asp:TextBox ID="TitleTextBox" runat="server" CssClass="mask-name" placeholder="Designaiton"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="TitleTextBoxRequiredFieldValidator" ControlToValidate="TitleTextBox" Text="*" ErrorMessage="Designation Field is Required!" ValidationGroup="sum" />
 
                <asp:TextBox ID="CompanyTextBox" CssClass="mask-name" runat="server" placeholder="Company"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="CompanyTextBoxRequiredFieldValidator" ControlToValidate="CompanyTextBox" Text="*" ErrorMessage="Company Name is Required!" ValidationGroup="sum" />
              
                <%--<a href="#" class="form-next-btn" onclick="GoToSlide(1);"></a>--%>
                <asp:LinkButton ID="SubmitLinkButton" CssClass="form-next-btn" runat="server" Text="" OnClick="SubmitLinkButton_Click" />
            </div>

            <div class="form-tab middle">
                <a href="#" class="form-prev-btn" onclick="GoToSlide(0);"></a>
                <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="SubmitLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:TextBox ID="StreetTextBox" runat="server" CssClass="mask-street" placeholder="Street"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="StreetTextBoxRequiredFieldValidator" ControlToValidate="StreetTextBox" Text="*" ErrorMessage="Street Field is Required!" ValidationGroup="sum" />
                       
                        <asp:TextBox ID="CityTextBox" runat="server" CssClass="mask-name" placeholder="City"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="CityTextBoxRequiredFieldValidator" ControlToValidate="CityTextBox" Text="*" ErrorMessage="City Field is Required!" ValidationGroup="sum" />
          
                        <asp:TextBox ID="PostalCodeTextBox" runat="server" CssClass="mask-pint (zip)" placeholder="Postal Code"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="PostalCodeTextBoxRequiredFieldValidator" ControlToValidate="PostalCodeTextBox" Text="*" ErrorMessage="Postal Code is Required!" ValidationGroup="sum" />
                        
                        <asp:ObjectDataSource ID="CountryObjectDataSource" runat="server"
                            TypeName="C3App.BLL.UserBL"
                            DataObjectTypeName="C3App.DAL.Country"
                            SelectMethod="GetCountries"></asp:ObjectDataSource>
                        <asp:DropDownList ID="CountryDropDownList" runat="server"
                            DataSourceID="CountryObjectDataSource"
                            DataTextField="CountryName" DataValueField="CountryID" OnInit="CountryDropDownList_Init">
                        </asp:DropDownList>
                        
                        <asp:TextBox ID="MobilePhoneTextBox" CssClass="mask-phone" runat="server" placeholder="Mobile Phone"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="MobilePhoneTextBoxRequiredFieldValidator" ControlToValidate="MobilePhoneTextBox" Text="*" ErrorMessage="Mobile Phone is Required!" ValidationGroup="sum" />
                        
                        <asp:TextBox ID="PrimaryEmailTextBox" CssClass="mask-email" runat="server" placeholder="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="PrimaryEmailTextBoxRequiredFieldValidator" ControlToValidate="PrimaryEmailTextBox" Text="*" ErrorMessage="Email Field is Required!" ValidationGroup="sum" />
                    
                    </ContentTemplate>
                </asp:UpdatePanel>
              <asp:LinkButton ID="SubmitLinkButton2" CssClass="form-next-btn" runat="server" Text="" OnClick="SubmitLinkButton2_Click" />
              <%--  <a href="#" class="form-next-btn" onclick="GoToSlide(2);"></a>--%>
            </div>

            <div class="form-tab right">
                <a href="#" class="form-prev-btn" onclick="GoToSlide(1);"></a>
                <asp:UpdatePanel runat="server" ID="UpdatePanel2">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="SubmitLinkButton2" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                       <img src="Content/themes/base/images/recaptcha.gif" width="200" />
                      <%--<recaptcha:RecaptchaControl ID="recaptcha" runat="server" Theme="white"
                    PublicKey="6LfY_doSAAAAAMXtPIKceanQLGuty1zun_7Wma22" PrivateKey="6LfY_doSAAAAAGozxK0IU6GWs5TJgIRV720eRPha" />--%>
                        <asp:LinkButton runat="server" class="form-submit left" Text="Submit"  CommandName="Insert" CausesValidation="True" ID="submit" OnClick="submit_Click"></asp:LinkButton>
                        <asp:LinkButton runat="server" class="form-submit right" Text="Cancel" CommandName="Cancel" CausesValidation="False" ID="cancel" OnClick="cancel_Click"></asp:LinkButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>



        <div class="reg-nav">
            <ul>
                <li><a href="#" >NAME</a></li>
                <li><a href="#" >CONTACT</a></li>
                <li><a href="#" >FINISH</a></li>
            </ul>
        </div>
    </div>


     <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel3"  UpdateMode="Always">
            <ContentTemplate>
                <h2><asp:Literal ID="Literal1" runat="server" Text=""></asp:Literal></h2>
                 <asp:HyperLink ID="CloseHyperLink" class="close-reveal-modal" runat="server">&#215;</asp:HyperLink>
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    
               <asp:UpdateProgress ID="UserRegisterUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

</asp:Content>
