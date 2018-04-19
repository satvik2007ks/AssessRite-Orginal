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
    public partial class Results : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadGrids();
                // loadGridOnline();
                // loadGridOffline();
            }
        }

        private void LoadGrids()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getResults]", Session["UserId"].ToString(), DateTime.Today.ToString("yyyy-MM-dd"), Session["SchoolId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            // ViewState["Tests"] = ds.Tables[0];
            //  ViewState["TestsOffline"] = ds.Tables[1];
            //   ViewState["ZeroNet"] = ds.Tables[2];
            if (ds.Tables[0].Rows.Count > 0)
            {
                divOnlineEmpty.Attributes.Add("style", "display:none");
                grdTests.DataSource = ds.Tables[0];
                grdTests.DataBind();
            }
            else
            {
                divOnlineEmpty.Attributes.Add("style", "display:block");
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                divOfflineEmpty.Attributes.Add("style", "display:none");
                grdTestOffline.DataSource = ds.Tables[1];
                grdTestOffline.DataBind();
            }
            else
            {
                divOfflineEmpty.Attributes.Add("style", "display:block");
            }

            if (ds.Tables[3].Rows.Count > 0)
            {
                divZeroNet.Attributes.Add("style", "display:block");
                if (ds.Tables[2].Rows.Count > 0)
                {
                    divZeroNetEmpty.Attributes.Add("style", "display:none");
                    grdZeroNet.DataSource = ds.Tables[2];
                    grdZeroNet.DataBind();
                }
                else
                {
                    divZeroNetEmpty.Attributes.Add("style", "display:block");
                }
            }
            else
            {
                divZeroNet.Attributes.Add("style", "display:none");
            }
        }

        //private void loadGridOffline()
        //{
        //    //  string qur = "SELECT Subject.SubjectName, Test.TestId, Test.TestCreationDate, Test.TestType, Test.TestKey, Test.NoOfQuestions, Test.TotalQuestions, Class.ClassName FROM Test LEFT OUTER JOIN Class ON Test.ClassId = Class.ClassId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId WHERE Test.CreatedBy='" + Session["UserId"].ToString() + "' and Test.TestType='Offline' order by Test.TestId Asc";
        //    String qur = "SELECT Class_1.ClassName, Subject.SubjectName, Test.TestId, Test.TestCreationDate, Test.TestType, Test.TestKey, Test.NoOfQuestions, Test.TotalQuestions, Class.ClassName AS AssignedTo, TestSchedule.TestScheduleId FROM Class INNER JOIN TestSchedule ON Class.ClassId = TestSchedule.AssignedClassId LEFT OUTER JOIN Test ON TestSchedule.TestId = Test.TestId LEFT OUTER JOIN Class AS Class_1 ON Test.ClassId = Class_1.ClassId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId  WHERE Test.CreatedBy='" + Session["UserId"].ToString() + "' and Test.TestType='Offline' order by TestSchedule.TestScheduleId DESC";
        //    DataSet ds = dbLibrary.idGetCustomResult(qur);
        //    ViewState["TestsOffline"] = ds;
        //    grdTestOffline.DataSource = ds;
        //    grdTestOffline.DataBind();
        //}

        //private void loadGridOnline()
        //{
        //    string qur = "SELECT Class_1.ClassName, Subject.SubjectName, Test.TestId, Test.TestCreationDate, Test.TestType, Test.TestKey, Test.NoOfQuestions, Test.TotalQuestions, TestSchedule.TestDate, CONVERT(VARCHAR, TestSchedule.TestActiveFrom, 108) AS TestActiveFrom, CONVERT(VARCHAR,TestSchedule.TestActiveTo, 108) AS TestActiveTo, Class.ClassName AS AssignedTo,TestSchedule.TestScheduleId FROM Class INNER JOIN TestSchedule ON Class.ClassId = TestSchedule.AssignedClassId LEFT OUTER JOIN Test ON TestSchedule.TestId = Test.TestId LEFT OUTER JOIN Class AS Class_1 ON Test.ClassId = Class_1.ClassId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId where Test.CreatedBy='" + Session["UserId"].ToString() + "' and Test.TestType='Online' and TestSchedule.TestDate<='" + DateTime.Today.ToString("yyyy-MM-dd") + "' order by TestSchedule.TestScheduleId DESC";
        //    DataSet ds = dbLibrary.idGetCustomResult(qur);
        //    ViewState["Tests"] = ds;
        //    grdTests.DataSource = ds;
        //    grdTests.DataBind();
        //}

        protected void btnViewConcepts_Click(object sender, EventArgs e)
        {
            Button btnViewConcepts = (Button)sender;
            string qur = "SELECT Concept.ConceptName, TestConcepts.TestKey FROM Concept RIGHT OUTER JOIN TestConcepts ON Concept.ConceptId = TestConcepts.ConceptId where TestConcepts.TestId=" + btnViewConcepts.CommandArgument.ToString();
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            grdConcepts.DataSource = ds;
            grdConcepts.DataBind();
            ltlConcept.Text = btnViewConcepts.CommandName.ToString();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        //protected void grdTests_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    grdTests.PageIndex = e.NewPageIndex;
        //    grdTests.DataSource = (DataSet)ViewState["Tests"];
        //    grdTests.DataBind();
        //}

        //protected void grdTestOffline_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    grdTestOffline.PageIndex = e.NewPageIndex;
        //    grdTestOffline.DataSource = (DataSet)ViewState["TestsOffline"];
        //    grdTestOffline.DataBind();
        //}

        protected void grdTests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                HyperLink lnkStudents = e.Row.FindControl("lnkStudents") as HyperLink;
                string qur = dbLibrary.idBuildQuery("[proc_getStudentCount]", drv["TestScheduleId"].ToString());
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lnkStudents.Text = ds.Tables[0].Rows[0]["Taken"].ToString() + " Out Off " + ds.Tables[0].Rows[0]["Total"].ToString();
                    //string redirect = "<script>window.open('StudentResults.aspx?TestScheduleId=" + drv["TestScheduleId"].ToString() + "&TestId=" + drv["TestId"].ToString()+"');</script>";
                    //Response.Write(redirect);
                    lnkStudents.NavigateUrl = "StudentResults.aspx?TestScheduleId=" + drv["TestScheduleId"].ToString() + "&TestId=" + drv["TestId"].ToString();
                }
            }
        }

        protected void grdTestOffline_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                HyperLink lnkStudents = e.Row.FindControl("lnkStudents") as HyperLink;
                string qur = dbLibrary.idBuildQuery("[proc_getStudentCount]", drv["TestScheduleId"].ToString());
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lnkStudents.Text = ds.Tables[0].Rows[0]["Taken"].ToString() + " Out Off " + ds.Tables[0].Rows[0]["Total"].ToString();
                    lnkStudents.NavigateUrl = "StudentResults.aspx?TestScheduleId=" + drv["TestScheduleId"].ToString() + "&TestId=" + drv["TestId"].ToString();
                    //string redirect = "<script>window.open('StudentResults.aspx?TestScheduleId=" + drv["TestScheduleId"].ToString() + "&TestId=" + drv["TestId"].ToString() + "');</script>";
                    //Response.Write(redirect);
                }
            }
        }

        protected void grdZeroNet_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                HyperLink lnkStudents = e.Row.FindControl("lnkStudents") as HyperLink;
                string qur = dbLibrary.idBuildQuery("[proc_getStudentCount]", drv["TestScheduleId"].ToString());
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lnkStudents.Text = ds.Tables[0].Rows[0]["Taken"].ToString() + " Out Off " + ds.Tables[0].Rows[0]["Total"].ToString();
                    lnkStudents.NavigateUrl = "StudentResults.aspx?TestScheduleId=" + drv["TestScheduleId"].ToString() + "&TestId=" + drv["TestId"].ToString();
                }
            }
        }

    }
}