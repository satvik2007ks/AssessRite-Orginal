using AssessRite;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.Student
{
    public partial class ViewResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            else
            {
                if (!IsPostBack)
                {
                    LoadResults();
                }
            }
        }

        private void LoadResults()
        {
            string qur = "SELECT TestAssigned.TestDateTime, TestSchedule.TestId, TestSchedule.TestKey, Subject.SubjectName, Class.ClassName, Test.TotalQuestions,TestAssigned.TestAssignedId FROM   Test INNER JOIN TestSchedule ON Test.TestId = TestSchedule.TestId INNER JOIN Subject ON Test.SubjectId = Subject.SubjectId INNER JOIN Class ON Test.ClassId = Class.ClassId RIGHT OUTER JOIN TestAssigned ON TestSchedule.TestScheduleId = TestAssigned.TestScheduleId Where TestAssigned.StudentId='" + Session["StudentId"].ToString() + "' and TestAssigned.TestDateTime is not null order by TestAssigned.TestDateTime desc";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            grdTests.DataSource = ds;
            grdTests.DataBind();
        }

        protected void grdTests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                Label lblResult = e.Row.FindControl("lblResult") as Label;
                string qur = "SELECT count(*)IsRightAnswer FROM StudentAnswers RIGHT OUTER JOIN TestAssigned ON StudentAnswers.TestAssignedId = TestAssigned.TestAssignedId WHERE (TestAssigned.StudentId = '" + Session["StudentId"].ToString() + "') AND (StudentAnswers.IsRightAnswer = '1') and (TestAssigned.Status='Taken') and TestAssigned.TestAssignedId='"+drv["TestAssignedId"] +"'";
                if (dbLibrary.idHasRows(qur))
                {
                    lblResult.Text = dbLibrary.idGetAFieldByQuery(qur) + " out of " + drv["TotalQuestions"].ToString();
                }
            }
        }
    }
}