using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.BLL;
using C3App.DAL;
using C3App.App_Code;

namespace C3App.Calls
{
    public partial class Calls : PageBase
    {

        #region Initializing...........
        private DropDownList AssaigendToDropDownList;
        private DropDownList TeamDropDownList;
        private CallBL callBL = new CallBL();
        private long callID = 0;
        private Int32 companyID;
        #endregion


        #region Call Page Function............

        protected void Page_Load(object sender, EventArgs e)
        {

            companyID = Convert.ToInt32(Session["CompanyID"]);
            try
            {
                if (Request.QueryString["ShowPanel"] != null)
                {
                    if (!IsPostBack)
                    {
                        Session["EditCallID"] = 0;
                    }
                }
                if (Session["EditCallID"] != null)
                {
                    callID = Convert.ToInt64(Session["EditCallID"]);
                    if (callID == 0)
                    {
                        CallDetailsView.ChangeMode(DetailsViewMode.Insert);

                        this.CallListGridView.DataBind();
                        this.CallListGridView.SelectedIndex = -1;
                        this.CallMiniDetailFormView.DataBind();
                        this.CallMiniMoreDetailsView.DataBind();


                        CallListUpdatePanel.Update();
                        MiniDetailBasicUpdatePanel.Update();


                        EditLinkButton.Visible = false;
                        DeleteLinkButton.Visible = false;
                    }
                    else if (callID > 0)
                    {
                        CallDetailsView.ChangeMode(DetailsViewMode.Edit);
                        if (CheckEdit() != false)
                            EditLinkButton.Visible = true;
                        if (CheckDelete() != false)
                            DeleteLinkButton.Visible = true;
                    }
                }
                else
                {
                    CallDetailsView.ChangeMode(DetailsViewMode.Insert);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void Page_Error(object sender, EventArgs e)
        {
            Exception exc = Server.GetLastError();
            Response.Write("<h2>Something wrong happend!</h2>");
            Response.Write("<b>Exception Type: </b>" + exc.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Exception: </b>" + exc.Message.ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception Type: </b>" + exc.InnerException.GetType().ToString() + "<br/><br/>");
            Response.Write("<b>Inner Exception: </b>" + exc.InnerException.Message + "<br/><br/>");
            Response.Write("<b>Inner Source: </b>" + exc.InnerException.Source + "<br/><br/>");
            ExceptionUtility.LogException(exc, "CallsPage");
            ExceptionUtility.NotifySystemOps(exc, "CallsPage");
            Server.ClearError();
        }

        //protected void Page_Init(object sender, EventArgs e)
        //{
        //    CallDetailsView.EnableDynamicData(typeof(Case));
        //}
        #endregion


        #region Call Tab Function.........

        protected void CallDetailsLinkButton_Click(object sender, EventArgs e)
        {
            Session["EditCallID"] = 0;
            CallDetailsView.DataSource = null;
            CallDetailsView.DataBind();
            CallDetailsView.ChangeMode(DetailsViewMode.Insert);
        }

        protected void ViewCallLinkButton_Click(object sender, EventArgs e)
        {
            CallListGridView.DataSourceID = SearchAllCallsObjectDataSource.ID;
            CallListGridView.SelectedIndex = -1;
            CallListGridView.DataBind();
            CallListUpdatePanel.Update();
            MiniDetailBasicUpdatePanel.Update();
            EditLinkButton.Visible = false;
            DeleteLinkButton.Visible = false;
            Session["EditCallID"] = 0;

            ///SearchTextBox.Text = String.Empty;
        }


        #endregion


        #region Call Insert Function........

        protected void CallDetailsView_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            long userid;
            if (String.IsNullOrEmpty(Session["CompanyID"].ToString())) { return; }
            else
            {
                e.Values["CompanyID"] = Convert.ToInt32(Session["CompanyID"]);
            }
            if (String.IsNullOrEmpty(Session["UserID"].ToString())) { return; }
            else
            {
                userid = Convert.ToInt64(Session["UserID"]);
            }


            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.Values["TeamID"] = null; }
            else { e.Values["TeamID"] = TeamDropDownList.SelectedValue; }
            if (Convert.ToInt32(AssaigendToDropDownList.SelectedValue) == 0) { e.Values["AssignedUserID"] = null; }
            else { e.Values["AssignedUserID"] = AssaigendToDropDownList.SelectedValue; }

            //Start Date & Time
            TextBox StartDate = CallDetailsView.FindControl("StartDateTextBox") as TextBox;
            TextBox StartTime = CallDetailsView.FindControl("StartTimeTextBox") as TextBox;
            string sd = StartDate.Text;
            string st = StartTime.Text;
            string sdst = sd + " " + st;
            DateTime dateStart = DateTime.Parse(sdst);

            //End Data & Time
            TextBox EndDate = CallDetailsView.FindControl("EndDateTextBox") as TextBox;
            TextBox EndTime = CallDetailsView.FindControl("EndTimeTextBox") as TextBox;
            string ed = EndDate.Text;
            string et = EndTime.Text;
            string edet = ed + " " + et;
            DateTime dateEnd = DateTime.Parse(edet);

            TimeSpan ts = dateEnd - dateStart;
            int d = Convert.ToInt32(ts.Days);
            int h = Convert.ToInt32(ts.Hours); //h is hour
            h += d * 24;
            int m = Convert.ToInt32(ts.Minutes); //h is Minutes

            e.Values["DateStart"] = dateStart;
            e.Values["DateEnd"] = dateEnd;
            e.Values["DurationHours"] = h;
            e.Values["DurationMinutes"] = m;

            e.Values["CreatedBy"] = userid;
            e.Values["CreatedTime"] = DateTime.Now;
            e.Values["ModifiedBy"] = userid;
            e.Values["ModifiedTime"] = DateTime.Now;

        }


        protected void CallDetailsObjectDataSource_Inserted(object sender, ObjectDataSourceStatusEventArgs e)
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
                CallListUpdatePanel.Update();
                MiniDetailBasicUpdatePanel.Update();

                CallDetailsView.DataBind();

                this.CallListGridView.DataBind();
                this.CallMiniDetailFormView.DataBind();
                this.CallMiniMoreDetailsView.DataBind();

                MessageLiteral.Text = "Success </br></br> <p> Call has been successfully saved <br/> ";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                CallDetailsView.ChangeMode(DetailsViewMode.Insert);

                Session["EditCallID"] = 0;
            }

        }

        #endregion


        #region Call Update Function........


        protected void CallDetailsView_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            if (Convert.ToInt32(TeamDropDownList.SelectedValue) == 0) { e.NewValues["TeamID"] = null; }
            else { e.NewValues["TeamID"] = TeamDropDownList.SelectedValue; }

            if (Convert.ToInt32(AssaigendToDropDownList.SelectedValue) == 0) { e.NewValues["AssignedUserID"] = null; }
            else { e.NewValues["AssignedUserID"] = AssaigendToDropDownList.SelectedValue; }


            //Start Date & Time
            TextBox StartDate = CallDetailsView.FindControl("StartDateTextBox") as TextBox;
            TextBox StartTime = CallDetailsView.FindControl("StartTimeTextBox") as TextBox;
            string sd = StartDate.Text;
            string st = StartTime.Text;
            string sdst = sd + " " + st;
            DateTime dateStart = DateTime.Parse(sdst);

            //End Data & Time
            TextBox EndDate = CallDetailsView.FindControl("EndDateTextBox") as TextBox;
            TextBox EndTime = CallDetailsView.FindControl("EndTimeTextBox") as TextBox;
            string ed = EndDate.Text;
            string et = EndTime.Text;
            string edet = ed + " " + et;
            DateTime dateEnd = DateTime.Parse(edet);

            TimeSpan ts = dateEnd - dateStart;
            int d = Convert.ToInt32(ts.Days);
            int h = Convert.ToInt32(ts.Hours); //h is hour
            h += d * 24;
            int m = Convert.ToInt32(ts.Minutes); //h is Minutes

            e.NewValues["DateStart"] = dateStart;
            e.NewValues["DateEnd"] = dateEnd;
            e.NewValues["DurationHours"] = h;
            e.NewValues["DurationMinutes"] = m;



            e.NewValues["ModifiedBy"] = Convert.ToInt64(Session["UserID"]);
            e.NewValues["ModifiedTime"] = DateTime.Now;

        }


        protected void CallDetailsObjectDataSource_Updated(object sender, ObjectDataSourceStatusEventArgs e)
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
                CallListUpdatePanel.Update();
                MiniDetailBasicUpdatePanel.Update();

                CallDetailsView.DataBind();
                this.CallListGridView.DataBind();
                this.CallListGridView.SelectedIndex = -1;
                this.CallMiniDetailFormView.DataBind();
                this.CallMiniMoreDetailsView.DataBind();

                MessageLiteral.Text = "Success </br></br> <p> Call has been successfully updated <br/> ";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                CallDetailsView.ChangeMode(DetailsViewMode.Insert);
                Session["EditCallID"] = 0;

            }
        }


        #endregion


        #region select and Command Function of Call...

        protected void SelectLinkButton_Command(object sender, CommandEventArgs e)
        {
            if (e.CommandArgument.ToString() != null)
            {
                Session["EditCallID"] = e.CommandArgument.ToString();
                callID = Convert.ToInt64(e.CommandArgument.ToString());

                int gindex = Convert.ToInt32(CallListGridView.SelectedIndex);
                if (gindex > -1)
                {
                    LinkButton nlbtn = CallListGridView.Rows[gindex].FindControl("SelectLinkButton") as LinkButton;
                    nlbtn.CssClass = "";
                }
                LinkButton lbtn = sender as LinkButton;
                lbtn.CssClass = "active";

                // if (CheckEdit() != false)
                EditLinkButton.Visible = true;
                // if (CheckDelete() != false)
                DeleteLinkButton.Visible = true;


                CallListUpdatePanel.Update();
                MiniDetailBasicUpdatePanel.Update();

                CallMiniDetailFormView.DataBind();
                CallMiniMoreDetailsView.DataBind();
            }
            else
            {
                Session["EditCallID"] = 0;
            }
        }

        protected void CallDetailsView_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            if (e.CommandName == "Cancel")
            {
                Session["EditCallID"] = 0;
                MessageLiteral.Text = "Changes discarded <br/> <p>Your changes have been discarded</p>";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "script", "ShowAlertModal();", true);
                CallDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
        }

        #endregion


        #region Call Edit, Delete, Search Function.......

        protected void SearchAllLinkButton_Click(object sender, EventArgs e)
        {
            DeleteLinkButton.Visible = false;
            EditLinkButton.Visible = false;

            CallListGridView.DataSourceID = SearchAllCallsObjectDataSource.ID;

            CallListUpdatePanel.Update();
            MiniDetailBasicUpdatePanel.Update();

            this.CallListGridView.DataBind();
            this.CallListGridView.SelectedIndex = -1;
            this.CallMiniDetailFormView.DataBind();
            this.CallMiniMoreDetailsView.DataBind();
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            DeleteLinkButton.Visible = false;
            EditLinkButton.Visible = false;

            CallListGridView.DataSourceID = SearchObjectDataSource.ID;

            CallListUpdatePanel.Update();
            MiniDetailBasicUpdatePanel.Update();

            this.CallListGridView.DataBind();
            this.CallListGridView.SelectedIndex = -1;
            this.CallMiniDetailFormView.DataBind();
            this.CallMiniMoreDetailsView.DataBind();
        }

        protected void EditLinkButton_Click(object sender, EventArgs e)
        {
            if (callID == 0)
            {
                CallDetailsView.ChangeMode(DetailsViewMode.Insert);
            }
            else if (callID > 0)
            {
                CallDetailsView.ChangeMode(DetailsViewMode.Edit);
            }
        }

        protected void DeleteLinkButton_Click(object sender, EventArgs e)
        {
            callID = Convert.ToInt64(Session["EditCallID"]);
            callBL.DeleteCallByID(callID);

            CallListUpdatePanel.Update();
            MiniDetailBasicUpdatePanel.Update();

            this.CallListGridView.DataBind();
            this.CallListGridView.SelectedIndex = -1;
            this.CallMiniDetailFormView.DataBind();
            this.CallMiniMoreDetailsView.DataBind();
            DeleteLinkButton.Visible = false;
            EditLinkButton.Visible = false;

            Session["EditCallID"] = 0;

        }

        #endregion


        #region Call Dropdown List funtion .......

        protected void TeamNameDropDownList_Init(object sender, EventArgs e)
        {
            TeamDropDownList = sender as DropDownList;
        }

        protected void AssaigendToDropDownList_Init(object sender, EventArgs e)
        {
            AssaigendToDropDownList = sender as DropDownList;
        }

        #endregion

        protected void EndTimeTextBox_TextChanged(object sender, EventArgs e)
        {
            TextBox StartDate = CallDetailsView.FindControl("StartDateTextBox") as TextBox;
            TextBox StartTime = CallDetailsView.FindControl("StartTimeTextBox") as TextBox;
            string sd = StartDate.Text;
            string st = StartTime.Text;
            string sdst = sd + " " + st;
            DateTime dateStart = DateTime.Parse(sdst);


            TextBox EndDate = CallDetailsView.FindControl("EndDateTextBox") as TextBox;
            TextBox EndTime = CallDetailsView.FindControl("EndTimeTextBox") as TextBox;
            string ed = EndDate.Text;
            string et = EndTime.Text;
            string edet = ed + " " + et;
            DateTime dateEnd = DateTime.Parse(edet);

            TimeSpan ts = dateEnd - dateStart;
            int d = Convert.ToInt32(ts.Days);
            int h = Convert.ToInt32(ts.Hours); //h is hour
            h += d * 24;
            int m = Convert.ToInt32(ts.Minutes); //h is Minutes

            TextBox DurationHours = CallDetailsView.FindControl("DurationHoursTextBox") as TextBox;
            DurationHours.Text = h.ToString();
            TextBox DurationMinute = CallDetailsView.FindControl("DurationMinutesTextBox") as TextBox;
            DurationMinute.Text = m.ToString();
        }



    }
}