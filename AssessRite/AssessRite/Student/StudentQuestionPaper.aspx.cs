using HtmlAgilityPack;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace AssessRite
{
    public partial class StudentQuestionPaper : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                if (Request.QueryString["TestId"] != null)
                {
                    if (Request.QueryString["Mode"] != null)
                    {
                        if (Request.QueryString["Mode"] == "Test")
                        {
                            hdnTestAssignedId.Value = Session["TestAssignedId"].ToString();
                            LoadQuestions();
                            btnSave.Visible = true;

                        }
                        else if (Request.QueryString["Mode"] == "View")
                        {
                            // LoadQuestionsAndAnswers();
                            if (Session["UserType"].ToString() != "4" || Session["TestAssignedId"] != null)
                            {
                                hdnTestAssignedId.Value = Session["TestAssignedId"].ToString();
                                LoadQuestions();
                                btnSave.Visible = false;

                            }
                        }
                        else if (Request.QueryString["Mode"] == "Offline")
                        {
                            LoadQuestions();
                            btnSave.Visible = false;
                        }
                        else if (Request.QueryString["Mode"] == "ResultEntry")
                        {
                            hdnTestAssignedId.Value = Session["TestAssignedId"].ToString();
                            LoadQuestions();
                            btnSave.Visible = true;

                        }
                    }
                    else
                    {
                        Response.Redirect("ViewResult.aspx");
                    }
                }
                else
                {
                    Response.Redirect("ViewResult.aspx");
                }
                if (Session["UserType"].ToString() == "4") //Student
                {
                    printButton.Attributes.Add("style", "display:none");
                }
            }
        }

        //private void LoadQuestionsAndAnswers()
        //{
        //    //string qur = dbLibrary.idBuildQuery("[proc_getTestPaper]", Request.QueryString["TestId"]);
        //    //DataSet ds = dbLibrary.idGetCustomResult(qur);
        //    //rptQuestions.DataSource = ds;
        //    //rptQuestions.DataBind();
        //}

        private void LoadQuestions()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getTestPaper]", Request.QueryString["TestId"]);
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            rptQuestions.DataSource = ds.Tables[0];
            rptQuestions.DataBind();
            if (ds.Tables[1].Rows.Count > 0)
            {
                lblTestKey.Text = ds.Tables[1].Rows[0]["TestKey"].ToString();
                lblSubject.Text = ds.Tables[1].Rows[0]["SubjectName"].ToString();
            }
        }

        protected void rptQuestions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                RadioButtonList radbtnOptions = (RadioButtonList)e.Item.FindControl("radbtnOptions");
                HiddenField hdnQuestionId = (HiddenField)e.Item.FindControl("hdnQuestionId");
                HiddenField hdnAnswerTypeId = (HiddenField)e.Item.FindControl("hdnAnswerTypeId");
                HtmlGenericControl divOptions = (HtmlGenericControl)e.Item.FindControl("divOptions");
                HtmlGenericControl divBrief = (HtmlGenericControl)e.Item.FindControl("divBrief");
                HtmlGenericControl divAnswer = (HtmlGenericControl)e.Item.FindControl("divAnswer");
                TextBox txtAnswer = (TextBox)e.Item.FindControl("txtAnswer");
                Label lblRightAnswer = (Label)e.Item.FindControl("lblRightAnswer");
                Image imgRightAnswer = (Image)e.Item.FindControl("imgRightAnswer");
                string qur = "SELECT Answers.AnswerId, Answers.Answer  FROM  Answers RIGHT OUTER JOIN Questions ON Answers.QuestionId = Questions.QuestionId Where Questions.QuestionId='" + hdnQuestionId.Value + "'";
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                if (hdnAnswerTypeId.Value == "1")
                {
                    divOptions.Attributes.Add("style", "display:block");
                    divBrief.Attributes.Add("style", "display:none");
                    radbtnOptions.DataTextField = "Answer";
                    radbtnOptions.DataValueField = "AnswerId";
                    radbtnOptions.DataSource = ds;
                    radbtnOptions.DataBind();
                }
                else if (hdnAnswerTypeId.Value == "3")
                {
                    divOptions.Attributes.Add("style", "display:block");
                    divBrief.Attributes.Add("style", "display:none");
                    int count = ds.Tables[0].Rows.Count;
                    for (int i = 0; i <= count - 1; i++)
                    {
                        radbtnOptions.Items.Add(new ListItem("<img src='" + ds.Tables[0].Rows[i]["Answer"].ToString().Split('~')[1] + "' width='" + "80" + "' height='" + "60" + "'/>", ds.Tables[0].Rows[i]["AnswerId"].ToString()));
                    }
                }
                else if (hdnAnswerTypeId.Value == "2")
                {
                    divBrief.Attributes.Add("style", "display:block");
                }

                if (Request.QueryString["Mode"] == "ResultEntry")
                {
                    qur = "SELECT  Questions.AnswerTypeId, TestQuestions.RightAnswerId, Answers.Answer FROM  TestQuestions LEFT OUTER JOIN Answers ON TestQuestions.RightAnswerId = Answers.AnswerId LEFT OUTER JOIN Questions ON TestQuestions.QuestionId = Questions.QuestionId where TestQuestions.TestId='" + Request.QueryString["TestId"] + "' and TestQuestions.QuestionId='" + hdnQuestionId.Value + "'";
                    DataSet ds1 = dbLibrary.idGetCustomResult(qur);
                    if (hdnAnswerTypeId.Value == "2")
                    {
                        string qur1 = "Select Answer from Answers where QuestionId='" + hdnQuestionId.Value + "'";
                        DataSet ds2 = dbLibrary.idGetCustomResult(qur1);
                        if (ds2.Tables[0].Rows.Count > 0)
                        {
                            txtAnswer.Text = ds2.Tables[0].Rows[0]["Answer"].ToString();
                        }
                        divOptions.Attributes.Add("style", "display:block");
                        radbtnOptions.Items.Add(new ListItem("Right Answer", "1"));
                        radbtnOptions.Items.Add(new ListItem("Wrong Answer", "0"));
                        divAnswer.Attributes.Add("style", "display:none");
                    }
                    else if (hdnAnswerTypeId.Value == "1")
                    {
                        divAnswer.Attributes.Add("style", "display:block");
                        lblRightAnswer.Text = ds1.Tables[0].Rows[0]["Answer"].ToString();
                        if (lblRightAnswer.Text.StartsWith("<p>"))
                        {
                            lblRightAnswer.Text = lblRightAnswer.Text.Substring(3);
                        }
                        if (lblRightAnswer.Text.EndsWith("</p>"))
                        {
                            lblRightAnswer.Text = lblRightAnswer.Text.Substring(0, lblRightAnswer.Text.Length - 4);
                        }
                        imgRightAnswer.Visible = false;

                    }
                    else
                    {
                        divAnswer.Attributes.Add("style", "display:block");
                        lblRightAnswer.Text = "";
                        imgRightAnswer.Visible = true;
                        imgRightAnswer.ImageUrl = ds1.Tables[0].Rows[0]["Answer"].ToString();
                    }
                }
                if (Request.QueryString["Mode"] == "View")
                {
                    Image imgStatus = (Image)e.Item.FindControl("imgStatus");

                    qur = "SELECT Questions.AnswerTypeId, TestQuestions.RightAnswerId, Answers.Answer, StudentAnswers.StudentAnswerId, StudentAnswers.IsRightAnswer FROM TestQuestions LEFT OUTER JOIN StudentAnswers ON TestQuestions.TestQuestionId = StudentAnswers.TestQuestionId LEFT OUTER JOIN Answers ON TestQuestions.RightAnswerId = Answers.AnswerId LEFT OUTER JOIN Questions ON TestQuestions.QuestionId = Questions.QuestionId where TestQuestions.TestId='" + Request.QueryString["TestId"] + "' and TestQuestions.QuestionId='" + hdnQuestionId.Value + "' and StudentAnswers.TestAssignedId='" + hdnTestAssignedId.Value + "'";
                    DataSet ds2 = dbLibrary.idGetCustomResult(qur);
                    if (hdnAnswerTypeId.Value == "2")
                    {
                        divOptions.Attributes.Add("style", "display:block");
                        divBrief.Attributes.Add("style", "display:block");
                        string qur6 = "Select Answer from Answers where QuestionId='" + hdnQuestionId.Value + "'";
                        DataSet ds4 = dbLibrary.idGetCustomResult(qur6);
                        if (ds4.Tables[0].Rows.Count > 0)
                        {
                            txtAnswer.Text = ds4.Tables[0].Rows[0]["Answer"].ToString();
                        }
                        //  txtAnswer.Text = ds2.Tables[0].Rows[0]["Answer"].ToString();
                        if (ds2.Tables[0].Rows[0]["IsRightAnswer"].ToString() == "True")
                        {
                            imgStatus.Visible = true;
                            imgStatus.ImageUrl = "../images/right.png";
                        }
                        else
                        {
                            imgStatus.Visible = true;
                            imgStatus.ImageUrl = "../images/wrong.png";
                        }
                        divAnswer.Attributes.Add("style", "display:none");
                        imgRightAnswer.Visible = false;

                        //if (radbtnOptions.SelectedValue == "1")
                        //{
                        //    imgStatus.Visible = true;
                        //    imgStatus.ImageUrl = "images/right.png";
                        //}
                        //else
                        //{
                        //    imgStatus.Visible = true;
                        //    imgStatus.ImageUrl = "images/wrong.png";
                        //}
                        //imgStatus.Visible = true;
                        //if (bool.Parse(ds2.Tables[0].Rows[0]["IsRightAnswer"].ToString()))
                        //{
                        //    divAnswer.Attributes.Add("style", "display:none");
                        //    imgStatus.ImageUrl = "images/right.png";
                        //}
                        //else
                        //{
                        //    imgStatus.ImageUrl = "images/wrong.png";
                        //    imgRightAnswer.Visible = false;
                        //}

                    }
                    else if (hdnAnswerTypeId.Value == "1")
                    {
                        divOptions.Attributes.Add("style", "display:block");
                        divBrief.Attributes.Add("style", "display:none");
                        imgStatus.Visible = true;
                        if (ds2.Tables[0].Rows.Count > 0)
                        {
                            radbtnOptions.SelectedValue = ds2.Tables[0].Rows[0]["StudentAnswerId"].ToString();
                            radbtnOptions.Enabled = false;

                            if (bool.Parse(ds2.Tables[0].Rows[0]["IsRightAnswer"].ToString()))
                            {
                                divAnswer.Attributes.Add("style", "display:none");
                                imgStatus.ImageUrl = "../images/right.png";
                            }
                            else
                            {
                                imgStatus.ImageUrl = "../images/wrong.png";
                                divAnswer.Attributes.Add("style", "display:block");
                                lblRightAnswer.Text = ds2.Tables[0].Rows[0]["Answer"].ToString();
                                if (lblRightAnswer.Text.StartsWith("<p>"))
                                {
                                    lblRightAnswer.Text = lblRightAnswer.Text.Substring(3);
                                }
                                if (lblRightAnswer.Text.EndsWith("</p>"))
                                {
                                    lblRightAnswer.Text = lblRightAnswer.Text.Substring(0, lblRightAnswer.Text.Length - 4);
                                }
                                imgRightAnswer.Visible = false;
                            }
                        }
                        else
                        {
                            imgStatus.ImageUrl = "../images/wrong.png";
                        }
                    }
                    else
                    {
                        divOptions.Attributes.Add("style", "display:block");
                        divBrief.Attributes.Add("style", "display:none");
                        imgStatus.Visible = true;
                        if (ds2.Tables[0].Rows.Count > 0)
                        {
                            radbtnOptions.SelectedValue = ds2.Tables[0].Rows[0]["StudentAnswerId"].ToString();
                            radbtnOptions.Enabled = false;

                            if (bool.Parse(ds2.Tables[0].Rows[0]["IsRightAnswer"].ToString()))
                            {
                                divAnswer.Attributes.Add("style", "display:none");
                                imgStatus.ImageUrl = "../images/right.png";

                            }
                            else
                            {
                                imgStatus.ImageUrl = "../images/wrong.png";
                                divAnswer.Attributes.Add("style", "display:block");
                                lblRightAnswer.Text = "";
                                imgRightAnswer.Visible = true;
                                imgRightAnswer.ImageUrl = ds2.Tables[0].Rows[0]["Answer"].ToString();
                            }
                        }
                        else
                        {
                            imgStatus.ImageUrl = "../images/wrong.png";
                        }
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            btnSave.Enabled = false;
            foreach (RepeaterItem item in rptQuestions.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    HiddenField hdnQuestionId = (HiddenField)item.FindControl("hdnQuestionId");
                    HiddenField hdnAnswerTypeId = (HiddenField)item.FindControl("hdnAnswerTypeId");
                    HiddenField hdnTestQuestionId = (HiddenField)item.FindControl("hdnTestQuestionId");
                    RadioButtonList radbtnOptions = (RadioButtonList)item.FindControl("radbtnOptions");
                    TextBox txtAnswer = (TextBox)item.FindControl("txtAnswer");
                    if (hdnAnswerTypeId.Value == "2")
                    {
                        string qur = dbLibrary.idBuildQuery("[proc_saveAnswers]", hdnTestAssignedId.Value, hdnTestQuestionId.Value, radbtnOptions.SelectedValue, "Brief");
                        dbLibrary.idExecute(qur);
                    }
                    else
                    {
                        string qur = dbLibrary.idBuildQuery("[proc_saveAnswers]", hdnTestAssignedId.Value, hdnTestQuestionId.Value, radbtnOptions.SelectedValue, "MultipleChoice");
                        dbLibrary.idExecute(qur);
                    }
                }
            }
            btnSave.Enabled = true;
            Response.Redirect("StudentQuestionPaper.aspx?TestId=" + Request.QueryString["TestId"].ToString() + "&Mode=View");
        }
    }
}