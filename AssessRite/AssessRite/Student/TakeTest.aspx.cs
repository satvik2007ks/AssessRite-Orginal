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
    public partial class TakeTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
        }

        private void LoadTests()
        {
            string hours, mins, sign = "";
            hours = hdnTimeZone.Value.Split('T')[1].Split('(')[0].Substring(0, 3).Trim();
            sign = hours.Substring(0, 1);
            mins = sign + hdnTimeZone.Value.Split('T')[1].Split('(')[0].Substring(3, 2).Trim();
            int timezoneMins = (int.Parse(hours) * 60);
            timezoneMins = timezoneMins + int.Parse(mins);
            DateTime datetimeUTC = DateTime.UtcNow;
            datetimeUTC = DateTime.UtcNow.AddMinutes(timezoneMins);
            hdnDate.Value = datetimeUTC.ToShortDateString();
            hdnCurrentTime.Value = datetimeUTC.ToShortTimeString();

            string qur = "SELECT Subject.SubjectName, Test.TestId, Test.TestCreationDate, Test.TestType, Test.TestKey, Test.TotalQuestions, Test.TestKey, TestSchedule.TestDate,TestSchedule.TestScheduleId, CONVERT(VARCHAR,TestSchedule.TestActiveFrom,108) as TestActiveFrom, CONVERT(VARCHAR,TestSchedule.TestActiveTo,108) as TestActiveTo, TestAssigned.StudentId, TestAssigned.TestAssignedId FROM TestSchedule RIGHT OUTER JOIN TestAssigned ON TestSchedule.TestScheduleId = TestAssigned.TestScheduleId LEFT OUTER JOIN Test ON TestSchedule.TestId = Test.TestId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId Where TestAssigned.StudentId='" + Session["StudentId"].ToString() + "' and TestSchedule.TestDate='" + hdnDate.Value + "' and Test.TestType='Online' and TestAssigned.Status='Not Taken'";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //again:
                //foreach (DataRow dr in ds.Tables[0].Rows)
                //{
                //    TimeSpan Validfrom = DateTime.Parse(dr["TestActiveFrom"].ToString()).TimeOfDay;
                //    TimeSpan ValidTo = DateTime.Parse(dr["TestActiveTo"].ToString()).TimeOfDay;
                //    if (DateTime.Parse(hdnCurrentTime.Value).TimeOfDay >= Validfrom)
                //    {
                //        if (!(DateTime.Parse(hdnCurrentTime.Value).TimeOfDay < ValidTo))
                //        {
                //            dr.Delete();
                //            ds.AcceptChanges();
                //            goto again;
                //        }
                //    }
                //    else
                //    {
                //        dr.Delete();
                //        ds.AcceptChanges();
                //        goto again;
                //    }
                //}
                grdTests.DataSource = ds;
                grdTests.DataBind();
                divLoading.Attributes.Add("style", "display:none");
               // lblLoading.Visible = false;
            }
            else
            {
                grdTests.DataSource = null;
                grdTests.DataBind();
                divLoading.Attributes.Add("style", "display:none");
                //  lblLoading.Visible = false;
            }
        }

        protected void btnTakeTest_Click(object sender, EventArgs e)
        {
            Button btnTakeTest = (Button)sender;
            Session["TestAssignedId"] = btnTakeTest.CommandName;
            //Response.Redirect("StudentQuestionPaper.aspx?TestId=" + btnTakeTest.CommandArgument + "&Mode=Test");
            Response.Redirect("Test.aspx?TestId=" + btnTakeTest.CommandArgument + "&Mode=Test");

        }

        protected void TestEnableTimer_Tick(object sender, EventArgs e)
        {
          //  ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "getDateTime()", true);
            //string date = hdnDate.Value;
            //string time = hdnCurrentTime.Value;
            if (hdnTimeZone.Value != "")
            {
                LoadTests();
            }
        }

        protected void grdTests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblTimeFrom = e.Row.FindControl("lblTimeFrom") as Label;
                Button btnTakeTest = e.Row.FindControl("btnTakeTest") as Button;
                DataRowView drv = e.Row.DataItem as DataRowView;
                TimeSpan Validfrom = DateTime.Parse(drv["TestActiveFrom"].ToString()).TimeOfDay;
                TimeSpan ValidTo = DateTime.Parse(drv["TestActiveTo"].ToString()).TimeOfDay;
                if (DateTime.Parse(hdnCurrentTime.Value).TimeOfDay >= Validfrom)
                {
                    if (!(DateTime.Parse(hdnCurrentTime.Value).TimeOfDay < ValidTo))
                    {
                        btnTakeTest.Enabled = false;
                        btnTakeTest.CssClass = "btn btn-default";
                    }
                    else
                    {
                        btnTakeTest.Enabled = true;
                        btnTakeTest.CssClass = "btn btn-primary";
                    }
                }
                else
                {
                    btnTakeTest.Enabled = false;
                    btnTakeTest.CssClass = "btn btn-defult";
                }
            }
        }
    }
}