using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.Generic_Content.Admin
{
    public partial class Concepts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("../../Login.aspx");
                }
                else
                {
                    hdnCountry.Value = Session["CountryId"].ToString();
                    hdnState.Value = Session["StateId"].ToString();
                }
            }
        }
    }
}