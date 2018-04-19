using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite
{
    public partial class ScheduledTests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            //if (!IsPostBack)
            //{
            //    loadGridOnline();
            //   // loadGridOffline();
            //}
        }

        //private void loadGridOffline()
        //{
        //    string qur = "SELECT Subject.SubjectName, Test.TestId, Test.TestCreationDate, Test.TestType, Test.TestKey, Test.NoOfQuestions, Test.TotalQuestions, Class.ClassName FROM Test LEFT OUTER JOIN Class ON Test.ClassId = Class.ClassId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId WHERE Test.CreatedBy='" + Session["UserId"].ToString() + "' and Test.TestType='Offline' order by Test.TestId Asc";
        //    DataSet ds = dbLibrary.idGetCustomResult(qur);
        //    ViewState["TestsOffline"] = ds;
        //    grdTestOffline.DataSource = ds;
        //    grdTestOffline.DataBind();
        //}

        private void loadGridOnline()
        {
            string qur = "SELECT Class_1.ClassName, Subject.SubjectName, Test.TestId, Test.TestCreationDate, Test.TestType, Test.TestKey, Test.NoOfQuestions, Test.TotalQuestions, TestSchedule.TestDate, CONVERT(VARCHAR, TestSchedule.TestActiveFrom, 108) AS TestActiveFrom, CONVERT(VARCHAR,TestSchedule.TestActiveTo, 108) AS TestActiveTo, Class.ClassName AS AssignedTo FROM Class INNER JOIN TestSchedule ON Class.ClassId = TestSchedule.AssignedClassId LEFT OUTER JOIN Test ON TestSchedule.TestId = Test.TestId LEFT OUTER JOIN Class AS Class_1 ON Test.ClassId = Class_1.ClassId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId where Test.CreatedBy='" + Session["UserId"].ToString() + "' and Test.TestType='Online' order by TestSchedule.TestScheduleId DESC";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            ViewState["Tests"] = ds;
         //   grdTests.DataSource = ds;
         //   grdTests.DataBind();
        }

        protected void btnViewConcepts_Click(object sender, EventArgs e)
        {
            Button btnViewConcepts = (Button)sender;
            string qur = "SELECT Concept.ConceptName, TestConcepts.TestKey FROM Concept RIGHT OUTER JOIN TestConcepts ON Concept.ConceptId = TestConcepts.ConceptId where TestConcepts.TestId=" + btnViewConcepts.CommandArgument.ToString();
            DataSet ds = dbLibrary.idGetCustomResult(qur);
         //   grdConcepts.DataSource = ds;
         //   grdConcepts.DataBind();
         //   ltlConcept.Text = btnViewConcepts.CommandName.ToString();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        protected void grdTests_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
         //   grdTests.PageIndex = e.NewPageIndex;
         //   grdTests.DataSource = (DataSet)ViewState["Tests"];
          //  grdTests.DataBind();
        }

        [System.Web.Services.WebMethod]
        public static string Delete(int testscheduledid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_DeleteScheduledTest]", testscheduledid.ToString());
            dbLibrary.idExecute(qur);
            return "Scheduled Test Deleted Successfully";
        }

        [System.Web.Services.WebMethod]
        public static string DeleteAssignedStudent(int TestAssignedId)
        {
            string qur = dbLibrary.idBuildQuery("[proc_DeleteAssignedStudent]", TestAssignedId.ToString());
            dbLibrary.idExecute(qur);
            return "Student Un-Assigned Successfully";
        }
        //protected void grdTestOffline_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    grdTestOffline.PageIndex = e.NewPageIndex;
        //    grdTestOffline.DataSource = (DataSet)ViewState["TestsOffline"];
        //    grdTestOffline.DataBind();
        //}
    }
}