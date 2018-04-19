using AssessRite;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.Student
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("../../Login.aspx");
                }
                if (Request.QueryString["Mode"] == "Test")
                {
                    if (Session["TestAssignedId"] != null)
                    {
                        hdnTestAssignedId.Value = Session["TestAssignedId"].ToString();
                        string qur = "Select Status from TestAssigned where TestAssignedId=" + hdnTestAssignedId.Value;
                        string status = dbLibrary.idGetAFieldByQuery(qur);
                        if (status == "Taken")
                        {
                            Response.Redirect("ViewResult.aspx");
                        }
                        else
                        {
                            LoadQuestion(Request.QueryString["TestId"], hdnQuestionNo.Value, hdnTestAssignedId.Value);
                        }
                    }
                    else
                    {
                        Response.Redirect("../../AccessDenied.aspx");
                    }
                }
                else
                {
                    Response.Redirect("../AccessDenied.aspx");
                }
            }
            else
            {
                if (Session["FromSummary"] != null)
                {
                    if (Session["FromSummary"].ToString() == "True")
                    {
                        Session["FromSummary"] = "False";
                        LoadPaletteButtons();
                    }
                }
            }
        }


        private void LoadQuestion(string TestId, string QuestionNo, string TestAssignedId)
        {
            if (hdnQuestionNo.Value == "1")
            {
                btnPrevious.Attributes.Add("style", "display:none");
            }
            else
            {
                btnPrevious.Attributes.Add("style", "display:block");
            }
            string qur = dbLibrary.idBuildQuery("[proc_getQuestionForTest]", Request.QueryString["TestId"], QuestionNo, hdnTestAssignedId.Value);
            DataSet ds = dbLibrary.idGetCustomResult(qur);

            if (ds.Tables[0].Rows.Count > 0)
            {
                hdnTestQuestionId.Value = ds.Tables[0].Rows[0]["TestQuestionId"].ToString();
                hdnQuestionId.Value = ds.Tables[0].Rows[0]["QuestionId"].ToString();
                hdnAnswerTypeId.Value = ds.Tables[0].Rows[0]["AnswerTypeId"].ToString();
                lblQuestionNo.Text = hdnQuestionNo.Value;
                lblQuestion.Text = Regex.Replace(Server.HtmlDecode(ds.Tables[0].Rows[0]["Question"].ToString()), "<p>&nbsp;</p>", "");
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                lblTestKey.Text = ds.Tables[1].Rows[0]["TestKey"].ToString();
                lblSubject.Text = ds.Tables[1].Rows[0]["SubjectName"].ToString();
            }
            if (ds.Tables[2].Rows.Count > 0)
            {
                if (hdnAnswerTypeId.Value == "1")
                {
                    divOptions.Attributes.Add("style", "display:block");
                    radbtnOptions.DataTextField = "Answer";
                    radbtnOptions.DataValueField = "AnswerId";
                    radbtnOptions.DataSource = ds.Tables[2];
                    radbtnOptions.DataBind();
                }
                else if (hdnAnswerTypeId.Value == "3")
                {
                    radbtnOptions.Items.Clear();
                    divOptions.Attributes.Add("style", "display:block");
                    int count = ds.Tables[2].Rows.Count;
                    for (int i = 0; i <= count - 1; i++)
                    {
                        radbtnOptions.Items.Add(new ListItem("<img src='" + ds.Tables[2].Rows[i]["Answer"].ToString().Split('~')[1] + "' width='" + "80" + "' height='" + "60" + "'/>", ds.Tables[2].Rows[i]["AnswerId"].ToString()));
                    }
                }
            }
            if (ds.Tables[3].Rows.Count > 0)
            {
                hdnTotal.Value = ds.Tables[3].Rows[0]["TotalCount"].ToString();
                lblTotalQuestions.Text = "Question No. " + hdnQuestionNo.Value + " out of " + hdnTotal.Value;
                // pnlPalette.Controls.Clear();
                //  LoadPaletteButtons();
                if (hdnQuestionNo.Value == ds.Tables[3].Rows[0]["TotalCount"].ToString())
                {
                    btnNext.Text = "Save & Go To Summary";
                    //    divSummary.Visible = true;
                    //    pnlPalette.Controls.Clear();
                    //    LoadPaletteButtons();
                }
                //else
                //{
                //    divSummary.Visible = false;
                //}
            }
            if (ds.Tables[4].Rows.Count > 0)
            {
                if (ds.Tables[4].Rows[0]["StudentAnswerId"].ToString() != "0")
                {
                    radbtnOptions.SelectedValue = ds.Tables[4].Rows[0]["StudentAnswerId"].ToString();
                }
            }
        }

        private void LoadPaletteButtons()
        {
            for (int i = 1; i <= int.Parse(hdnTotal.Value); i++)
            {
                Button newButton = new Button();
                newButton.ID = "btn" + i;
                newButton.Click += new EventHandler(button_Click);
                newButton.Text = i.ToString();
                pnlPalette.Controls.Add(newButton);
                LoadPaletteColor();
            }
        }

        private void button_Click(object sender, EventArgs e)
        {
            btnNext.Text = "Save & Next";
            divMain.Attributes.Add("style", "display:block");
            divSummary.Attributes.Add("style", "display:none");
            Button btn = (Button)sender;
            string no = btn.ID.Replace("btn", "").Trim();
            hdnQuestionNo.Value = no;
            LoadQuestion(Request.QueryString["TestId"], no, hdnTestAssignedId.Value);
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            btnPrevious.Enabled = false;
            btnNext.Text = "Save & Next";
            hdnQuestionNo.Value = (int.Parse(hdnQuestionNo.Value) - 1).ToString();
            LoadQuestion(Request.QueryString["TestId"], hdnQuestionNo.Value, hdnTestAssignedId.Value);
            btnPrevious.Enabled = true;
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            btnNext.Enabled = false;
            //if (radbtnOptions.SelectedIndex != -1)
            //{
            string qur = dbLibrary.idBuildQuery("[proc_saveAnswers]", hdnTestAssignedId.Value, hdnTestQuestionId.Value, radbtnOptions.SelectedValue, "MultipleChoice");
            dbLibrary.idExecute(qur);
            //  }
            if (int.Parse(hdnQuestionNo.Value) == int.Parse(hdnTotal.Value))
            {
                divMain.Attributes.Add("style", "display:none");
                divSummary.Attributes.Add("style", "display:block");
                LoadPaletteButtons();
                Session["FromSummary"] = "True";
            }
            else
            {
                hdnQuestionNo.Value = (int.Parse(hdnQuestionNo.Value) + 1).ToString();
                LoadQuestion(Request.QueryString["TestId"], hdnQuestionNo.Value, hdnTestAssignedId.Value);
                //LoadPaletteColor();
            }
            btnNext.Enabled = true;
        }

        private void LoadPaletteColor()
        {
            foreach (var button in pnlPalette.Controls.OfType<Button>())
            {
                // Set the value of each one
                button.BackColor = Color.Orange;
            }
            string qur1 = "SELECT  TestQuestions.QuestionNo,StudentAnswers.StudentAnswerId FROM StudentAnswers LEFT OUTER JOIN TestQuestions ON StudentAnswers.TestQuestionId = TestQuestions.TestQuestionId Where StudentAnswers.TestAssignedId = '" + hdnTestAssignedId.Value + "'";
            DataSet ds1 = dbLibrary.idGetCustomResult(qur1);
            ViewState["AnsweredQuestions"] = ds1;
            if (ds1.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                {
                    int questionNo = int.Parse(ds1.Tables[0].Rows[i][0].ToString());
                    int studentanswerid = int.Parse(ds1.Tables[0].Rows[i][1].ToString());
                    if (studentanswerid != 0)
                    {
                        string control = "btn" + questionNo.ToString();
                        if (pnlPalette.FindControl(control) != null)
                        {
                            Button btn = pnlPalette.FindControl(control) as Button;
                            btn.BackColor = Color.Green;
                        }
                    }
                }
            }
            //string control1 = "btn" + hdnQuestionNo.Value;
            //if (pnlPalette.FindControl(control1) != null)
            //{
            //    Button btn = pnlPalette.FindControl(control1) as Button;
            //    btn.BackColor = Color.MediumPurple;
            //}
        }

        protected void btnGoBack_Click(object sender, EventArgs e)
        {
            divMain.Attributes.Add("style", "display:block");
            divSummary.Attributes.Add("style", "display:none");
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            btnFinish.Enabled = false;
            DataSet ds = (DataSet)ViewState["AnsweredQuestions"];
            if (ds.Tables[0].Rows.Count > 0)
            {
                string qur = dbLibrary.idBuildQuery("[proc_FinishTest]", hdnTestAssignedId.Value);
                dbLibrary.idExecute(qur);
                Response.Redirect("StudentQuestionPaper.aspx?TestId=" + Request.QueryString["TestId"].ToString() + "&Mode=View");
            }
            else
            {
                Response.Redirect("TakeTest.aspx");
            }
        }
    }
}