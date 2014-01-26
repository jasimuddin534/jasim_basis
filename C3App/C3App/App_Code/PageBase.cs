using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace C3App.App_Code
{
    public class PageBase : System.Web.UI.Page
    {
        public bool CheckEdit()
        {
            bool edit = false;
            string value = Convert.ToString(Session["EditLinkButton"]);
            if (value == "False")
            {
                edit = false;
            }
            else
                edit = true;

            return edit;
        }

        public bool CheckDelete()
        {
            bool delete = false;
            string value = Convert.ToString(Session["DeleteLinkButton"]);
            if (value == "False")
            {
                delete = false;
            }
            else
                delete = true;

            return delete;
        }






    }
}