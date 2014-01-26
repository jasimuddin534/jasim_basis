<%@ Page Title="Cases Page" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Cases.aspx.cs" Inherits="C3App.Cases.Cases" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="BodyContent">

    <asp:Panel ID="DetailsPanel" runat="server" SkinID="DetailsTab" tab-id="1">

        <asp:LinkButton ID="CaseDetailsLinkButton" runat="server" SkinID="TabTitle" CausesValidation="false" Text="Create Case" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Case');" OnClick="CaseDetailsLinkButton_Click" />

        <asp:Panel ID="DetailsContentPanel" runat="server" SkinID="TabContent">
            <asp:UpdatePanel ID="CasesDetailsUpdatePanel" runat="server">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="CaseDetailsLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>

                    <asp:ValidationSummary ID="CaseValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="sum" ShowValidationErrors="true" />

                    <asp:ObjectDataSource ID="CaseDetailsObjectDataSource" runat="server"
                        TypeName="C3App.BLL.CaseBL"
                        DataObjectTypeName="C3App.DAL.Case"
                        InsertMethod="InsertCase"
                        SelectMethod="GetCaseByID"
                        UpdateMethod="UpdateCase"
                        DeleteMethod="DeleteCaseByID"
                        OnInserted="CaseDetailsObjectDataSource_Inserted"
                        OnUpdated="CaseDetailsObjectDataSource_Updated">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditCaseID" Name="caseID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>

                    <asp:DetailsView ID="CaseDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="fields-label"
                        AutoGenerateRows="False"
                        DataSourceID="CaseDetailsObjectDataSource"
                        DataKeyNames="CaseID,CompanyID,CaseNumber,IsDeleted,Subject,AccountID,Timestamp,CreatedBy,CreatedTime,ModifiedBy,ModifiedTime"
                        OnItemInserting="CaseDetailsView_ItemInserting"
                        OnItemUpdating="CaseDetailsView_ItemUpdating"
                        OnItemCommand="CaseDetailsView_ItemCommand"
                        DefaultMode="Insert">
                        <Fields>
                            <asp:TemplateField HeaderText="Case Number" SortExpression="CaseNumber">
                                <InsertItemTemplate>
                                    <asp:TextBox ID="CaseNumberTextBox" runat="server" CssClass="required-field" Text="Case Number Auto Generate" ReadOnly="true"></asp:TextBox>
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="CaseNumberTextBox" runat="server" CssClass="required-field" Text='<%# Bind("CaseNumber") %>' ReadOnly="true" MaxLength="50"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Subject" SortExpression="Subject">
                                <EditItemTemplate>
                                    <asp:TextBox ID="SubjectTextBox" runat="server" CssClass="required-field mask-name" Text='<%# Bind("Subject") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="SubjectRequiredValidator" runat="server" ControlToValidate="SubjectTextBox" Display="None" ErrorMessage="Subject is Required" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator ID="SubjectRegularExpression" runat="server" ControlToValidate="SubjectTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Subject Field" Text="" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Account" SortExpression="AccountName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="AccountNameTextBox" runat="server" ReadOnly="true" SkinID="TextBoxWithButton" CssClass="mask-name" Text='<%# Eval("Account.Name") %>'></asp:TextBox>
                                    <asp:Button ID="ModalPopButton2" runat="server" CommandArgument="Accounts" OnClick="ModalPopButton_Click" OnClientClick="OpenModal('BodyContent_AccountsContentModalPanel')" SkinID="ButtonWithTextBox" Text="Select" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CaseStatusObjectDataSource" runat="server" TypeName="C3App.BLL.CaseBL" SelectMethod="GetCaseStatuses" DataObjectTypeName="C3App.DAL.CaseStatuse"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="StatusDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="CaseStatusObjectDataSource" DataTextField="Value" DataValueField="CaseStatusID" OnInit="StatusDropDownList_Init" SelectedValue='<%# Eval("StatusID")==null ? "0" : Eval("StatusID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Priority">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="CasePrioritieObjectDataSource" runat="server" TypeName="C3App.BLL.CaseBL" SelectMethod="GetCasePriorities" DataObjectTypeName="C3App.DAL.CasePrioritie"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="PriorityDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="CasePrioritieObjectDataSource" DataTextField="Value" DataValueField="CasePriorityID" OnInit="PriorityDropDownList_Init" SelectedValue='<%# Eval("Priority")==null ? "0" : Eval("Priority") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Type" SortExpression="Type">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TypeTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("Type") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="TypeLength" runat="server" ControlToValidate="TypeTextBox" Display="None" ValidationExpression="^[A-z\s.-]{1,100}$" Text=""
                                        ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Type Field" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignedToObjectDataSource" runat="server" TypeName="C3App.BLL.UserBL" SelectMethod="GetUsers" DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssaigendToDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="AssignedToObjectDataSource"
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssaigendToDropDownList_Init" OnSelectedIndexChanged="AssaigendToDropDownList_SelectedIndexChanged" AutoPostBack="True"
                                        SelectedValue='<%# Eval("AssignedUserID")==null ? "0" : Eval("AssignedUserID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:Label ID="NotifyLabel" runat="server" Text="Notify user" Visible="False"></asp:Label>
                                    <asp:CheckBox ID="NotifyCheckBox" runat="server" Text="" Visible="False" OnCheckedChanged="NotifyCheckBox_CheckedChanged" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TameNameObjectDataSource" runat="server" TypeName="C3App.BLL.TeamBL" SelectMethod="GetTeams" DataObjectTypeName="C3App.DAL.Team"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TeamNameDropDownList" runat="server" DataSourceID="TameNameObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("TeamID")==null ? "0" : Eval("TeamID") %>'
                                        DataTextField="Name" DataValueField="TeamID" OnInit="TeamNameDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DescriptionText" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Resolution" SortExpression="Resolution">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ResolutionText" runat="server" Text='<%# Bind("Resolution") %>' TextMode="MultiLine"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField ShowHeader="False">
                                <InsertItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>&nbsp;
                                    <asp:LinkButton ID="InsertLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Insert" Text="Save" ValidationGroup="sum"></asp:LinkButton>
                                </InsertItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>&nbsp;
                                    <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" CausesValidation="True" CommandName="Update" Text="Save" ValidationGroup="sum"></asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        </Fields>
                    </asp:DetailsView>

                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="CasesDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="CasesDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>



        <asp:Panel ID="AccountsContentModalPanel" runat="server" SkinID="ModalPopLeft">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

            <asp:UpdatePanel ID="ModalListUpdatePanel" runat="server" UpdateMode="Always">
                <Triggers>
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="ModalTitleLabel" runat="server" SkinID="ModalTitle" Text="Select Account"></asp:Label>
                    <asp:LinkButton ID="CreateAccountLinkButton" runat="server" CssClass="modal-create-btn" Text="Create" OnClientClick="OpenCreateModal('BodyContent_CreateModalPanel')" />

                    <asp:Panel ID="ModalSearchPanel" SkinID="ModalSearchPanel" runat="server">
                        <asp:Panel ID="AccountSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="ModalSearchPanel2" runat="server" CssClass="search">
                                <asp:Label ID="AccountSearchLabel" runat="server" Text="Search"></asp:Label>
                                <asp:TextBox ID="AccountSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="AccountSearchTextBox_TextChanged"></asp:TextBox>
                                <asp:LinkButton ID="AccountSearchLinkButton" runat="server" CssClass="search-btn modal-search" OnClick="AccountSearchTextBox_TextChanged"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="ModalListPanel" runat="server" SkinID="ModalListPanel">
                        <asp:ObjectDataSource ID="AccountObjectDataSource" runat="server" SelectMethod="SearchAccount" TypeName="C3App.BLL.AccountBL">

                            <SelectParameters>
                                <asp:ControlParameter ControlID="AccountSearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:UpdatePanel ID="AccountList" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <asp:GridView ID="AccountGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False" DataSourceID="AccountObjectDataSource" Visible="False"
                                    ShowHeader="False">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="AccountImage" runat="server" ImageUrl="~/Content/images/c3/account.jpg" />
                                                <asp:LinkButton ID="SelectAccountLinkButton" runat="server" CommandArgument='<%# Eval("AccountID") %>' CommandName="Select" OnCommand="SelectAccountLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="PrimaryEmailLabel" runat="server" Text='<%# Eval("PrimaryEmail") %>' />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>

        <asp:UpdatePanel ID="ModalCreateUpdatePanel" runat="server" UpdateMode="Conditional">
            <Triggers>
            </Triggers>
            <ContentTemplate>
                <asp:Panel ID="CreateModalPanel" runat="server" SkinID="ModalCreatePanelLeft">
                    <asp:HyperLink ID="HyperLink11" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
                    <asp:Label ID="CreateAccountLabel" runat="server" SkinID="ModalTitle" Text="Create Account"></asp:Label>

                    <asp:Panel ID="ModalCreateContentPanel" runat="server" CssClass="modal-create-content">

                        <asp:ObjectDataSource ID="AccountsDetailsObjectDataSource" runat="server"
                            TypeName="C3App.BLL.AccountBL" DataObjectTypeName="C3App.DAL.Account"
                            InsertMethod="InsertAccount" SelectMethod="GetAccounts" OnInserted="AccountsDetailsObjectDataSource_Inserted"></asp:ObjectDataSource>

                        <asp:ValidationSummary ID="ValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="avs" />
                        <br />
                        <asp:DetailsView ID="AccountDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="field-label"
                            DataSourceID="AccountsDetailsObjectDataSource"
                            DataKeyNames="AccountID,CompanyID,Name,CreatedTime,ModifiedTime"
                            AutoGenerateRows="False"
                            OnItemInserting="AccountDetailsView_ItemInserting"
                            OnItemInserted="AccountDetailsView_ItemInserted"
                            DefaultMode="Insert">
                            <Fields>
                                <asp:TemplateField HeaderText="Account Name" SortExpression="Name">
                                    <InsertItemTemplate>
                                        <asp:TextBox ID="AccountNameTextBox" runat="server" CssClass="required-field mask-name" Text='<%# Bind("Name") %>' MaxLength="150"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="AccountNameRequiredValidator" runat="server" ControlToValidate="AccountNameTextBox" Display="none" ErrorMessage="Name is Required" Text="*" ValidationGroup="avs" />
                                        <asp:RegularExpressionValidator ID="AccountNameRegularExpression" runat="server" ControlToValidate="AccountNameTextBox" Display="None"
                                            ValidationExpression="^[A-z\s.-]{1,150}$" Text="" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Account Name Field !" ValidationGroup="sum" />
                                    </InsertItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Primary Email" SortExpression="PrimaryEmail">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="AccountPrimaryEmailTextBox" runat="server" CssClass="mask-email" Text='<%# Bind("PrimaryEmail") %>' MaxLength="100"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="AccountPrimaryEmailRegularExpression" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*.{1,100}"
                                            ControlToValidate="AccountPrimaryEmailTextBox" ErrorMessage="Primary email address invelid, accept only email format value" Display="None" ValidationGroup="avs"></asp:RegularExpressionValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Office Phone" SortExpression="OfficePhone">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="AccountOfficePhoneTextBox" runat="server" CssClass="mask-phone" Text='<%# Bind("OfficePhone") %>' MaxLength="25"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="AccountOfficePhoneRegularExpression" runat="server" ControlToValidate="AccountOfficePhoneTextBox" Display="None"
                                            ValidationExpression="^(\+?(88)?)((02)|(0?1))((\d{9})|(\d{7}))$" Text="" ErrorMessage="Office phone should only accept phone format value" ValidationGroup="avs" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Website" SortExpression="Website">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="AccountWebsiteTextBox" runat="server" CssClass="mask-url" Text='<%# Bind("Website") %>' MaxLength="255"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="AccountWebsiteRegularExpression" runat="server" ControlToValidate="AccountWebsiteTextBox" Display="None"
                                            ValidationExpression="^(ht|f)tp(s?)\:\/\/[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*(\/?)([a-zA-Z0-9\-\.\?\,\'\/\\\+&amp;%\$#_]*)?$"
                                            Text="" ErrorMessage="Website should only accept URL format value" ValidationGroup="avs" />
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField ShowHeader="False">
                                    <InsertItemTemplate>
                                        <asp:LinkButton ID="InsertLinkButton2" runat="server" CssClass="form-btn" CausesValidation="true" CommandName="Insert" Text="Save" ValidationGroup="avs"></asp:LinkButton>&nbsp;
                                    </InsertItemTemplate>
                                </asp:TemplateField>
                            </Fields>

                        </asp:DetailsView>
                    </asp:Panel>
                </asp:Panel>

            </ContentTemplate>

        </asp:UpdatePanel>

    </asp:Panel>




    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">
        <asp:LinkButton ID="ViewCaseLinkButton" runat="server" SkinID="TabTitle" OnClick="ViewCaseLinkButton_Click" Text="View Cases" OnClientClick="GoToTab(2,'Create Case');" />


        <asp:Panel ID="CaseViewContentPanel" runat="server" SkinID="TabContent">

            <asp:ObjectDataSource ID="SearchObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Case"
                TypeName="C3App.BLL.CaseBL" SelectMethod="GetCaseBySubject">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" Name="SubjectSearch" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:ObjectDataSource>

            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">

                <asp:Panel ID="SearchFilterPanel" runat="server" CssClass="filter">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton ID="SearchAllLinkButton" runat="server" CssClass="search-label active" OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                    <asp:LinkButton ID="SearchNewLinkButton" runat="server" CssClass="search-label active" OnClick="SearchNewLinkButton_Click">New</asp:LinkButton>
                    <asp:LinkButton ID="SearchAssginedLinkButton" runat="server" CssClass="search-label active" OnClick="SearchAssginedLinkButton_Click">Assgined</asp:LinkButton>
                </asp:Panel>

                <asp:Panel ID="TextSearchPanel" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                    <asp:LinkButton ID="SearchButton" runat="server" CssClass="search-btn" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>

            </asp:Panel>

            <asp:Panel ID="ListPanel" runat="server" SkinID="ListPanel">

                <asp:UpdatePanel ID="CaseListUpdatePanel" runat="server" UpdateMode="Conditional">

                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewCaseLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchNewLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAssginedLinkButton" EventName="Click" />
                    </Triggers>

                    <ContentTemplate>

                        <asp:ObjectDataSource ID="SearchAllCasesObjectDataSource" runat="server" SelectMethod="GetCases" DataObjectTypeName="C3App.DAL.Case" TypeName="C3App.BLL.CaseBL"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="SearchNewCasesObjectDataSource" runat="server" SelectMethod="GetNewCases" DataObjectTypeName="C3App.DAL.Case" TypeName="C3App.BLL.CaseBL"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="SearchAssginedCasesObjectDataSource" runat="server" SelectMethod="GetAssginedCases" DataObjectTypeName="C3App.DAL.Case" TypeName="C3App.BLL.CaseBL"></asp:ObjectDataSource>



                        <asp:GridView ID="CaseListGridView" runat="server" CssClass="list-form"
                            AutoGenerateColumns="False"
                            DataKeyNames="CaseID"
                            DataSourceID="SearchAllCasesObjectDataSource"
                            GridLines="None"
                            ShowHeader="false">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="CaseImage" runat="server" ImageUrl="~/Content/images/c3/case.jpg" />
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("CaseID")+ ";" + Eval("AssignedUserID") + ";"+Eval("Subject") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                            <%--<asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("CaseID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">--%>
                                            <%# Eval("Subject") %>&nbsp;<br />
                                            <asp:Label ID="CaseNumberLabel" runat="server" Text='<%# Eval("CasePriority.Value") %>'></asp:Label>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdateProgress ID="CasesListUpdateProgress" runat="server" AssociatedUpdatePanelID="CaseListUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </asp:Panel>

            <asp:UpdatePanel ID="MiniDetailBasicUpdatePanel" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Panel ID="MiniDetailBasicPanel" runat="server" CssClass="mini-detail-panel">

                        <asp:ObjectDataSource ID="CaseMiniDetailObjectDataSource" runat="server"
                            TypeName="C3App.BLL.CaseBL"
                            SelectMethod="GetCaseByID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="CaseListGridView" Type="Int64" Name="caseID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:FormView ID="CaseMiniDetailFormView" runat="server" CssClass="mini-details-form"
                            DataSourceID="CaseMiniDetailObjectDataSource"
                            DataKeyNames="CaseID">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Image ID="CasesImage" runat="server" CssClass="img-profile" ImageUrl="~/Content/images/c3/case.jpg" />
                                <asp:Panel ID="CaseMiniDetailBasicPanel" runat="server">
                                    <asp:Label ID="SubjectLabel" runat="server" CssClass="fullname" Text='<%# Eval("Subject") %>'></asp:Label>
                                    <asp:Label ID="AccountNameLabel" runat="server" CssClass="royal-building" Text='<%# Eval("Account.Name") %>'></asp:Label>
                                    <asp:Label ID="CaseStutasLabel" runat="server" CssClass="hourglass" Text='<%# Eval("CaseStatus.Value") %>'></asp:Label>
                                    <asp:Label ID="TeamNameLabel" runat="server" CssClass="star" Text='<%# Eval("CasePriority.Value") %>'></asp:Label>
                                    <asp:Label ID="CaseStatusLabel" runat="server" CssClass="user" Text='<%# Eval("User.FirstName") %>'></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>


                        <asp:Panel ID="ButtonPanel" runat="server" CssClass="mini-detail-control-panel three-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="EditLinkButton" runat="server" Text="Edit" ToolTip="Edit" CssClass="control-btn" CommandArgument="CaseID" OnClientClick="GoToTab(1,'Case Details');" OnClick="EditLinkButton_Click">
                                            <i class="icon-edit"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:Panel ID="TaskNotifyPanel" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="NotifyLinkButton" CssClass="control-btn has-confirm " runat="server" Text="Convert" ToolTip="Notify to User">
                                       <i class="icon-share-alt"></i></asp:LinkButton>
                                        <asp:LinkButton ID="NotifyConfirmLinkButton" runat="server" OnClick="NotifyLinkButton_Click">Notify</asp:LinkButton>
                                        <asp:LinkButton ID="NotifyCancelLinkButton" runat="server" class="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>
                                <li>
                                    <asp:Panel ID="DeleteConfirmPanel" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CssClass="control-btn has-confirm" Text="Delete" CommandArgument="CaseID" ToolTip="Delete">
                                            <i class="icon-trash"></i>
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="ConfirmLinkButton" runat="server" OnClick="DeleteLinkButton_Click">Confirm</asp:LinkButton>
                                        <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>

                            </ul>
                        </asp:Panel>

                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <asp:Panel ID="CaseMiniDetailMore" runat="server">

                            <asp:DetailsView ID="CaseMiniMoreDetailsView" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label"
                                DataSourceID="CaseMiniDetailObjectDataSource" DataKeyNames="CaseID"
                                AutoGenerateRows="False">
                                <EmptyDataTemplate>
                                    <p>Data Not Found</p>
                                </EmptyDataTemplate>
                                <FieldHeaderStyle CssClass="field-label" />
                                <Fields>
                                    <asp:BoundField DataField="CaseNumber" HeaderText="Case Number" SortExpression="CaseNumber" />
                                    <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                        <ItemTemplate>
                                            <asp:Label ID="TeamNameLabel" runat="server" Text='<%# Bind("Team.Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Type" HeaderText="Type" SortExpression="Type" />
                                    <asp:BoundField DataField="Resolution" HeaderText="Resolution" SortExpression="Resolution" />
                                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                </Fields>
                            </asp:DetailsView>

                        </asp:Panel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="MiniDetailBasicUpdateProgress" runat="server" AssociatedUpdatePanelID="MiniDetailBasicUpdatePanel">
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


    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel2" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="MessageLiteral" runat="server" Text=""></asp:Literal></h4>
                <a class="close-reveal-modal">&#215;</a>
                <asp:Label ID="Label6" runat="server" Text=""></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>

