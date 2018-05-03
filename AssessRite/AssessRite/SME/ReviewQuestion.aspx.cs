using AssessRite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SME
{
    public partial class ReviewQuestion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string DeleteQuestion(int questionid)
        {
            string qur = dbLibrary.idBuildQuery("proc_ManageQuestion", HttpContext.Current.Session["UserId"].ToString(), questionid.ToString(), HttpContext.Current.Session["InstitutionId"].ToString(), "", "", "", "Delete");
            dbLibrary.idExecute(qur);
            //dbLibrary.idUpdateTable("Questions",
            //    "QuestionId=" + questionid,
            //    "IsDeleted", "1");
            return "Question Deleted Successfully";
        }

        [System.Web.Services.WebMethod(EnableSession =true)]
        public static string RejectQuestion(int questionid, string comment)
        {
            var regexItem = new Regex("^[a-zA-Z0-9\' ]*$");
            if (!regexItem.IsMatch(comment))
            {
                return "Comment Cannot Have Special Characters";
            }
            if (!(Regex.IsMatch(comment, "[^0-9]")))
            {
                return "Comment Cannot Have Just Numbers";
            }
            //dbLibrary.idUpdateTable("Questions",
            //"QuestionId=" + questionid,
            //"Comment", comment,
            //"StatusId", "2",
            //"ReviewedBy", HttpContext.Current.Session["SMEId"].ToString());
            string qur = dbLibrary.idBuildQuery("proc_ManageQuestion", HttpContext.Current.Session["UserId"].ToString(), questionid.ToString(), HttpContext.Current.Session["InstitutionId"].ToString(), "2", comment, HttpContext.Current.Session["SMEId"].ToString(), "Reject");
            dbLibrary.idExecute(qur);
            return "Question Sent Back to DE for Correction";
        }

        [System.Web.Services.WebMethod(EnableSession =true)]
        public static string ApproveQuestion(int questionid)
        {
            //dbLibrary.idUpdateTable("Questions",
            //    "QuestionId=" + questionid,
            //    "Comment", "",
            //    "AddedDateTime", DateTime.Now.ToString(),
            //    "StatusId", "3",
            //    "ReviewedBy", HttpContext.Current.Session["SMEId"].ToString());
            string qur = dbLibrary.idBuildQuery("proc_ManageQuestion", HttpContext.Current.Session["UserId"].ToString(), questionid.ToString(), HttpContext.Current.Session["InstitutionId"].ToString(), "3", "", HttpContext.Current.Session["SMEId"].ToString(), "Approve");
            dbLibrary.idExecute(qur);
            return "Question Approved";
        }
    }
}