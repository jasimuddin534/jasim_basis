﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using C3App.App_Code;

namespace C3App.Errors
{
    public partial class Http404ErrorPage : System.Web.UI.Page
    {
        protected HttpException ex = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Log the exception and notify system operators
            ex = new HttpException("HTTP 404");
            ExceptionUtility.LogException(ex, "Caught in Http404ErrorPage");
            ExceptionUtility.NotifySystemOps(ex, "Caught in Http404ErrorPage");
        }
    }
}