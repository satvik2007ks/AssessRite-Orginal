using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Net;
using System.Text;

namespace AssessRite
{
    public partial class Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Session["UserId"] == null)
            //{
            //    Response.Redirect("../Login.aspx");
            //}
            if (Request.QueryString["TestAssignedId"] != null)
            {
                loadBasicReport();
            }
        }

        private void loadBasicReport()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getBasicReport]", Request.QueryString["TestAssignedId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                grdBasic.DataSource = ds.Tables[0];
                grdBasic.DataBind();
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                divMistakes.Attributes.Add("style", "display:block");
                grdMistakes.DataSource = ds.Tables[1];
                grdMistakes.DataBind();
                ViewState["grdMistakes"] = ds.Tables[1];
            }
            else
            {
                divMistakes.Attributes.Add("style", "display:none");
            }
            DataTable dtConceptReport = new DataTable();
            dtConceptReport.Columns.Add("ConceptId");
            dtConceptReport.Columns.Add("Concept");
            dtConceptReport.Columns.Add("CorrectTotal");
            dtConceptReport.Columns.Add("Percentage");
            dtConceptReport.Columns.Add("LowerClasses");
            a:
            foreach (DataRow dr in ds.Tables[2].Rows)
            {
                foreach (DataRow dr1 in ds.Tables[3].Rows)
                {
                    if (dr["ConceptId"].ToString() == dr1["ConceptId"].ToString())
                    {
                        int CorrectCount = int.Parse(dr["NoofQuestions"].ToString()) - int.Parse(dr1["NoofQuestions"].ToString()); //Total Questions-WrongQuestions count
                        int total = int.Parse(dr["NoofQuestions"].ToString());
                        decimal percentage = (((decimal)CorrectCount) / (decimal)total) * 100;
                        string percent = Math.Round(percentage).ToString();
                        dtConceptReport.Rows.Add(dr["ConceptId"].ToString(), dr["ConceptName"].ToString(), CorrectCount.ToString() + " / " + dr["NoofQuestions"].ToString(), percent + "%");
                        dr.Delete();
                        dr1.Delete();
                        ds.Tables[2].AcceptChanges();
                        ds.Tables[3].AcceptChanges();
                        goto a;
                    }
                }
            }
            if (ds.Tables[2].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[2].Rows)
                {
                    dtConceptReport.Rows.Add(dr["ConceptId"].ToString(), dr["ConceptName"].ToString(), dr["NoofQuestions"].ToString() + " / " + dr["NoofQuestions"].ToString(), "100%");
                }
            }
            if (ds.Tables[4].Rows.Count > 0)
            {
                foreach (DataRow dr1 in dtConceptReport.Rows)
                {
                    bool ismatch = false;
                    foreach (DataRow d in ds.Tables[4].Rows)
                    {
                        if (d["ConceptId"].ToString() == dr1["ConceptId"].ToString())
                        {
                            dr1["LowerClasses"] += d["ClassName"].ToString() + ", ";
                            ismatch = true;
                            dtConceptReport.AcceptChanges();
                        }
                    }
                    if(ismatch)
                    {
                        dr1["LowerClasses"] = dr1["LowerClasses"].ToString().Trim().TrimEnd(',');
                        dtConceptReport.AcceptChanges();
                    }
                }
            }
            grdConceptsAnalysis.DataSource = dtConceptReport;
            grdConceptsAnalysis.DataBind();
        }

        protected void grdBasic_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                Label lblResult = e.Row.FindControl("lblResult") as Label;
                string qur = "SELECT count(*)IsRightAnswer FROM StudentAnswers RIGHT OUTER JOIN TestAssigned ON StudentAnswers.TestAssignedId = TestAssigned.TestAssignedId WHERE (TestAssigned.StudentId = '" + drv["StudentId"].ToString() + "') AND (StudentAnswers.IsRightAnswer = '1') and (TestAssigned.Status='Taken') and TestAssigned.TestAssignedId='" + Request.QueryString["TestAssignedId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    lblResult.Text = dbLibrary.idGetAFieldByQuery(qur) + " out of " + drv["TotalQuestions"].ToString();
                }
            }
        }

        protected void lnkExport_Click(object sender, EventArgs e)
        {

        }

        protected void grdConceptsAnalysis_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                HtmlGenericControl divPercent = e.Row.FindControl("divPercent") as HtmlGenericControl;
                Label lblPercentage = e.Row.FindControl("lblPercentage") as Label;
                if (drv["Percentage"].ToString()=="0%")
                {
                    lblPercentage.Attributes.Add("style", "color:black;");
                }
                else
                {
                    lblPercentage.Attributes.Add("style", "color:white;");
                }
                divPercent.Attributes.Add("style", "width:" + drv["Percentage"] + "; background-color:green;");
            }
        }

        protected void grdMistakes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdMistakes.PageIndex = e.NewPageIndex;
            grdMistakes.DataSource = ((DataTable)ViewState["grdMistakes"]);
            grdMistakes.DataBind();
        }

        protected void btnDoqnload_Click(object sender, EventArgs e)
        {
            WebClient myClient = new WebClient();
            string myPageHTML = null;
            byte[] requestHTML;
            // Gets the url of the page
            string currentPageUrl = Request.Url.ToString();

            UTF8Encoding utf8 = new UTF8Encoding();
            requestHTML = myClient.DownloadData(currentPageUrl);
            myPageHTML = utf8.GetString(requestHTML);


            //string fileName = "report.doc";

            //// You can add whatever you want to add as the HTML and it will be generated as Ms Word docs

            //Response.AppendHeader("Content-Type", "application/msword");

            //Response.AppendHeader("Content-disposition", "attachment; filename=" + fileName);

            //Response.Write(myPageHTML);
            string url = HttpContext.Current.Request.Url.AbsoluteUri;
            //HtmlToPdf converter = new HtmlToPdf();

            //// convert the url to pdf 
            //PdfDocument doc = converter.ConvertUrl(url);

            //// save pdf document 
            //doc.Save(file);

            //// close pdf document 
            //doc.Close();
        }
    }
}