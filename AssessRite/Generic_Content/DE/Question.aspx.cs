using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace AssessRite.Generic_Content.DE
{
    public partial class Question : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                loadDropDown();
                if (Request.QueryString["QuestionId"] != null)
                {
                    loadQuestion();
                }
            }
        }
        private void loadQuestion()
        {
            Session["QuestionId"] = Request.QueryString["QuestionId"].ToString();
            string qur = dbLibrary.idBuildQuery("proc_getQuestionForEditing", Request.QueryString["QuestionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlClassName.SelectedValue = ds.Tables[0].Rows[0]["ClassId"].ToString();
                ddlClassName_SelectedIndexChanged(ddlClassName.SelectedValue, EventArgs.Empty);
                ddlSubject.SelectedValue = ds.Tables[0].Rows[0]["SubjectId"].ToString();
                ddlSubject_SelectedIndexChanged(ddlSubject.SelectedValue, EventArgs.Empty);
                ddlConcepts.SelectedValue = ds.Tables[0].Rows[0]["ConceptId"].ToString();
                ddlConcepts_SelectedIndexChanged(ddlConcepts.SelectedValue, EventArgs.Empty);
                ddlObjectives.SelectedValue = ds.Tables[0].Rows[0]["ObjectiveId"].ToString();
                txtQuestion.Text = ds.Tables[0].Rows[0]["Question"].ToString();
                ddlAnswerType.SelectedValue = ds.Tables[0].Rows[0]["AnswerTypeId"].ToString();
                Session["answertype"] = ds.Tables[0].Rows[0]["AnswerTypeId"].ToString();
                EnableDisableOptions();
                if (ddlAnswerType.SelectedValue == "1" || ddlAnswerType.SelectedValue == "3")
                {
                    LoadRepeater();
                }
                if (ddlAnswerType.SelectedValue == "2")
                {
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        txtAnswerKey.Text = ds.Tables[1].Rows[0]["Answer"].ToString();
                    }
                    else
                    {
                        txtAnswerKey.Text = "";
                    }
                }
                if (ddlAnswerType.SelectedValue == "1")
                {
                    btnUpdate.Visible = true;
                    lblUError.Visible = false;

                }
                else if (ddlAnswerType.SelectedValue == "3")
                {
                    lblUError.Visible = true;
                    btnUpdate.Visible = false;
                }

                btnQuestionsSave.Text = "Update Question";
            }
        }

        private void loadDropDown()
        {
            //string qur1 = dbLibrary.idBuildQuery("[proc_getDataForQuestion]", Session["InstitutionId"].ToString());
            //DataSet ds = dbLibrary.idGetCustomResult(qur1);
            //ViewState["Data"] = ds;
            //try
            //{
            //    if (ds.Tables[0].Rows.Count > 0)
            //    {
            //        ddlClassName.DataTextField = "ClassName";
            //        ddlClassName.DataValueField = "ClassId";
            //        ddlClassName.DataSource = ds.Tables[0];
            //        ddlClassName.DataBind();
            //        ddlClassName.Items.Insert(0, new ListItem("--Select--", "-1"));
            //        ddlClassName.SelectedIndex = 0;
            //    }
            //}
            //catch (Exception ex)
            //{
            //    ddlClassName.Items.Clear();
            //}
            //try
            //{
            //    if (ds.Tables[4].Rows.Count > 0)
            //    {
            //        ddlAnswerType.DataTextField = "AnswerType";
            //        ddlAnswerType.DataValueField = "AnswerTypeId";
            //        ddlAnswerType.DataSource = ds.Tables[4];
            //        ddlAnswerType.DataBind();
            //        ddlAnswerType.Items.Insert(0, new ListItem("--Select--", "-1"));
            //        ddlAnswerType.SelectedIndex = 0;
            //    }
            //}
            //catch (Exception ex)
            //{
            //    ddlAnswerType.Items.Clear();
            //}
            string qur = "Select * from Class where IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "' ORDER BY MasterClassId";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlClassName.DataTextField = "ClassName";
                ddlClassName.DataValueField = "ClassId";
                ddlClassName.DataSource = ds;
                ddlClassName.DataBind();
                ddlClassName.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlClassName.SelectedIndex = 0;
            }
            else
            {
                ddlClassName.Items.Clear();
            }
            qur = "Select * from AnswerType";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlAnswerType.DataTextField = "AnswerType";
                ddlAnswerType.DataValueField = "AnswerTypeId";
                ddlAnswerType.DataSource = ds;
                ddlAnswerType.DataBind();
                ddlAnswerType.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlAnswerType.SelectedIndex = 0;
            }
            else
            {
                ddlAnswerType.Items.Clear();
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            btnQuestionsSave.Text = "Save Question";
            txtQuestion.Text = "";
            ddlAnswerType.SelectedIndex = 0;
            divOptions.Attributes.Add("Style", "display:none");
            Session.Remove("QuestionId");
            Session.Remove("answertype");
            btnUpdate.Visible = false;
            lblUError.Visible = false;
            divError.Attributes.Add("Style", "display:none");
            //  btnDeleteQ.Visible = false;
            //   gridQuestion.SelectedIndex = -1;
            //   loadGrid();
            //  btnDeleteQ.Visible = false;
            txtAnswerKey.Text = "";
            divAnswerKey.Attributes.Add("style", "display:none;");

        }

        protected void ddlClassName_SelectedIndexChanged(object sender, EventArgs e)
        {
            //DataSet ds = (DataSet)ViewState["Data"];
            //DataTable dt = ds.Tables[1];
            //if (dt.Rows.Count > 0)
            //{
            //    try
            //    {
            //        var results = (from myRow in dt.AsEnumerable()
            //                       where (int)myRow["ClassId"] == int.Parse(ddlClassName.SelectedValue)
            //                       select myRow).CopyToDataTable();
            //        DataTable dtTemp = (DataTable)results;
            //        ddlSubject.DataTextField = "SubjectName";
            //        ddlSubject.DataValueField = "SubjectId";
            //        ddlSubject.DataSource = dtTemp;
            //        ddlSubject.DataBind();
            //        ddlSubject.Items.Insert(0, new ListItem("--Select--", "-1"));
            //        ddlSubject.SelectedIndex = 0;
            //    }
            //    catch (Exception ex)
            //    {
            //        ddlSubject.Items.Clear();
            //    }

            //}
            //else
            //{
            //    ddlSubject.Items.Clear();
            //}
            string qur = "Select * from Subject where IsDeleted='0' and ClassId=" + ddlClassName.SelectedValue;
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataSource = ds;
                ddlSubject.DataBind();
                ddlSubject.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlSubject.SelectedIndex = 0;
            }
            else
            {
                ddlSubject.Items.Clear();
                ddlConcepts.Items.Clear();
                ddlObjectives.Items.Clear();

            }
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            //DataSet ds = (DataSet)ViewState["Data"];
            //DataTable dt = ds.Tables[2];
            //if (dt.Rows.Count > 0)
            //{
            //    try
            //    {
            //        var results = (from myRow in dt.AsEnumerable()
            //                       where (int)myRow["ClassId"] == int.Parse(ddlClassName.SelectedValue) && (int)myRow["SubjectId"] == int.Parse(ddlSubject.SelectedValue)
            //                       select myRow).CopyToDataTable();
            //        DataTable dtTemp = (DataTable)results;
            //        ddlConcepts.DataTextField = "ConceptName";
            //        ddlConcepts.DataValueField = "ConceptId";
            //        ddlConcepts.DataSource = dtTemp;
            //        ddlConcepts.DataBind();
            //        ddlConcepts.Items.Insert(0, new ListItem("--Select--", "-1"));
            //        ddlConcepts.SelectedIndex = 0;
            //    }
            //    catch (Exception ex)
            //    {
            //        ddlConcepts.Items.Clear();
            //    }
            //}
            //else
            //{
            //    ddlConcepts.Items.Clear();
            //}
            // loadGrid();
            string qur = "Select * from Concept where IsDeleted='0' and ClassId=" + ddlClassName.SelectedValue + " and SubjectId=" + ddlSubject.SelectedValue;
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlConcepts.DataTextField = "ConceptName";
                ddlConcepts.DataValueField = "ConceptId";
                ddlConcepts.DataSource = ds;
                ddlConcepts.DataBind();
                ddlConcepts.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlConcepts.SelectedIndex = 0;
            }
            else
            {
                ddlConcepts.Items.Clear();
                ddlObjectives.Items.Clear();
            }
        }

        private void loadObjective()
        {
            //DataSet ds = (DataSet)ViewState["Data"];
            //DataTable dt = ds.Tables[3];
            //if (dt.Rows.Count > 0)
            //{
            //    try
            //    {
            //        var results = (from myRow in dt.AsEnumerable()
            //                       where (int)myRow["SubjectId"] == int.Parse(ddlSubject.SelectedValue) && (int)myRow["ConceptId"] == int.Parse(ddlConcepts.SelectedValue)
            //                       select myRow).CopyToDataTable();
            //        DataTable dtTemp = (DataTable)results;
            //        ddlObjectives.DataTextField = "ObjectiveName";
            //        ddlObjectives.DataValueField = "ObjectiveId";
            //        ddlObjectives.DataSource = dtTemp;
            //        ddlObjectives.DataBind();
            //        ddlObjectives.Items.Insert(0, new ListItem("--Select--", "-1"));
            //        ddlObjectives.SelectedIndex = 0;
            //    }
            //    catch (Exception ex)
            //    {
            //        ddlObjectives.Items.Clear();
            //    }
            //}
            //else
            //{
            //    ddlObjectives.Items.Clear();
            //}
            string qur = "Select * from Objectives where IsDeleted='0' and SubjectId=" + ddlSubject.SelectedValue + " and ConceptId=" + ddlConcepts.SelectedValue;
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlObjectives.DataTextField = "ObjectiveName";
                ddlObjectives.DataValueField = "ObjectiveId";
                ddlObjectives.DataSource = ds;
                ddlObjectives.DataBind();
                ddlObjectives.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlObjectives.SelectedIndex = 0;
            }
            else
            {
                ddlObjectives.Items.Clear();
            }
        }
        protected void ddlConcepts_SelectedIndexChanged(object sender, EventArgs e)
        {
            loadObjective();
            //loadGrid();
            // loadConcepts();

            //qur = "SELECT  Questions.QuestionId, Questions.Question, AnswerType.AnswerType, AnswerType.AnswerTypeId FROM  Questions LEFT OUTER JOIN AnswerType ON Questions.AnswerTypeId = AnswerType.AnswerTypeId where Questions.SubjectId=" + ddlSubject.SelectedValue + " and Questions.ConceptId=" + ddlConcepts.SelectedValue;
            //DataSet ds1 = dbLibrary.idGetCustomResult(qur);
            //gridQuestion.DataSource = ds1;
            //gridQuestion.DataBind();
        }

        protected void ddlAnswerType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAnswerType.SelectedValue == "1" || ddlAnswerType.SelectedValue == "3")
            {
                //divOptions.Attributes.Add("Style", "display:block");
                txtAnswerKey.Text = "";
                divAnswerKey.Attributes.Add("style", "display:none;margin-top:10px;");
            }
            else
            {
                divOptions.Attributes.Add("Style", "display:none");
                divAnswerKey.Attributes.Add("style", "display:block;margin-top:10px;");
            }
            //if(ddlAnswerType.SelectedValue=="2")
            //{
            //    divAnswerKey.Attributes.Add("style", "display:block;margin-top:10px;");
            //  //  Session["answertype"] = ddlAnswerType.SelectedValue;
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);
            //}
            //else
            //{
            //    divAnswerKey.Attributes.Add("style", "display:none;margin-top:10px;");
            //}
        }

        private void EnableDisableOptions()
        {
            if (ddlAnswerType.SelectedValue == "1" || ddlAnswerType.SelectedValue == "3")
            {
                divOptions.Attributes.Add("Style", "display:block");
                txtAnswerKey.Text = "";
                divAnswerKey.Attributes.Add("style", "display:none;margin-top:10px;");

            }
            else
            {
                divOptions.Attributes.Add("Style", "display:none");
                divAnswerKey.Attributes.Add("style", "display:block;margin-top:10px;");
            }
        }

        protected void btnQuestionsSave_Click(object sender, EventArgs e)
        {
            divError.Attributes.Add("Style", "display:none");
            if (ddlClassName.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Select Class*";
                return;
            }
            if (ddlSubject.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Select Subject*";
                return;
            }
            if (ddlConcepts.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Select Concept*";
                return;
            }
            if (ddlObjectives.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Select Objective*";
                return;
            }
            if (ddlAnswerType.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Select Answer Type*";
                return;
            }
            if (txtQuestion.Text.Replace("&nbsp;", "").Replace("<br />", "").Replace("<p>", "").Replace("</p>", "").Trim().Length <= 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Question Required*";
                return;
            }
            // if (Session["answertype"].ToString() == "2")
            // {
            if (ddlAnswerType.SelectedValue == "2" && txtAnswerKey.Text.Replace("&nbsp;", "").Replace("<br />", "").Replace("<p>", "").Replace("</p>", "").Trim().Length <= 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Answer Key Required*";
                return;
            }
            // }
            else
            {
                divError.Attributes.Add("Style", "display:none");
            }

            //   string htmlEncoded = WebUtility.HtmlEncode(tbHtmlEditor.Text);

            if (btnQuestionsSave.Text == "Save Question")
            {
                string question, answer, qur;

                Session["answertype"] = ddlAnswerType.SelectedValue;
                if (IsOtherLanguage(ddlSubject.SelectedValue))
                {
                    question = Regex.Replace(txtQuestion.Text, "<[^>]*>", string.Empty);
                    answer = Regex.Replace(txtAnswerKey.Text, "<[^>]*>", string.Empty);
                    if (answer.Contains("'"))
                    {
                        answer = answer.Replace("'", "`");
                    }
                    if (question.Contains("'"))
                    {
                        question = question.Replace("'", "`");
                    }
                    qur = "Exec proc_AddQuestions '','" + ddlSubject.SelectedValue + "','" + ddlConcepts.SelectedValue + "','" + ddlObjectives.SelectedValue + "',N" + "'" + question + "','" + ddlAnswerType.SelectedValue + "',N" + "'" + answer + "','" + Session["DEId"].ToString() + "','1','" + Session["UserId"].ToString() + "','" + Session["InstitutionId"].ToString() + "','Insert'";
                }
                else
                {
                    question = txtQuestion.Text.Trim();
                    answer = txtAnswerKey.Text.Trim();
                    if (answer.Contains("'"))
                    {
                        answer = answer.Replace("'", "`");
                    }
                    if (question.Contains("'"))
                    {
                        question = question.Replace("'", "`");
                    }
                    qur = dbLibrary.idBuildQuery("[proc_AddQuestions]", "", ddlSubject.SelectedValue, ddlConcepts.SelectedValue, ddlObjectives.SelectedValue, question, ddlAnswerType.SelectedValue, answer, Session["DEId"].ToString(), "1", Session["UserId"].ToString(), Session["InstitutionId"].ToString(), "Insert");
                }
                string questionid = dbLibrary.idGetAFieldByQuery(qur);
                HiddenField1.Value = questionid;
                Session["QuestionId"] = questionid;
                btnQuestionsSave.Text = "Update Question";
                lblMsg.Text = "Question Added Successfully";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
                EnableDisableOptions();
                LoadRepeater();
            }
            else
            {
                if (Session["answertype"].ToString() != ddlAnswerType.SelectedValue)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "showModal();", true);
                }
                else
                {
                    string question, answer, qur;
                    if (IsOtherLanguage(ddlSubject.SelectedValue))
                    {
                        question = Regex.Replace(txtQuestion.Text, "<[^>]*>", string.Empty);
                        answer = Regex.Replace(txtAnswerKey.Text, "<[^>]*>", string.Empty);
                        if (answer.Contains("'"))
                        {
                            answer = answer.Replace("'", "`");
                        }
                        if (question.Contains("'"))
                        {
                            question = question.Replace("'", "`");
                        }
                        qur = "Exec proc_AddQuestions '" + Session["QuestionId"].ToString() + "','" + ddlSubject.SelectedValue + "','" + ddlConcepts.SelectedValue + "','" + ddlObjectives.SelectedValue + "',N" + "'" + question + "','" + ddlAnswerType.SelectedValue + "',N" + "'" + answer + "','" + Session["DEId"].ToString() + "','1','" + Session["UserId"].ToString() + "','" + Session["InstitutionId"].ToString() + "','Update'";
                    }
                    else
                    {
                        question = txtQuestion.Text;
                        answer = txtAnswerKey.Text;
                        if (answer.Contains("'"))
                        {
                            answer = answer.Replace("'", "`");
                        }
                        if (question.Contains("'"))
                        {
                            question = question.Replace("'", "`");
                        }
                        qur = dbLibrary.idBuildQuery("[proc_AddQuestions]", Session["QuestionId"].ToString(), ddlSubject.SelectedValue, ddlConcepts.SelectedValue, ddlObjectives.SelectedValue, question.Trim(), ddlAnswerType.SelectedValue, answer.Trim(), Session["DEId"].ToString(), "1", Session["UserId"].ToString(), Session["InstitutionId"].ToString(), "Update");

                    }
                    dbLibrary.idExecute(qur);
                    lblMsg.Text = "Question Updated Successfully";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
                    EnableDisableOptions();
                    LoadRepeater();
                }
            }
            //EnableDisableOptions();
            //LoadRepeater();
            //loadGrid();

        }

        private bool IsOtherLanguage(string subject)
        {
            string qur = "Select IsOtherLanguage from Subject where SubjectId='" + subject + "'";
            bool IsOtherLanguage = bool.Parse(dbLibrary.idGetAFieldByQuery(qur));
            if (IsOtherLanguage)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                RadioButton radbtnOption = (RadioButton)e.Item.FindControl("radbtnOption");
                Label lblOption = (Label)e.Item.FindControl("lblOption");
                string optionNo = (Repeater1.Items.Count + 1).ToString();
                lblOption.Text = "Option" + optionNo;
                HtmlGenericControl divTextItem = (HtmlGenericControl)e.Item.FindControl("divTextItem");
                HtmlGenericControl divImageItem = (HtmlGenericControl)e.Item.FindControl("divImageItem");
                if (ddlAnswerType.SelectedValue == "3")
                {
                    divImageItem.Attributes.Add("style", "display:block");
                    divTextItem.Attributes.Add("style", "display:none");
                    lblUError.Visible = true;
                    btnUpdate.Visible = false;
                }
                if (ddlAnswerType.SelectedValue == "1")
                {
                    divTextItem.Attributes.Add("style", "display:block");
                    divImageItem.Attributes.Add("style", "display:none");
                    lblUError.Visible = false;
                    btnUpdate.Visible = true;
                }
                if ((bool)drv["IsRightAnswer"])
                {
                    radbtnOption.Checked = true;
                }
                else
                {
                    radbtnOption.Checked = false;
                }
            }
            if (e.Item.ItemType == ListItemType.Footer)
            {
                HtmlGenericControl divText = (HtmlGenericControl)e.Item.FindControl("divText");
                HtmlGenericControl divImage = (HtmlGenericControl)e.Item.FindControl("divImage");
                if (ddlAnswerType.SelectedValue == "3")
                {
                    divImage.Attributes.Add("style", "display:block");
                    divText.Attributes.Add("style", "display:none");
                }
                if (ddlAnswerType.SelectedValue == "1")
                {
                    divText.Attributes.Add("style", "display:block");
                    divImage.Attributes.Add("style", "display:none");
                }
                Label lblOption = (Label)e.Item.FindControl("lblOption");
                string optionNo = (Repeater1.Items.Count + 1).ToString();
                lblOption.Text = "Option" + optionNo;
            }
        }


        protected void btnAdd_Click(object sender, EventArgs e)
        {
            HtmlGenericControl divError1 = Repeater1.Controls[Repeater1.Controls.Count - 1].Controls[0].FindControl("divError1") as HtmlGenericControl;
            Label lblError1 = Repeater1.Controls[Repeater1.Controls.Count - 1].Controls[0].FindControl("lblError1") as Label;
            TextBox txtOption = Repeater1.Controls[Repeater1.Controls.Count - 1].Controls[0].FindControl("txtOption") as TextBox;
            RadioButton radbtnOptionSet = Repeater1.Controls[Repeater1.Controls.Count - 1].Controls[0].FindControl("radbtnOptionSet") as RadioButton;
            string fileName = "";
            int count = 0;
            foreach (RepeaterItem item in Repeater1.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    RadioButton radbtnOption = (RadioButton)item.FindControl("radbtnOption");
                    if (radbtnOption.Checked == true)
                    {
                        count++;
                    }
                }
            }
            if (count >= 1 && radbtnOptionSet.Checked == true)
            {
                divError1.Attributes.Add("style", "display:block;");
                lblError1.Text = "More Than One Answer Cannot be Right Answer*";
                radbtnOptionSet.Checked = false;
                return;
            }

            if (ddlAnswerType.SelectedValue == "3")
            {
                FileUpload FileUpload1 = Repeater1.Controls[Repeater1.Controls.Count - 1].Controls[0].FindControl("FileUpload1") as FileUpload;
                if (!string.IsNullOrEmpty(FileUpload1.PostedFile.FileName))
                {
                    if (CheckFileType(FileUpload1.FileName))
                    {
                        int latestAnswerid = 0;
                        string qur = "SELECT IDENT_CURRENT ('Answers') as id Select COUNT(*) as count";
                        DataSet ds = dbLibrary.idGetCustomResult(qur);
                        int currentIdentity = int.Parse(ds.Tables[0].Rows[0]["id"].ToString());
                        int totalRows = int.Parse(ds.Tables[1].Rows[0]["count"].ToString());
                        if (totalRows == 0 && currentIdentity == 1)
                        {
                            latestAnswerid = currentIdentity;
                        }
                        else
                        {
                            latestAnswerid = currentIdentity + 1;
                        }
                        divError1.Attributes.Add("style", "display:none;");
                        string extension = Path.GetFileName(FileUpload1.PostedFile.FileName);
                        extension = extension.Split('.')[1];
                        fileName = Session["QuestionId"].ToString() + "_" + latestAnswerid + "." + extension;
                        FileUpload1.PostedFile.SaveAs(Server.MapPath("~/testImages/") + fileName);
                    }
                    else
                    {
                        divError1.Attributes.Add("style", "display:block;");
                        lblError1.Text = "Invalid FileType!!Image File Can only be jpg, png or gif";
                        return;
                    }
                }
                else
                {
                    divError1.Attributes.Add("style", "display:block;");
                    lblError1.Text = "Image File Cannot be Empty*";
                    return;
                }
            }
            if (ddlAnswerType.SelectedValue == "1")
            {
                if (txtOption.Text == "")
                {
                    divError1.Attributes.Add("style", "display:block;");
                    lblError1.Text = "Option Text Cannot be Empty*";
                    return;
                }
                else
                {
                    divError1.Attributes.Add("style", "display:none;");
                }
            }
            string answer = ddlAnswerType.SelectedValue == "3" ? "~/testImages/" + fileName : txtOption.Text;
            if (ddlAnswerType.SelectedValue == "1")
            {
                if (IsOtherLanguage(ddlSubject.SelectedValue))
                {
                    answer = Regex.Replace(answer, "<[^>]*>", string.Empty);
                }
                else if (answer.Contains("'"))
                {
                    answer = answer.Replace("'", "`");
                }
            }
            string qurAns = "select AnswerId from Answers where QuestionId='" + Session["QuestionId"].ToString() + "' and Answer='" + answer + "'";
            if (dbLibrary.idHasRows(qurAns))
            {
                divError1.Attributes.Add("style", "display:block;");
                lblError1.Text = "This Option Already Exists*";
                divError1.Focus();
                return;
            }
            else
            {
                divError1.Attributes.Add("style", "display:none;");
            }

            if (IsOtherLanguage(ddlSubject.SelectedValue))
            {
                bool isrightanswer = radbtnOptionSet.Checked == true ? true : false;
                //string qurans = "Insert Into Answers values('" + Session["QuestionId"].ToString() + "',N" + "'" + answer + "','" + isrightanswer + "')";
                //dbLibrary.idExecute(qurans);
                SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                string query = "Exec [proc_AddOptions] @AnswerId,@Answer,@QuestionId,@isRightAnswer,@StatusId,@UserId,@SchoolId,@type";
                SqlCommand cmd = new SqlCommand(query, sqlConnection);
                cmd.Parameters.AddWithValue("@AnswerId", "");
                cmd.Parameters.AddWithValue("@Answer", answer);
                cmd.Parameters.AddWithValue("@QuestionId", Session["QuestionId"].ToString());
                cmd.Parameters.AddWithValue("@isRightAnswer", isrightanswer);
                // cmd.Parameters.AddWithValue("@EnteredBy", Session["DEId"].ToString());
                cmd.Parameters.AddWithValue("@StatusId", "1");
                cmd.Parameters.AddWithValue("@UserId", Session["UserId"].ToString());
                cmd.Parameters.AddWithValue("@SchoolId", Session["InstitutionId"].ToString());
                cmd.Parameters.AddWithValue("@type", "Insert");
                try
                {
                    sqlConnection.Open();
                    cmd.ExecuteNonQuery();
                }
                catch
                {

                }
                finally
                {
                    sqlConnection.Close();
                }
            }
            else
            {
                //dbLibrary.idInsertInto("Answers",
                //    "QuestionId", Session["QuestionId"].ToString(),
                //    "Answer", ddlAnswerType.SelectedValue == "3" ? "~/testImages/" + fileName : answer.Replace("''", "'"),
                //    "IsRightAnswer", radbtnOptionSet.Checked == true ? "1" : "0");
                string qry = dbLibrary.idBuildQuery("[proc_AddOptions]", "", ddlAnswerType.SelectedValue == "3" ? "~/testImages/" + fileName : answer.Replace("''", "'"), Session["QuestionId"].ToString(), radbtnOptionSet.Checked == true ? "1" : "0", "1", Session["UserId"].ToString(), Session["InstitutionId"].ToString(), "Insert");
                dbLibrary.idExecute(qry);
            }
            lblMsg.Text = "Option Added Successfully";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
            LoadRepeater();
            //   gridQuestion.SelectedIndex = -1;
            //   gridQuestion_SelectedIndexChanged(sender, EventArgs.Empty);
        }

        bool CheckFileType(string fileName)
        {
            string ext = Path.GetExtension(fileName);
            switch (ext.ToLower())
            {
                case ".gif":
                    return true;
                case ".jpg":
                    return true;
                case ".jpeg":
                    return true;
                case ".png":
                    return true;
                default:
                    return false;
            }
        }
        private void LoadRepeater()
        {
            string qur = "Select Answer, IsRightAnswer,AnswerId from Answers where QuestionId=" + Session["QuestionId"].ToString();
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            Repeater1.DataSource = ds;
            Repeater1.DataBind();
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Button btnDelete = (Button)sender;
            string qur = "Select Answer from Answers where AnswerId=" + btnDelete.CommandArgument;
            if (ddlAnswerType.SelectedValue == "3")
            {
                string url = dbLibrary.idGetAFieldByQuery(qur);
                var filePath = Server.MapPath(url);
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                }
            }
            if (ddlAnswerType.SelectedValue == "1" || ddlAnswerType.SelectedValue == "3")
            {
                qur = dbLibrary.idBuildQuery("[proc_DeleteAnswer]", Session["UserId"].ToString(), Session["QuestionId"].ToString(), btnDelete.CommandArgument, Session["InstitutionId"].ToString());
                //qur = "Delete from Answers where AnswerId=" + btnDelete.CommandArgument;
                dbLibrary.idExecute(qur);
            }

            LoadRepeater();
            //loadGrid();
        }

        protected void radbtnOption_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton radbtnOption = (RadioButton)sender;

            foreach (RepeaterItem item in Repeater1.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    RadioButton radbtnOption1 = (RadioButton)item.FindControl("radbtnOption");
                    UpdatePanel UpdatePanel2 = (UpdatePanel)item.FindControl("UpdatePanel2");
                    if (radbtnOption1.ClientID != radbtnOption.ClientID)
                    {
                        radbtnOption1.Checked = false;
                    }
                    UpdatePanel2.Update();
                }
            }
            RadioButton radbtnOptionSet = Repeater1.Controls[Repeater1.Controls.Count - 1].Controls[0].FindControl("radbtnOptionSet") as RadioButton;
            radbtnOptionSet.Checked = false;

        }
        protected void radbtnOptionSet_CheckedChanged(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in Repeater1.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    RadioButton radbtnOption1 = (RadioButton)item.FindControl("radbtnOption");
                    UpdatePanel UpdatePanel2 = (UpdatePanel)item.FindControl("UpdatePanel2");
                    radbtnOption1.Checked = false;
                    UpdatePanel2.Update();
                }
            }
        }
        protected void btnContinue_Click(object sender, EventArgs e)
        {
            string qur = "Delete  from Answers where QuestionId=" + Session["QuestionId"].ToString();
            dbLibrary.idExecute(qur);
            string question, answer;
            if (IsOtherLanguage(ddlSubject.SelectedValue))
            {
                question = Regex.Replace(txtQuestion.Text, "<[^>]*>", string.Empty);
                answer = Regex.Replace(txtAnswerKey.Text, "<[^>]*>", string.Empty);
                if (answer.Contains("'"))
                {
                    answer = answer.Replace("'", "`");
                }
                if (question.Contains("'"))
                {
                    question = question.Replace("'", "`");
                }
                qur = "Exec proc_AddQuestions '" + Session["QuestionId"].ToString() + "','" + ddlSubject.SelectedValue + "','" + ddlConcepts.SelectedValue + "','" + ddlObjectives.SelectedValue + "',N" + "'" + question + "','" + ddlAnswerType.SelectedValue + "',N" + "'" + answer + "','" + Session["DEId"].ToString() + "','1','" + Session["UserId"].ToString() + "','" + Session["InstitutionId"].ToString() + "','Update'";
            }
            else
            {
                question = txtQuestion.Text;
                answer = txtAnswerKey.Text;
                if (answer.Contains("'"))
                {
                    answer = answer.Replace("'", "`");
                }
                if (question.Contains("'"))
                {
                    question = question.Replace("'", "`");
                }
                qur = dbLibrary.idBuildQuery("[proc_AddQuestions]", Session["QuestionId"].ToString(), ddlSubject.SelectedValue, ddlConcepts.SelectedValue, ddlObjectives.SelectedValue, question, ddlAnswerType.SelectedValue, answer, Session["DEId"].ToString(), "1", Session["UserId"].ToString(), Session["InstitutionId"].ToString(), "Update");
            }
            dbLibrary.idExecute(qur);

            EnableDisableOptions();
            LoadRepeater();
            //  loadGrid();
            lblUError.Visible = false;
            btnUpdate.Visible = false;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#myModal').modal('hide');", true);

        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ddlAnswerType.SelectedValue = Session["answertype"].ToString();
            if (ddlAnswerType.SelectedValue != "2")
            {
                txtAnswerKey.Text = "";
                divAnswerKey.Attributes.Add("style", "display:none;margin-top:10px;");
                EnableDisableOptions();
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "$('#myModal').modal('hide');", true);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            bool success = true;
            RadioButton radbtnOptionSet = Repeater1.Controls[Repeater1.Controls.Count - 1].Controls[0].FindControl("radbtnOptionSet") as RadioButton;
            HtmlGenericControl divErr = Repeater1.Controls[Repeater1.Controls.Count - 1].Controls[0].FindControl("divError1") as HtmlGenericControl;
            Label lblErr = Repeater1.Controls[Repeater1.Controls.Count - 1].Controls[0].FindControl("lblError1") as Label;
            int count = 0;
            foreach (RepeaterItem item in Repeater1.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    RadioButton radbtnOption = (RadioButton)item.FindControl("radbtnOption");
                    if (radbtnOption.Checked == true)
                    {
                        count++;
                    }
                }
            }
            if (count >= 1 && radbtnOptionSet.Checked == true)
            {
                divErr.Attributes.Add("style", "display:block;");
                lblErr.Text = "More Than One Answer Cannot be Right Answer*";
                radbtnOptionSet.Checked = false;
                return;
            }
            DataTable dtOptions = new DataTable();
            dtOptions.Columns.Add("AnswerId");
            dtOptions.Columns.Add("Answer");
            dtOptions.Columns.Add("IsRightAnswer");
            foreach (RepeaterItem item in Repeater1.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    RadioButton radbtnOption = (RadioButton)item.FindControl("radbtnOption");
                    TextBox txtOption = (TextBox)item.FindControl("txtOption");
                    Button btnDelete = (Button)item.FindControl("btnDelete");
                    string answer;
                    if (IsOtherLanguage(ddlSubject.SelectedValue))
                    {
                        answer = Regex.Replace(txtOption.Text, "<[^>]*>", string.Empty);
                    }
                    else
                    {
                        answer = txtOption.Text.Trim();
                    }
                    if (answer.Contains("'"))
                    {
                        answer = answer.Replace("'", "`");
                    }
                    string qurAns = "select AnswerId from Answers where QuestionId='" + Session["QuestionId"].ToString() + "' and Answer='" + answer + "'";
                    if (dbLibrary.idHasRows(qurAns))
                    {
                        string ans = dbLibrary.idGetAFieldByQuery(qurAns);
                        if (btnDelete.CommandArgument != ans)
                        {
                            divErr.Attributes.Add("style", "display:block;");
                            lblErr.Text = "This Option Already Exists*";
                            divErr.Focus();
                            success = false;
                            return;
                        }
                        else
                        {
                            if (ddlAnswerType.SelectedValue == "1")
                            {
                                if (IsOtherLanguage(ddlSubject.SelectedValue))
                                {
                                    bool isrightanswer = radbtnOption.Checked == true ? true : false;

                                    dtOptions.Rows.Add(btnDelete.CommandArgument, answer, isrightanswer);

                                    //string qur = "update Answers set Answer=N" + "'" + answer + "', IsRightAnswer='" + isrightanswer + "' where AnswerId='" + btnDelete.CommandArgument + "'";
                                    //dbLibrary.idExecute(qur);
                                    //SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                                    //string query = "Exec [proc_AddOptions] @AnswerId,@Answer,@QuestionId,@isRightAnswer,@EnteredBy,@StatusId,@UserId,@SchoolId,@type";
                                    //SqlCommand cmd = new SqlCommand(query, sqlConnection);
                                    //cmd.Parameters.AddWithValue("@AnswerId", btnDelete.CommandArgument);
                                    //cmd.Parameters.AddWithValue("@Answer", answer);
                                    //cmd.Parameters.AddWithValue("@QuestionId", Session["QuestionId"].ToString());
                                    //cmd.Parameters.AddWithValue("@isRightAnswer", isrightanswer);
                                    //cmd.Parameters.AddWithValue("@EnteredBy", Session["DEId"].ToString());
                                    //cmd.Parameters.AddWithValue("@StatusId", "1");
                                    //cmd.Parameters.AddWithValue("@UserId", Session["UserId"].ToString());
                                    //cmd.Parameters.AddWithValue("@SchoolId", Session["InstitutionId"].ToString());
                                    //cmd.Parameters.AddWithValue("@type", "Update");
                                    //try
                                    //{
                                    //    sqlConnection.Open();
                                    //    cmd.ExecuteNonQuery();
                                    //}
                                    //catch
                                    //{

                                    //}
                                    //finally
                                    //{
                                    //    sqlConnection.Close();
                                    //}
                                }
                                else
                                {
                                    dtOptions.Rows.Add(btnDelete.CommandArgument, txtOption.Text.Replace("'", "`"), radbtnOption.Checked == true ? "1" : "0");

                                    //dbLibrary.idUpdateTable("Answers",
                                    //    "AnswerId=" + btnDelete.CommandArgument,
                                    //    "Answer", txtOption.Text.Replace("'", "`"),
                                    //    "isRightAnswer", radbtnOption.Checked == true ? "1" : "0");
                                    //   string qry = dbLibrary.idBuildQuery("[proc_AddOptions]", btnDelete.CommandArgument, txtOption.Text.Replace("'", "`"), Session["QuestionId"].ToString(), radbtnOption.Checked == true ? "1" : "0", Session["DEId"].ToString(), "1", Session["UserId"].ToString(), Session["InstitutionId"].ToString(), "Update");
                                    //   dbLibrary.idExecute(qry);
                                }

                                //  lblMsg.Text = "Options Updated Successfully";
                                //   Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
                                divErr.Attributes.Add("style", "display:none;");
                            }
                            else
                            {
                                success = false;
                            }
                        }
                    }
                    else
                    {
                        divErr.Attributes.Add("style", "display:none;");
                    }
                    if (ddlAnswerType.SelectedValue == "1")
                    {
                        if (IsOtherLanguage(ddlSubject.SelectedValue))
                        {
                            bool isrightanswer = radbtnOption.Checked == true ? true : false;

                            dtOptions.Rows.Add(btnDelete.CommandArgument, answer, isrightanswer);

                            //string qur = "update Answers set Answer=N" + "'" + answer + "', IsRightAnswer='" + isrightanswer + "' where AnswerId='" + btnDelete.CommandArgument + "'";
                            //dbLibrary.idExecute(qur);
                            //SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                            //string query = "Exec [proc_AddOptions] @AnswerId,@Answer,@QuestionId,@isRightAnswer,@EnteredBy,@StatusId,@UserId,@SchoolId,@type";
                            //SqlCommand cmd = new SqlCommand(query, sqlConnection);
                            //cmd.Parameters.AddWithValue("@AnswerId", btnDelete.CommandArgument);
                            //cmd.Parameters.AddWithValue("@Answer", answer);
                            //cmd.Parameters.AddWithValue("@QuestionId", Session["QuestionId"].ToString());
                            //cmd.Parameters.AddWithValue("@isRightAnswer", isrightanswer);
                            //cmd.Parameters.AddWithValue("@EnteredBy", Session["DEId"].ToString());
                            //cmd.Parameters.AddWithValue("@StatusId", "1");
                            //cmd.Parameters.AddWithValue("@UserId", Session["UserId"].ToString());
                            //cmd.Parameters.AddWithValue("@SchoolId", Session["InstitutionId"].ToString());
                            //cmd.Parameters.AddWithValue("@type", "Update");
                            //try
                            //{
                            //    sqlConnection.Open();
                            //    cmd.ExecuteNonQuery();
                            //}
                            //catch
                            //{

                            //}
                            //finally
                            //{
                            //    sqlConnection.Close();
                            //}
                        }
                        else
                        {
                            dtOptions.Rows.Add(btnDelete.CommandArgument, txtOption.Text.Replace("'", "`"), radbtnOption.Checked == true ? "1" : "0");

                            //dbLibrary.idUpdateTable("Answers",
                            //    "AnswerId=" + btnDelete.CommandArgument,
                            //    "Answer", txtOption.Text.Replace("'", "`"),
                            //    "isRightAnswer", radbtnOption.Checked == true ? "1" : "0");
                            //  string qry = dbLibrary.idBuildQuery("[proc_AddOptions]", btnDelete.CommandArgument, txtOption.Text.Replace("'", "`"), Session["QuestionId"].ToString(), radbtnOption.Checked == true ? "1" : "0", Session["DEId"].ToString(), "1", Session["UserId"].ToString(), Session["InstitutionId"].ToString(), "Update");
                            //  dbLibrary.idExecute(qry);
                        }


                        // lblMsg.Text = "Options Updated Successfully";
                        // Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
                        divErr.Attributes.Add("style", "display:none;");
                    }
                    else
                    {
                        success = false;
                    }
                    UpdatePanel UpdatePanel2 = (UpdatePanel)item.FindControl("UpdatePanel2");
                    UpdatePanel2.Update();
                }
            }
            if (success == true)
            {
                SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                SqlCommand cmd = new SqlCommand("[proc_UpdateOptions]", sqlConnection);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter dtparam = cmd.Parameters.AddWithValue("@QuestionId", Session["QuestionId"].ToString());
                dtparam = cmd.Parameters.AddWithValue("@StatusId", "1");
                dtparam = cmd.Parameters.AddWithValue("@UserId", Session["UserId"].ToString());
                dtparam = cmd.Parameters.AddWithValue("@SchoolId", Session["InstitutionId"].ToString());
                dtparam = cmd.Parameters.AddWithValue("@List", dtOptions);
                dtparam.SqlDbType = SqlDbType.Structured;
                try
                {
                    sqlConnection.Open();
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {

                }
                finally
                {
                    sqlConnection.Close();
                }
                lblMsg.Text = "Options Updated Successfully";
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
            }
            //  gridQuestion_SelectedIndexChanged(gridQuestion, EventArgs.Empty);
        }

        protected void gridAnswer_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                if (ddlAnswerType.SelectedValue == "3")
                {
                    e.Row.Cells[0].Text = "Options Image URL";
                }
                else
                {
                    e.Row.Cells[0].Text = "Options";

                }
            }
        }

        protected void btnDeleteQ_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

    }
}