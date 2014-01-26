using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using C3App.DAL;
using System.IO;
using C3App.BLL;


namespace C3App
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }

            //Session["PanelShow"] = string.Empty;
            //Session["CompanyID"] = 1;
            //Session["RoleID"] = 1;
            //Session["UserID"] = 1;
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/UserLogin.aspx");
            }
            else
            {
                string page = Path.GetFileName(Request.Url.AbsolutePath);

                string isadmin = Convert.ToString(Session["IsAdmin"]);

             //   Label1.Text = page + isadmin;

                if (isadmin != "True" && page == "ACLRoles.aspx")
                {
                    Response.Redirect("~/Dashboard/Dashboard.aspx");
                }
                if (isadmin != "True" && page == "Users.aspx")
                {
                    Response.Redirect("~/Dashboard/Dashboard.aspx");
                }
                if (isadmin != "True" && page == "Teams.aspx")
                {
                    Response.Redirect("~/Dashboard/Dashboard.aspx");
                }
                if (isadmin != "True" && page == "Company.aspx")
                {
                    Response.Redirect("~/Dashboard/Dashboard.aspx");
                }

                if (isadmin != "True" && page == "Administration.aspx")
                {
                    Response.Redirect("~/Dashboard/Dashboard.aspx");
                }
                if (isadmin != "True" && page == "CompanySetup.aspx")
                {
                    Response.Redirect("~/Dashboard/Dashboard.aspx");
                }

        }

        }


        protected void Page_Load(object sender, EventArgs e)
        {
            
                switch (Request.QueryString["ShowPanel"])
                {
                    case "DetailsPanel":
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "showTabs", "GoToTab(1);", true);                     
                        break;
                    case "ViewPanel":
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "showTabs", "GoToTab(2);", true);
                        break;
                }

            // Role Based Page Access //
            // START //

                Session["EditLinkButton"] = "True";
                Session["DeleteLinkButton"] = "True";

            string[] pageurl = Path.GetFileName(Request.Url.AbsolutePath).Split('.');
            string page = pageurl[0];
            UserBL userBL = new UserBL();
            string pageaccess = userBL.PageAccess(page);
            string functionname = "";
            string functionaccess = "";
            string createpage = "";
            string viewpage = "";
            string cpermission = "";
            string vpermission = "";
            string[] pid = { "" };
            pid = pageaccess.Split(':');
            for (int x = 0; x < pid.Length; x++)
            {
                string[] fid = { "" };
                fid = pid[x].Split('#');

                if (fid.Length > 0 && fid[0] != "")
                {
                    functionname = fid[0];
                    functionaccess = fid[1];

                    if (functionname == "Search" && functionaccess == "False")
                    {
                        Panel search = (Panel)BodyContent.FindControl("SearchPanel");
                        search.Visible = false;
                    }
                    else if (functionname == "List" && functionaccess == "False")
                    {
                        Panel list = (Panel)BodyContent.FindControl("ListPanel");
                        list.Visible = false;

                        //Panel mini = (Panel)BodyContent.FindControl("MiniDetailsPanel");
                        //mini.Visible = false;

                        //Panel more = (Panel)BodyContent.FindControl("MiniDetailMorePanel");
                        //more.Visible = false;
                    }
                    else if (functionname == "Edit" && functionaccess == "False")
                    {
                        LinkButton edit = (LinkButton)BodyContent.FindControl("EditLinkButton");
                        edit.Visible = false;
                        Session["EditLinkButton"] = "False";
                    }
                    
                    else if (functionname == "Delete" && functionaccess == "False")
                    {
                       LinkButton delete = (LinkButton)BodyContent.FindControl("DeleteLinkButton");
                        delete.Visible = false;
                        Session["DeleteLinkButton"] = "False";
                    }
                    else if (functionname == "Create" && functionaccess == "False")
                    {
                        createpage = "Create"; cpermission = "False";
                        Panel create = (Panel)BodyContent.FindControl("DetailsPanel");
                        create.Visible = false;
                    }
                    else if (functionname == "View" && functionaccess == "False")
                    {
                        viewpage = "View"; vpermission = "False";
                        Panel view = (Panel)BodyContent.FindControl("ViewPanel");
                        view.Visible = false;
                    }

                }//if

            }//for

            // if a user do not have any permission it will take to the dashboard page. 

            if ((viewpage == "View" && vpermission == "False") && (createpage == "Create" && cpermission == "False"))
            {
                Response.Redirect("~/Dashboard/Dashboard.aspx");
            }
            
            //for left panel Contact + Task + Document + Administrator

            String[] pages = {"Contacts","Tasks","Documents"};

            for (int i = 0; i < 3; i++)
            {
                string ps = userBL.PageAccess(pages[i]);
            
                    if ((ps.Contains("Create#False")) && (ps.Contains("View#False")) && i == 0)
                        {
                            contact.Visible = false;
                        }
                    if ((ps.Contains("Create#False")) && (ps.Contains("View#False")) && i == 1)
                        {
                            task.Visible = false;
                        }
                    if ((ps.Contains("Create#False")) && (ps.Contains("View#False")) && i == 2)
                        {
                            documents.Visible = false;
                        }
              }

          
                string isadmin = Convert.ToString(Session["IsAdmin"]);
                if (isadmin !="True")
                {
                    administrator.Visible = false;
                }
            
            // END //
              
        }
        

        protected void PanelSet(object sender, EventArgs e)
        {
            Button btn = sender as Button;
            Session["PanelShow"] = btn.CommandArgument.ToString();
        }




        public string MenuCreate()
        {
     
            string parentsmenu = MenuList(0);
            string[] parents = parentsmenu.Split(',');

            LinkedList<string> linked = new LinkedList<string>();
            linked.AddLast("<ul>");

            foreach (string p in parents)
            {

                int v = Menuid(p,0);

                linked.AddLast("<li class=dropdown >");
               

                linked.AddLast("<a href=#>" + p + "</a>");

                string[] submenu2 = { "" };
                string menus = SubMenuList(v);

                if (menus != "")
                {
                    submenu2 = menus.Split(',');
                }
                else
                {
                    submenu2[0] = "N/A";
                }

                if (submenu2[0] == "N/A")
                {
                    linked.AddLast("</li>");
                }

               // First Level Submenu

                else if (submenu2.Length > 0 && submenu2[0] != "N/A")
                {

                    linked.AddLast("<ul>");


                    foreach (string value in submenu2)
                    {
                        linked.AddLast("<li class='dropdown submenu' >");
                        linked.AddLast("<a href=#>" +value + "</a>");

                        int submenuid = Menuid(value,v);

                        string[] childSubmenu = { "" };

                        string children = ChildMenuList(submenuid);


                        if (children != "")
                        {
                            childSubmenu = children.Split(',');
                        }
                        else
                        {
                            childSubmenu[0] = "N/A";
                        }

                        if (childSubmenu[0] == "N/A")
                        {
                            linked.AddLast("</li>");
                        }

                     // second Level Submenu

                        else if (childSubmenu.Length > 0 && childSubmenu[0] != "N/A")
                        {

                            linked.AddLast("<ul>");

                            foreach (string val in childSubmenu)
                            {
                                int childsubmenuid = Menuid(val,submenuid);
                                string path = ResolveUrl("~//") + UrlPath(childsubmenuid);

                                linked.AddLast("<li>");
                                linked.AddLast("<a href=" + path + "> <b>" + val + "</b> </a>");
                                linked.AddLast("</li>");
                            }

                            linked.AddLast("</ul>");
                            linked.AddLast("</li>");
                        }

                    }


                    linked.AddLast("</ul>");
                    linked.AddLast("</li>");
                }
                //linked.AddLast("</li>");
            }

            linked.AddLast("</ul>");

            StringBuilder sb = new StringBuilder();


            foreach (var item in linked)
            {
                sb.Append(item);
            }

            return sb.ToString();
        }

        C3Entities context = new C3Entities();
        public string MenuList(int value)
        {
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);
            int moduleid = 0;
            int[] parents = { 0};
            int i = 0;
            int roleid = Convert.ToInt32(Session["RoleID"]);
            string rolename = "";
            bool isadmin = false;
            string qadmin = "";

            var queryrole = from rr in context.ACLRoles
                            where (rr.RoleID == roleid)
                            select rr.Name;
            if (queryrole.Count() > 0)
            {
                foreach (var q in queryrole)
                {
                    rolename = q;
                    if (rolename == "Administrator" || rolename == "Admin")
                    {
                        isadmin = true;
                    }
                    else
                    {
                        isadmin = false;
                    }
                }
            }

          

            if (isadmin == false)
            {
              var query = (from pp in context.Modules
                             join xx in context.CompanyModules on pp.ModuleID equals xx.ModuleID
                             where (xx.CompanyID == companyid && xx.IsDeleted == false && pp.IsActive==true && pp.IsDeleted == false && pp.IsAdmin == false)
                             orderby pp.ModuleOrder ascending
                             select pp.ParentID).Distinct();

              if (query.Count() > 0)
              {
                  parents = new int[query.Count()];
                  foreach (var q in query)
                  {
                      moduleid = Convert.ToInt32(q);
                      parents[i] = moduleid;
                      i++;

                  }
              }

            }
            else
            {
                var query = (from pp in context.Modules
                             join xx in context.CompanyModules on pp.ModuleID equals xx.ModuleID
                             where (xx.CompanyID == companyid && xx.IsDeleted == false && pp.IsActive == true && pp.IsDeleted == false )
                             orderby pp.ModuleOrder ascending
                             select pp.ParentID).Distinct();
               
                
                if (query.Count() > 0)
                {
                    parents = new int[query.Count()];
                    foreach (var q in query)
                    {
                        moduleid = Convert.ToInt32(q);
                        parents[i] = moduleid;
                        i++;

                    }
                }

            }

           

            string menus = "";
            string displayname = "";

            foreach(int j in parents)
            {
                var query1 = from ppp in context.Modules
                             where (ppp.ModuleID == j)
                             select ppp.DisplayName;

                if (query1.Count() > 0)
                {
                    foreach (var q1 in query1)
                    {
                        displayname = q1;
                        if (displayname != null)
                        {
                            menus += displayname + ",";
                        }
                    }
                }

            }
            menus = menus.TrimEnd(',');


            return menus;
        }

        public string SubMenuList(int value)
        {
            string menus = "";
            string displayname = "";
            Int32 companyid = Convert.ToInt32(HttpContext.Current.Session["CompanyID"]);

            var query = from pp in context.Modules
                        join xx in context.CompanyModules on pp.ModuleID equals xx.ModuleID
                        where (pp.ParentID == value && xx.CompanyID==companyid && xx.IsDeleted == false && pp.IsActive==true && pp.IsDeleted == false )
                        orderby pp.ModuleOrder ascending
                        select pp.DisplayName;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {
                    displayname = q;
                    if (displayname != null)
                    {
                        menus += displayname + ",";
                    }

                }
            }

            menus = menus.TrimEnd(',');
            return menus;
        }

   

        public string ChildMenuList(int value)
        {



            string menus = "";
            string getvalue = "";
            Int32 roleid = Convert.ToInt32(HttpContext.Current.Session["RoleID"]);

            var query = (from pp in context.Modules
                        join xx in context.ACLActions on pp.ParentID equals xx.ModuleID
                        where (pp.ParentID == value && xx.RoleID == roleid && pp.IsActive==true && pp.IsDeleted==false)
                         orderby pp.ModuleOrder ascending
                        select pp.DisplayName).Distinct();
         
            if (query.Count() > 0)
            {
                foreach (var q in query)
                {

                    getvalue = q;
                    if (getvalue != null)
                    {
                        menus += q + ",";
                    }

                }
            }

            menus = menus.TrimEnd(',');

           // Response.Write("menu is " + menus + "<hr>");

            string newmenu = "";
            int fun = 0;
            int fun2 = 0;
            string[] childSubmenu = { "" };
            childSubmenu = menus.Split(',');

            foreach(string c in childSubmenu)
            {

                var query1 = (from ppp in context.ACLActions
                              where ((ppp.FunctionID == 5 && ppp.RoleID == roleid && ppp.ModuleID == value && ppp.Access == true && c.Contains("Company Details")) || (ppp.FunctionID == 2 && ppp.RoleID == roleid && ppp.ModuleID == value && ppp.Access == true && c.Contains("Create")) || (ppp.FunctionID == 5 && ppp.RoleID == roleid && ppp.ModuleID == value && ppp.Access == true && c.Contains("View")))
                              select ppp.FunctionID).Distinct();

                if (query1.Count() > 0)
                {
                    foreach (var q1 in query1)
                    {

                        fun = Convert.ToInt32(q1);
                        newmenu += c + ",";

                    }
                }
             
            }

 
            newmenu = newmenu.TrimEnd(',');
            return newmenu;
        }

        public int Menuid(string value,int p)
        {
            int submenuid = 0;

            var query = from pp in context.Modules
                        where (pp.DisplayName == value && pp.ParentID==p)
                        select pp.ModuleID;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {

                    submenuid = q;

                }
            }

            return submenuid;
        }

        public string UrlPath(int childsubmenuid)
        {
            string path = "";

            var query = from pp in context.Modules
                        where (pp.ModuleID == childsubmenuid)
                        select pp.RelativePath;

            if (query.Count() > 0)
            {
                foreach (var q in query)
                {

                    path = q;

                }
            }

            return path;
        }

        protected void signout_Click(object sender, EventArgs e)
        {

            UserBL objUserBL = new UserBL();
            string sessionid = Session.SessionID;
            long log = 0;
            string target = "UserLogin.aspx";
            string status = "Logout";
            int companyId = Convert.ToInt32(Session["CompanyID"]);
            long userId = Convert.ToInt64(Session["UserID"]);
            log = objUserBL.InsertUserLogout(companyId, userId, sessionid, status, target);
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/UserLogin.aspx");
        }


    }
}