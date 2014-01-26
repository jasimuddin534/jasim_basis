<%@ Page Title="Documents Page" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Documents.aspx.cs" Inherits="C3App.Documents.Documents" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>



<asp:Content runat="server" ID="Content2" ContentPlaceHolderID="BodyContent">
    <%--dsfds--%>
    <asp:Panel ID="DetailsPanel" runat="server" SkinID="DetailsTab" tab-id="1">
        <asp:LinkButton ID="DocumentDetailLinkButton" runat="server" SkinID="TabTitle" Text="Create Document" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Document')" OnClick="DocumentDetailLinkButton_Click" />

        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">

            <asp:UpdatePanel ID="DocumentsDetailUpdatePanel" runat="server" UpdateMode="Always">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="DocumentDetailLinkButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                    <asp:PostBackTrigger ControlID="DownloadLinkButton" />
                </Triggers>
                <ContentTemplate>
                    <asp:ValidationSummary ID="DocumentDetailValidationSummary" runat="server" ValidationGroup="sum" ShowSummary="true" DisplayMode="BulletList" />
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="FileFormat" runat="server" Text="File must be pdf, doc, docx, xlsx, xls, pptx, accdb or csv format" />
                            </td>
                        </tr>
                        <tr>
                            <td class="document-upload">
                                <ajaxToolkit:AjaxFileUpload ID="DocumentUpload" runat="server" ToolTip="File must be jpg,jpeg,gif,bmp,pdf,png,txt,doc, docx,xlsx,xls,pptx or csv format"
                                    ThrobberID="myThrobber" OnUploadComplete="DocumentUpload_UploadComplete"
                                    ContextKeys="fred"
                                    AllowedFileTypes="accdb,pdf,doc,docx,xlsx,xls,pptx,csv"
                                    MaximumNumberOfFiles="1" />
                                <asp:LinkButton ID="DownloadLinkButton" runat="server" CssClass="modal-pop-form-btn" Text="Download" OnClick="DocumentDownloadLinkButton_Click"></asp:LinkButton>
                            </td>
                        </tr>
                    </table>
                    <asp:ObjectDataSource ID="DocumentObjectDataSource" runat="server"
                        TypeName="C3App.BLL.DocumentBL"
                        DataObjectTypeName="C3App.DAL.Document"
                        InsertMethod="InsertDocument"
                        SelectMethod="GetDocumentByID"
                        UpdateMethod="UpdateDocument"
                        OnInserted="DocumentObjectDataSource_Inserted"
                        OnUpdated="DocumentObjectDataSource_Updated">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditDocumentID" Name="documentID" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>

                    <asp:DetailsView ID="DocumentDetailsView" runat="server" CssClass="details-form" FieldHeaderStyle-CssClass="fields-label" AutoGenerateRows="False"
                        OnItemInserting="DocumentDetailsView_ItemInserting"
                        OnItemUpdating="DocumentDetailsView_ItemUpdating"
                        OnItemCommand="DocumentDetailsView_ItemCommand"
                        DataSourceID="DocumentObjectDataSource"
                        DataKeyNames="DocumentID,Name,FilePath,CompanyID,Timestamp,CreatedTime,CreatedBy,ModifiedTime,ModifiedBy"
                        OnDataBound="DocumentDetailsView_DataBound"
                        DefaultMode="Insert">
                        <Fields>


                            <asp:TemplateField HeaderText="File Name" SortExpression="Name">

                                <EditItemTemplate>
                                    <asp:TextBox ID="DocumentNameText" runat="server" CssClass="required-field mask-name input-with-bt" Text='<%# Bind("Name") %>' MaxLength="255"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="DocumentNameRequiredValidator" runat="server" ControlToValidate="DocumentNameText" Display="None" ErrorMessage="File Name is required" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator ID="DocumentNameRegularExpression" runat="server" ControlToValidate="DocumentNameText" Display="None"
                                        ValidationExpression="^[A-z\s.-]{1,255}$" Text="" ErrorMessage="Only Letters, Underscore, Space, Fullstop and Hyphen are allowed in File Name !" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Active Date" SortExpression="ActiveDate">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ActiveDateTextBox" runat="server" CssClass="datepicker" Text='<%# Bind("ActiveDate","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Expiry Date" SortExpression="ExpiryDate">
                                <EditItemTemplate>
                                    <asp:TextBox ID="ExpiryDateTextBox" runat="server" CssClass="datepicker" Text='<%# Bind("ExpiryDate","{0:d}") %>' DataFormatString="{0:d}"></asp:TextBox>
                                    <asp:CompareValidator ID="DateCompareValidator" runat="server" Operator="GreaterThanEqual" Type="Date" ControlToValidate="ExpiryDateTextBox"
                                        ControlToCompare="ActiveDateTextBox" ErrorMessage="Expiry Date must be greater than Active Date !" Text="*" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Category" SortExpression="CategoryID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="DocumentCategorieObjectDataSource" runat="server" TypeName="C3App.BLL.DocumentBL" SelectMethod="GetDocumentCategories" DataObjectTypeName="C3App.DAL.DocumentCategory"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="CategoryIDDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="DocumentCategorieObjectDataSource" DataTextField="Value" DataValueField="DocumentCategoryID" OnInit="CategoryDropDownList_Init" SelectedValue='<%# Eval("CategoryID")==null ? "0" : Eval("CategoryID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Sub Category" SortExpression="SubcategoryID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="DocumentSubcategorieObjectDataSource" runat="server" TypeName="C3App.BLL.DocumentBL" SelectMethod="GetDocumentSubcategories" DataObjectTypeName="C3App.DAL.DocumentSubcategory"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="SubcategoryDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="DocumentSubcategorieObjectDataSource" DataTextField="Value" DataValueField="DocumentSubcategoryID" OnInit="SubcategoryDropDownList_Init" SelectedValue='<%# Eval("SubcategoryID")==null ? "0" : Eval("SubcategoryID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Status" SortExpression="StatusID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="DocumentStatusObjectDataSource" runat="server" TypeName="C3App.BLL.DocumentBL" SelectMethod="GetDocumentStatuses" DataObjectTypeName="C3App.DAL.DocumentStatus"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="StatusDropDownList" runat="server" AppendDataBoundItems="true" DataSourceID="DocumentStatusObjectDataSource" DataTextField="Value" DataValueField="DocumentStatusID" OnInit="StatusDropDownList_Init" SelectedValue='<%# Eval("StatusID")==null ? "0" : Eval("StatusID") %>'>
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Revision" SortExpression="Revision">
                                <EditItemTemplate>
                                    <asp:TextBox ID="RevisionTextBox" runat="server" CssClass="mask-name" Text='<%# Bind("Revision") %>' MaxLength="50"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RevisionLength" runat="server" ControlToValidate="RevisionTextBox" Display="None"
                                        ValidationExpression="^[\w\s\+?,'.-@#&{}\:;()]{1,50}$" Text="" ErrorMessage="Some Special Characters are not supported in Revision Field !" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Template" SortExpression="TemplateID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TemplateObjectDataSource" runat="server" TypeName="C3App.BLL.DocumentBL" SelectMethod="GetDocumentTemplates" DataObjectTypeName="C3App.DAL.DocumentTemplate"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="TemplateDropDownList" runat="server" DataSourceID="TemplateObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("TemplateID")==null ? "0" : Eval("TemplateID") %>'
                                        DataTextField="Value" DataValueField="DocumentTemplateID" OnInit="TemplateDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Assigned To" SortExpression="AssignedUserID">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="AssignedUserObjectDataSource" runat="server" TypeName="C3App.BLL.UserBL" SelectMethod="GetUsers" DataObjectTypeName="C3App.DAL.User"></asp:ObjectDataSource>
                                    <asp:DropDownList ID="AssignedUserDropDownList" runat="server" DataSourceID="AssignedUserObjectDataSource" AppendDataBoundItems="true"
                                        SelectedValue='<%# Eval("AssignedUserID")==null ? "0" : Eval("AssignedUserID") %>'
                                        DataTextField="FirstName" DataValueField="UserID" OnInit="AssignedUserDropDownList_Init">
                                        <asp:ListItem Enabled="true" Selected="True" Text="None" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Teams" SortExpression="TeamID">
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

            <asp:UpdateProgress ID="DocumentsDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="DocumentsDetailUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>


        </asp:Panel>
    </asp:Panel>

    <asp:Panel ID="ViewPanel" runat="server" SkinID="ViewTab" tab-id="2">
        <asp:LinkButton ID="ViewDocumentLinkButton" runat="server" SkinID="TabTitle" OnClick="ViewDocumentLinkButton_Click" Text="View Documents" OnClientClick="GoToTab(2,'Create Document')" />
        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">

            <asp:Panel ID="SearchPanel" runat="server" SkinID="SearchPanel">
                <asp:Panel ID="SearchAllPanel" runat="server" CssClass="filter">
                    <asp:Label ID="SearchLabel" runat="server" Text="Search Filter" />
                    <asp:LinkButton ID="SearchAllLinkButton" runat="server" CssClass="search-label active" Text="All" OnClick="SearchAllLinkButton_Click"></asp:LinkButton>
                    <asp:LinkButton ID="SearchMarketingDocumentsLinkButton" runat="server" CssClass="search-label active" Text="Marketing" OnClick="SearchMarketingDocumentsLinkButton_Click"></asp:LinkButton>
                    <asp:LinkButton ID="SearchSalesDocumentsLinkButton" runat="server" CssClass="search-label active" Text="Sales" OnClick="SearchSalesDocumentsLinkButton_Click"></asp:LinkButton>
                    <asp:LinkButton ID="SearchOrderDocumentsLinkButton" runat="server" CssClass="search-label active" Text="Order" OnClick="SearchOrderDocumentsLinkButton_Click"></asp:LinkButton>
                </asp:Panel>

                <asp:Panel ID="SearchTextBoxPanel" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="SearchFilterLabel" runat="server" Text="Search" />
                    <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                    <asp:LinkButton ID="SearchButton" runat="server" CssClass="search-btn" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>

                </asp:Panel>

            </asp:Panel>

            <asp:Panel ID="ListPanel" runat="server" SkinID="ListPanel">
                <asp:UpdatePanel ID="DocumentsListUpdatePanel" runat="server" UpdateMode="Conditional">

                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ViewDocumentLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="DeleteLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchMarketingDocumentsLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchSalesDocumentsLinkButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchOrderDocumentsLinkButton" EventName="Click" />
                    </Triggers>

                    <ContentTemplate>

                        <asp:ObjectDataSource ID="DocumentSearchObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Document" TypeName="C3App.BLL.DocumentBL" SelectMethod="GetDocumentByName" UpdateMethod="UpdateDocument">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="SearchTextBox" Name="nameSearchString" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:ObjectDataSource ID="DocumentListObjectDataSource" runat="server" SelectMethod="GetDocuments" TypeName="C3App.BLL.DocumentBL" DataObjectTypeName="C3App.DAL.Document"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="MarketingDocumentsObjectDataSource" runat="server" SelectMethod="GetMarketingDocuments" TypeName="C3App.BLL.DocumentBL" DataObjectTypeName="C3App.DAL.Document"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="SalesDocumentsObjectDataSource" runat="server" SelectMethod="GetSalesDocuments" TypeName="C3App.BLL.DocumentBL" DataObjectTypeName="C3App.DAL.Document"></asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="OrderDocumentsObjectDataSource" runat="server" SelectMethod="GetOrderDocuments" TypeName="C3App.BLL.DocumentBL" DataObjectTypeName="C3App.DAL.Document"></asp:ObjectDataSource>


                        <asp:GridView ID="DocumentsGridView" runat="server" CssClass="list-form"
                            AutoGenerateColumns="False"
                            DataKeyNames="DocumentID"
                            DataSourceID="DocumentListObjectDataSource"
                            GridLines="None"
                            ShowHeader="false">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="DocumentImage" runat="server" ImageUrl="~/Content/images/c3/document.jpg" />
                                        <asp:LinkButton ID="SelectDocumentListLinkButton" runat="server" CommandArgument='<%# Eval("DocumentID") %>' CommandName="Select" OnCommand="SelectDocumentListLinkButton_Command" CausesValidation="false">
                                            <%# Eval("Name")%>
                                            <asp:Label ID="DocumentCategoryLabel" runat="server" Text='<%# Eval("DocumentCategory.Value") %>' />
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress ID="DocumentListUpdateProgress" runat="server" AssociatedUpdatePanelID="DocumentsListUpdatePanel">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                            <h2>Loading...</h2>
                            <asp:Image ID="ProgressImage2" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>

            </asp:Panel>

            <asp:UpdatePanel ID="DocumetnsMiniDetailsUpdatePanel" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:PostBackTrigger ControlID="DocumentDownloadLinkButton" />
                </Triggers>
                <ContentTemplate>
                    <asp:Panel ID="MiniDetailBasicPanel" runat="server" CssClass="mini-detail-panel">

                        <asp:ObjectDataSource ID="MiniDocumentObjectDataSource" runat="server"
                            TypeName="C3App.BLL.DocumentBL"
                            SelectMethod="GetDocumentByID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DocumentsGridView" Type="Int32" Name="documentID" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>


                        <asp:FormView ID="MiniDocumentFormView" runat="server" CssClass="mini-details-form"
                            DataSourceID="MiniDocumentObjectDataSource"
                            DataKeyNames="DocumentID">
                            <EmptyDataTemplate>
                                <p>Data Not Found</p>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <asp:Image ID="UserImage" runat="server" CssClass="img-profile" ImageUrl="~/Content/images/c3/document.jpg" />
                                <asp:Panel ID="BasicPanel" runat="server">
                                    <asp:Label ID="DocumentNameLabel" runat="server" CssClass="fullname" Text='<%# Eval("Name") %>'></asp:Label>
                                    <asp:Label ID="DocumentCategoryLabel" runat="server" CssClass="document-tag" Text='<%# Eval("DocumentCategory.Value") %>'></asp:Label>
                                    <asp:Label ID="DocumentStatusLabel" runat="server" CssClass="hourglass" Text='<%# Eval("DocumentStatus.Value") %>'></asp:Label>
                                    <asp:Label ID="RevisionLabel" runat="server" CssClass="profile-pages" Text='<%# Eval("Revision") %>'></asp:Label>
                                    <asp:Label ID="UserFirstNameLabel" runat="server" CssClass="user" Text='<%# Eval("User.FirstName") %>'></asp:Label>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:FormView>
                        <asp:Panel ID="buttonpanel" runat="server" CssClass="mini-detail-control-panel three-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="EditLinkButton" runat="server" CssClass="control-btn" ToolTip="Edit" CommandArgument="DocumentID" OnClientClick="GoToTab(1,'Document Details');" OnClick="EditLinkButton_Click">
                                            <i class="icon-edit"></i>
                                    </asp:LinkButton></li>
                                <li>
                                    <asp:LinkButton ID="DocumentDownloadLinkButton" runat="server" CssClass="control-btn" ToolTip="Download File" OnClick="DocumentDownloadLinkButton_Click">
                                      <i class="icon-arrow-down"></i>
                                    </asp:LinkButton>
                                </li>
                                <li>
                                    <asp:Panel ID="DeleteConfirmPanel" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="DeleteLinkButton" runat="server" CssClass="control-btn has-confirm" CommandArgument="DocumentID" ToolTip="Delete">
                                            <i class="icon-trash"></i>
                                        </asp:LinkButton><asp:LinkButton ID="DeleteConfirmLinkButton" runat="server" OnClick="DeleteLinkButton_Click">Confirm</asp:LinkButton><asp:LinkButton ID="DeleteCancelLinkButton" runat="server" CssClass="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>

                                <%--<li>
                                    <asp:Panel ID="DocumentDownloadPanel" runat="server" CssClass="slide-confirm">
                                        <asp:LinkButton ID="DocumentDownloadLinkButton" CssClass="control-btn has-confirm " runat="server" Text="Convert" ToolTip="Downloda Document">
                                       <i class="icon-arrow-down"></i></asp:LinkButton>
                                        <asp:LinkButton ID="DownloadConfirmLinkButton" runat="server" OnClick="DocumentDownloadLinkButton_Click">Download</asp:LinkButton>
                                        <asp:LinkButton ID="DownloadCancelLinkButton" runat="server" class="slide-cancel">Cancel</asp:LinkButton>
                                    </asp:Panel>
                                </li>--%>
                            </ul>
                        </asp:Panel>
                    </asp:Panel>
                    <asp:Panel ID="MiniDetailMorePanel" runat="server" SkinID="MiniDetailMorePanel">
                        <asp:Panel ID="DocumentMiniDetailMorePanel" runat="server">
                            <asp:DetailsView ID="MiniMoreDetailsView" runat="server" CssClass="mini-details-more-form" FieldHeaderStyle-CssClass="field-label"
                                AutoGenerateRows="False" DataKeyNames="DocumentID"
                                DataSourceID="MiniDocumentObjectDataSource">
                                <FieldHeaderStyle CssClass="field-label" />
                                <EmptyDataTemplate>
                                    <p>Data Not Found</p>
                                </EmptyDataTemplate>
                                <Fields>

                                    <asp:TemplateField HeaderText="Document Subcategory" SortExpression="SubcategoryID">
                                        <ItemTemplate>
                                            <asp:Label ID="DocumentSubCategoryLabel" runat="server" Text='<%# Eval("DocumentSubcategory.Value") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Active Date" SortExpression="ActiveDate">
                                        <ItemTemplate>
                                            <asp:Label ID="ActiveDateLabel" runat="server" Text='<%# Eval("ActiveDate","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Expiry Date" SortExpression="ExpiryDate">
                                        <ItemTemplate>
                                            <asp:Label ID="ExpiryDateLabel" runat="server" Text='<%# Eval("ExpiryDate","{0:d}") %>' DataFormatString="{0:d}"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Template" SortExpression="TemplateID">
                                        <ItemTemplate>
                                            <asp:Label ID="DocumentTemplateLabel" runat="server" Text='<%# Eval("DocumentTemplate.Value") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Team" SortExpression="TeamID">
                                        <ItemTemplate>
                                            <asp:Label ID="TeamNameLabel" runat="server" Text='<%# Eval("Team.Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description" />
                                </Fields>
                            </asp:DetailsView>


                        </asp:Panel>

                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>


            <asp:UpdateProgress ID="DocumetnsMiniDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="DocumetnsMiniDetailsUpdatePanel">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel3" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent3" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        <%--<asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/ajax-loader.gif" />--%>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>



        </asp:Panel>


    </asp:Panel>

    <div id="myModal" class="reveal-modal small">
        <asp:UpdatePanel ID="MessageUpdatePanel" runat="server" UpdateMode="Always">
            <ContentTemplate>
                <h4>
                    <asp:Literal ID="MessageHeaderLiteral" runat="server" Text=""></asp:Literal></h4>
                <asp:LinkButton ID="MessageCloseLinkButton" runat="server" CssClass="close-reveal-modal" Text="">&#215;</asp:LinkButton><asp:Label ID="MessageBodyLabel" runat="server" Text=""></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
