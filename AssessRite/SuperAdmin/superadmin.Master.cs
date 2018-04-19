using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SuperAdmin
{
    public partial class superadmin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            if (Session["UserType"].ToString() == "1")
            {
                lblName.Text = Session["UserName"].ToString();
            }
            else
            {
                Response.Redirect("../AccessDenied.aspx");
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("../Login.aspx");
        }
    }
}