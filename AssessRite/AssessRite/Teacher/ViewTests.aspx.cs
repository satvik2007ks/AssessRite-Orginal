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
    public partial class ViewTests : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                loadGrid();
            }
        }

        private void loadGrid()
        {
            string qur = "";
            if ((Session["UserType"].ToString() == "2") && (Session["AdminId"] != null))
            {
                qur = "SELECT Class_1.ClassName, Subject.SubjectName, Test.TestId, Test.TestCreationDate, Test.TestType, Test.TestKey, Test.NoOfQuestions, Test.TotalQuestions FROM Test LEFT OUTER JOIN Class AS Class_1 ON Test.ClassId = Class_1.ClassId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId where Test.IsDeleted='0' and Class_1.IsDeleted='0' and Subject.IsDeleted='0' and Class_1.SchoolId='" + Session["InstitutionId"].ToString() + "' order by Test.TestId desc";
            }
            else
            {
                qur = "SELECT Class_1.ClassName, Subject.SubjectName, Test.TestId, Test.TestCreationDate, Test.TestType, Test.TestKey, Test.NoOfQuestions, Test.TotalQuestions FROM Test LEFT OUTER JOIN Class AS Class_1 ON Test.ClassId = Class_1.ClassId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId where Test.IsDeleted='0' and Class_1.IsDeleted='0' and Subject.IsDeleted='0' and Test.CreatedBy='" + Session["UserId"].ToString() + "' and Class_1.SchoolId='" + Session["InstitutionId"].ToString() + "' order by Test.TestId desc";
            }
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            ViewState["Tests"] = ds;
            grdTests.DataSource = ds;
            grdTests.DataBind();
        }

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

        protected void btnSchedule_Click(object sender, EventArgs e)
        {
            divError.Attributes.Add("style", "display:none");
            btnAssign.Attributes.Add("style", "display:none;");
            divStudents.Attributes.Add("style", "display:none;margin-top:10px");
            Button btnSchedule = (Button)sender;
            //if (btnSchedule.Text == "Assign")
            //{
            //    divSchedule.Attributes.Add("style", "display:none");
            //    hdnOffline.Value = "True";
            //}
            //else
            //{
            //    divSchedule.Attributes.Add("style", "display:block");
            //    hdnOffline.Value = "False";
            //}
            string qur = "Select * from Class where IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "' ORDER BY MasterClassId";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlClass.DataTextField = "ClassName";
                ddlClass.DataValueField = "ClassId";
                ddlClass.DataSource = ds;
                ddlClass.DataBind();
                ddlClass.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlClass.SelectedIndex = 0;
            }
            chkStudents.Items.Clear();
            ltlTestKey.Text = btnSchedule.CommandName.ToString();
            btnAssign.CommandArgument = btnSchedule.CommandArgument.ToString();
            btnAssign.CommandName = btnSchedule.CommandName.ToString();


            // ScriptManager.RegisterStartupScript(this, this.GetType(), "CallMyFunction", "getLocalTimeZone()", true);
            string hours, mins, sign = "";
            hours = hdnTimeZone.Value.Split('T')[1].Split('(')[0].Substring(0, 3).Trim();
            sign = hours.Substring(0, 1);
            mins = sign + hdnTimeZone.Value.Split('T')[1].Split('(')[0].Substring(3, 2).Trim();
            int timezoneMins = (int.Parse(hours) * 60);
            timezoneMins = timezoneMins + int.Parse(mins);
            DateTime datetimeUTC = DateTime.UtcNow;
            datetimeUTC = DateTime.UtcNow.AddMinutes(timezoneMins);

            string date, from, to = "";
            date = datetimeUTC.ToShortDateString();
            from = RoundUp(DateTime.Parse(datetimeUTC.ToString()), TimeSpan.FromMinutes(15)).ToShortTimeString();
            to = RoundUp(DateTime.Parse(datetimeUTC.ToString()), TimeSpan.FromMinutes(15)).ToShortTimeString();
            to = DateTime.Parse(to).AddHours(1).ToShortTimeString();
            ScriptManager.RegisterStartupScript(this, GetType(), "setFromUTCDate", "<script type='text/javascript'>$('#" + txtDate.ClientID + "').val('" + date + "');</script>", false);
            ScriptManager.RegisterStartupScript(this, GetType(), "setFromText", "<script type='text/javascript'>$('#" + txtFrom.ClientID + "').val('" + from + "');</script>", false);
            ScriptManager.RegisterStartupScript(this, GetType(), "setToText", "<script type='text/javascript'>$('#" + txtTo.ClientID + "').val('" + to + "');</script>", false);

            UpdatePanel1.Update();
            divErr.Attributes.Add("style", "display:none;margin-top:10px");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalSchedule();", true);
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            string qur = "SELECT Student.FirstName+' '+ Student.LastName as Name, Student.StudentId FROM StudentClass RIGHT OUTER JOIN Student ON StudentClass.StudentId = Student.StudentId Where StudentClass.ClassId='" + ddlClass.SelectedValue + "' and StudentClass.IsCurrent='1' and Student.IsDeleted='0'";
            DataSet ds1 = dbLibrary.idGetCustomResult(qur);
            if (dbLibrary.idHasRows(qur))
            {
                chkStudents.DataValueField = "StudentId";
                chkStudents.DataTextField = "Name";
                chkStudents.DataSource = ds1;
                chkStudents.DataBind();
                divStudents.Attributes.Add("style", "display:block;margin-top:10px");
                btnAssign.Attributes.Add("style", "display:block;margin: 0 auto");
                divError.Attributes.Add("style", "display:none");
            }
            else
            {
                btnAssign.Attributes.Add("style", "display:none;");
                divStudents.Attributes.Add("style", "display:none");
                divError.Attributes.Add("style", "display:block;margin-top:10px");
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            divErr.Attributes.Add("style", "display:none;margin-top:10px");
            //if (hdnOffline.Value == "False")
            //{
            if (txtDate.Text == "")
            {
                divErr.Attributes.Add("style", "display:block;margin-top:10px");
                lblError.Text = "Date Cannot be Empty*";
                txtDate.Focus();
                return;
            }
            if (txtFrom.Text == "")
            {
                divErr.Attributes.Add("style", "display:block;margin-top:10px");
                lblError.Text = "'Test Active From' Cannot be Empty*";
                txtFrom.Focus();
                return;
            }
            if (txtTo.Text == "")
            {
                divErr.Attributes.Add("style", "display:block;margin-top:10px");
                lblError.Text = "'Test Active To' Cannot be Empty*";
                txtTo.Focus();
                return;
            }
            //}
            if (ddlClass.SelectedIndex == 0)
            {
                divErr.Attributes.Add("style", "display:block;margin-top:10px");
                lblError.Text = "Select Class*";
                return;
            }
            string hours, mins, sign = "";
            hours = hdnTimeZone.Value.Split('T')[1].Split('(')[0].Substring(0, 3).Trim();
            sign = hours.Substring(0, 1);
            mins = sign + hdnTimeZone.Value.Split('T')[1].Split('(')[0].Substring(3, 2).Trim();
            int timezoneMins = (int.Parse(hours) * 60);
            timezoneMins = timezoneMins + int.Parse(mins);
            DateTime datetimeUTC = DateTime.UtcNow;
            datetimeUTC = DateTime.UtcNow.AddMinutes(timezoneMins);
            DateTime t1 = DateTime.Parse(datetimeUTC.ToShortTimeString());
            DateTime t2 = DateTime.Parse(txtFrom.Text);
            DateTime t3 = DateTime.Parse(txtTo.Text);
            if (DateTime.Parse(txtDate.Text) == DateTime.Parse(datetimeUTC.ToShortDateString()))
            {
                if (t2 < t1)
                {
                    divErr.Attributes.Add("style", "display:block;margin-top:10px");
                    lblError.Text = "Invalid Time! Active Test From Time Should be Greater than Current Time*";
                    txtFrom.Focus();
                    return;
                }
                if (t3 < t2)
                {
                    divErr.Attributes.Add("style", "display:block;margin-top:10px");
                    lblError.Text = "Invalid Active To Time! Should be Greater than Active From Time*";
                    txtTo.Focus();
                    return;
                }
            }
            int count = 0;
            foreach (ListItem li in chkStudents.Items)
            {
                if (li.Selected)
                {
                    count++;
                }
            }

            if (chkStudents.Items.Cast<ListItem>().Any(item => item.Selected))
            {
                //    if (chkStudentsAll.Checked == true || count > 0)
                //{
                string checkqur = "Select TestScheduleId from TestSchedule where TestId='" + btnAssign.CommandArgument.ToString() + "' and AssignedClassId='" + ddlClass.SelectedValue.ToString() + "' and TestDate='" + txtDate.Text + "'";
                if (dbLibrary.idHasRows(checkqur))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalExists();", true);
                }
                else
                {
                    ScheduledAssign();
                }
            }
            else
            {
                divErr.Attributes.Add("style", "display:block;margin-top:10px");
                lblError.Text = "Select Students to Assign Test*";
                return;
            }

        }

        DateTime RoundUp(DateTime dt, TimeSpan d)
        {
            return new DateTime(((dt.Ticks + d.Ticks - 1) / d.Ticks) * d.Ticks);
        }

        private void ScheduledAssign()
        {
            string qur = dbLibrary.idBuildQuery("[proc_ScheduleTest]", btnAssign.CommandArgument.ToString(), btnAssign.CommandName.ToString(), txtDate.Text, txtFrom.Text, txtTo.Text, ddlClass.SelectedValue.ToString());
            string TestScheduleId = dbLibrary.idGetAFieldByQuery(qur);
            DataTable dtAssignedStudents = new DataTable();
            dtAssignedStudents.Columns.Add("TestScheduleId");
            dtAssignedStudents.Columns.Add("StudentId");
            dtAssignedStudents.Columns.Add("StudentClassId");
            dtAssignedStudents.Columns.Add("Status");
            dtAssignedStudents.Columns.Add("TestDateTime");
            foreach (ListItem li in chkStudents.Items)
            {
                if (li.Selected)
                {
                    qur = "select StudentClassId from studentClass where StudentId='" + li.Value + "' and IsCurrent='1'";
                    string studentClassId = dbLibrary.idGetAFieldByQuery(qur);
                    dtAssignedStudents.Rows.Add(TestScheduleId, li.Value.ToString(), studentClassId, "Not Taken", DBNull.Value);
                }
            }
            if (dtAssignedStudents.Rows.Count > 0)
            {
                dbLibrary.idInsertDataTable("[proc_TestAssigned]", "@List", dtAssignedStudents);
            }
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Pop", "$('#modalSchedule').modal('hide');", true);
            lblMsg.Text = "Test Scheduled & Assigned Successfully";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "CallMyFunction1", "runEffect1()", true);
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        protected void chkStudentsAll_CheckedChanged(object sender, EventArgs e)
        {
            if (chkStudentsAll.Checked)
            {
                foreach (ListItem li in chkStudents.Items)
                {
                    li.Selected = true;
                }
            }
            else
            {
                foreach (ListItem li in chkStudents.Items)
                {
                    li.Selected = false;
                }
            }
        }

        protected void grdTests_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (!string.IsNullOrEmpty(e.Row.Cells[5].Text))
                {
                    string date = DateTime.Parse(e.Row.Cells[5].Text).ToString("yyyyMMddHHmmss");
                    e.Row.Cells[5].Attributes.Add("data-order", date);
                }
                if (e.Row.Cells[2].Text.Contains("Offline"))
                {
                    Button btnSchedule = e.Row.FindControl("btnSchedule") as Button;
                    btnSchedule.Visible = false;
                }
                string qur = "Select TestScheduleId from TestSchedule where TestKey='"+ e.Row.Cells[1].Text + "'";
                if(dbLibrary.idHasRows(qur))
                {
                    Button btnDeleteTest = e.Row.FindControl("btnDeleteTest") as Button;
                    btnDeleteTest.Visible = false;

                }
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            ScheduledAssign();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Pop", "$('#modalAlreadyExists').modal('hide');", true);
        }

        protected void chkStudents_SelectedIndexChanged(object sender, EventArgs e)
        {
            int count = 0;
            foreach (ListItem li in chkStudents.Items)
            {
                if (li.Selected)
                {
                    count++;
                }
            }
            if (chkStudents.Items.Count == count)
            {
                chkStudentsAll.Checked = true;
            }
            else
            {
                chkStudentsAll.Checked = false;
            }
        }

        protected void btnDeleteTest_Click(object sender, EventArgs e)
        {
            Button btnDeleteTest = (Button)sender;
            btnDeleteTestYes.CommandArgument = btnDeleteTest.CommandArgument;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalForDelete();", true);
        }

        protected void btnDeleteTestYes_Click(object sender, EventArgs e)
        {
            dbLibrary.idUpdateTable("Test",
                "TestId=" + btnDeleteTestYes.CommandArgument,
                "IsDeleted", "1");
          //  ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Pop", "$('#myModal2').modal('hide');", true);
            lblMsg.Text = "Test Deleted Successfully";
            loadGrid();
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "CallMyFunction1", "runEffect1()", true);
           
        }

        //protected void grdTests_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        if (e.Row.Cells[2].Text.Contains("Offline"))
        //        {
        //            Button btnSchedule = e.Row.FindControl("btnSchedule") as Button;
        //            btnSchedule.Text = "Assign";
        //        }
        //    }
        //}
    }
}