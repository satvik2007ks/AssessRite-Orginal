using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite
{
    public partial class ManualResultEntry : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                //MultiView1.SetActiveView(View1);
                LoadDropDown();
            }
        }

        private void LoadDropDown()
        {
            string qur = "";
            if ((Session["UserType"].ToString() == "2") && (Session["AdminId"] != null))
            {
                qur = "SELECT Test.TestId, Test.TestKey FROM Test LEFT OUTER JOIN Class AS Class_1 ON Test.ClassId = Class_1.ClassId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId where Test.IsDeleted='0' and Class_1.IsDeleted='0' and Subject.IsDeleted='0' and Test.TestType='Offline' and Class_1.SchoolId='" + Session["SchoolId"].ToString() + "' order by Test.TestId desc";
            }
            else
            {
                qur = "SELECT Test.TestId, Test.TestKey FROM Test LEFT OUTER JOIN Class AS Class_1 ON Test.ClassId = Class_1.ClassId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId where Test.IsDeleted='0' and Class_1.IsDeleted='0' and Subject.IsDeleted='0' and Test.CreatedBy='" + Session["UserId"].ToString() + "' and Test.TestType='Offline' and Class_1.SchoolId='" + Session["SchoolId"].ToString() + "' order by Test.TestId desc";
            }
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlTest.DataTextField = "TestKey";
                ddlTest.DataValueField = "TestId";
                ddlTest.DataSource = ds;
                ddlTest.DataBind();
                ddlTest.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlTest.SelectedIndex = 0;
            }
        }

        protected void ddlTest_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTest.SelectedValue == "-1")
            {
                divTestDetails.Attributes.Add("style", "display:none;");
                divError.Attributes.Add("style", "display:block");
                lblError.Text = "Select Test*";
                return;
            }
            else
            {
                lblError.Text = "";
                divError.Attributes.Add("style", "display:none");
            }
            string qur = "SELECT Test.TestCreationDate, Test.TestId, Test.TotalQuestions, Class.ClassName, Subject.SubjectName FROM  Subject RIGHT OUTER JOIN Test ON Subject.SubjectId = Test.SubjectId LEFT OUTER JOIN Class ON Test.ClassId = Class.ClassId where Test.TestId='" + ddlTest.SelectedValue + "'";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                divTestDetails.Attributes.Add("style", "display:block;");
                lblClass.Text = ds.Tables[0].Rows[0]["ClassName"].ToString();
                lblDate.Text = ds.Tables[0].Rows[0]["TestCreationDate"].ToString();
                lblQuestions.Text = ds.Tables[0].Rows[0]["TotalQuestions"].ToString();
                lblSubject.Text = ds.Tables[0].Rows[0]["SubjectName"].ToString();

                Session.Remove("TestAssignedId");
                Session.Remove("TestId");
                Session.Remove("TestKey");

                Session["TestId"] = ddlTest.SelectedValue;
                Session["TestKey"] = ddlTest.SelectedItem.Text;
                loadClass();

            }
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {

            //lblSelectClass.CssClass = lblSelectClass.CssClass.Replace("btn-primary", "");
            //lblClassStudent.CssClass = lblClassStudent.CssClass.Replace("btn", "btn btn-primary");
            //MultiView1.SetActiveView(View2);
        }

        private void loadClass()
        {
            string qur = "Select * from Class where IsDeleted='0' and SchoolId='" + Session["SchoolId"].ToString() + "' ORDER BY MasterClassId";
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
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlClass.SelectedValue == "-1")
            {
                divError.Attributes.Add("style", "display:block");
                lblError.Text = "Select Class*";
                return;
            }
            else
            {
                lblError.Text = "";
                divError.Attributes.Add("style", "display:none");
            }
            string qur = "SELECT Student.StudentId, Student.FirstName+' '+Student.LastName as Name FROM Student RIGHT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where StudentClass.IsCurrent='1' and StudentClass.ClassId='" + ddlClass.SelectedValue + "' and Student.IsDeleted='0'";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlStudent.DataTextField = "Name";
                ddlStudent.DataValueField = "StudentId";
                ddlStudent.DataSource = ds;
                ddlStudent.DataBind();
                ddlStudent.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlStudent.SelectedIndex = 0;
            }
            else
            {
                ddlStudent.Items.Clear();
                ddlStudent.Items.Insert(0, new ListItem("--No Student Found--", "-1"));
                ddlStudent.SelectedIndex = 0;
            }
        }

        protected void btnContinue2_Click(object sender, EventArgs e)
        {
            if (ddlTest.SelectedValue == "-1")
            {
                divError.Attributes.Add("style", "display:block");
                lblError.Text = "Select Test*";
                return;
            }
            else if (ddlClass.SelectedValue == "-1")
            {
                divError.Attributes.Add("style", "display:block");
                lblError.Text = "Select Class*";
                return;
            }
            else if (ddlStudent.SelectedValue == "-1")
            {
                divError.Attributes.Add("style", "display:block");
                lblError.Text = "Select Student*";
                return;
            }
            else
            {
                divError.Attributes.Add("style", "display:none");
            }
            string qur1 = "SELECT TestAssigned.TestAssignedId, TestAssigned.TestScheduleId, TestAssigned.Status  FROM TestAssigned LEFT OUTER JOIN TestSchedule ON TestAssigned.TestScheduleId = TestSchedule.TestScheduleId Where TestAssigned.StudentId='" + ddlStudent.SelectedValue + "' and TestSchedule.TestId='" + Session["TestId"].ToString() + "' and TestSchedule.AssignedClassId='" + ddlClass.SelectedValue + "'";
            DataSet ds = dbLibrary.idGetCustomResult(qur1);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ViewState["Temp"] = ds;
                if (ds.Tables[0].Rows[0]["Status"].ToString() == "Taken")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
                }
                else
                {
                    Assign(true);
                }
            }
            else
            {
                Assign(false);
            }
        }

        private void Assign(bool found)
        {
            string TestScheduleId = "";
            string TestAssignedId = "";
            // DataTable dtAssignedStudents = new DataTable();
            if (found)
            {
                DataSet dsTemp = (DataSet)ViewState["Temp"];
                TestAssignedId = dsTemp.Tables[0].Rows[0]["TestAssignedId"].ToString();
            }
            else
            {
                string qry = "Select TestScheduleId from TestSchedule where TestId='" + Session["TestId"].ToString() + "' and TestKey='" + Session["TestKey"].ToString() + "' and AssignedClassId='" + ddlClass.SelectedValue.ToString() + "'";
                TestScheduleId = dbLibrary.idGetAFieldByQuery(qry);
                if (string.IsNullOrEmpty(TestScheduleId))
                {
                    qry = dbLibrary.idBuildQuery("[proc_ScheduleTest]", Session["TestId"].ToString(), Session["TestKey"].ToString(), "", "", "", ddlClass.SelectedValue.ToString());
                    TestScheduleId = dbLibrary.idGetAFieldByQuery(qry);
                }
                if (!string.IsNullOrEmpty(TestScheduleId))
                {
                    string qur = dbLibrary.idBuildQuery("[proc_AssignOfflineTest]", TestScheduleId, ddlStudent.SelectedValue);
                    TestAssignedId = dbLibrary.idGetAFieldByQuery(qur);
                }
            }
            Session["TestAssignedId"] = TestAssignedId;
            if (!string.IsNullOrEmpty(TestAssignedId))
            {
                //string redirect = "<script>window.open('QuestionPaper.aspx?TestId=" + Session["TestId"].ToString() + "&Mode=ResultEntry');</script>";
                //Response.Write(redirect);
                ScriptManager.RegisterStartupScript(Page, typeof(Page), "OpenWindow", "window.open('QuestionPaper.aspx?TestId=" + Session["TestId"].ToString() + "&Mode=ResultEntry');", true);

            }
            //string qry = "Select TestScheduleId from TestSchedule where TestId='" + Session["TestId"].ToString() + "' and AssignedClassId='" + ddlClass.SelectedValue.ToString() + "'";
            //DataSet ds = dbLibrary.idGetCustomResult(qry);
            //if(ds.Tables[0].Rows.Count>0)
            //{
            //    TestScheduleId = ds.Tables[0].Rows[0]["TestScheduleId"].ToString();
            //    qry= "Select TestAssignedId from TestAssigned where TestScheduleId='"+TestScheduleId+ "' and StudentId='"+ddlClass.SelectedValue+"'";
            //}
            //else
            //{
            //}
            //lblSelectClass.CssClass = lblSelectClass.CssClass.Replace("btn-primary", "");
            //lblClassStudent.CssClass = lblClassStudent.CssClass.Replace("btn-primary", "");
            //lblResult.CssClass = lblResult.CssClass.Replace("btn", "btn btn-primary");
            // MultiView1.SetActiveView(View3);
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            DataSet Temp = (DataSet)ViewState["Temp"];
            string qur = dbLibrary.idBuildQuery("[proc_DeleteTestAssigned]", Temp.Tables[0].Rows[0]["TestAssignedId"].ToString());
            dbLibrary.idExecute(qur);
            //    ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Pop", "$('#myModal').modal('hide');", true);
            Assign(false);

        }

        protected void ddlStudent_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlStudent.SelectedValue == "-1")
            {
                divError.Attributes.Add("style", "display:block");
                lblError.Text = "Select Student*";
                return;
            }
            else
            {
                lblError.Text = "";
                divError.Attributes.Add("style", "display:none");
            }
        }
    }
}