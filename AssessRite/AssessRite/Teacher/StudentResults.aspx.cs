using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using SelectPdf;


namespace AssessRite
{
    public partial class StudentResults : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (Request.QueryString["TestScheduleId"] != null)
            {
                if (Request.QueryString["TestId"] != null)
                {
                    LoadStudents();
                }
            }
        }

        private void LoadStudents()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getStudentListTaken]", Request.QueryString["TestScheduleId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            ViewState["TotalQuestions"] = ds.Tables[4];
            if (ds.Tables[0].Rows.Count > 0)
            {
                divDownload.Attributes.Add("style", "display:block");
                divTakenEmpty.Attributes.Add("style", "display:none");
                grdStudentsTaken.DataSource = ds.Tables[0];
                grdStudentsTaken.DataBind();
            }
            else
            {
                divDownload.Attributes.Add("style", "display:none");
                divTakenEmpty.Attributes.Add("style", "display:block; margin-bottom:20px;");
            }
            //if (ds.Tables[0].Rows.Count == 0)
            //{
            //    lblTaken.Attributes.Add("style", "display:none");
            //}
            //else
            //{
            //    lblTaken.Attributes.Add("style", "display:block");
            //}
            if (ds.Tables[1].Rows.Count > 0)
            {
                divNotTakenEmpty.Attributes.Add("style", "display:none");
                grdStudentsNotTaken.DataSource = ds.Tables[1];
                grdStudentsNotTaken.DataBind();
            }
            else
            {
                divNotTakenEmpty.Attributes.Add("style", "display:block; margin-bottom:20px;");
            }
            //if(ds.Tables[1].Rows.Count==0)
            //{
            //    lblNotTaken.Attributes.Add("style", "display:none");
            //}
            //else
            //{
            //    lblNotTaken.Attributes.Add("style", "display:block");
            //}
            ViewState["TestKey"] = ds.Tables[3];

        }

        protected void lnkViewPaper_Click(object sender, EventArgs e)
        {
            Session.Remove("TestAssignedId");
            LinkButton lnkViewPaper = (LinkButton)sender;
            Session["TestAssignedId"] = lnkViewPaper.CommandArgument;
            // MultiView1.SetActiveView(View3);
            string redirect = "<script>window.open('QuestionPaper.aspx?TestId=" + Request.QueryString["TestId"].ToString() + "&Mode=View');</script>";
            Response.Write(redirect);
        }

        protected void lnkViewReport_Click(object sender, EventArgs e)
        {
            Session.Remove("TestAssignedId");
            LinkButton lnkViewReport = (LinkButton)sender;
            // Session["TestAssignedId"] = lnkViewReport.CommandArgument;
            string redirect = "<script>window.open('Report.aspx?TestAssignedId=" + lnkViewReport.CommandArgument.ToString() + "');</script>";
            Response.Write(redirect);
        }

        protected void lnkDownload_Click(object sender, EventArgs e)
        {
            LinkButton lnkDownload = (LinkButton)sender;
            lnkDownload.Enabled = false;
            DataTable dt = (DataTable)ViewState["TestKey"];
            string testkey = dt.Rows[0]["TestKey"].ToString();
            string currenturl = HttpContext.Current.Request.Url.AbsoluteUri;
            currenturl = currenturl.Split('/')[2];
            string url = "http://" + currenturl + "/Teacher/" + "Report.aspx?TestAssignedId=" + lnkDownload.CommandArgument.ToString();
            string pdf_page_size = "A4";
            PdfPageSize pageSize = (PdfPageSize)Enum.Parse(typeof(PdfPageSize),
                pdf_page_size, true);

            string pdf_orientation = "Landscape";
            // string pdf_orientation = "Portrait";
            PdfPageOrientation pdfOrientation =
                (PdfPageOrientation)Enum.Parse(typeof(PdfPageOrientation),
                pdf_orientation, true);

            int webPageWidth = 1120;
            // int webPageWidth = 1024;
            try
            {
                //   webPageWidth = Convert.ToInt32(1024);
                webPageWidth = Convert.ToInt32(1120);
            }
            catch { }

            int webPageHeight = 0;
            try
            {
                webPageHeight = Convert.ToInt32(0);
            }
            catch { }

            // instantiate a html to pdf converter object
            HtmlToPdf converter = new HtmlToPdf();

            // set converter options
            converter.Options.PdfPageSize = pageSize;
            converter.Options.PdfPageOrientation = pdfOrientation;
            converter.Options.WebPageWidth = webPageWidth;
            converter.Options.WebPageHeight = webPageHeight;

            // create a new pdf document converting an url
            SelectPdf.PdfDocument doc = converter.ConvertUrl(url);

            // save pdf document
            doc.Save(Response, false, lnkDownload.CommandName + "_" + testkey + ".pdf");

            // close pdf document
            doc.Close();
            lnkDownload.Enabled = true;
        }

        protected void grdStudentsTaken_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DataRowView drv = e.Row.DataItem as DataRowView;
                Label lblResult = e.Row.FindControl("lblResult") as Label;
                DataTable dt = (DataTable)ViewState["TotalQuestions"];
                lblResult.Text = drv["TotalRightAnswers"].ToString() + " out of " + dt.Rows[0]["TotalQuestions"].ToString();
            }
        }

        public override void VerifyRenderingInServerForm(Control control)
        {
            //base.VerifyRenderingInServerForm(control);
        }

        protected void lnkDownloadResult_Click(object sender, EventArgs e)
        {
            DataTable dt = (DataTable)ViewState["TestKey"];
            string testkey = dt.Rows[0]["TestKey"].ToString();
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    grdStudentsTaken.Columns[2].Visible = false;
                    grdStudentsTaken.Columns[3].Visible = false;
                    grdStudentsTaken.Columns[4].Visible = false;

                    grdStudentsTaken.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
                    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
                    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
                    pdfDoc.Open();
                    htmlparser.Parse(sr);
                    pdfDoc.Close();

                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=Results_"+ testkey + ".pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Write(pdfDoc);
                    Response.End();
                }
            }
        }
    }
}