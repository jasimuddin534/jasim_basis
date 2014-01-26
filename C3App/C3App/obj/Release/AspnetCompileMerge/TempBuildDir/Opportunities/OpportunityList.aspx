<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="OpportunityList.aspx.cs" Inherits="C3App.Opportunities.OpportunityList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
    <div>
                 <asp:Label ID="Label1" runat="server" Text="Enter any part of Opportunity  Name :  "></asp:Label>
         <asp:TextBox ID="searchTextBox" runat="server" AutoPostBack="True" OnTextChanged="searchTextBox_TextChanged"></asp:TextBox>
         <asp:Button ID="searchButton" runat="server" OnClick="searchButton_Click" Text="search" />
         <br />

         <br />
                 <asp:ObjectDataSource ID="opportunityListObjectDataSource" runat="server" DataObjectTypeName="C3App.DAL.Opportunity" InsertMethod="InsertOpportunity" SelectMethod="SearchOpportunities" TypeName="C3App.BLL.OpportunityBL" >
                     <SelectParameters>
                         <asp:ControlParameter ControlID="searchTextBox" Name="search" PropertyName="Text" Type="String" />
                     </SelectParameters>
                     
                 </asp:ObjectDataSource>
                 <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="opportunityListObjectDataSource" ForeColor="Black" >
                     <Columns>
                  <asp:TemplateField HeaderText="Opportunities" SortExpression="Opportunities">
            <ItemTemplate>
                 <a href ='<%#"OpportunityDetails.aspx?OpportunityID="+DataBinder.Eval(Container.DataItem,"OpportunityID") %>'> Select </a>
            </ItemTemplate>
             </asp:TemplateField>

                         <asp:BoundField DataField="Name" HeaderText="Opportunity Name" SortExpression="Name" />

                         <asp:TemplateField  HeaderText="Account Name" SortExpression="Account.Name" >
                              <ItemTemplate>
                   <asp:Label ID="Label1" runat="server" Text='<%# Eval("Account.Name")%>'> 
                                </asp:Label> 
                                 </ItemTemplate>
                          
                         </asp:TemplateField>
                         <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                         <asp:TemplateField HeaderText="Sales Stage" SortExpression="OpportunitySalesStage.Value">
                            
                             <ItemTemplate>
                                 <asp:label ID="salesStagelabel" runat="server" Text='<%# Eval("OpportunitySalesStage.Value") %>'></asp:label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:BoundField DataField="DateEnclosed" HeaderText="Date closed" SortExpression="DateEnclosed" />
                         <asp:TemplateField HeaderText="Assigned User" SortExpression="User.UserName">
                             <ItemTemplate>
                                 <asp:label ID="userlabel" runat="server" Text='<%# Eval("User.UserName") %>'></asp:label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Team" SortExpression="Team.Name">
                             <ItemTemplate>
                                 <asp:label ID="teamlabel" runat="server" Text='<%# Eval("Team.Name") %>'></asp:label>
                             </ItemTemplate>
                         </asp:TemplateField>
                     </Columns>
                 </asp:GridView>
                 <br />
    </div>

   <%-- <asp:ObjectDataSource ID="OpportunityListObjectDataSource1" runat="server" DataObjectTypeName="C3App.DAL.Opportunity" InsertMethod="InsertOpportunity" SelectMethod="SearchOpportunities" TypeName="C3App.BLL.OpportunityBL">
                     <SelectParameters>
                         <asp:ControlParameter ControlID="SearchTextBox" Name="search" PropertyName="Text" Type="String" />
                     </SelectParameters>
                 </asp:ObjectDataSource>
                 <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="OpportunityListObjectDataSource1" ForeColor="Black" >
                     <Columns>
                  <asp:TemplateField HeaderText="Opportunities" SortExpression="Opportunities">
            <ItemTemplate>
                 <a href ='<%#"OpportunityDetails.aspx?OpportunityID="+DataBinder.Eval(Container.DataItem,"OpportunityID") %>'> Select </a>
            </ItemTemplate>
             </asp:TemplateField>

                         <asp:BoundField DataField="Name" HeaderText="Opportunity Name" SortExpression="Name" />

                         <asp:TemplateField  HeaderText="Account Name" SortExpression="Account.Name" >
                              <ItemTemplate>
                   <asp:AccountLabel ID="AccountLabel1" runat="server" Text='<%# Eval("Account.Name")%>'> 
                                </asp:AccountLabel> 
                                 </ItemTemplate>
                          
                         </asp:TemplateField>
                         <asp:BoundField DataField="Amount" HeaderText="Amount" SortExpression="Amount" />
                         <asp:TemplateField HeaderText="Sales Stage" SortExpression="OpportunitySalesStage.Value">
                            
                             <ItemTemplate>
                                 <asp:label ID="salesStagelabel" runat="server" Text='<%# Eval("OpportunitySalesStage.Value") %>'></asp:label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:BoundField DataField="DateEnclosed" HeaderText="Date closed" SortExpression="DateEnclosed" />
                         <asp:TemplateField HeaderText="Assigned User" SortExpression="User.UserName">
                             <ItemTemplate>
                                 <asp:label ID="userlabel" runat="server" Text='<%# Eval("User.UserName") %>'></asp:label>
                             </ItemTemplate>
                         </asp:TemplateField>
                         <asp:TemplateField HeaderText="Team" SortExpression="Team.Name">
                             <ItemTemplate>
                                 <asp:label ID="teamlabel" runat="server" Text='<%# Eval("Team.Name") %>'></asp:label>
                             </ItemTemplate>
                         </asp:TemplateField>
                     </Columns>
                 </asp:GridView>--%>
</asp:Content>
