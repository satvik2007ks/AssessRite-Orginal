using AssessRite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite._3.Admin
{
    public partial class ViewQuestion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
        }
        [System.Web.Services.WebMethod]
        public static string DeleteQuestion(int questionid)
        {
            //dbLibrary.idUpdateTable("Questions",
            //    "QuestionId=" + questionid,
            //    "IsDeleted", "1");
            string qur = dbLibrary.idBuildQuery("proc_ManageQuestion", HttpContext.Current.Session["UserId"].ToString(), questionid.ToString(), HttpContext.Current.Session["InstitutionId"].ToString(), "", "", "", "Delete");
            dbLibrary.idExecute(qur);
            return "Question Deleted Successfully";
        }
    }
}