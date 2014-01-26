<%@ Page Title="Team" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Teams.aspx.cs" Inherits="C3App.Users.Teams" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">

    <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">

        <asp:LinkButton ID="TeamInsertButton" runat="server" SkinID="TabTitle" Text="Create Team" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Team');" OnClick="TeamInsertButton_Click" />

        <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">
            <asp:UpdatePanel runat="server" ID="UpdatePanel1">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="TeamInsertButton" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="EditLinkButton" EventName="Click" />
                </Triggers>
                <ContentTemplate>

                    <asp:ValidationSummary ID="TeamsValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                    <asp:ObjectDataSource ID="TeamDetailsObjectDataSource" runat="server"
                        DataObjectTypeName="C3App.DAL.Team" TypeName="C3App.BLL.TeamBL"
                        SelectMethod="GetTeamsByID"
                        OnInserted="TeamDetailsObjectDataSource_Inserted"
                        OnUpdated="TeamDetailsObjectDataSource_Updated"
                        InsertMethod="TeamsInsertOrUpdate"
                        UpdateMethod="TeamsInsertOrUpdate">

                        <SelectParameters>
                            <asp:SessionParameter SessionField="EditTeamID" Name="tid" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:DetailsView FieldHeaderStyle-CssClass="fields-label" CssClass="details-form" ID="TeamsDetailsView" runat="server" AutoGenerateRows="False"
                        DataSourceID="TeamDetailsObjectDataSource" DefaultMode="Insert"
                        OnItemInserting="TeamsDetailsView_ItemInserting"
                        OnItemInserted="TeamsDetailsView_ItemInserted"
                        OnItemUpdating="TeamsDetailsView_ItemUpdating"
                        OnItemUpdated="TeamsDetailsView_ItemUpdated"
                        OnItemCommand="TeamsDetailsView_ItemCommand"
                        DataKeyNames="TeamID,CompanyID,CreatedTime,CreatedBy,TeamSetID">

                        <EmptyDataTemplate>
                            <p>
                                No Data Found.
                            </p>
                        </EmptyDataTemplate>

                        <Fields>
                            <asp:TemplateField HeaderText="Name" SortExpression="Name">
                                <EditItemTemplate>
                                    <asp:TextBox runat="server" CssClass="required-field mask-name" Text='<%# Bind("Name") %>' ID="NameTextBox"></asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="NameTextBoxRequiredFieldValidator" ControlToValidate="NameTextBox" Text="*" ErrorMessage="Team Name is Required!" ValidationGroup="sum" />
                                    <asp:RegularExpressionValidator
                                        ID="TeamNameRegularExpressionValidator"
                                        runat="server"
                                        ValidationExpression="^[a-zA-Z''-'.\s]{1,200}$"
                                        ControlToValidate="NameTextBox" Text="*"
                                        ErrorMessage="Some Special Characters are not supported in Team Name Field!" ValidationGroup="sum">  
                                    </asp:RegularExpressionValidator>
                                </EditItemTemplate>
                            </asp:TemplateField>

                            <asp:BoundField DataField="Description" HeaderText="Description" SortExpression="Description"></asp:BoundField>
                            <asp:TemplateField HeaderText="TeamSet" SortExpression="TeamSetID">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TeamSetTextBox" CssClass="required-field input-with-btn" Text='<%# Eval("TeamSet.TeamSetName") %>' runat="server" ReadOnly="True" ></asp:TextBox>
                                    <asp:Button ID="ModalPopButton2" runat="server" CommandArgument="TeamSet" OnClick="ModalPopButton2_Click"
                                        OnClientClick="OpenModal('BodyContent_ModalPanel1')" SkinID="ButtonWithTextBox" Text="Select" />
                                    <asp:RequiredFieldValidator runat="server" ID="TeamSetTextBoxRequiredFieldValidator" ControlToValidate="TeamSetTextBox" Text="*" ErrorMessage="TeamSet Name is Required!" ValidationGroup="sum" />
                                </EditItemTemplate>
                            </asp:TemplateField>


                            <%-- <asp:TemplateField HeaderText="TeamSet">
                                <EditItemTemplate>
                                    <asp:ObjectDataSource ID="TeamSetObjectDataSource" runat="server"
                                        TypeName="C3App.BLL.TeamBL"
                                        DataObjectTypeName="C3App.DAL.TeamSet"
                                        SelectMethod="GetTeamSetsByCompanyID"></asp:ObjectDataSource>

                                    <asp:DropDownList ID="TeamSetDropDownList" runat="server"
                                        DataSourceID="TeamSetObjectDataSource"
                                        SelectedValue='<%# Bind("TeamSetID") %>'
                                        DataTextField="TeamSetName" DataValueField="TeamSetID" OnInit="TeamSetDropDownList_Init">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>--%>

                            <asp:TemplateField ShowHeader="False">
                                <EditItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="UpdateLinkButton" runat="server" CssClass="form-btn" ValidationGroup="sum" CausesValidation="True" CommandName="Update" Text="Save"></asp:LinkButton>
                                </EditItemTemplate>

                                <InsertItemTemplate>
                                    <asp:LinkButton ID="CancelLinkButton" runat="server" CssClass="form-btn" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                                    <asp:LinkButton ID="InsertLinkButton" runat="server" CssClass="form-btn" ValidationGroup="sum" CausesValidation="True" CommandName="Insert" Text="Save"></asp:LinkButton>
                                </InsertItemTemplate>
                            </asp:TemplateField>

                        </Fields>
                    </asp:DetailsView>
                </ContentTemplate>
            </asp:UpdatePanel>

            <asp:UpdateProgress ID="TeamDetailUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                <ProgressTemplate>
                    <asp:Panel ID="ProgressOverlayPanel" runat="server" CssClass="loading"></asp:Panel>
                    <asp:Panel ID="ProgressOverlayContent" runat="server" CssClass="loadingContent">
                        <h2>Loading...</h2>
                        <asp:Image ID="ProgressImage" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>

        </asp:Panel>



        <asp:Panel ID="ModalPanel1" SkinID="ModalPopLeft" runat="server">
            <asp:HyperLink ID="HyperLink1" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink> 
               <asp:LinkButton ID="CreateTeamSet" runat="server" CssClass="modal-create-btn" Text="Create" OnClientClick="OpenCreateModal('BodyContent_Panel291')" />
             <asp:UpdatePanel runat="server" ID="UpdatePanel3" UpdateMode="Always">
                <Triggers>
                    <%--  <asp:AsyncPostBackTrigger ControlID="ModalPopButton2" EventName="Click" />--%>
                </Triggers>
                <ContentTemplate>
                    <asp:Label ID="ModalLabel" runat="server" SkinID="ModalTitle" Text="Search TeamSet"></asp:Label>
                    <asp:Panel ID="ModalCreatePanel" SkinID="ModalCreatePanel" runat="server">
                    </asp:Panel>

                    <asp:Panel ID="ModalSearchPanel" SkinID="ModalSearchPanel" runat="server">
                        <asp:Label ID="Label12" runat="server" Text="Search"></asp:Label>
                        <asp:TextBox ID="TextBox1" runat="server" AutoPostBack="true"></asp:TextBox>
                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="search-btn">
                        <i class="icon-search"></i>
                        </asp:LinkButton>
                    </asp:Panel>


                    <asp:Panel ID="ModalListPanel" SkinID="ModalListPanel" runat="server">
                        <asp:ObjectDataSource ID="TeamSetObjectDataSource" runat="server"
                            SelectMethod="GetTeamSets" TypeName="C3App.BLL.TeamBL">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TextBox1" Name="nameSearchString" PropertyName="Text"
                                    Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:GridView ID="TeamSetsGridView" runat="server" class="list-form"
                            AutoGenerateColumns="False" ShowHeader="false"
                            DataKeyNames="TeamSetID" GridLines="None"
                            DataSourceID="TeamSetObjectDataSource">

                            <EmptyDataTemplate>
                                <p>
                                    No Data Found.
                                </p>
                            </EmptyDataTemplate>

                            <Columns>

                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" />
                                        <asp:LinkButton ID="SelectTeamSets" runat="server"  CommandArgument='<%# Eval("TeamSetID") %>' CommandName="Select" OnCommand="SelectTeamSets_Command" CausesValidation="False">
                                           <%# Eval("TeamSetName") %>
                                         
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>

                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>


        <div ID="myModal" runat="server" Class="reveal-modal small">
            <asp:UpdatePanel runat="server" ID="UpdatePanel5" UpdateMode="Always">
                <ContentTemplate>
                    <h4><asp:Literal ID="Literal1" runat="server" Text=""></asp:Literal></h4>
                    <a class="close-reveal-modal">&#215;</a>
                    <asp:Label ID="Label6" runat="server" Text=""></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>


        <asp:Panel ID="Panel291" SkinID="ModalCreatePanelLeft" runat="server">
            <asp:HyperLink ID="HyperLink11" runat="server" SkinID="CreateModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
            <asp:Label ID="Label31" runat="server" SkinID="ModalTitle" Text="Create TeamSet"></asp:Label>
            <asp:Panel ID="Panel7" runat="server" CssClass="modal-create-content">
                <asp:UpdatePanel runat="server" ID="UpdatePanel6" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="CreateTeamSet" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                          <asp:ValidationSummary ID="ValidationSummary" runat="server" DisplayMode="BulletList" ShowSummary="true" ValidationGroup="teamset" />
                            <br />           
                            <asp:Label ID="TeamSetNameLabel" runat="server" Text="Team Set Name"></asp:Label>
                            <br /> <br />
                            <asp:TextBox ID="TeamSetNameTextBox" runat="server" ></asp:TextBox>
                         <asp:RequiredFieldValidator runat="server" ID="TeamSetNameTextBoxRequiredFieldValidator" ControlToValidate="TeamSetNameTextBox" Text="*" ErrorMessage="TeamSet Name is Required!" ValidationGroup="teamset" />
                            <asp:LinkButton ID="Cancel" CssClass="form-btn" runat="server" Text="Cancel" OnClientClick="CloseModal('BodyContent_Panel291')" ></asp:LinkButton>
                            <asp:LinkButton ID="Submit" CssClass="form-btn" CausesValidation="true" CommandName="Insert" runat="server" Text="Save" ValidationGroup="teamset"  OnClick="Submit_Click"></asp:LinkButton>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
        </asp:Panel>

    </asp:Panel>

    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">
        <asp:LinkButton runat="server" ID="UpdateTab2" SkinID="TabTitle" OnClick="UpdateButton_Click" Text="View Teams" OnClientClick="GoToTab(2,'Create Team')" />
        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">
            <asp:ObjectDataSource ID="SearchObjectDataSource" runat="server" SelectMethod="GetTeamsByName" TypeName="C3App.BLL.TeamBL">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" PropertyName="Text" Name="nameSearchString" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>

            <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                <asp:Panel ID="Panel5" runat="server" CssClass="filter">
                    <asp:Label ID="Label8" runat="server" Text="Search Filter"></asp:Label>
                    <asp:LinkButton runat="server" ID="SearchAllLinkButton" CssClass="search-label active" OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                </asp:Panel>
                <asp:Panel ID="Panel3" runat="server" CssClass="search" DefaultButton="SearchButton">
                    <asp:Label ID="Label91" runat="server" Text="Search"></asp:Label>
                    <asp:TextBox ID="SearchTextBox" runat="server"></asp:TextBox>
                    <asp:LinkButton CssClass="search-btn" ID="SearchButton" runat="server" OnClick="SearchButton_Click" Text="Search"></asp:LinkButton>
                </asp:Panel>
            </asp:Panel>

            <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">
                <asp:UpdatePanel ID="upListView" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="UpdateTab2" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:ObjectDataSource ID="TeamsObjectDataSource" runat="server"
                            SelectMethod="GetTeamsByCompanyID"
                            TypeName="C3App.BLL.TeamBL" DataObjectTypeName="C3App.DAL.Team"></asp:ObjectDataSource>
                        <asp:GridView ID="TeamsGridView" runat="server" CssClass="list-form" AutoGenerateColumns="False"
                            DataKeyNames="TeamID"
                            DataSourceID="TeamsObjectDataSource" GridLines="None" ShowHeader="false">

                            <EmptyDataTemplate>
                                <p>
                                    No team found.
                                </p>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Image ID="ContactImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/contact.jpg" />
                                        <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# String.Concat(Eval("TeamID"),":", Eval("TeamSetID")) %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                                <%# Eval("Name")%>
                                            <%# "<br />" + "<br />" %>
                                        </asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:UpdateProgress ID="TeamsUpdateProgress" runat="server" AssociatedUpdatePanelID="upListView">
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
           
                <asp:UpdatePanel ID="miniDetails" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <asp:Panel ID="MiniDetailBasicPanel" CssClass="mini-detail-panel" runat="server">
                        <asp:ObjectDataSource ID="MiniTeamObjectDataSource" runat="server"
                            SelectMethod="GetTeamsByID"
                            TypeName="C3App.BLL.TeamBL" DataObjectTypeName="C3App.DAL.Team">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TeamsGridView" Type="Int64" Name="tid" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:ObjectDataSource>

                        <asp:FormView CssClass="mini-details-form" ID="MiniTeamFormView" runat="server" DataSourceID="MiniTeamObjectDataSource"
                            DataKeyNames="TeamID">
                            <EmptyDataTemplate>
                                <p>
                                    No team selected...
                                </p>
                            </EmptyDataTemplate>

                            <ItemTemplate>     
                                <asp:Image ID="TeamImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/contact.jpg" />
                                 <asp:Panel ID="Panel2" runat="server">
                                    <asp:Label ID="Label2" CssClass="fullname" runat="server" Text='<%# Eval("Name") %>'>'></asp:Label>
                                    <asp:Label ID="Label3" runat="server" CssClass="description" Text='<%# Eval("Description") %>'></asp:Label>
                                    <asp:Label ID="Label4" runat="server" CssClass="description" Text='<%# Eval("TeamSet.TeamSetName") %>'></asp:Label>
                                </asp:Panel>

                            </ItemTemplate>
                        </asp:FormView>
                        <asp:Panel ID="Panel1" runat="server" CssClass="mini-detail-control-panel three-controls">
                            <ul>
                                <li>
                                    <asp:LinkButton ID="EditLinkButton" CssClass="control-btn" ToolTip="Edit" runat="server" CommandArgument="" OnClientClick="GoToTab(1,'Team Details');" OnClick="EditLinkButton_Click">
                                     <i class="icon-edit"></i>
                                    </asp:LinkButton>
                                </li>

                                <li>
                                    <asp:LinkButton ID="ModalPopButton2" CssClass="control-btn" ToolTip="Select Members" runat="server" OnClick="UpdateButton_Click" OnClientClick="OpenModal('BodyContent_ModalPanel2')">
                                                    <i class="icon-user"></i>
                                    </asp:LinkButton>
                                </li>

                                <li>

                                    <div class="slide-confirm">
                                        <asp:LinkButton ID="DeleteLinkButton" ToolTip="Delete" CssClass="control-btn has-confirm" runat="server">
                                                    <i class="icon-trash"></i>                                                                                                  
                                        </asp:LinkButton>
                                        <asp:LinkButton ID="TeamDeleteButton" runat="server" ToolTip="Delete" Text="Confirm" OnClick="DeleteLinkButton_Click">
                                        </asp:LinkButton>
                                        <a href="#" class="slide-cancel">Cancel</a>
                                    </div>
                                </li>

                            </ul>
                        </asp:Panel>
                    </asp:Panel>

                    <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                        <asp:Panel ID="MiniTeamsDetailMore" runat="server">
                            <asp:ObjectDataSource ID="SelectedTeamObjectDataSource" runat="server"
                                SelectMethod="GetUsersByTeam" TypeName="C3App.BLL.TeamBL">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="TeamsGridView" Type="Int64" Name="teamid" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <asp:GridView ID="SelectedTeamGridView" runat="server" AutoGenerateColumns="False"
                                GridLines="None" class="list-form" ShowHeader="false"
                                DataSourceID="SelectedTeamObjectDataSource">
                                <EmptyDataTemplate>
                                    <p class="no-selected">
                                        No Member Selected.
                                    </p>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                         <asp:Image ID="TeamImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/user.jpg" />
                                            <asp:LinkButton ID="SelectLinkButton2" runat="server" CommandArgument='<%# Eval("UserID") %>' CommandName="Select" CausesValidation="False">
                                                <%# Eval("FirstName")%>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </asp:Panel>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>

               <asp:UpdateProgress ID="MiniDetailsUpdateProgress" runat="server" AssociatedUpdatePanelID="miniDetails">
                   <ProgressTemplate>
                       <asp:Panel ID="ProgressOverlayPanel3" runat="server" CssClass="loading"></asp:Panel>
                       <asp:Panel ID="ProgressOverlayContent3" runat="server" CssClass="loadingContent">
                           <h2>Loading...</h2>
                           <asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                       </asp:Panel>
                   </ProgressTemplate>
               </asp:UpdateProgress>

            </asp:Panel>

            <asp:Panel ID="ModalPanel2" SkinID="ModalPopRight" runat="server">
                <asp:HyperLink ID="HyperLink2" runat="server" SkinID="ModalCloseButton"><i class='icon-remove'></i></asp:HyperLink>
                <asp:UpdatePanel runat="server" ID="UpdatePanel4">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="ModalPopButton2" EventName="Click" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Label ID="Label1" runat="server" SkinID="ModalTitle" Text="Select Members"></asp:Label>
                        <asp:Panel ID="Panel2" SkinID="ModalCreatePanel" runat="server">
                        </asp:Panel>
                        <asp:Panel ID="Panel39" SkinID="ModalSearchPanel" runat="server">
                 
                            <asp:Label ID="Label5" runat="server" Text="Name"></asp:Label>
                            <asp:TextBox ID="SearchNameTextBox" runat="server" AutoPostBack="true"></asp:TextBox>
                            <asp:LinkButton ID="SearchLinkButton" runat="server" CssClass="search-btn">
                        <i class="icon-search"></i>
                            </asp:LinkButton>
                        </asp:Panel>
                        <asp:Label ID="Label7" runat="server" Text="Member List" CssClass="list-title">
                             <asp:LinkButton ID="Save" CssClass="modal-list-title-button" runat="server" Text="Save"  OnClientClick="CloseModal('BodyContent_ModalPanel2')" OnClick="Save_Click"></asp:LinkButton>
                        </asp:Label>

                        <asp:Panel ID="Panel4" SkinID="ModalListPanel" runat="server">
                            <asp:ObjectDataSource ID="TeamMemberObjectDataSource" runat="server"
                                SelectMethod="GetTeamUsers" TypeName="C3App.BLL.TeamBL">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="EditTeamID" Name="teamid" Type="Int64"></asp:SessionParameter>
                                </SelectParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="SearchNameTextBox" Name="nameSearchString" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>

                            <asp:GridView ID="TeamMemberGridView" runat="server" class="list-form"
                                AutoGenerateColumns="False"
                                DataKeyNames="UserID" GridLines="None" ShowHeader="false"
                                DataSourceID="TeamMemberObjectDataSource">

                                <EmptyDataTemplate>
                                    <p>
                                        No Data Found.
                                    </p>
                                </EmptyDataTemplate>

                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkdelete" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                             <asp:Image ID="TeamUserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/user.jpg" />
                                            <asp:LinkButton ID="SelectLinkButton1" runat="server" CommandArgument='<%# Eval("UserID") %>' CommandName="Select" OnCommand="SelectLinkButton1_Command" CausesValidation="False">
                                                <%# Eval("FirstName")%>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("PrimaryEmail") %>'></asp:Label>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                </Columns>
                            </asp:GridView>
                           

                        </asp:Panel>
                    </ContentTemplate>
                </asp:UpdatePanel>


                <asp:UpdateProgress ID="TeamsUsersUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel4">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel4" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent4" runat="server" CssClass="loadingContent">
                            <h4>Loading...</h4>
                            <asp:Image ID="ProgressImage4" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>


            </asp:Panel>

        </asp:Panel>
    </asp:Panel>


</asp:Content>
