<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Payments.aspx.cs" Inherits="C3App.Payments.Payments" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <asp:Panel ID="DetailsPanel" runat="server" SkinID="DetailsTab" tab-id="1">
        <asp:LinkButton runat="server" ID="PaymentDetailLinkButton" SkinID="TabTitle" Text="Create Payment"
            OnClientClick="GoToTab(1,'Create Payment')" OnClick="PaymentDetailLinkButton_Click"></asp:LinkButton>
        <asp:Panel ID="DetailsContentPanel" runat="server" SkinID="TabContent">
            <asp:UpdatePanel ID="PaymentDetailUpdatePanel" runat="server">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="PaymentDetailLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>
                    <asp:ValidationSummary ID="PaymentDetailValidationSummary" runat="server" ValidationGroup="PaymentDetail" ShowSummary="true" DisplayMode="BulletList" />
                    <asp:ObjectDataSource ID="PaymentDetailsObjectDataSource" runat="server"
                        TypeName="C3App.BLL.PaymentBL" DataObjectTypeName="C3App.DAL.Payment"
                        InsertMethod="InsertOrUpdatePayment" SelectMethod="GetPaymentByID" UpdateMethod="InsertOrUpdatePayment"
                        OnInserted="PaymentDetailsObjectDataSource_Inserted" OnUpdated="PaymentDetailsObjectDataSource_Updated">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="PaymentID" Name="paymentID" Type="Int32"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:DetailsView ID="PaymentsDetailsView" runat="server"
                        DataSourceID="PaymentDetailsObjectDataSource" AutoGenerateRows="False"
                        FieldHeaderStyle-CssClass="fields-label" CssClass="details-form" DataKeyNames="PaymentID,CompanyID,CreatedTime,CreatedBy"
                        DefaultMode="Insert" OnItemInserting="PaymentsDetailsView_ItemInserting" OnItemUpdating="PaymentsDetailsView_ItemUpdating">
                        <EmptyDataTemplate>
                            No Payment Selected
                        </EmptyDataTemplate>
                        <Fields>
                            <asp:DynamicField DataField="Amount" HeaderText="Amount" ValidationGroup="PaymentDetail" />
                            <asp:DynamicField DataField="BankFee" HeaderText="Bank Fee" ValidationGroup="PaymentDetail" />
                            <asp:TemplateField HeaderText="Account">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AccountTextBox" runat="server" SkinID="TextBoxWithButton"
                                        Text='<%# Eval("AccountID") %>'></asp:TextBox>
                                    <%--They used asp:Button--%>
                                    <asp:LinkButton ID="AccountLinkButton" runat="server" SkinID="ButtonWithTextBox" Text="Select"
                                        OnClientClick="OpenModal('BodyContent_AccountsContentPanel')">
                                    </asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Account">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AccountsObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.AccountBL"
                                        DataObjectTypeName="C3App.DAL.Account"
                                        SelectMethod="GetAccounts"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AccountsDropDownList" runat="server"
                                        DataSourceID="AccountsObjectDataSource" SelectedValue='<%# Bind("AccountID")  %>'
                                        DataTextField="Name" DataValueField="AccountID" OnInit="AccountsDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Currency">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CurrenciesObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.Currency"
                                        SelectMethod="GetCurrencies"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CurrenciesDropDownList" runat="server"
                                        DataSourceID="CurrenciesObjectDataSource"
                                        DataTextField="Name" DataValueField="CurrencyID" OnInit="CurrenciesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="CustomerReference" HeaderText="Customer Reference" ValidationGroup="PaymentDetail" />
                            <asp:TemplateField HeaderText="Payment Date">
                                <EditItemTemplate>
                                    <asp:TextBox ID="PaymentDateTextBox" runat="server" Text='<%# Bind("PaymentDate","{0:d}") %>' CssClass="datepicker"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Payment Type">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="PaymentTypesObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.PaymentBL"
                                        DataObjectTypeName="C3App.DAL.PaymentType"
                                        SelectMethod="GetPaymentTypes"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="PaymentTypesDropDownList" runat="server"
                                        DataSourceID="PaymentTypesObjectDataSource"
                                        DataTextField="Value" DataValueField="PaymentTypeID" OnInit="PaymentTypesDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:DynamicField DataField="PaymentNumber" HeaderText="Payment Number" ValidationGroup="PaymentDetail" />
                            <asp:TemplateField HeaderText="Teams">
                                <%--<InsertItemTemplate>
                                    <asp:ObjectDataSource ID="TeamsInsertObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.TeamBL"
                                        DataObjectTypeName="C3App.DAL.Team"
                                        SelectMethod="GetTeamsByCompanyID"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsInsertDropDownList" runat="server"
                                        DataSourceID="TeamsInsertObjectDataSource"
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>--%>
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TeamsEditObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.TeamBL"
                                        DataObjectTypeName="C3App.DAL.Team"
                                        SelectMethod="GetTeamsByCompanyID">
                                        <%--<SelectParameters>
                                            <asp:SessionParameter SessionField="PaymentTeamID" Name="TeamID" Type="Int64"></asp:SessionParameter>
                                        </SelectParameters>--%>
                                    </asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamsEditDropDownList" runat="server"
                                        DataSourceID="TeamsEditObjectDataSource" AppendDataBoundItems="true"
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamsEditDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Assigned To">
                                <InsertItemTemplate>
                                    <asp:ObjectDataSource ID="UsersObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.UserBL"
                                        DataObjectTypeName="C3App.DAL.User"
                                        SelectMethod="GetUsersByCompanyID"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="UsersDropDownList" runat="server"
                                        DataSourceID="UsersObjectDataSource"
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="UsersDropDownList_Init">
                                    </asp:DropDownList>
                                </InsertItemTemplate>
                            </asp:TemplateField>--%>
                            <asp:TemplateField ShowHeader="False">
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="SaveLinkButton" runat="server" CssClass="form-btn" ValidationGroup="PaymentDetail" CausesValidation="True" CommandName="Insert" Text="Save"></asp:LinkButton>
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="SaveLinkButton" runat="server" CssClass="form-btn" ValidationGroup="PaymentDetail" CausesValidation="True" CommandName="Update" Text="Save"></asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                    </asp:DetailsView>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="PaymentDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="PaymentDetailUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </asp:Panel>

        <asp:Panel ID="AccountsContentPanel" runat="server" SkinID="ModalPopLeft">
            <asp:HyperLink ID="ModalCloseHyperLink" runat="server" SkinID="ModalCloseButton">
                <i class="icon-remove"></i>
            </asp:HyperLink>
            <%--Need to modify js--%>
            <asp:LinkButton ID="CreateAccountLinkButton" runat="server" CssClass="modal-create-btn" Text="Create"
                OnClientClick="OpenCreateModal('BodyContent_Panel291')"></asp:LinkButton>
            <asp:UpdatePanel ID="AccountsUpdatePanel" runat="server" UpdateMode="Always">
                <ContentTemplate>
                    <asp:Label ID="ModalTitleLabel" runat="server" SkinID="ModalTitle" Text="Search Account"></asp:Label>
                    <asp:Panel ID="AccountSearchPanel" runat="server" SkinID="ModalSearchPanel">
                        <asp:Label ID="SearchLabel" runat="server" Text="Search"></asp:Label>
                        <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                        <asp:LinkButton ID="SearchLinkButton" runat="server" CssClass="search-btn">
                            <i class="icon-search"></i>
                        </asp:LinkButton>
                    </asp:Panel>
                    <asp:Panel ID="AccountListPanel" runat="server" SkinID="ModalListPanel">
                        <asp:ObjectDataSource ID="AccountsObjectDataSource" runat="server"
                            TypeName="C3App.BLL.AccountBL" DataObjectTypeName="C3App.DAL.Account"
                            SelectMethod="GetAccountsByName">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="SearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:GridView ID="AccountsGridView" runat="server" CssClass="list-form" AutoGenerateColumns="false"
                            ShowHeader="false" GridLines="None" DataSourceID="AccountsObjectDataSource"
                            DataKeyNames="AccountID">
                            <EmptyDataTemplate>
                                <p>No Account Found</p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="AccountImage" runat="server" CssClass="img-profile"
                                            ImageUrl="~/Content/images/c3/account.jpg" />
                                        <asp:LinkButton ID="SelectAccountLinkButton" runat="server" CausesValidation="false"
                                            CommandName="Select" CommandArgument='<%# Eval("AccountID") %>'
                                            Text='<%# Eval("AccountID") %>' OnCommand="SelectAccountLinkButton_Command">
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:UpdateProgress ID="AccountsUpdateProgress" runat="server" AssociatedUpdatePanelID="AccountsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel1" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent1" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage1" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
        </asp:Panel>
    </asp:Panel>

    <asp:Panel ID="ViewPanel" runat="server" SkinID="ViewTab" tab-id="2">

        <asp:LinkButton ID="ViewPaymentsLinkButton" runat="server" SkinID="TabTitle" Text="View Payments"
            OnClick="ViewPaymentsLinkButton_Click" OnClientClick="GoToTab(2,'Create Payment')"></asp:LinkButton>
        <asp:Panel ID="ViewContentPanel" runat="server" SkinID="TabContent">

            <asp:Panel ID="SearchPanel" runat="server" SkinID="SearchPanel">
                <asp:Panel ID="SearchFilterPanel" runat="server" CssClass="filter">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton ID="SearchAllLinkButton" runat="server" CssClass="search-label active"
                        OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="SearchKeywordPanel" runat="server" CssClass="search">
                    <asp:Label ID="SearchKeywordLabel" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchKeywordTextBox" runat="server"></asp:TextBox>
                    <asp:ObjectDataSource ID="SearchKeywordObjectDataSource" runat="server"
                        TypeName="C3App.BLL.PaymentBL" SelectMethod="SearchPaymentsByName">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="SearchKeywordTextBox" PropertyName="Text" Name="nameSearchString" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:LinkButton ID="SearchKeywordLinkButton" runat="server" Text="Search" CssClass="search-btn"
                        OnClick="SearchKeywordLinkButton_Click"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="PaymentsPanel" runat="server" SkinID="ListPanel">

                <asp:UpdatePanel ID="PaymentsUpdatePanel" runat="server" UpdateMode="Conditional">

                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewPaymentsLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchKeywordLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                    </Triggers>

                    <ContentTemplate>
                        <asp:ObjectDataSource ID="PaymentsObjectDataSource" runat="server" TypeName="C3App.BLL.PaymentBL"
                            SelectMethod="GetPayments"></asp:ObjectDataSource>

                        <asp:GridView ID="PaymentsGridView" runat="server" CssClass="list-form" AutoGenerateColumns="false"
                            DataSourceID="PaymentsObjectDataSource" DataKeyNames="PaymentID" GridLines="None" ShowHeader="false">
                            <EmptyDataTemplate>
                                <p>No payments found</p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="PaymentImage" runat="server" CssClass="img-profile"
                                            ImageUrl="~/Content/images/c3/payment.png" />
                                        <%--Check below todo--%>
                                        <asp:LinkButton ID="SelectPaymentLinkButton" runat="server" CommandName="Select"
                                            CommandArgument='<%# Eval("PaymentID") + ";" + Eval("TeamID") %>' OnCommand="SelectPaymentLinkButton_Command">
                                            <asp:Literal ID="PaymentNumberLiteral" runat="server" Text='<%# Eval("PaymentNumber")%>'></asp:Literal>
                                            <asp:Label ID="AmountLabel" runat="server" Text='<%# Eval("Amount")%>'></asp:Label>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </ContentTemplate>

                </asp:UpdatePanel>

                <asp:UpdateProgress ID="PaymentsUpdateProgress" runat="server" AssociatedUpdatePanelID="PaymentsUpdatePanel" DynamicLayout="true" DisplayAfter="0">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </asp:Panel>
            <asp:Panel ID="MiniDetailsPanel" runat="server">
                <asp:UpdatePanel ID="MiniDetailsUpdatePanel" runat="server" UpdateMode="Conditional">
                    <Triggers>
                    </Triggers>
                    <ContentTemplate>
                        <asp:Panel ID="MiniDetailsBasicPanel" runat="server" CssClass="mini-detail-panel">
                            <asp:ObjectDataSource ID="PaymentMiniDetailsObjectDataSource" runat="server"
                                TypeName="C3App.BLL.PaymentBL" SelectMethod="GetPaymentByID">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="PaymentsGridView" PropertyName="SelectedValue" DefaultValue="-1" Name="paymentID" Type="Int32"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <asp:FormView ID="PaymentMiniBasicFormView" runat="server" CssClass="mini-details-form"
                                DataSourceID="PaymentMiniDetailsObjectDataSource" DataKeyNames="PaymentID">
                                <EmptyDataTemplate>
                                    <p>No Payment Selected</p>
                                </EmptyDataTemplate>
                                <ItemTemplate>
                                    <asp:Image ID="PaymentImage" runat="server" CssClass="img-profile"
                                        ImageUrl="~/Content/images/c3/payment.png" />
                                    <asp:Panel ID="MiniDetailFormPanel" runat="server">
                                        <asp:Label ID="AccountNameLabel" runat="server" CssClass="fullname" Text='<%#Eval("AccountID") %>'></asp:Label>
                                        <asp:Label ID="AmountLabel" runat="server" CssClass="department" Text='<%#Eval("Amount") %>'></asp:Label>
                                        <asp:Label ID="PaymentTypeLabel" runat="server" CssClass="phone" Text='<%#Eval("PaymentTypeID") %>'></asp:Label>
                                        <asp:Label ID="PaymentDateLabel" runat="server" CssClass="email" Text='<%#Eval("PaymentDate") %>'></asp:Label>
                                    </asp:Panel>
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:Panel ID="ActionPanel" runat="server" CssClass="mini-detail-control-panel three-controls">
                                <ul>
                                    <li>
                                        <asp:LinkButton ID="EditLinkButton" runat="server" CssClass="control-btn"
                                            OnClick="EditLinkButton_Click" OnClientClick="GoToTab(1,'Payment Details')" CausesValidation="false">
                                            <i class="icon-edit"></i>
                                        </asp:LinkButton>
                                    </li>
                                    <li>
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CssClass="control-btn has-confirm"
                                            CausesValidation="false">
                                            <i class="icon-trash"></i>
                                        </asp:LinkButton>
                                        <asp:Panel ID="SlideConfirmPanel" runat="server" CssClass="slide-confirm">
                                            <asp:LinkButton ID="DeleteConfirmedLinkButton" runat="server" Text="Confirm"
                                                OnClick="DeleteConfirmedLinkButton_Click"></asp:LinkButton>
                                            <asp:LinkButton ID="DeleteCanceledLinkButton" runat="server" CssClass="slide-cancel" Text="Cancel"></asp:LinkButton>
                                        </asp:Panel>
                                    </li>
                                    <li>
                                        <asp:LinkButton ID="NotifyLinkButton" runat="server" CssClass="control-btn"
                                            OnClick="NotifyLinkButton_Click" CausesValidation="false">
                                            <i class="icon-share-alt"></i>
                                        </asp:LinkButton>
                                    </li>
                                </ul>
                            </asp:Panel>
                        </asp:Panel>
                        <asp:Panel ID="MiniDetailsMorePanel" runat="server" CssClass="mini-detail-more-panel">
                            <asp:DetailsView ID="PaymentMiniMoreDetailsView" runat="server" CssClass="mini-details-more-form"
                                FieldHeaderStyle-CssClass="fields-label" AutoGenerateRows="false"
                                DataKeyNames="PaymentID">
                                <EmptyDataTemplate>
                                    <p>No Payment Selected</p>
                                </EmptyDataTemplate>
                                <Fields>
                                    <asp:BoundField DataField="AccountName" HeaderText="Account Name" />
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" />
                                </Fields>
                            </asp:DetailsView>
                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="MiniDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="MiniDetailsUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel3" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent3" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </asp:Panel>
        </asp:Panel>
    </asp:Panel>
    <%--Need to check this following issue with asp:Panel--%>
    <asp:Panel ID="myModal" runat="server" CssClass="reveal-modal small">
        <asp:UpdatePanel ID="MessageUpdatePanel" runat="server" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="MessageHeaderLiteral" runat="server" Text=""></asp:Literal></h4>
                <%--Modified close button to Linkbuton--%>
                <asp:LinkButton ID="MessageCloseLinkButton" runat="server" CssClass="close-reveal-modal" Text="">&#215;</asp:LinkButton>
                <%--<a class="close-reveal-modal">&#215;</a>--%>
                <asp:Label ID="MessageBodyLabel" runat="server" Text=""></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
</asp:Content>
