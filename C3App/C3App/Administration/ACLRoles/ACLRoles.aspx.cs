using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;
using System.Text;
using System.Web.Services;
using C3App.App_Code;



namespace C3App.Administration.ACLRoles
{
    public partial class ACLRoles : System.Web.UI.Page
    {
        

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Request.QueryString["ShowPanel"] != null)
            {
                if ((!IsPostBack))
                {
                    Session.Remove("EditRoleID");
                }
            }

            int roleid = Convert.ToInt32(Session["EditRoleID"]);

            if (roleid == 0)
            {
                RoleEditButton.Visible = false;
                ModalPopButton2.Visible = false;
                DeleteLinkButton.Visible = false;

                this.ACLRolesGridView.DataBind();
                this.ACLRolesGridView.SelectedIndex = -1;
                this.MiniRoleFormView.DataBind();
                this.SelectedRolesGridView.DataBind();
                upListView.Update();
                miniDetails.Update();
            }
            else if (roleid > 0)
            {
                
                string name = "";
                ACLRoleBL aclroleBL = new ACLRoleBL();
                name = aclroleBL.SearchRoleNameByID(roleid);
                if (name == "Administrator" || name == "Admin")
                {
                    RoleEditButton.Visible = false;
                    ModalPopButton2.Visible = true;
                    DeleteLinkButton.Visible = false;
                }
                else
                {
                    RoleEditButton.Visible = true;
                    ModalPopButton2.Visible = true;
                    DeleteLinkButton.Visible = true;
                }

              
            }
            
        }

        public void Page_Error(object sender, EventArgs e)
        {
            // Get last error from the server
            Exception exc = Server.GetLastError();

            //Development phase error messages
            Response.Write("<h2>Something wrong happend!</h2>");
            Response.Write("<b>Exception Type: </b>" + exc.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Exception: </b>" + exc.Message.ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception Type: </b>" + exc.InnerException.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception: </b>" + exc.InnerException.Message + "<br/><br/>");
            Response.Write("<b>Inner Source: </b>" + exc.InnerException.Source + "<br/><br/>");
            //Response.Write("<b>Stack Trace: </b>" + exc.StackTrace.ToString());

            //Log the exception and notify system operators
            ExceptionUtility.LogException(exc, "ACLRolesPage");
            ExceptionUtility.NotifySystemOps(exc, "ACLRolesPage");

            //Clear the error from the server
            Server.ClearError();
        }

        public string CreateACLActionTable()
        {
            string message = "";

            if (Session["UserID"] != null)
            {

                StringBuilder sb = new StringBuilder();
                ACLRoleBL aclRoleBL = new ACLRoleBL();

                int qroleid = Convert.ToInt32(Session["EditRoleID"]);

                // string name = aclRoleBL.SearchRoleNameByID(qroleid);
                // string des = aclRoleBL.SearchRoleDesByID(qroleid);



                //HiddenField1.Value = name + ":" + des;

                //TextBox txtRoleName = (TextBox)aclAction.FindControl("RoleNameTextBox");
                //TextBox txtDes = (TextBox)aclAction.FindControl("DescriptionTextBox");

                //txtRoleName.Text = name;
                //DescriptionTextBox.Text = des;

                //sb.Append("<table><tr><td>");
                //sb.Append("Role Name");
                //sb.Append("</td><td>");
                //sb.Append("<input id='NameTextBox' type='text' onclick='rolename(this);' value='").Append(name).Append("' />");

                //sb.Append("</td></tr>");
                //sb.Append("<tr><td>");
                //sb.Append("Description");
                //sb.Append("</td><td>");
                //sb.Append("<input id='DesTextBox' type='text' onclick='roledes(this);' value='").Append(des).Append("' />");
                //sb.Append("</td></tr></table>");




                sb.Append("<table><tr><td><b>Modules</b></td>");

                IEnumerable<ACLFunction> functionList;
                IEnumerable<CompanyModule> moduleList;


                functionList = aclRoleBL.GetFunctionList();
                moduleList = aclRoleBL.GetModuleListByCompanyID();
                int listCount = functionList.Count();
                int moduleCount = moduleList.Count();
                string check = "checked";
                string functionName;
                string moduleName;
                int moduleId;
                int functionId;
                string accessid;
                int a;

                for (a = 0; a < listCount; a++)
                {
                    functionName = functionList.ElementAt(a).FunctionName;
                    functionId = functionList.ElementAt(a).FunctionID;

                    sb.Append("<td><b>").Append(functionName).Append("</b></td>");

                }

                sb.Append("</tr>");

                //string acess = "";
                string allchk = "";

                for (int j = 0; j < moduleCount; j++)
                {
                    moduleId = moduleList.ElementAt(j).ModuleID;
                    moduleName = aclRoleBL.GetModuleNameByID(moduleId);

                    sb.Append("<tr>");
                    sb.Append("<td>").Append(moduleName).Append("</td>");


                    for (int i = 0; i < listCount; i++)
                    {
                        functionName = functionList.ElementAt(i).FunctionName;
                        functionId = functionList.ElementAt(i).FunctionID;
                        string dropdownid = moduleId + ":" + functionId;
                        check = "checked";


                        accessid = aclRoleBL.SearchACLActionAccessID(qroleid, moduleId, functionId);

                        //acess += accessid ;
                        //Label6.Text = "access id id " + acess  ;


                        if (qroleid > 0 && accessid != "-1")
                        {

                            if (accessid == "1") { check = "checked"; allchk += moduleId + ":" + functionId + "#"; }
                            else if (accessid == "0") { check = ""; }
                            else if (accessid == "n/a") { check = ""; }
                        }
                        else if (qroleid == 0)
                        {
                            check = "checked";
                            allchk = "new";
                        }

                        sb.Append("<td>");
                        sb.Append("<input id='").Append(dropdownid).Append("' type='checkbox'").Append(check).Append(" onclick='clickMethod(this);' value='").Append(dropdownid).Append("' />");

                    }

                    sb.Append("</td></tr>");

                }

                //sb.Append("<tr><td>");
                //sb.Append("<input runat=server type=button value='Save' onClick='HandleIT(); return false;' />");
                //sb.Append("</td></tr>");
                sb.Append("</table>");
                return sb.ToString();
            }

            else
            {
                
                Response.Redirect("~/UserLogin.aspx");
                return message;
            }


        }


        [WebMethod]
        public static string ProcessIT(string value,string newval,string delval)
        {
            ACLRoleBL aclRoleBL = new ACLRoleBL();
            string result = "Welcome Mr. " + value;
            string sroleid = Convert.ToString(HttpContext.Current.Session["EditRoleID"]);
            int qroleid = Convert.ToInt32(HttpContext.Current.Session["EditRoleID"]);
            string test = "";
            string access = "0";

            //string s = "123";
            //int byParsing = int.Parse(s);
            //int re;
            //int.TryParse(s, out re);
       

            // *********** Insert ACL Action and Role //

 

            string[] roles = { "" };
            roles = value.Split(':');
            string rolename = "";
            string description = "";
            int roleid = 0;
             rolename = roles[0];
             description = roles[1];
            
            if(rolename != "")
            {

                if (qroleid == 0 )
                {
                    roleid = aclRoleBL.InsertRole(rolename,description);
                    aclRoleBL.InsertACLAction(roleid,0);

                    qroleid = roleid;
                }


               //************Edit Role ***********************//

                    else if (qroleid > 0)
                    {
                        aclRoleBL.EditRole(rolename, description, qroleid);
                    }
  
              // *********** Edit ACL Action True ************* //
            
                    string aid = newval.TrimEnd('#');
                    string[] mid = { "" };
                    mid = aid.Split('#');
                    int moduleId = 0;
                    int functionId = 0;
                    Int64 re = 0;
           
                    if (newval != string.Empty)
                    {
                        for (int x = 0; x < mid.Length; x++)
                        {
                            string[] fid = { "" };
                            fid = mid[x].Split(':');

                            moduleId = int.Parse(fid[0]);
                            functionId = int.Parse(fid[1]);
                            access = "1";
                            //test += fid[0] + fid[1] + "#";
                            re = aclRoleBL.EditACLAction(moduleId, functionId, access, qroleid);


                        }
                    }

                //********* Edit ACL Action False ********************//

                    string did = delval.TrimEnd('#');
                    string[] tid = { "" };
                    tid = did.Split('#');
                    int delmodule = 0;
                    int delfunction = 0;
                    Int64 rep = 0;
                    //string tested = "";
                    if(delval != string.Empty)
                    {
                            for (int x = 0; x < tid.Length; x++)
                            {
                                string[] gid = { "" };
                                gid = tid[x].Split(':');

                                delmodule = int.Parse(gid[0]);
                                delfunction = int.Parse(gid[1]);
                                access = "0";
                                // tested += gid[0] + gid[1] + "#";
                                rep = aclRoleBL.EditACLAction(delmodule, delfunction, access, qroleid);
                            }
                    }
            
    
        

            test += "value" + value + " delval" + delval + " newval" + newval + "roleid" + qroleid + "re" + re + "rep"+ rep + "roles" + roleid ;


        }

            test = "RoleName Field can not be Empty!!";

          
           HttpContext.Current.Session["EditRoleID"] = 0;

            return test;


        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
         
        }

        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            Session["EditRoleID"] = e.CommandArgument.ToString();
            miniDetails.Update();

            int roleid = Convert.ToInt32(Session["EditRoleID"]);
            string name = "";
            ACLRoleBL aclroleBL = new ACLRoleBL();
            name = aclroleBL.SearchRoleNameByID(roleid);

            if (name == "Administrator" || name == "Admin")
            {
                RoleEditButton.Visible = false;
                ModalPopButton2.Visible = true;
                DeleteLinkButton.Visible = false;
            }
            else
            {
                RoleEditButton.Visible = true;
                ModalPopButton2.Visible = true;
                DeleteLinkButton.Visible = true;
            }

            int gindex = Convert.ToInt32(ACLRolesGridView.SelectedIndex);
            if (gindex > -1)
            {

                LinkButton nlbtn = ACLRolesGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                nlbtn.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            lbtn.CssClass = "active"; 
        }

        protected void RoleEditButton_Click(object sender, EventArgs e)
        {
            RoleInsertButton.Text = "Role Details";
            //HiddenField1.Value = Session["EditRoleID"].ToString();
            ACLRoleBL aclRoleBL = new ACLRoleBL();
            int qroleid = Convert.ToInt32(Session["EditRoleID"]);
            string name = aclRoleBL.SearchRoleNameByID(qroleid);
            string des = aclRoleBL.SearchRoleDesByID(qroleid);
            TextBox txtRoleName = (TextBox)aclAction.FindControl("RoleNameTextBox");
            TextBox txtDes = (TextBox)aclAction.FindControl("DescriptionTextBox");
            txtRoleName.Text = name;
            DescriptionTextBox.Text = des;
          
        }

        protected void RoleInsertButton_Click(object sender, EventArgs e)
        {

            Session["EditRoleID"] = 0;
            TextBox txtRoleName = (TextBox)aclAction.FindControl("RoleNameTextBox");
            TextBox txtDes = (TextBox)aclAction.FindControl("DescriptionTextBox");
            txtRoleName.Text = "";
            DescriptionTextBox.Text = "";

        }

        protected void RoleDeleteButton_Click(object sender, EventArgs e)
        {
            ACLRoleBL aclRoleBL = new ACLRoleBL();
            int roleid = Convert.ToInt32(Session["EditRoleID"]);
            aclRoleBL.DeactivateRole(roleid);
            Session["EditRoleID"] = 0;
            this.ACLRolesGridView.DataBind();
            this.ACLRolesGridView.SelectedIndex = -1;
            this.MiniRoleFormView.DataBind();
            upListView.Update();
            miniDetails.Update();
            RoleEditButton.Visible = false;
            ModalPopButton2.Visible = false;
            DeleteLinkButton.Visible = false;
        }

        protected void LinkButtonUpdate_Click(object sender, EventArgs e)
        {
            this.ACLRolesGridView.DataBind();
            this.upListView.Update();
            this.MiniRoleFormView.DataBind();
            this.miniDetails.Update();

            Session["EditRoleID"] = 0;
            TextBox txtRoleName = (TextBox)aclAction.FindControl("RoleNameTextBox");
            TextBox txtDes = (TextBox)aclAction.FindControl("DescriptionTextBox");
            txtRoleName.Text = "";
            DescriptionTextBox.Text = "";
            aclAction.DataBind();
            UpdatePanel1.Update();
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(1,'Create Role');", true);

        }

        protected void SelectLinkButton1_Command(object sender, CommandEventArgs e)
        {
            foreach (GridViewRow gvrow in RoleMemberGridView.Rows)
            {
                Int64 userid = Convert.ToInt64(e.CommandArgument.ToString());
                CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkdelete");
                if (userid == Convert.ToInt64(RoleMemberGridView.DataKeys[gvrow.RowIndex].Value))
                {
                    chkdelete.Checked = true;

                }

            }

        }

        protected void SaveUser_Click(object sender, EventArgs e)
        {
            ACLRoleBL aclroleBL = new ACLRoleBL();
            int roleid = Convert.ToInt32(Session["EditRoleID"]);

            foreach (GridViewRow gvrow in RoleMemberGridView.Rows)
            {

                CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkdelete");
                if (chkdelete.Checked)
                {
                    
                    Int64 userid = Convert.ToInt64(RoleMemberGridView.DataKeys[gvrow.RowIndex].Value);

                    //Label6.Text = userid + "," + roleid;

                    aclroleBL.UsersSetRoleID(userid, roleid);

                }
            }

            this.ACLRolesGridView.DataBind();
            this.MiniRoleFormView.DataBind();
            this.SelectedRolesGridView.DataBind();
            this.RoleMemberGridView.DataBind();
            upListView.Update();
            miniDetails.Update();
        }

        protected void Cancel_Click(object sender, EventArgs e)
        {
            Session["EditRoleID"] = 0;
            TextBox txtRoleName = (TextBox)aclAction.FindControl("RoleNameTextBox");
            TextBox txtDes = (TextBox)aclAction.FindControl("DescriptionTextBox");
            txtRoleName.Text = "";
            DescriptionTextBox.Text = "";
            aclAction.DataBind();
            UpdatePanel1.Update();
            //Literal1.Text = "Submission cancelled <br/> <p>Your changes have been discarded</p>";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#myModal').reveal();", true);
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            ACLRolesGridView.DataSourceID = SearchObjectDataSource.ID;
            ACLRolesGridView.DataBind();
            upListView.Update();
        }

        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            ACLRolesGridView.DataSourceID = ACLRolesObjectDataSource.ID;
            ACLRolesGridView.DataBind();
            upListView.Update();
        }

      
    
    }
}