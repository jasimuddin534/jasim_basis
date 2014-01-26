<%@ Page Title="" Language="C#"  MasterPageFile="~/App_MasterPages/base/Main.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="C3App.Dashboard.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyContent" runat="server">
<script type="text/javascript" >
    $(function () {
        $('.dragbox')
        .each(function () {
            $(this).hover(function () {
                $(this).find('h2').addClass('collapse');
            }, function () {
                $(this).find('h2').removeClass('collapse');
            })
            .find('h2').hover(function () {
                $(this).find('.configure').css('visibility', 'visible');
            }, function () {
                $(this).find('.configure').css('visibility', 'hidden');
            })
            .click(function () {
                $(this).siblings('.dragbox-content').toggle();
            })
            .end()
            .find('.configure').css('visibility', 'hidden');
        });
        $('.col').sortable({
            connectWith: '.col',
            handle: 'h2',
            cursor: 'move',
            placeholder: 'placeholder',
            forcePlaceholderSize: true,
            opacity: 0.4,
            stop: function (event, ui) {
                $(ui.item).find('h2').click();
                var sortorder = '';
                $('.col').each(function () {
                    var itemorder = $(this).sortable('toArray');
                    var columnId = $(this).attr('id');
                    sortorder += columnId + '=' + itemorder.toString() + '&';
                });
                //  alert('SortOrder: ' + sortorder);
                /*Pass sortorder variable to server using ajax to save state*/
            }
        })
        .disableSelection();
    });
</script>
    <style type="text/css">
        div.col {
            float: left;
            width: 50%;
            padding:5px;
            min-height: 200px;
            
        }
        div.dragbox {
            border: 1px solid #777777;
            margin-bottom:15px;
        }
            div.dragbox h2 {
                font-size: 130%;
                margin: 0;
                padding: 10px 20px;
                font-weight: 600;
                background-color: #D71E2F;
                color: #E8E8E8;
                cursor: pointer;
            }

        div.dragbox-content {
            background-color: #efefef;
            padding: 10px;
            overflow: hidden;
            height: auto;
        }

        table[id*='GridView'] tbody tr th {
            border: 1px solid #5D5E5E;
            padding: 5px 0;
            background-color: #5D5E5E;
            color: #ffffff;
            font-weight: 400;
        }

        table[id*='GridView'] tbody tr td {
            border: 1px solid #5D5E5E;
            padding: 3px;
        }

            table[id*='GridView'] tbody tr td p {
                margin: 0;
            }
    </style>
    <div style="margin-left: 10px;">
	<h3 style="text-align:center; color: #D71E2F; font-weight: 400; 

margin:10px 5px; padding: 10px; background-color: #D71e2f; color: #ffffff;"><i 

class="icon-home"></i> Dashboard</h3>
	<div class="col" id="col1">
        <div class="dragbox" id="item1" >
			<h2><i class="icon-group"></i> My Meetings</h2>
			<div class="dragbox-content" >
                 <div style="width: 100%;">    

                     <asp:ObjectDataSource ID="meetingsObjectDataSource" runat="server" SelectMethod="GetMyMeetings" TypeName="C3App.BLL.MeetingBL">
                         <SelectParameters>
                             <asp:SessionParameter SessionField="UserID" Name="inviteeID" Type="Int64"></asp:SessionParameter>
                         </SelectParameters>
                     </asp:ObjectDataSource>

                     <asp:GridView ID="meetingsGridView" runat="server" AutoGenerateColumns="False" DataSourceID="meetingsObjectDataSource" AllowPaging="True"  GridLines="None" PageSize="2" >
                         <Columns>
                             <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject"></asp:BoundField>
                             <asp:BoundField DataField="Location" HeaderText="Location" SortExpression="Location"></asp:BoundField>
                             <asp:TemplateField HeaderText="StartDate" SortExpression="StartDate">
                                 <ItemTemplate>
                                     <asp:Label runat="server" Text='<%# Bind("StartDate", "{0:MMMM dd,yyyy (hh:mm:ss tt)}") %>' ID="Label1"></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>

                             <asp:TemplateField HeaderText="EndDate" SortExpression="EndDate">
                                 <ItemTemplate>
                                     <asp:Label runat="server" Text='<%# Bind("EndDate", "{0:MMMM dd,yyyy (hh:mm:ss tt)}") %>' ID="Label1"></asp:Label>
                                 </ItemTemplate>
                             </asp:TemplateField>

                         </Columns>
                     </asp:GridView>
                 </div>
            </div>
		</div>

		<div class="dragbox" id="item2" >
			<h2><i class="icon-folder-open"></i> My Accounts</h2>
            <div class="dragbox-content">
                <div style="width: 100%;">
                    <asp:ObjectDataSource ID="AccountsObjectDataSource"
                        runat="server" SelectMethod="GetAccountsByAssignedUserID"
                        TypeName="C3App.BLL.AccountBL">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="UserID"
                                Name="assigneduserid" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:GridView ID="AccountsGridView" runat="server"
                        AutoGenerateColumns="False"
                        DataSourceID="AccountsObjectDataSource" >
                
                        <EmptyDataTemplate>
                            <p>
                                No Data Found.
                            </p>
                        </EmptyDataTemplate>
                        <Columns>

                            <asp:BoundField DataField="Name" HeaderText="Name"
                                SortExpression="Name"></asp:BoundField>
                            <asp:BoundField DataField="OfficePhone"
                                HeaderText="Phone" SortExpression="OfficePhone"></asp:BoundField>
                            <asp:TemplateField HeaderText="Date Entered" SortExpression="CreatedTime">
                                <ItemTemplate>
                                    <asp:Label runat="server"  Text='<%# Bind("CreatedTime", "{0:MMMM dd,yyyy (hh:mm:ss tt)}") %>'  ID="Label1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
		</div>
        <div class="dragbox" id="item3">
			<h2><i class="icon-random"></i> My Leads</h2>
            <div class="dragbox-content">
                <div style="width: 100%;">
                    <asp:ObjectDataSource ID="LeadsObjectDataSource"
                        runat="server" SelectMethod="GetLeadsByAssignedUserID"
                        TypeName="C3App.BLL.LeadBL">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="UserID"
                                Name="assigneduserid" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:GridView ID="LeadsGridView" runat="server"
                        AutoGenerateColumns="False" DataSourceID="LeadsObjectDataSource"  >
                        <EmptyDataTemplate>
                            <p>
                                No Data Found.
                            </p>
                        </EmptyDataTemplate>
                        <Columns>

                            <asp:BoundField DataField="FirstName"
                                HeaderText="FirstName" SortExpression="FirstName"></asp:BoundField>
                            <asp:BoundField DataField="LastName"
                                HeaderText="LastName" SortExpression="LastName"></asp:BoundField>
                            <asp:BoundField DataField="PhoneMobile"
                                HeaderText="Mobile" SortExpression="PhoneMobile"></asp:BoundField>
                            <asp:TemplateField HeaderText="Date Entered" SortExpression="CreatedTime">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("CreatedTime", "{0:MMMM dd,yyyy (hh:mm:ss tt)}") %>' ID="Label1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            

                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
	</div>
	<div class="col" id="col2"  >
        <div class="dragbox" id="item4">
            <h2><i class="icon-briefcase"></i> My Top Opportunities</h2>
            <div class="dragbox-content">
                <div style="width: 100%;">

                    <asp:ObjectDataSource ID="OpportunityObjectDataSource"
                        runat="server" SelectMethod="GetOppotunitiesByAssignedUserID"
                        TypeName="C3App.BLL.OpportunityBL">
                        <SelectParameters>
                            <asp:SessionParameter SessionField="UserID"
                                Name="assigneduserid" Type="Int64"></asp:SessionParameter>
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:GridView ID="OpportunityGridView" runat="server"
                        AutoGenerateColumns="False" DataSourceID="OpportunityObjectDataSource" AllowPaging="True" GridLines="None" PageSize="1" >
                        <EmptyDataTemplate>
                            <p>
                                No Data Found.
                            </p>
                        </EmptyDataTemplate>
                        <Columns>
                            <asp:BoundField DataField="Name" HeaderText="Name"
                                SortExpression="Name"></asp:BoundField>
                            <asp:BoundField DataField="Amount"
                                HeaderText="Amount" SortExpression="Amount"></asp:BoundField>
                            <asp:TemplateField HeaderText="Date closed" SortExpression="DateEnclosed">
                                <ItemTemplate>
                                    <asp:Label runat="server" Text='<%# Bind("DateEnclosed", "{0:MMMM dd,yyyy (hh:mm:ss tt)}") %>' ID="Label1"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                </div>
            </div>
        </div>
		<div class="dragbox" id="item5" >
			<h2><i class="icon-sitemap"></i> PipeLines</h2>
			<div class="dragbox-content" >
               No Data Found
            </div>
		</div>
        <div class="dragbox" id="item6">
            <h2><i class="icon-calendar"></i> My Tasks</h2>
            <div class="dragbox-content">
               <div style="width: 100%;">
                   <asp:ObjectDataSource ID="TaskObjectDataSource" runat="server" SelectMethod="GetTaskByAssignedUser" TypeName="C3App.BLL.TaskBL"></asp:ObjectDataSource>

                   <asp:GridView ID="TaskGridView" runat="server" AutoGenerateColumns="False" DataSourceID="TaskObjectDataSource" AllowPaging="True" GridLines="None" PageSize="2">
                       <EmptyDataTemplate>
                           <p>
                               No Data Found.
                           </p>
                       </EmptyDataTemplate>
                       <Columns>
                           <asp:BoundField DataField="Subject" HeaderText="Subject" SortExpression="Subject"></asp:BoundField>
                           <asp:BoundField DataField="Priority" HeaderText="Priority" SortExpression="Priority"></asp:BoundField>
                           <asp:TemplateField HeaderText="StartDate" SortExpression="StartDate">
                               <ItemTemplate>
                                   <asp:Label runat="server" Text='<%# Bind("StartDate", "{0:MMMM dd,yyyy}") %>' ID="Label1"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="DueDate" SortExpression="DueDate">
                               <ItemTemplate>
                                   <asp:Label runat="server" Text='<%# Bind("DueDate", "{0:MMMM dd,yyyy}") %>' ID="Label2"></asp:Label>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:BoundField DataField="ParentType" HeaderText="Type" SortExpression="ParentType"></asp:BoundField>
                       </Columns>
                   </asp:GridView>

                </div>
            </div>
        </div>
	</div>
</div>

</asp:Content>
