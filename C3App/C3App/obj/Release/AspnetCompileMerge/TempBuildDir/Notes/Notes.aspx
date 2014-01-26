<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Notes.aspx.cs" Inherits="C3App.Notes.Notes" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    <asp:Panel ID="DetailsPanel" runat="server" SkinID="DetailsTab" tab-id="1">

        <asp:LinkButton ID="NoteDetailLinkButton" runat="server" SkinID="TabTitle" Text="Create Note" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Note');" OnClick="NoteDetailLinkButton_Click" />

        <asp:Panel ID="DetailsContentPanel" runat="server" SkinID="TabContent">
            <asp:UpdatePanel ID="NoteDetailsUpdatePanel" runat="server">

                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="NoteDetailLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                    <asp:PostBackTrigger ControlID="DownloadLinkButton" />
                </Triggers>
                <ContentTemplate>

                    <asp:ValidationSummary ID="NoteDetailValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />


                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="FileFormat" runat="server" Text="File must be pdf, doc, docx, xlsx, xls, pptx, accdb or csv format" />
                            </td>
                        </tr>
                        <tr>
                            <td class="document-upload">
                                <ajaxToolkit:AjaxFileUpload ID="NoteFileUpload" runat="server" ToolTip="File must be jpg,jpeg,gif,bmp,pdf,png,txt,doc, docx,xlsx,xls,pptx or csv format"
                                    ThrobberID="myThrobber" OnUploadComplete="NoteFileUpload_UploadComplete"
                                    ContextKeys="fred"
                                    AllowedFileTypes="accdb,pdf,doc,docx,xlsx,xls,pptx,csv"
                                    MaximumNumberOfFiles="1" />
                                <asp:LinkButton ID="DownloadLinkButton" runat="server" CssClass="modal-pop-form-btn" Text="Download" OnClick="DownloadLinkButton_Click"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>

                    <asp:ObjectDataSource ID="NoteDetailsObjectDataSource" runat="server"
                        OldValuesParameterFormatString="original_{0}"
                        TypeName="C3App.BLL.NoteBL"
                        DataObjectTypeName="C3App.DAL.Note"
                        InsertMethod="InsertOrUpdateNote"
                        SelectMethod="GetNoteByID"
                        UpdateMethod="InsertOrUpdateNote"
                        OnInserted="NoteDetailsObjectDataSource_Inserted"
                        OnUpdated="NoteDetailsObjectDataSource_Updated">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditNoteID" Name="noteID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>

                    <asp:DetailsView ID="NoteDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="fields-label" AutoGenerateRows="False"
                        DataKeyNames="NoteID,Name,FilePath,CompanyID,IsDeleted,Timestamp,CreatedBy,CreatedTime,ModifiedBy,ModifiedTime"
                        DataSourceID="NoteDetailsObjectDataSource"
                        OnItemInserting="NoteDetailsView_ItemInserting"
                        OnItemUpdating="NoteDetailsView_ItemUpdating"
                        OnItemCommand="NoteDetailsView_ItemCommand"
                        OnDataBound="NoteDetailsView_DataBound"
                        DefaultMode="Insert">
                        <Fields>
                            <asp:TemplateField HeaderText="Note Name" SortExpression="Name">
                                <EditItemTemplate>
                                    <asp:TextBox ID="NameTextBox" runat="server" CssClass="required-field mask-name" Text='<%# Bind("Name") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="NameRequiredValidator" runat="server" ControlToValidate="NameTextBox" ErrorMessage="Name is Required" Text="*" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator ID="NameRegularExpression" runat="server" ControlToValidate="NameTextBox" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,100}$" Text="" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in Name" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="File Name" SortExpression="FileName">
                                <EditItemTemplate>
                                    <asp:TextBox ID="FileNameText" runat="server" Text='<%# Bind("FileName") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="FileNameRegularExpression" runat="server" ControlToValidate="FileNameText" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,50}$" Text="" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in File Name" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Parent Type">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ParentTypeDropDownList" runat="server" AppendDataBoundItems="true" OnInit="ParentTypeDropDownList_Init" SelectedValue='<%# Eval("ParentType")==null ? "None" : Eval("ParentType") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="None"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Accounts" Value="Accounts"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Teams" Value="Teams"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Users" Value="Users"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Contacts" Value="Contacts"></asp:ListItem>
                                        <asp:ListItem Enabled="true" Selected="False" Text="Opportunity" Value="Opportunity"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Parent Name" SortExpression="ParentID">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ParentNameTextBox" runat="server" CssClass="mask-name" SkinID="TextBoxWithButton" ReadOnly="true" Text='<%# Bind("ParentID") %>'></asp:TextBox>
                                    <asp:Button ID="ModalPopButton" runat="server" OnClick="ModalPopButton_Click" OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                </EditItemTemplate>
                            </asp:TemplateField>



                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedTo">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignedUserObjectDataSource" runat="server" TypeName="C3App.BLL.UserBL" SelectMethod="GetUsersByCompanyID" DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssaigendUserDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="AssignedUserObjectDataSource"
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssaigendUserDropDownList_Init"
                                        SelectedValue='<%# Eval("AssignedUserID")==null ? "0" : Eval("AssignedUserID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Description" SortExpression="Description">
                                <EditItemTemplate>
                                    <asp:TextBox ID="DescriptionTextBox" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine"></asp:TextBox>
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

            <asp:UpdateProgress ID="NoteDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="NoteDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h3>Loading...</h3>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>


        <asp:Panel ID="ModalPanel1" runat="server" SkinID="ModalPopLeft">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>

            <asp:UpdatePanel ID="ModalUpdatePanel" runat="server" UpdateMode="Always">
                <Triggers>
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="ModalTitleLabel" runat="server" SkinID="ModalTitle"></asp:Label>

                    <asp:Panel ID="ModalSearchPanel" runat="server" SkinID="ModalSearchPanel">

                        <asp:Panel ID="AccountSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="AccountSearchPane2" runat="server" CssClass="search">
                                <asp:Label ID="AccountSearchLabel" runat="server" Text="Search" />
                                <asp:TextBox ID="AccountSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="AccountSearch_Event"></asp:TextBox>
                                <asp:LinkButton ID="AccountSearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="AccountSearch_Event"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="TeamSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="TeamSearchPanel2" runat="server" CssClass="search">
                                <asp:Label ID="TeamSearchLabel" runat="server" Text="Search" />
                                <asp:TextBox ID="TeamSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="TeamSearch_Event"></asp:TextBox>
                                <asp:LinkButton ID="TeamSearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="TeamSearch_Event"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="UserSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="UserSearchPanel2" runat="server" CssClass="search">
                                <asp:Label ID="UserSearchLabel" runat="server" Text="Search" />
                                <asp:TextBox ID="UserSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="UserSearch_Event"></asp:TextBox>
                                <asp:LinkButton ID="UserSearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="UserSearch_Event"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="ContactSearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="ContactSearchPanel2" runat="server" CssClass="search">
                                <asp:Label ID="ContactSearchLabel" runat="server" Text="Search" />
                                <asp:TextBox ID="ContactSearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="ContactSearch_Event"></asp:TextBox>
                                <asp:LinkButton ID="ContactSearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="ContactSearch_Event"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                        <asp:Panel ID="OpportunitySearchPanel" runat="server" Visible="False">
                            <asp:Panel ID="OpportunitySearchPanel2" runat="server" CssClass="search">
                                <asp:Label ID="OpportunitySearchLabel" runat="server" Text="Search" />
                                <asp:TextBox ID="OpportunitySearchTextBox" runat="server" AutoPostBack="True" OnTextChanged="OpportunitySearch_Event"></asp:TextBox>
                                <asp:LinkButton ID="OpportunitySearchLinkButton" runat="server" CssClass="search-btn modal-search" Text="Search" OnClick="OpportunitySearch_Event"><i class="icon-search"></i></asp:LinkButton>
                            </asp:Panel>
                        </asp:Panel>

                    </asp:Panel>

                    <asp:Panel ID="ModalListPanel" runat="server" SkinID="ModalListPanel">

                        <asp:UpdatePanel ID="AccountListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <asp:ObjectDataSource ID="AccountObjectDataSource" runat="server" SelectMethod="SearchAccount" TypeName="C3App.BLL.AccountBL">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="AccountSearchTextBox" PropertyName="Text" Name="search" Type="String"></asp:ControlParameter>
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:GridView ID="AccountGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False" DataSourceID="AccountObjectDataSource" Visible="False" ShowHeader="False">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/user.jpg" />
                                                <asp:LinkButton ID="AccountListLinkButton" runat="server" CommandArgument='<%# Eval("AccountID") %>' CommandName="Select" OnCommand="AccountListLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="AccountEmail1Label" runat="server" Text='<%# Eval("PrimaryEmail") %>' />
                                                </asp:LinkButton></ItemTemplate></asp:TemplateField></Columns></asp:GridView></ContentTemplate></asp:UpdatePanel><asp:UpdatePanel ID="TeamListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <asp:ObjectDataSource ID="TeamsObjectDataSource" runat="server" SelectMethod="GetTeamsByName" TypeName="C3App.BLL.TeamBL" DataObjectTypeName="C3App.DAL.Team">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="TeamSearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:GridView ID="TeamsGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False" Visible="false"
                                    DataKeyNames="Name,TeamID"
                                    DataSourceID="TeamsObjectDataSource" GridLines="None">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p></EmptyDataTemplate><Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" CssClass="img-profile" ImageUrl="~/Users/Images/Chrysanthemum.jpg" />
                                                <asp:LinkButton ID="TeamListLinkButton" runat="server" CommandArgument='<%# Eval("TeamID") %>' CommandName="Select" OnCommand="TeamListLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="DescriptionLabel" runat="server" Text='<%# Eval("Description") %>' />
                                                </asp:LinkButton></ItemTemplate></asp:TemplateField></Columns></asp:GridView></ContentTemplate></asp:UpdatePanel><asp:UpdatePanel ID="UserListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <asp:ObjectDataSource ID="UserObjectDataSource" runat="server" SelectMethod="GetUsersByFirstName" TypeName="C3App.BLL.UserBL" DataObjectTypeName="C3App.DAL.User">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="UserSearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:GridView ID="UserGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                                    DataKeyNames="FirstName,UserID" ShowHeader="false"
                                    DataSourceID="UserObjectDataSource" GridLines="None">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p></EmptyDataTemplate><Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" CssClass="img-profile" ImageUrl="~/Content/images/c3/user.jpg" />
                                                <asp:LinkButton ID="UserListLinkButton" runat="server" CommandArgument='<%# Eval("UserID") %>' CommandName="Select" OnCommand="UserListLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("FirstName")%>
                                                    <asp:Label ID="PrimaryEmailLabel" runat="server" Text='<%# Eval("PrimaryEmail") %>' />
                                                </asp:LinkButton></ItemTemplate></asp:TemplateField></Columns></asp:GridView></ContentTemplate></asp:UpdatePanel><asp:UpdatePanel ID="ContactListUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <asp:ObjectDataSource ID="ContactListObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Contact" TypeName="C3App.BLL.ContactBL" SelectMethod="GetContactByName">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ContactSearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:GridView ID="ContactListGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                                    DataKeyNames="FirstName,ContactID" ShowHeader="false"
                                    DataSourceID="ContactListObjectDataSource" GridLines="None">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p></EmptyDataTemplate><Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/contact.jpg" />
                                                <asp:LinkButton ID="ContactListLinkButton" runat="server" CommandArgument='<%# Eval("ContactID") %>' CommandName="Select" OnCommand="ContactListLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("FirstName")%>
                                                    <asp:Label ID="EmailAddressLabel" runat="server" Text='<%# Eval("PrimaryEmail") %>' />
                                                </asp:LinkButton></ItemTemplate></asp:TemplateField></Columns></asp:GridView></ContentTemplate></asp:UpdatePanel><asp:UpdatePanel ID="OpportunityUpdatePanel" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>

                                <asp:ObjectDataSource ID="OpportunityListObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity" SelectMethod="SearchOpportunities" TypeName="C3App.BLL.OpportunityBL">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="OpportunitySearchTextBox" Name="search" PropertyName="Text" Type="String" />
                                    </SelectParameters>
                                </asp:ObjectDataSource>

                                <asp:GridView ID="OpportunityListGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                                    DataKeyNames="Name,OpportunityID" DataSourceID="OpportunityListObjectDataSource" GridLines="None" ShowHeader="False">
                                    <EmptyDataTemplate>
                                        <p>Data Not Found</p></EmptyDataTemplate><Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Image ID="UserImage" runat="server" ImageUrl="~/Content/images/c3/opportunity.jpg" Height="60" Width="60" />
                                                <asp:LinkButton ID="OpportunityListLinkButton" runat="server" CommandArgument='<%# Eval("OpportunityID") %>' CommandName="Select" OnCommand="OpportunityListLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="AccountNameLabel" runat="server" Text='<%# Eval("Account.Name") %>' />
                                                </asp:LinkButton></ItemTemplate></asp:TemplateField></Columns></asp:GridView></ContentTemplate></asp:UpdatePanel></asp:Panel></ContentTemplate></asp:UpdatePanel></asp:Panel></asp:Panel><asp:Panel ID="ViewPanel" runat="server" SkinID="ViewTab" tab-id="2">
        <asp:LinkButton runat="server" ID="ViewNoteLinkButton" SkinID="TabTitle" OnClick="ViewNoteLinkButton_Click" Text="View Notes" OnClientClick="GoToTab(2,'Create Note');" />
        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">


            <asp:Panel ID="SearchPanel" runat="server" SkinID="SearchPanel">

                <asp:Panel ID="SearchFilterPanel1" runat="server" CssClass="filter">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search Filter" />
                    <asp:LinkButton ID="SearchAllLinkButton" runat="server" CssClass="search-label active" Text="All" OnClick="SearchAllLinkButton_Click"></asp:LinkButton></asp:Panel><asp:Panel ID="SearchFilterPanel2" runat="server" CssClass="search" DefaultButton="SearchLinkButton">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search" />
                    <asp:TextBox ID="SearchTextBox" runat="server" OnTextChanged="SearchLinkButton_Click"></asp:TextBox><asp:LinkButton ID="SearchLinkButton" runat="server" CssClass="search-btn" OnClick="SearchLinkButton_Click" Text="Search">
                    </asp:LinkButton></asp:Panel></asp:Panel><asp:Panel ID="ListPanel" runat="server" SkinID="ListPanel">
                <asp:UpdatePanel ID="NotesListUpdatePanel" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewNoteLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>

                        <asp:ObjectDataSource ID="NotesListObjectDataSource" runat="server" TypeName="C3App.BLL.NoteBL" DataObjectTypeName="C3App.DAL.Note" SelectMethod="GetNotes"></asp:ObjectDataSource>

                        <asp:ObjectDataSource ID="SearchNoteObjectDataSource" runat="server" TypeName="C3App.BLL.NoteBL" DataObjectTypeName="C3App.DAL.Note" SelectMethod="GetNotesByName">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="SearchTextBox" PropertyName="Text" Name="name" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:GridView ID="NotesListGridView" runat="server" CssClass="list-form"
                            AutoGenerateColumns="False"
                            DataKeyNames="NoteID"
                            DataSourceID="NotesListObjectDataSource"
                            GridLines="None"
                            ShowHeader="false">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p></EmptyDataTemplate><Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="NoteImage" runat="server" ImageUrl="~/Content/images/c3/note.jpg" Height="60" Width="60" />
                                        <%--<asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("NoteID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">--%>
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("NoteID")+ ";" + Eval("ParentID") + ";" + Eval("ParentType")+";"+Eval("FilePath")%>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                            <%# Eval("Name") %>&nbsp;<br />
                                            <asp:Label ID="ParentTypeLabel" runat="server" Text='<%# Eval("ParentType") %>'></asp:Label>
                                        </asp:LinkButton></ItemTemplate></asp:TemplateField></Columns></asp:GridView></ContentTemplate></asp:UpdatePanel><asp:UpdateProgress ID="NotesListUpdateProgress" runat="server" AssociatedUpdatePanelID="NotesListUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h3>Loading...</h3><asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </asp:Panel>

            <asp:UpdatePanel ID="NoteMiniDetailsUpdatePanel" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="FileDownloadLinkButton" />
                </Triggers>

                <ContentTemplate>

                    <asp:Panel ID="MiniDetailBasicPanel" runat="server" CssClass="mini-detail-panel">

                        <asp:ObjectDataSource ID="NoteMiniDetailObjectDataSource" runat="server" TypeName="C3App.BLL.NoteBL" DataObjectTypeName="C3App.DAL.Note" SelectMethod="GetNoteByID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="NotesListGridView" Type="Int64" Name="noteID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:FormView ID="NoteMiniDetailFormView" runat="server" CssClass="mini-details-form" DataSourceID="NoteMiniDetailObjectDataSource" DataKeyNames="NoteID">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p></EmptyDataTemplate><ItemTemplate>
                                <asp:Image ID="NoteImage" runat="server" CssClass="img-profile" ImageUrl="~/Content/images/c3/note.jpg" />
                                <asp:Panel ID="Panel1" runat="server">
                                    <asp:Label ID="NameLabel" runat="server" CssClass="fullname" Text='<%# Eval("Name") %>'></asp:Label><asp:Label ID="UserNameLabel" runat="server" CssClass="user" Text='<%# Eval("User.FirstName") %>'></asp:Label><asp:Label ID="ParentTypeLabel" runat="server" CssClass="megaphone-tag" Text='<%# Eval("ParentType") %>'></asp:Label><asp:Label ID="FileNameLabel" runat="server" CssClass="star" Text='<%# Eval("FileName") %>'></asp:Label></asp:Panel></ItemTemplate></asp:FormView><asp:Panel ID="ButtonPanel" runat="server" CssClass="mini-detail-control-panel three-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="EditLinkButton" runat="server" Text="Edit" ToolTip="Edit Note" CssClass="control-btn" OnClientClick="GoToTab(1,'Note Details');" OnClick="EditLinkButton_Click">
                                            <i class="icon-edit"></i>
                                    </asp:LinkButton></li><li>
                                    <asp:LinkButton ID="FileDownloadLinkButton" runat="server" CssClass="control-btn" ToolTip="Download File" OnClick="DownloadLinkButton_Click">
                                      <i class="icon-arrow-down"></i>
                                    </asp:LinkButton></li><li>
                                    <asp:Panel ID="DeleteConfirmPanel" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CssClass="control-btn has-confirm" Text="Delete" CommandArgument="NoteID" ToolTip="Delete Notes">
                                            <i class="icon-trash"></i>
                                        </asp:LinkButton><asp:LinkButton ID="NoteDeleteLinkButton" runat="server" OnClick="DeleteLinkButton_Click">Confirm</asp:LinkButton><asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="slide-cancel">Cancel</asp:LinkButton></asp:Panel></li></ul></asp:Panel></asp:Panel><asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <asp:Panel ID="MiniNoteDetailMore" runat="server">

                            <asp:DetailsView ID="NoteMiniMoreDetailsView" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label"
                                AutoGenerateRows="False" DataSourceID="NoteMiniDetailObjectDataSource">
                                <EmptyDataTemplate>
                                    <p>Data Not Found</p></EmptyDataTemplate><Fields>
                                    <asp:BoundField DataField="ParentID" HeaderText="ParentID" SortExpression="ParentID"></asp:BoundField>
                                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                                </Fields>
                                <Fields>
                                </Fields>

                            </asp:DetailsView>

                        </asp:Panel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="miniDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="NoteMiniDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel5" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent5" runat="server" CssClass="loadingContent">
                        <h3>Loading...</h3><asp:Image ID="ProgressImage5" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>


    </asp:Panel>


    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel runat="server" ID="UpdatePanel4" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="MessageLiteral" runat="server" Text=""></asp:Literal></h4><a class="close-reveal-modal">&#215;</a></ContentTemplate></asp:UpdatePanel></div></asp:Content>