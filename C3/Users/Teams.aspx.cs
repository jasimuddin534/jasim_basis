using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;
using C3App.App_Code;

namespace C3App.Users
{
    public partial class Teams : PageBase 
    {
        private DropDownList teamSetDropDownList;


        protected void Page_Init(object sender, EventArgs e)
        {
            TeamsDetailsView.EnableDynamicData(typeof(Team));
        }


        protected void TeamSetDropDownList_Init(object sender, EventArgs e)
        {

            teamSetDropDownList = sender as DropDownList;

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
            ExceptionUtility.LogException(exc, "TeamsPage");
            ExceptionUtility.NotifySystemOps(exc, "TeamsPage");

            //Clear the error from the server
            Server.ClearError();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
           
            try
            {

                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        Session.Remove("EditTeamID");
                    }
                }
                //if (Session["EditTeamID"] != null)
                //{
                    Int64 teamid = Convert.ToInt64(Session["EditTeamID"]);

                    if (teamid == 0)
                    {

                        TeamsDetailsView.ChangeMode(DetailsViewMode.Insert);
                        //TeamsDetailsView.AutoGenerateInsertButton = true;
                        EditLinkButton.Visible = false;
                        ModalPopButton2.Visible = false;
                        DeleteLinkButton.Visible = false;

                        this.TeamsGridView.DataBind();
                        this.TeamsGridView.SelectedIndex = -1;
                        this.MiniTeamFormView.DataBind();
                        this.SelectedTeamGridView.DataBind();
                        upListView.Update();
                        miniDetails.Update();
                    }
                    else if (teamid > 0)
                    {
                        TeamsDetailsView.ChangeMode(DetailsViewMode.Edit);

                    }
                //}
                //else
                //{
                //    TeamsDetailsView.ChangeMode(DetailsViewMode.Insert);
                //    //TeamsDetailsView.AutoGenerateInsertButton = true;
                //}
            }
            catch (Exception ex)
            {
                throw ex;
            } 
        }


        protected void TeamsDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            int companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            Int64 userid = Convert.ToInt64(HttpContext.Current.Session["UserID"]);
            int teamsetid = Convert.ToInt32(HttpContext.Current.Session["EditTeamSetID"]);
            e.Values["CreatedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["CompanyID"] = companyid;
            e.Values["TeamSetID"] = teamsetid;

        }

        protected void TeamsDetailsView_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            this.TeamsGridView.DataBind();
            this.MiniTeamFormView.DataBind();
            this.SelectedTeamGridView.DataBind();
            upListView.Update();
            miniDetails.Update();

        
            Int64 id = 0;
            string value = Convert.ToString(Session["NewTeam"]);
            if (value != "")
            id = int.Parse(value);


            if (id > 0)
            {
                Literal1.Text = "Success !</br></br> <p>Team information has been saved successfully</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#BodyContent_myModal').reveal();", true);
                Session["EditTeamID"] = 0;
                TeamsDetailsView.DataBind();

            }
            else
            {
                Literal1.Text = "Error !</br></br> <p>Team information did not save.</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#BodyContent_myModal').reveal();", true);
                Session["EditTeamID"] = 0;
                TeamsDetailsView.DataBind();
           
            }

        }

        protected void TeamsDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            Int64 userid = Convert.ToInt32(HttpContext.Current.Session["UserID"]);
            int teamsetid = Convert.ToInt32(HttpContext.Current.Session["EditTeamSetID"]);
            
            e.NewValues["ModifiedBy"] = userid;
            e.NewValues["ModifiedTime"] = DateTime.Now;
            e.NewValues["TeamSetID"] = teamsetid;

           Int64 teamid = Convert.ToInt64(Session["EditTeamID"]);
           TeamBL teamBL = new TeamBL();
           teamBL.SetTeamSetIDinUsers(teamid, teamsetid);

           
        }

        protected void TeamsDetailsView_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
  
            this.TeamsGridView.DataBind();
            this.MiniTeamFormView.DataBind();
            this.SelectedTeamGridView.DataBind();
            upListView.Update();
            miniDetails.Update();


            Int64 id = 0;
            string value = Convert.ToString(Session["UpdateTeam"]);
            if (value != "")
            id = int.Parse(value);

            if (id > 0)
            {
                Literal1.Text = "Success !</br></br> <p>Team information has been updated successfully</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#BodyContent_myModal').reveal();", true);
                Session["EditTeamID"] = 0;
                TeamsDetailsView.DataBind();
            }
            else
            {
                Literal1.Text = "Error !</br></br> <p>Team information did not save.</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#BodyContent_myModal').reveal();", true);
                Session["EditTeamID"] = 0;
                TeamsDetailsView.DataBind();
            }
        }

        protected void TeamsDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                TeamsDetailsView.ChangeMode(DetailsViewMode.Edit);
            }

            if (e.CommandName == "Update")
            {
                TeamsDetailsView.ChangeMode(DetailsViewMode.Edit);
            }

            if (e.CommandName == "Cancel")
            {

               Session["EditTeamID"] = 0;
               Session["EditTeamSetID"] = 0;
               TeamsDetailsView.DataBind();
               Literal1.Text = "Submission cancelled <br/> <p>Your changes have been discarded</p>";
               ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "$('#BodyContent_myModal').reveal();", true);
           
            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
        }


        protected void TeamInsertButton_Click(object sender, EventArgs e)
        {
        
            Session["EditTeamID"] = 0;
            TeamsDetailsView.ChangeMode(DetailsViewMode.Insert);
            //TeamsDetailsView.AutoGenerateInsertButton = true;
        }

        protected void EditLinkButton_Click(object sender, EventArgs e)
        {
           
            TeamInsertButton.Text = "Team Details";
            TeamsDetailsView.ChangeMode(DetailsViewMode.Edit);
          //  TeamsDetailsView.AutoGenerateEditButton = true;

        }

        protected void SelectMembers_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            Session["EditTeamID"] = btn.CommandArgument.ToString();
        }

 
        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            string value = e.CommandArgument.ToString();
            string[] all = { "" };
            all = value.Split(':');
            Session["EditTeamID"] = all[0];
            Session["EditTeamSetID"] = all[1];

            long teamid = Convert.ToInt64(Session["EditTeamID"]);
            string name = "";
            TeamBL teamBL = new TeamBL();
            var team = teamBL.GetTeamsByID(teamid);
            name = team.ElementAt(0).Name;

            if (name == "Global")
            {
                EditLinkButton.Visible = false;
                ModalPopButton2.Visible = true;
                DeleteLinkButton.Visible = false;
            }
            else
            {
                EditLinkButton.Visible = true;
                ModalPopButton2.Visible = true;
                DeleteLinkButton.Visible = true;
            }


            int gindex = Convert.ToInt32(TeamsGridView.SelectedIndex);
            if (gindex > -1)
            {

                LinkButton nlbtn = TeamsGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                nlbtn.CssClass = "";
            }
            LinkButton lbtn = sender as LinkButton;
            lbtn.CssClass = "active";
            miniDetails.Update();
        }



        protected void Save_Click(object sender, EventArgs e)
        {
            TeamBL teamBL = new TeamBL();
            Int64 teamid = Convert.ToInt64(Session["EditTeamID"]);

            foreach (GridViewRow gvrow in TeamMemberGridView.Rows)
            {
                
                CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkdelete");
                if (chkdelete.Checked)
                {
                    Int64 userid = Convert.ToInt64(TeamMemberGridView.DataKeys[gvrow.RowIndex].Value);
                    teamBL.UsersSetTeamID(userid, teamid);

                }
            }

            this.TeamsGridView.DataBind();
            this.MiniTeamFormView.DataBind();
            this.SelectedTeamGridView.DataBind();
            this.TeamMemberGridView.DataBind();
            upListView.Update();
            miniDetails.Update();

        }

        protected void DeleteLinkButton_Click(object sender, EventArgs e)
        {
            TeamBL teamBL = new TeamBL();
            Int64 teamid = Convert.ToInt64(Session["EditTeamID"]);
            teamBL.DeactivateTeam(teamid);
            Session["EditTeamID"] = 0;
            this.TeamsGridView.DataBind();
            this.TeamsGridView.SelectedIndex = -1;
            this.MiniTeamFormView.DataBind();
            upListView.Update();
            miniDetails.Update();
            EditLinkButton.Visible = false;
            ModalPopButton2.Visible = false;
            DeleteLinkButton.Visible = false;
           // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "GoToTab(2);", true);

        }

        protected void SelectLinkButton1_Command(object sender, CommandEventArgs e)
        {
            foreach (GridViewRow gvrow in TeamMemberGridView.Rows)
            {
                Int64 userid = Convert.ToInt64(e.CommandArgument.ToString());
                CheckBox chkdelete = (CheckBox)gvrow.FindControl("chkdelete");
                if (userid == Convert.ToInt64(TeamMemberGridView.DataKeys[gvrow.RowIndex].Value) )
                {
                    chkdelete.Checked = true;

                }
              
            }

        }

        protected void TeamSetTextBox_Load(object sender, EventArgs e)
        {
            TeamBL teamBL = new TeamBL();
            string teamsetname = Convert.ToString(Session["EditTeamSetName"]);
            if (teamsetname != null)
            {
                TextBox pe = (TextBox)TeamsDetailsView.FindControl("TeamSetTextBox");
                pe.Text = teamsetname;

            }
        }

        protected void ModalPopButton2_Click(object sender, EventArgs e)
        {

        }

      
    
        protected void Submit_Click(object sender, EventArgs e)
        {

            TeamBL teamBL = new TeamBL();
            string teamsetname = "";
            int teamsetid = 0;

            if (TeamSetNameTextBox.Text!="")
            {
                var tset = teamBL.SetTeamSets(TeamSetNameTextBox.Text);
                teamsetname = tset.ElementAt(0).TeamSetName;
                teamsetid = tset.ElementAt(0).TeamSetID;
                Session["EditTeamSetName"] = teamsetname;
                Session["EditTeamSetID"] = teamsetid;

                if (teamsetname != null)
                {
                    TextBox pe = TeamsDetailsView.FindControl("TeamSetTextBox") as TextBox;
                    pe.Text = teamsetname;
                }

      
                this.TeamSetsGridView.DataBind();

                TeamSetNameTextBox.Text = "";

                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModals(['BodyContent_ModalPanel1','BodyContent_Panel291']);", true);
            }

           }

    

        protected void SelectTeamSets_Command(object sender, CommandEventArgs e)
        {
            string val = e.CommandArgument.ToString();
            int teamsetid = Convert.ToInt32(val);
            //int test = teamBL.TeamSetTeamSetID(teamsetid);
            TeamBL teamBL = new TeamBL();
            string teamsetname = teamBL.GetTeamSetNameByID(teamsetid);
            Session["EditTeamSetName"] = teamsetname;
            Session["EditTeamSetID"] = teamsetid;
            if (teamsetname != null)
            {
                TextBox pe = TeamsDetailsView.FindControl("TeamSetTextBox") as TextBox;
                pe.Text = teamsetname;

            }


            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "CloseModals(['BodyContent_ModalPanel1','BodyContent_Panel291']);", true);

        }

        protected void TeamDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
        {
            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Insert failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;

            }
            else
            {
                string value = "";
                value = Convert.ToString(e.ReturnValue);
                Session["NewTeam"] = value;
            }
        }

        protected void TeamDetailsObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
        {

            if (e.Exception != null)
            {
                var customValidator = new CustomValidator();
                customValidator.IsValid = false;
                customValidator.ErrorMessage = "Update failed: " + e.Exception.InnerException.Message;
                customValidator.ValidationGroup = "sum";
                Page.Validators.Add(customValidator);
                e.ExceptionHandled = true;

            }
            else
            {
                string value = "";
                value = Convert.ToString(e.ReturnValue);
                Session["UpdateTeam"] = value;
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {

            EditLinkButton.Visible = false;
            ModalPopButton2.Visible = false;
            DeleteLinkButton.Visible = false;
            TeamsGridView.DataSourceID = SearchObjectDataSource.ID; 
            this.TeamsGridView.DataBind();
            this.TeamsGridView.SelectedIndex = -1;
            this.MiniTeamFormView.DataBind();
            this.SelectedTeamGridView.DataBind();
            upListView.Update();
            miniDetails.Update();


        }

        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            EditLinkButton.Visible = false;
            ModalPopButton2.Visible = false;
            DeleteLinkButton.Visible = false;
            TeamsGridView.DataSourceID = TeamsObjectDataSource.ID;
            this.TeamsGridView.DataBind();
            this.TeamsGridView.SelectedIndex = -1;
            this.MiniTeamFormView.DataBind();
            this.SelectedTeamGridView.DataBind();
            upListView.Update();
            miniDetails.Update();
        }

       

     



    }
}