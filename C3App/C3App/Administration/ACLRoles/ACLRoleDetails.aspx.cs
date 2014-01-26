using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;

namespace C3App.Administration.ACLRoles
{
    public partial class ACLRoleDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //int qroleid = Convert.ToInt32(Request.QueryString["RoleID"].ToString());



            //ACLRoleBL objUserBL = new ACLRoleBL();

            //Table tbldynamicrole = new Table();

            //TableRow trole = new TableRow();
            //TableCell tcrole = new TableCell();
            //TableCell tc1role = new TableCell();

            //Label lblRoleName = new Label();
            //lblRoleName.ID = "lblRoleName";
            //lblRoleName.Text = "Role Name";
            //tcrole.Controls.Add(lblRoleName);
            //trole.Cells.Add(tcrole);


            //TextBox txtRoleName = new TextBox();
            //txtRoleName.ID = "txtRoleName";

            //if (qroleid > 0)
            //{
            //    //roleid = objUserBL.SearchRoleNameByID(roleid, companyid);
            //    txtRoleName.Text = objUserBL.SearchRoleNameByID(qroleid);
            //}
            //else
            //{
            //    txtRoleName.Text = "";
            //}

            //tc1role.Controls.Add(txtRoleName);
            //trole.Cells.Add(tc1role);

            //tbldynamicrole.Rows.Add(trole);


            //TableCell tcdes = new TableCell();
            //TableCell tc1des = new TableCell();
            //TableRow trdes = new TableRow();
            //Label lblDes = new Label();
            //lblDes.ID = "lblDes";
            //lblDes.Text = "Description";
            //tcdes.Controls.Add(lblDes);
            //TextBox txtDes = new TextBox();
            //txtDes.ID = "txtDes";
            //if (qroleid > 0)
            //{
            //    //roleid = objUserBL.SearchRoleDesByID(roleid, companyid);
            //    txtDes.Text = objUserBL.SearchRoleDesByID(qroleid);
            //}
            //else
            //{
            //    txtDes.Text = "";
            //}

            //tc1des.Controls.Add(txtDes);
            //trdes.Cells.Add(tcdes);
            //trdes.Cells.Add(tc1des);
            //tbldynamicrole.Rows.Add(trdes);


            //aclAction.Controls.Add(tbldynamicrole);


            //Table tbldynamic = new Table();
            //TableRow tr = new TableRow();
            //TableCell tc = new TableCell();
            //Label lblName = new Label();
            //lblName.ID = "lblName";
            //lblName.Text = "Modules";
            //tc.Controls.Add(lblName);
            //tr.Cells.Add(tc);


            //IEnumerable<ACLFunction> functionList;
            //IEnumerable<CompanyModule> moduleList;


            //functionList = objUserBL.GetFunctionList();
            //moduleList = objUserBL.GetModuleListByCompanyID();
            //int listCount = functionList.Count();
            //int moduleCount = moduleList.Count();
            //string functionName;
            //string moduleName;
            //int moduleId;
            //int functionId;
            //string accessid;
            //string accessvalue = "No";
            //int a;

            //for (a = 0; a < listCount; a++)
            //{
            //    TableCell tc3 = new TableCell();
            //    functionName = functionList.ElementAt(a).FunctionName;
            //    functionId = functionList.ElementAt(a).FunctionID;
            //    Label lblFunctionName = new Label();
            //    lblFunctionName.ID = functionId + functionName + a;

            //    // Response.Write("welcome " + lblFunctionName.ID + "<br>");

            //    lblFunctionName.Text = functionName;
            //    tc3.Controls.Add(lblFunctionName);
            //    tr.Cells.Add(tc3);
            //}

            //tbldynamic.Rows.Add(tr);


            //for (int j = 0; j < moduleCount; j++)
            //{
            //    TableRow trn = new TableRow();
            //    TableCell tcn = new TableCell();
            //    Label lblmoduleName = new Label();

            //    moduleName = moduleList.ElementAt(j).ModuleName;
            //    moduleId = moduleList.ElementAt(j).ModuleID;
            //    // Response.Write("welcome"+ moduleName);

            //    lblmoduleName.ID = moduleId + moduleName;
            //    lblmoduleName.Text = moduleName;
            //    tcn.Controls.Add(lblmoduleName);
            //    trn.Cells.Add(tcn);

            //    for (int i = 0; i < listCount; i++)
            //    {
            //        TableCell tc2 = new TableCell();
            //        functionName = functionList.ElementAt(i).FunctionName;
            //        functionId = functionList.ElementAt(i).FunctionID;

            //        DropDownList ddl = new DropDownList();
            //        //ddl.Width = 100;
            //        //ddl.Height = 25;
            //        ddl.ID = moduleId + functionName;

            //        //ddl.Items.Add("Yes");
            //        //ddl.Items.Add("No");

            //        accessid = objUserBL.SearchACLActionAccessID(qroleid, moduleId, functionId);

            //        if (qroleid > 0 && accessid != "-1")
            //        {

            //            if (accessid == "1") { accessvalue = "Yes"; } else if (accessid == "0") { accessvalue = "No"; }
            //            ddl.Items.Add(new ListItem(accessvalue, accessid));
            //            if (accessid != "1")
            //                ddl.Items.Add(new ListItem("Yes", "1"));
            //            if (accessid != "0")
            //                ddl.Items.Add(new ListItem("No", "0"));
            //        }
            //        else
            //        {
            //            ddl.Items.Add(new ListItem("Yes", "1"));
            //            ddl.Items.Add(new ListItem("No", "0"));
            //        }




            //        // TextBox txtName = new TextBox();
            //        // txtName.ID = moduleId + functionName;

            //        // Response.Write("welcome" + txtName.ID);

            //        tc2.Controls.Add(ddl);
            //        trn.Cells.Add(tc2);
            //    }

            //    tbldynamic.Rows.Add(trn);

            //}

            //TableCell tc1 = new TableCell();
            //TableCell tcb = new TableCell();
            //TableCell tcb1 = new TableCell();
            //TableRow trb = new TableRow();


            //Button btnSubmit = new Button();
            //btnSubmit.ID = "btnSubmit";
            //btnSubmit.Text = "Submit";
            //btnSubmit.Click += new System.EventHandler(btnSubmit_click);
            //tcb.Controls.Add(btnSubmit);
            //trb.Cells.Add(tcb);


            //Button btnCancel = new Button();
            //btnCancel.ID = "btnCancel";
            //btnCancel.Text = "Cancel";
            //btnCancel.Click += new System.EventHandler(btnCancel_click);
            //tcb1.Controls.Add(btnCancel);
            //trb.Cells.Add(tcb1);


            //tbldynamic.Rows.Add(trb);

            //aclAction.Controls.Add(tbldynamic);


        }


        protected void btnSubmit_click(object sender, EventArgs e)
        {


            //int qroleid = Convert.ToInt32(Request.QueryString["RoleID"].ToString());



            //IEnumerable<ACLFunction> functionList;
            //IEnumerable<CompanyModule> moduleList;

            //ACLRoleBL objUserBL = new ACLRoleBL();
            //functionList = objUserBL.GetFunctionList();
            //moduleList = objUserBL.GetModuleListByCompanyID();
            //int listCount = functionList.Count();
            //int moduleCount = moduleList.Count();
            //string functionName;
            //string moduleName;
            //int moduleId;
            //int functionId;
            //int roleid;

            //TextBox txtRoleName = (TextBox)aclAction.FindControl("txtRoleName");
            //TextBox txtDes = (TextBox)aclAction.FindControl("txtDes");


            //Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            //roleid = objUserBL.SearchRoleID(txtRoleName.Text, companyid);

            //// Response.Write("hi" + roleid + companyid + qroleid);
            //// Response.Write("UserName: " + txtRoleName.Text + "; " + "Email: " + txtDes.Text);

            //if (roleid < 0 && companyid > 0 && qroleid == 0)
            //{
            //    //Response.Write("hi" + roleid + companyid + qroleid);

            //    objUserBL.InsertRole(txtRoleName.Text, txtDes.Text);
            //    roleid = objUserBL.SearchRoleID(txtRoleName.Text, companyid);

            //    for (int j = 0; j < moduleCount; j++)
            //    {
            //        moduleName = moduleList.ElementAt(j).ModuleName;
            //        moduleId = moduleList.ElementAt(j).ModuleID;

            //        //  Response.Write("welcome" + moduleId);

            //        for (int i = 0; i < listCount; i++)
            //        {

            //            functionName = functionList.ElementAt(i).FunctionName;
            //            functionId = functionList.ElementAt(i).FunctionID;

            //            var txtname = moduleId + functionName;
            //            //  Response.Write("<br>");
            //            //  Response.Write("welcome " + txtname);


            //            DropDownList txtUserName = (DropDownList)aclAction.FindControl(txtname);

            //            //  Response.Write("  value " + txtUserName.Text);

            //            // Response.Write("<br>");

            //            string access = txtUserName.SelectedValue;


            //            objUserBL.InsertACLAction(moduleId, functionId, access, roleid);


            //        }

            //    }

            //    Response.Redirect("ACLRoleList.aspx");

            //}
            //else if (qroleid > 0)
            //{

            //    objUserBL.EditRole(txtRoleName.Text, txtDes.Text, qroleid);
            //    // roleid = objUserBL.SearchRoleID(txtRoleName.Text, companyid);

            //    for (int j = 0; j < moduleCount; j++)
            //    {
            //        moduleName = moduleList.ElementAt(j).ModuleName;
            //        moduleId = moduleList.ElementAt(j).ModuleID;

            //        //  Response.Write("welcome" + moduleId);

            //        for (int i = 0; i < listCount; i++)
            //        {

            //            functionName = functionList.ElementAt(i).FunctionName;
            //            functionId = functionList.ElementAt(i).FunctionID;

            //            var txtname = moduleId + functionName;
            //            //  Response.Write("<br>");
            //            //  Response.Write("welcome " + txtname);


            //            DropDownList txtUserName = (DropDownList)aclAction.FindControl(txtname);

            //            //  Response.Write("  value " + txtUserName.Text);

            //            // Response.Write("<br>");

            //            string access = txtUserName.SelectedValue;


            //            objUserBL.EditACLAction(moduleId, functionId, access, qroleid);


            //        }

            //    }

            //    Response.Redirect("ACLRoleList.aspx");



            //    // Response.Write("Invalid Role Entry");
            //    //ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('Invalid Role Entry')</script>");

            //}

            //else
            //{
            //    Response.Write("Invalid Role Entry");
            //    ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('Invalid Role Entry')</script>");

            //}


        }

        protected void btnCancel_click(object sender, EventArgs e)
        {
            Response.Redirect("ACLRoleList.aspx");
        }



    }
}