<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="ACLRoles.aspx.cs" Inherits="C3App.Administration.ACLRoles.ACLRoles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
       <script  type="text/javascript">


           var newval = "";
           var delval = "";

           function clickMethod(control) {
              // alert(control.checked );
               if (control.checked)
               {
                 // alert(control.value);
                   newval += control.value+"#";
               }
               if (control.checked==false) {
                 //  alert(control.value);
                   delval += control.value + "#";
               }
           }
          
           function HandleIT() {
               //alert("hi");
              // alert("newval " + newval);
              //  alert(" delval" + delval);
              
               var name = document.getElementById('<%=RoleNameTextBox.ClientID %>').value;
               var des = document.getElementById('<%=DescriptionTextBox.ClientID %>').value;
               var value = name + ":" + des;
               var regex = /^[a-zA-Z''-'\s]{1,200}$/;
               var match = regex.test(name);

               if (name != "" && match == true ) {
                   PageMethods.ProcessIT(value, newval, delval, onSucess, onError);
               }
            function onSucess(result) {
                newval = "";
                delval = "";
                var test = document.getElementById('<%=RoleNameTextBox.ClientID %>').value;
                if (test == "") {
                    alert(result);
                }
                else if(test!="")
                {
                    $('#myAlert').reveal();
                       GoToTab(1, 'Create Role');
                    __doPostBack('ctl00$BodyContent$LinkButtonUpdate', '');
                }
            }
            function onError(result) {
                alert('Something wrong.');
            }
        }


    </script>
</asp:Content>
<asp:Content runat="server" ID="LeftTabs" ContentPlaceHolderID="BodyContent">
   
      <asp:Panel ID="DetailsPanel" SkinID="DetailsTab" runat="server" tab-id="1">
        <asp:LinkButton ID="RoleInsertButton" runat="server" SkinID="TabTitle" Text="Create Role" CommandArgument="Insert" OnClientClick="GoToTab(1,'Create Role');" OnClick="RoleInsertButton_Click" />

          <asp:Panel ID="DetailsContentPanel" SkinID="TabContent" runat="server">
  
              <asp:LinkButton ID="LinkButtonUpdate" runat="server" OnClick="LinkButtonUpdate_Click"></asp:LinkButton>

              <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                  <ProgressTemplate>
                      Loading...
                  </ProgressTemplate>
              </asp:UpdateProgress>
              <asp:UpdatePanel runat="server" ID="UpdatePanel1" UpdateMode="Conditional">
                  <Triggers>
                      <asp:AsyncPostBackTrigger ControlID="RoleInsertButton" EventName="Click" />
                      <asp:AsyncPostBackTrigger ControlID="RoleEditButton" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="Save" EventName="Click" />
                  </Triggers>
                  <ContentTemplate>

                        <asp:ValidationSummary ID="RolesValidationSummary" runat="server" ValidationGroup="sum" EnableClientScript="true" ShowSummary="true" DisplayMode="BulletList" />

                      <asp:Panel ID="aclAction" runat="server">
                      
                          <table class="details-form">
                              <tbody>
                                  <tr>
                                      <td class="field-label">
                                          <asp:Label ID="RoleNameLabel" runat="server" Text="Name"></asp:Label>
                                      </td>
                                      <td>
                                          <asp:TextBox CssClass="required-field mask-name" ID="RoleNameTextBox" runat="server"></asp:TextBox>
                                          <asp:RequiredFieldValidator runat="server" ID="RoleNameTextBoxRequiredFieldValidator" ControlToValidate="RoleNameTextBox" Text="*" ErrorMessage="Role Name is Required!" ValidationGroup="sum" />
                                          <asp:RegularExpressionValidator
                                              ID="RoleNameRegularExpressionValidator"
                                              runat="server"
                                              ValidationExpression="^[a-zA-Z''-'.\s]{1,200}$"
                                              ControlToValidate="RoleNameTextBox" Text="*"
                                              ErrorMessage="Some Special Characters are not supported in Role Name Field!" ValidationGroup="sum">  
                                          </asp:RegularExpressionValidator>
                                      
                                      </td>                                      
                                  </tr>
                                  <tr>
                                      <td class="field-label">
                                          <asp:Label ID="DescriptionLabel" runat="server" Text="Description"></asp:Label>
                                      </td>
                                      <td>
                                          <asp:TextBox ID="DescriptionTextBox" runat="server"></asp:TextBox>
                                         
                                      </td>
                                  </tr>
                              </tbody>
                          </table>
                          
                  
                          <%= CreateACLActionTable() %>

                          <asp:HiddenField ID="HiddenField1" runat="server" />
                          <asp:LinkButton ID="Cancel" runat="server" CssClass="form-btn" Text="Cancel"  OnClientClick="GoToTab(1,'Create Role');" OnClick="Cancel_Click"></asp:LinkButton>
                          <asp:LinkButton ID="Save" runat="server" CssClass="form-btn" Text="Save" CausesValidation="True" ValidationGroup="sum" OnClientClick="HandleIT();"></asp:LinkButton>

                      </asp:Panel>
                  </ContentTemplate>
              </asp:UpdatePanel>
  
          
          </asp:Panel>
          <asp:Panel ID="Panel5" runat="server">
              <div id="myAlert" class="reveal-modal small">
                  <h4><asp:Literal ID="Literal1" runat="server" Text="Success"></asp:Literal></h4>
                  <a class="close-reveal-modal">&#215;</a>
                  <asp:Label ID="Label6" runat="server" Text="Role information has been saved Successfully."></asp:Label>
              </div>
          </asp:Panel>
          <asp:Panel ID="Panel6" runat="server">
              <div id="myModal" class="reveal-modal small">
                  <h4><asp:Literal ID="Literal2" runat="server" Text="Submission cancelled"></asp:Literal></h4>
                  <a class="close-reveal-modal">&#215;</a>
                  <asp:Label ID="Label2" runat="server" Text="Your changes have been discarded"></asp:Label>
              </div>
          </asp:Panel>
    </asp:Panel>

    <asp:Panel ID="ViewPanel" SkinID="ViewTab" runat="server" tab-id="2">
      <asp:LinkButton runat="server" ID="UpdateTab2" SkinID="TabTitle" OnClick="UpdateButton_Click" Text="View Roles" OnClientClick="GoToTab(2,'Create Role')" />

        <asp:Panel ID="ViewContentPanel" SkinID="TabContent" runat="server">

            <asp:ObjectDataSource ID="SearchObjectDataSource" runat="server" SelectMethod="GetRolesByName" TypeName="C3App.BLL.ACLRoleBL">
                <SelectParameters>
                    <asp:ControlParameter ControlID="SearchTextBox" PropertyName="Text" Name="nameSearchString" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:ObjectDataSource>

                    <asp:Panel ID="SearchPanel" SkinID="SearchPanel" runat="server">
                        <asp:Panel ID="Panel7" runat="server" CssClass="filter">
                            <asp:Label ID="Label8" runat="server" Text="Search Filter"></asp:Label>
                            <asp:LinkButton runat="server" ID="SearchAllLinkButton" CssClass="search-label active" OnClick="SearchAllLinkButton_Click">All</asp:LinkButton>
                        </asp:Panel>

                        <asp:Panel ID="Panel3" runat="server" CssClass="search" DefaultButton="SearchButton">
                         <asp:Label ID="Label91" runat="server" Text="Search"></asp:Label>
                            <asp:TextBox ID="SearchTextBox" runat="server" ></asp:TextBox>
                            <asp:LinkButton CssClass="search-btn" ID="SearchButton" runat="server" Text="Search" OnClick="SearchButton_Click"></asp:LinkButton>
                        </asp:Panel>
                    </asp:Panel>

                    <asp:Panel ID="ListPanel" SkinID="ListPanel" runat="server">
                     
                     
                        <asp:ObjectDataSource ID="ACLRolesObjectDataSource" runat="server"
                            SelectMethod="GetRolesByCompanyID" TypeName="C3App.BLL.ACLRoleBL">
                        </asp:ObjectDataSource>

                        <asp:UpdatePanel ID="upListView" runat="server" UpdateMode="Conditional">
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="LinkButtonUpdate" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="UpdateTab2" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="SearchButton" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="SearchAllLinkButton" EventName="Click" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:GridView ID="ACLRolesGridView" runat="server"  SelectedIndex="1"
                                    DataKeyNames="RoleID" CssClass="list-form" GridLines="None" ShowHeader="false"
                                    DataSourceID="ACLRolesObjectDataSource" AutoGenerateColumns="False">
                                    <EmptyDataTemplate>
                                        <p>
                                            No role found.
                                        </p>
                                    </EmptyDataTemplate>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                               <asp:Image ID="RoleImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/administration_icon.png" />
                                                <asp:LinkButton ID="SelectLinkButton" runat="server" CommandArgument='<%# Eval("RoleID") %>' CommandName="Select" OnCommand="SelectLinkButton_Command" CausesValidation="False">
                                                    <%# Eval("Name")%>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Description") %>'></asp:Label>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                            <asp:UpdateProgress ID="RolesUpdateProgress" runat="server" AssociatedUpdatePanelID="upListView">
                            <ProgressTemplate>
                                <asp:Panel ID="ProgressOverlayPanel2" runat="server" CssClass="loading"></asp:Panel>
                                <asp:Panel ID="ProgressOverlayContent2" runat="server" CssClass="loadingContent">
                                    <h2>Loading...</h2>
                                    <asp:Image ID="ProgressImage2" runat="server" ImageUrl="../../../Content/themes/base/images/loading.gif" />
                                </asp:Panel>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </asp:Panel>


            <asp:UpdatePanel ID="miniDetails" runat="server" UpdateMode="Conditional">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="LinkButtonUpdate" EventName="Click" />
                </Triggers>
                <ContentTemplate>

                        <asp:Panel ID="MiniDetailBasicPanel" CssClass="mini-detail-panel" runat="server">
                            <asp:Panel ID="MiniRolesDetailBasic" runat="server">
                            <asp:ObjectDataSource ID="MiniRoleObjectDataSource" runat="server"
                                SelectMethod="GetRolesByID"
                                TypeName="C3App.BLL.ACLRoleBL" DataObjectTypeName="C3App.DAL.ACLRole">

                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ACLRolesGridView" Type="Int32" Name="roleid" PropertyName="SelectedValue" />
                                </SelectParameters>

                            </asp:ObjectDataSource>
                           
                                    <asp:FormView ID="MiniRoleFormView" runat="server" DataSourceID="MiniRoleObjectDataSource"
                                        CssClass="mini-details-form"
                                        DataKeyNames="RoleID">

                                        <EmptyDataTemplate>
                                            <p>
                                                No role selected...
                                            </p>
                                        </EmptyDataTemplate>

                                        <ItemTemplate>
                                            <asp:Image ID="RoleImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/administration_icon.png" />
                                            <asp:Panel ID="Panel2" runat="server">
                                               <asp:Label ID="Label3" CssClass="fullname" runat="server" Text='<%# Eval("Name") %>' ></asp:Label>
                                                <asp:Label ID="Label4" runat="server" CssClass="description" Text='<%# Eval("Description") %>'></asp:Label>

                                            </asp:Panel>
                                        </ItemTemplate>
                                    </asp:FormView>

                                    <asp:Panel ID="Panel1" runat="server" CssClass="mini-detail-control-panel three-controls">
                                        <ul>
                                            <li>
                                                <asp:LinkButton ID="RoleEditButton" ToolTip="Edit" CssClass="control-btn" runat="server" CommandArgument="" OnClientClick="GoToTab(1,'Role Details');" OnClick="RoleEditButton_Click">
                                                    <i class="icon-edit"></i>
                                                </asp:LinkButton>
                                            </li>

                                            <li>
                                                <asp:LinkButton ID="ModalPopButton2" ToolTip="Select Members" CssClass="control-btn" runat="server" OnClick="UpdateButton_Click" OnClientClick="OpenModal('BodyContent_ModalPanel2')">
                                                    <i class="icon-user"></i>
                                                </asp:LinkButton>
                                            </li>

                                            <li>
                                                <div class="slide-confirm">
                                                    <asp:LinkButton ID="DeleteLinkButton" ToolTip="Delete" CssClass="control-btn has-confirm" runat="server">
                                                    <i class="icon-trash"></i>                                                                                                  
                                                    </asp:LinkButton>

                                                    <asp:LinkButton ID="RoleDeleteButton" runat="server" Text="Confirm" OnClick="RoleDeleteButton_Click">
                                                    </asp:LinkButton>
                                                    <a href="#" class="slide-cancel">Cancel</a>
                                                </div>
                                            </li>

                                        </ul>
                                    </asp:Panel>
                                </asp:Panel>
                        </asp:Panel>


                        <asp:Panel ID="MiniDetailMorePanel" SkinID="MiniDetailMorePanel" runat="server">
                            <asp:Panel ID="MiniRolesDetailMore" runat="server">
                            <asp:ObjectDataSource ID="SelectedRoleObjectDataSource" runat="server"
                                SelectMethod="GetUsersByRoleID" TypeName="C3App.BLL.ACLRoleBL">

                                <SelectParameters>
                                    <asp:ControlParameter ControlID="ACLRolesGridView" Type="Int32" Name="roleid" PropertyName="SelectedValue" />
                                </SelectParameters>

                            </asp:ObjectDataSource>
                            
                            <asp:GridView ID="SelectedRolesGridView" runat="server" AutoGenerateColumns="False"
                                GridLines="None" class="list-form" ShowHeader="false"
                                DataSourceID="SelectedRoleObjectDataSource">
                                <EmptyDataTemplate>
                                    <p class="no-selected">
                                        No Member Selected.
                                    </p>
                                </EmptyDataTemplate>
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Image ID="RoleuserImage" CssClass="img-profile" runat="server" ImageUrl="~/Content/images/c3/user.jpg" />
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
            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                <ProgressTemplate>
                    Loading...
                </ProgressTemplate>
            </asp:UpdateProgress>


         

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
                            <%-- <asp:Label ID="Label5" runat="server" Text="Name"></asp:Label>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>

                    <asp:Label ID="Label6" runat="server" Text="Email"></asp:Label>
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>--%>

                            <asp:Label ID="Label5" runat="server" Text="Name"></asp:Label>
                            <asp:TextBox ID="SearchNameTextBox" runat="server" AutoPostBack="true"></asp:TextBox>
                            <asp:LinkButton ID="SearchLinkButton" runat="server" CssClass="search-btn">
                        <i class="icon-search"></i>
                            </asp:LinkButton>
                        </asp:Panel>
                        <asp:Label ID="Label7" runat="server" Text="Member List" CssClass="list-title">
                             <asp:LinkButton CssClass="modal-list-title-button" ID="SaveUser" runat="server" Text="Save"  OnClientClick="CloseModal('BodyContent_ModalPanel2')" OnClick="SaveUser_Click"></asp:LinkButton>

                        </asp:Label>

                        <asp:Panel ID="Panel4" SkinID="ModalListPanel" runat="server">

                            <asp:ObjectDataSource ID="RoleMemberObjectDataSource" runat="server"
                                SelectMethod="GetRoleUsers" TypeName="C3App.BLL.ACLRoleBL">
                                <SelectParameters>
                                    <asp:SessionParameter SessionField="EditRoleID" Name="roleid" Type="Int32"></asp:SessionParameter>
                                </SelectParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="SearchNameTextBox" Name="nameSearchString" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>

                            
                            <asp:GridView ID="RoleMemberGridView" runat="server" class="list-form"
                                AutoGenerateColumns="False"
                                DataKeyNames="UserID" GridLines="None" ShowHeader="false"
                                DataSourceID="RoleMemberObjectDataSource">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkdelete" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Image ID="UserImage" CssClass="img-profile" runat="server" ImageUrl="~/Users/Images/Chrysanthemum.jpg" />
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

                <asp:UpdateProgress ID="RoleUsersUpdateProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel4">
                    <ProgressTemplate>
                        <asp:Panel ID="ProgressOverlayPanel3" runat="server" CssClass="loading"></asp:Panel>
                        <asp:Panel ID="ProgressOverlayContent3" runat="server" CssClass="loadingContent">
                            <h4>Loading...</h4>
                            <asp:Image ID="ProgressImage3" runat="server" ImageUrl="~/Content/themes/base/images/loading.gif" />
                        </asp:Panel>
                    </ProgressTemplate>
                </asp:UpdateProgress>


            </asp:Panel>


        </asp:Panel>
    </asp:Panel>
</asp:Content>
