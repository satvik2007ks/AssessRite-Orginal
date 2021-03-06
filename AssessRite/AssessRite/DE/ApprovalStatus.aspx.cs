﻿using AssessRite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.DE
{
    public partial class ApprovalStatus : System.Web.UI.Page
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
            dbLibrary.idUpdateTable("Questions",
                "QuestionId=" + questionid,
                "IsDeleted", "1");
            return "Question Deleted Successfully";
        }
    }
}