using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace C3App
{
    public partial class ModuleSelect : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Panel pnlLeftPanel = this.Master.FindControl("LeftPanel") as Panel;
            pnlLeftPanel.Visible = false;

            Panel pnlContainerBody = this.Master.FindControl("ContainerBody") as Panel;
            pnlContainerBody.CssClass = "container-body margin-all";
        }
    }
}