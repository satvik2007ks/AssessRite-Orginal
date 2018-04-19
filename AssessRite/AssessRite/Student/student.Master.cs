using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.Student
{
    public partial class student : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Session["Reset"] = true;
            Configuration config = WebConfigurationManager.OpenWebConfiguration("~/Web.Config");
            SessionStateSection section = (SessionStateSection)config.GetSection("system.web/sessionState");
            int timeout = (int)section.Timeout.TotalMinutes * 1000 * 60;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "SessionAlert", "SessionExpireAlert(" + timeout + ");", true);
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (Session["UserType"].ToString() == "4")
            {
                lblName.Text = Session["UserName"].ToString();
                lblSchoolName.Text = Session["SchoolName"].ToString();
            }
            else
            {
                Response.Redirect("../../AccessDenied.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("../../Login.aspx");
        }
    }
}