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
    public partial class CreateTest : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadDropDown();
                // LoadGrid();
            }
        }

        private void LoadDropDown()
        {
            string qur="Select TestType from SchoolTestType where SchoolId='" + Session["InstitutionId"].ToString() + "'";
            if(dbLibrary.idHasRows(qur))
            {
                DataSet ds1 = dbLibrary.idGetCustomResult(qur);
                ddlTestType.DataTextField = "TestType";
                ddlTestType.DataValueField = "TestType";
                ddlTestType.DataSource = ds1;
                ddlTestType.DataBind();
                ddlTestType.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlTestType.SelectedIndex = 0;
            }
            qur = "Select * from Class where IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "' ORDER BY MasterClassId";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlTestClass.DataTextField = "ClassName";
                ddlTestClass.DataValueField = "ClassId";
                ddlTestClass.DataSource = ds;
                ddlTestClass.DataBind();
                ddlTestClass.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlTestClass.SelectedIndex = 0;
            }

        }

        private void LoadSubject()
        {
            string qur = "Select * from Subject where ClassId=" + ddlTestClass.SelectedValue + " and IsDeleted='0'";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlTestSubject.DataTextField = "SubjectName";
                ddlTestSubject.DataValueField = "SubjectId";
                ddlTestSubject.DataSource = ds;
                ddlTestSubject.DataBind();
                ddlTestSubject.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlTestSubject.SelectedIndex = 0;
            }
            else
            {
                ddlTestSubject.Items.Clear();
            }
        }

        private void LoadConcept()
        {
            string qur = "Select * from Concept where ClassId=" + ddlTestClass.SelectedValue + " and SubjectId=" + ddlTestSubject.SelectedValue + " and IsDeleted='0'";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                chkConcepts.DataTextField = "ConceptName";
                chkConcepts.DataValueField = "ConceptId";
                chkConcepts.DataSource = ds;
                chkConcepts.DataBind();
                // chkConcepts.Items.Insert(0, new ListItem("--All--", "0"));
                // chkConcepts.SelectedIndex = 0;
            }
            else
            {
                chkConcepts.Items.Clear();
            }
        }
        protected void ddlTestClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadSubject();
        }

        protected void btnCreateTest_Click(object sender, EventArgs e)
        {
            divError.Attributes.Add("Style", "display:none");
            if (ddlTestType.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Attributes.Add("style", "color:red");
                lblError.Text = "Please Select Test Type";
                return;
            }
            if (ddlTestClass.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Attributes.Add("style", "color:red");
                lblError.Text = "Please Select Class";
                return;
            }
            if (ddlTestSubject.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Attributes.Add("style", "color:red");
                lblError.Text = "Please Select Subject";
                return;
            }
            int counter = 0;
            foreach(ListItem li in chkConcepts.Items)
            {
                if(li.Selected)
                {
                    counter++;
                }
            }
            if(counter==0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Attributes.Add("style", "color:red");
                lblError.Text = "Please Select Concept";
                return;
            }
            if (txtNoOfQuestions.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Attributes.Add("style", "color:red");
                lblError.Text = "Please Enter No. of Questions";
                return;
            }
            again:
            string testkey = GenerateUniqueTestKey();
            string qur = "select TestKey from Test where TestKey='" + testkey + "'";
            string value = dbLibrary.idGetAFieldByQuery(qur);
            if (!(string.IsNullOrEmpty(value)))
            {
                goto again;
            }
            else
            {
                // string testkey1= Convert.ToBase64String(Guid.NewGuid().ToByteArray()).Substring(0, 6);
                string qur1 = dbLibrary.idBuildQuery("[proc_CreateTest]", ddlTestType.SelectedValue.ToString(), ddlTestClass.SelectedValue.ToString(), ddlTestSubject.SelectedValue.ToString(), Session["UserId"].ToString(), testkey, txtNoOfQuestions.Text.Trim());
                string testId = dbLibrary.idGetAFieldByQuery(qur1);

                int count = chkConcepts.Items.Count;
                DataTable dtTestConcepts = new DataTable();
                dtTestConcepts.Columns.Add("ConceptId");
                dtTestConcepts.Columns.Add("TestId");
                dtTestConcepts.Columns.Add("TestKey");
                //if (chkConcepts.Items[0].Selected)
                //{
                //    for (int i = 1; i <= count-1; i++)
                //    {
                //        dtTestConcepts.Rows.Add(chkConcepts.Items[i].Value.ToString(), testId, testkey);
                //    }
                //}
                //else
                //{
                foreach (ListItem li in chkConcepts.Items)
                {
                    if (li.Selected)
                    {
                        dtTestConcepts.Rows.Add(li.Value.ToString(), testId, testkey);
                    }
                }
                //}
                if (dtTestConcepts.Rows.Count > 0)
                {
                    dbLibrary.idInsertDataTable("proc_saveTestConcepts", "@List", dtTestConcepts);
                }
                divError.Attributes.Add("Style", "margin-top:5px; display:block");
                lblError.Attributes.Add("style", "color:green");
                lblError.Text = "Test Created. Test ID is: " + testkey;
                btnCreateTest.Visible = false;
                string questiontypemc="", questiontypeba="", questiontypemci = "";
                if(ddlTestType.SelectedValue=="Offline")
                {
                    questiontypemc = chkQuestionType.Items[0].Selected == true ? chkQuestionType.Items[0].Value : "";
                    questiontypeba = chkQuestionType.Items[1].Selected == true ? chkQuestionType.Items[1].Value : "";
                    questiontypemci = chkQuestionType.Items[2].Selected == true ? chkQuestionType.Items[2].Value : "";
                }
                qur = dbLibrary.idBuildQuery("[proc_generateQuestionPaperWithConcept]", testId, questiontypemc,questiontypeba,questiontypemci);
                string totalnoOfQuestions = dbLibrary.idGetAFieldByQuery(qur);
                lblTotQuestions.Text = totalnoOfQuestions + " Questions Added to the Test";

                divOffline.Attributes.Add("style", "margin-top:10px; margin-bottom:5px; display:block");
                link.NavigateUrl = "QuestionPaper.aspx?TestId=" + testId + "&Mode=Offline";
            }
            //  string qur = "SELECT IDENT_CURRENT ('Test') as id";
        }

        private static Random random = new Random();
        private string GenerateUniqueTestKey()
        {
            int length = 6;
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[random.Next(s.Length)]).ToArray());
            //string key = string.Empty;
            //return key;
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            ClearAll();
        }

        private void ClearAll()
        {
            chkConceptsAll.Checked = false;
            ddlTestClass.SelectedIndex = 0;
            ddlTestSubject.Items.Clear();
            txtNoOfQuestions.Text = "";
            btnCreateTest.Visible = true;
            divError.Attributes.Add("Style", "display:none");
            chkConcepts.Items.Clear();
            divConcept.Attributes.Add("style", "display:none");
            lblTotQuestions.Text = "";
            divOffline.Attributes.Add("style", "margin-top:10px; margin-bottom:5px; display:none");
        }

        protected void ddlTestSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadConcept();
            if (ddlTestSubject.SelectedIndex != 0)
            {
                divConcept.Attributes.Add("style", "display:block;margin-top:5px;");
            }
            else
            {
                divConcept.Attributes.Add("style", "display:none;margin-top:5px;");
            }
        }

        protected void chkConceptsAll_CheckedChanged(object sender, EventArgs e)
        {
            if (chkConceptsAll.Checked)
            {
                foreach (ListItem li in chkConcepts.Items)
                {
                    li.Selected = true;
                }
            }
            else
            {
                foreach (ListItem li in chkConcepts.Items)
                {
                    li.Selected = false;
                }
            }
        }

        protected void chkConcepts_SelectedIndexChanged(object sender, EventArgs e)
        {
            int count = 0;
            foreach (ListItem li in chkConcepts.Items)
            {
                if (li.Selected)
                {
                    count++;
                }
            }
            if (chkConcepts.Items.Count == count)
            {
                chkConceptsAll.Checked = true;
            }
            else
            {
                chkConceptsAll.Checked = false;
            }

        }

        protected void ddlTestType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(ddlTestType.SelectedValue== "Offline")
            {
                divQuestionType.Attributes.Add("style", "display:block");
            }
            else
            {
                divQuestionType.Attributes.Add("style", "display:none");
            }
        }
    }
}