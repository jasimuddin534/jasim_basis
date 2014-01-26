<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="EmailTemplates.aspx.cs" Inherits="C3App.EmailTemplates.EmailTemplates" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    <%--<table style='max-width: 600px; width: 600px; height: auto; border-collapse: collapse; background-color: #fcfcfc; min-height: 200px; margin: 0; border: 1px solid #dddddd;'>
        <tr>
            <td style='width: 75%; vertical-align: top;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/top-left.png' alt='Panacea Systems Ltd' style='display: block; height: 80px; width: 320px;' />
            </td>
            <td rowspan='2' style='width: 25%; vertical-align: top;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/logo.png' alt='Panacea Systems Limited' style='display: block; height: 150px; margin: 10px 20px 0 0; float: right;' />
            </td>
        </tr>
        <tr>
            <td style='vertical-align: bottom;'>
                <h1 style='font-family: sans-serif; font-weight: 300; padding: 12px 15px 5px 15px; background-color: #8D2577; color: #eeeeee; float: left; margin: 0 20px 0 0; font-size: 25px;'>REGISTRATION CONFIRMATION
                </h1>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='padding: 20px; text-align: justify; font-family: sans-serif; font-size: 14px; line-height: 18px; font-weight: 300;'>
                <p>Dear <strong style='font-weight: 600'>User</strong>,</p>
                <p>
                    Welcome to C3. An account has been created for you. Please click on the following link to activate your account
           
                </p>
                <span style='display: block; text-align: center;'>
                    <a href='http://dev.c3.com.bd/Activation.aspx?PrimaryEmail=<%=PrimaryEmail%>&ActivationID=<%=ActivationID%>' style='margin: 20px 0 10px; display: inline-block; text-align: center; padding: 15px 15px 12px; background-color: #942D7F; color: #ffffff; font-family: sans-serif; text-decoration: none; font-weight: 300; border-radius: 2px; font-size: 15px;'>CLICK HERE TO ACTIVATE</a>
                </span>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='padding: 20px; text-align: justify; font-family: sans-serif; font-size: 14px; line-height: 18px; font-weight: 300;'>
                <h3 style='padding-top: 10px; margin: 0 0 10px 0; border-top: 1px solid #DDDDDD;'><strong>User Credentials</strong></h3>
                <p>
                    Please use the following credentials to login

                </p>
                <p>
                    <strong>Username: <%=PrimaryEmail%>
               
                        <br />
                        Password: <%=Password%></strong>
                </p>
                <span style='display: block; text-align: center;'>
                    <a href='http://dev.c3.com.bd/UserLogin.aspx' style='margin: 20px 0 10px; display: inline-block; text-align: center; padding: 15px 15px 12px; background-color: #942D7F; color: #ffffff; font-family: sans-serif; text-decoration: none; font-weight: 300; border-radius: 2px; font-size: 15px;'>CLICK HERE TO LOGIN</a>
                </span>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='padding: 0 20px; font-family: sans-serif; font-weight: 300; font-size: 11px; line-height: 14px; color: #777777;'>
                <p style='border-top: 1px dashed #aaaaaa; border-bottom: 1px dashed #aaaaaa; margin: 0; padding: 10px 0;'>
                    Note: Privileged/Confidential information may be contained in this message and may be subject to legal privilege. Access to this e-mail by anyone other than the intended is unauthorised. If you are not the intended recipient (or responsible for delivery of the message to such person), you may not use, copy, distribute or deliver to anyone this message (or any part of its contents ) or take any action in reliance on it. In such case, you should destroy this message, and notify us immediately. If you have received this email in error, please notify us immediately by e-mail or telephone and delete the e-mail from any computer. If you or your employer does not consent to internet e-mail messages of this kind, please notify us immediately. All reasonable precautions have been taken to ensure no viruses are present in this e-mail. As our company cannot accept responsibility for any loss or damage arising from the use of this e-mail or attachments we recommend that you subject these to your virus checking procedures prior to use. The views, opinions, conclusions and other informations expressed in this electronic mail are not given or endorsed by the company unless otherwise indicated by an authorized representative independent of this message.
           
                </p>
            </td>
            <tr>
        <tr>
            <td colspan='2' style='width: 30%; padding: 0 20px; vertical-align: middle; padding-top: 10px;'>
                <a href='#' style='font-family: sans-serif; text-decoration: none; font-weight: 600; font-size: 13px; color: #906988;'>&copy; All Rights Reserved Panacea Systems Limited</a> | 
           
                <a href='#' style='font-family: sans-serif; text-decoration: none; font-weight: 600; font-size: 13px; color: #A17999;'>Privacy Policy</a>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='width: 50%; vertical-align: bottom; padding-top: 10px;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/bottom-right.png' alt='Panaca Systems Ltd' style='display: block; float: right; height: 70px; width: 380px;' />
            </td>
        </tr>
    </table>
    <table style='max-width: 600px; width: 600px; height: auto; border-collapse: collapse; background-color: #fcfcfc; min-height: 200px; margin: 0; border: 1px solid #dddddd;'>
        <tr>
            <td style='width: 75%; vertical-align: top;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/top-left.png' alt='Panacea Systems Ltd' style='display: block; height: 80px; width: 320px;' />
            </td>
            <td rowspan='2' style='width: 25%; vertical-align: top;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/logo.png' alt='Panacea Systems Limited' style='display: block; height: 150px; margin: 10px 20px 0 0; float: right;' />
            </td>
        </tr>
        <tr>
            <td style='vertical-align: bottom;'>
                <h1 style='font-family: sans-serif; font-weight: 300; padding: 12px 15px 5px 15px; background-color: #8D2577; color: #eeeeee; float: left; margin: 0 20px 0 0; font-size: 25px;'>PASSWORD RECOVERY
                </h1>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='padding: 20px; text-align: justify; font-family: sans-serif; font-size: 14px; line-height: 18px; font-weight: 300;'>
                <h3 style='padding-top: 10px; margin: 0 0 10px 0; border-top: 1px solid #DDDDDD;'><strong>User Credentials</strong></h3>
                <p>Dear <strong style='font-weight: 600'>User</strong>,</p>
                <p>
                    We have received a password reset notification. Please use the following credentials to login

                </p>
                <p>
                    <strong>Username: <%=PrimaryEmail%>
               
                        <br />
                        Password: <%=Password%></strong>
                </p>
                <span style='display: block; text-align: center;'>
                    <a href='http://dev.c3.com.bd/UserLogin.aspx' style='margin: 20px 0 10px; display: inline-block; text-align: center; padding: 15px 15px 12px; background-color: #942D7F; color: #ffffff; font-family: sans-serif; text-decoration: none; font-weight: 300; border-radius: 2px; font-size: 15px;'>CLICK HERE TO LOGIN</a>
                </span>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='padding: 0 20px; font-family: sans-serif; font-weight: 300; font-size: 11px; line-height: 14px; color: #777777;'>
                <p style='border-top: 1px dashed #aaaaaa; border-bottom: 1px dashed #aaaaaa; margin: 0; padding: 10px 0;'>
                    Note: Privileged/Confidential information may be contained in this message and may be subject to legal privilege. Access to this e-mail by anyone other than the intended is unauthorised. If you are not the intended recipient (or responsible for delivery of the message to such person), you may not use, copy, distribute or deliver to anyone this message (or any part of its contents ) or take any action in reliance on it. In such case, you should destroy this message, and notify us immediately. If you have received this email in error, please notify us immediately by e-mail or telephone and delete the e-mail from any computer. If you or your employer does not consent to internet e-mail messages of this kind, please notify us immediately. All reasonable precautions have been taken to ensure no viruses are present in this e-mail. As our company cannot accept responsibility for any loss or damage arising from the use of this e-mail or attachments we recommend that you subject these to your virus checking procedures prior to use. The views, opinions, conclusions and other informations expressed in this electronic mail are not given or endorsed by the company unless otherwise indicated by an authorized representative independent of this message.
           
                </p>
            </td>
            <tr>
        <tr>
            <td colspan='2' style='width: 30%; padding: 0 20px; vertical-align: middle; padding-top: 10px;'>
                <a href='#' style='font-family: sans-serif; text-decoration: none; font-weight: 600; font-size: 13px; color: #906988;'>&copy; All Rights Reserved Panacea Systems Limited</a> | 
           
                <a href='#' style='font-family: sans-serif; text-decoration: none; font-weight: 600; font-size: 13px; color: #A17999;'>Privacy Policy</a>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='width: 50%; vertical-align: bottom; padding-top: 10px;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/bottom-right.png' alt='Panaca Systems Ltd' style='display: block; float: right; height: 70px; width: 380px;' />
            </td>
        </tr>
    </table>
    <table style='max-width: 600px; width: 600px; height: auto; border-collapse: collapse; background-color: #fcfcfc; min-height: 200px; margin: 0; border: 1px solid #dddddd;'>
        <tr>
            <td style='width: 75%; vertical-align: top;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/top-left.png' alt='Panacea Systems Ltd' style='display: block; height: 80px; width: 320px;' />
            </td>
            <td rowspan='2' style='width: 25%; vertical-align: top;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/logo.png' alt='Panacea Systems Limited' style='display: block; height: 150px; margin: 10px 20px 0 0; float: right;' />
            </td>
        </tr>
        <tr>
            <td style='vertical-align: bottom;'>
                <h1 style='font-family: sans-serif; font-weight: 300; padding: 12px 15px 5px 15px; background-color: #8D2577; color: #eeeeee; float: left; margin: 0 20px 0 0; font-size: 25px;'>TASK ASSIGNMENT
                </h1>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='padding: 20px; text-align: justify; font-family: sans-serif; font-size: 14px; line-height: 18px; font-weight: 300;'>
                <p>Dear <strong style='font-weight: 600'>User</strong>,</p>
                <p>
                    You have been assigned to deal the following <%=ModuleName%>
           
                </p>
                <p>
                    <strong><%=Key%>: <%=Value%></strong>
                </p>
                
            </td>
        </tr>
        <tr>
            <td colspan='2' style='padding: 0 20px; font-family: sans-serif; font-weight: 300; font-size: 11px; line-height: 14px; color: #777777;'>
                <p style='border-top: 1px dashed #aaaaaa; border-bottom: 1px dashed #aaaaaa; margin: 0; padding: 10px 0;'>
                    Note: Privileged/Confidential information may be contained in this message and may be subject to legal privilege. Access to this e-mail by anyone other than the intended is unauthorised. If you are not the intended recipient (or responsible for delivery of the message to such person), you may not use, copy, distribute or deliver to anyone this message (or any part of its contents ) or take any action in reliance on it. In such case, you should destroy this message, and notify us immediately. If you have received this email in error, please notify us immediately by e-mail or telephone and delete the e-mail from any computer. If you or your employer does not consent to internet e-mail messages of this kind, please notify us immediately. All reasonable precautions have been taken to ensure no viruses are present in this e-mail. As our company cannot accept responsibility for any loss or damage arising from the use of this e-mail or attachments we recommend that you subject these to your virus checking procedures prior to use. The views, opinions, conclusions and other informations expressed in this electronic mail are not given or endorsed by the company unless otherwise indicated by an authorized representative independent of this message.
           
                </p>
            </td>
            <tr>
        <tr>
            <td colspan='2' style='width: 30%; padding: 0 20px; vertical-align: middle; padding-top: 10px;'>
                <a href='#' style='font-family: sans-serif; text-decoration: none; font-weight: 600; font-size: 13px; color: #906988;'>&copy; All Rights Reserved Panacea Systems Limited</a> | 
           
                <a href='#' style='font-family: sans-serif; text-decoration: none; font-weight: 600; font-size: 13px; color: #A17999;'>Privacy Policy</a>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='width: 50%; vertical-align: bottom; padding-top: 10px;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/bottom-right.png' alt='Panaca Systems Ltd' style='display: block; float: right; height: 70px; width: 380px;' />
            </td>
        </tr>
    </table>
    <table style='max-width: 600px; width: 600px; height: auto; border-collapse: collapse; background-color: #fcfcfc; min-height: 200px; margin: 0; border: 1px solid #dddddd;'>
        <tr>
            <td style='width: 75%; vertical-align: top;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/top-left.png' alt='Panacea Systems Ltd' style='display: block; height: 80px; width: 320px;' />
            </td>
            <td rowspan='2' style='width: 25%; vertical-align: top;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/logo.png' alt='Panacea Systems Limited' style='display: block; height: 150px; margin: 10px 20px 0 0; float: right;' />
            </td>
        </tr>
        <tr>
            <td style='vertical-align: bottom;'>
                <h1 style='font-family: sans-serif; font-weight: 300; padding: 12px 15px 5px 15px; background-color: #8D2577; color: #eeeeee; float: left; margin: 0 20px 0 0; font-size: 25px;'>MEETING INVITATION
                </h1>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='padding: 20px; text-align: justify; font-family: sans-serif; font-size: 14px; line-height: 18px; font-weight: 300;'>
                <h3 style='padding-top: 10px; margin: 0 0 10px 0; border-top: 1px solid #DDDDDD;'><strong>Notification</strong></h3>
                <p>Dear <strong style='font-weight: 600'>User</strong>,</p>
                <p>
                    This is to inform you that, you are being invited to join following meeting created by <%=CreatedBy%>

                </p>
                <p>
                    <strong>
                        Meeting Subject: <%=Subject%><br />
                        Meeting Time: From <%=StartDate%> To <%=EndDate%><br />
                        Meeting Location: <%=Location%><br />
                    </strong>
                </p>
                <span style='display: block; text-align: center;'>
                    <a href='http://dev.c3.com.bd/UserLogin.aspx' style='margin: 20px 0 10px; display: inline-block; text-align: center; padding: 15px 15px 12px; background-color: #942D7F; color: #ffffff; font-family: sans-serif; text-decoration: none; font-weight: 300; border-radius: 2px; font-size: 15px;'>CLICK HERE TO LOGIN</a>
                </span>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='padding: 0 20px; font-family: sans-serif; font-weight: 300; font-size: 11px; line-height: 14px; color: #777777;'>
                <p style='border-top: 1px dashed #aaaaaa; border-bottom: 1px dashed #aaaaaa; margin: 0; padding: 10px 0;'>
                    Note: Privileged/Confidential information may be contained in this message and may be subject to legal privilege. Access to this e-mail by anyone other than the intended is unauthorised. If you are not the intended recipient (or responsible for delivery of the message to such person), you may not use, copy, distribute or deliver to anyone this message (or any part of its contents ) or take any action in reliance on it. In such case, you should destroy this message, and notify us immediately. If you have received this email in error, please notify us immediately by e-mail or telephone and delete the e-mail from any computer. If you or your employer does not consent to internet e-mail messages of this kind, please notify us immediately. All reasonable precautions have been taken to ensure no viruses are present in this e-mail. As our company cannot accept responsibility for any loss or damage arising from the use of this e-mail or attachments we recommend that you subject these to your virus checking procedures prior to use. The views, opinions, conclusions and other informations expressed in this electronic mail are not given or endorsed by the company unless otherwise indicated by an authorized representative independent of this message.
           
                </p>
            </td>
            <tr>
        <tr>
            <td colspan='2' style='width: 30%; padding: 0 20px; vertical-align: middle; padding-top: 10px;'>
                <a href='#' style='font-family: sans-serif; text-decoration: none; font-weight: 600; font-size: 13px; color: #906988;'>&copy; All Rights Reserved Panacea Systems Limited</a> | 
           
                <a href='#' style='font-family: sans-serif; text-decoration: none; font-weight: 600; font-size: 13px; color: #A17999;'>Privacy Policy</a>
            </td>
        </tr>
        <tr>
            <td colspan='2' style='width: 50%; vertical-align: bottom; padding-top: 10px;'>
                <img src='http://dev.c3.com.bd/Content/themes/base/images/email_template/bottom-right.png' alt='Panaca Systems Ltd' style='display: block; float: right; height: 70px; width: 380px;' />
            </td>
        </tr>
    </table>    
        --%>


</asp:Content>
