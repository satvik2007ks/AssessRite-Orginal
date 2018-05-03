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
    public partial class AcademicYear : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
                loadGrid();
        }

        private void loadGrid()
        {
            string qur = "Select * from AcedemicYear where IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString()+ "' order by  LEFT(AcademicYear, CHARINDEX('-',AcademicYear)-1) asc";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                gridAcademicYear.DataSource = ds;
                gridAcademicYear.DataBind();
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            divError.Attributes.Add("Style", "display:none");
            txtAcademic.Text = "";
            btnAcademicYear.Text = "Save";
            gridAcademicYear.SelectedIndex = -1;
            gridAcademicYear_SelectedIndexChanged(sender, EventArgs.Empty);
            btnDelete.Visible = false;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);


        }

        protected void btnAcademicYear_Click(object sender, EventArgs e)
        {
            if (txtAcademic.Text == "")
            {
                lblError.Text = "Please Enter Academic Year";
                divError.Attributes.Add("Style", "display:block");
            }
            else if(!(txtAcademic.Text.StartsWith("20")))
            {
                lblError.Text = "Invalid Academic Year";
                divError.Attributes.Add("Style", "display:block");
            }
            else
            {
                divError.Attributes.Add("Style", "display:none");

                string qur = "Select AcademicYearId from AcedemicYear where AcademicYear='" + txtAcademic.Text + "' and IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    int AcademicYearId = int.Parse(dbLibrary.idGetAFieldByQuery(qur));
                    if (btnAcademicYear.Text == "Save")
                    {
                        divError.Attributes.Add("Style", "display:block");
                        lblError.Text = "Academic Year Already Exists";
                        return;
                    }
                    else
                    {
                        if (AcademicYearId == int.Parse(btnAcademicYear.CommandArgument))
                        {
                            dbLibrary.idUpdateTable("AcedemicYear",
                            "AcademicYearId=" + btnAcademicYear.CommandArgument,
                            "AcademicYear", txtAcademic.Text);
                            lblMsg.Text = "Academic Year Updated Successfully";

                        }
                        else
                        {
                            divError.Attributes.Add("Style", "display:block");
                            lblError.Text = "Academic Year Already Exists";
                            return;
                        }
                    }
                }
                else
                {
                    if (btnAcademicYear.Text == "Save")
                    {
                        dbLibrary.idInsertInto("AcedemicYear",
                       "AcademicYear", txtAcademic.Text,
                       "SchoolId", Session["InstitutionId"].ToString());
                        lblMsg.Text = "Academic Year Saved Successfully";

                    }
                    else
                    {
                        dbLibrary.idUpdateTable("AcedemicYear",
                            "AcademicYearId=" + btnAcademicYear.CommandArgument,
                            "AcademicYear", txtAcademic.Text);
                        lblMsg.Text = "Academic Year Updated Successfully";

                    }
                }
                loadGrid();
                txtAcademic.Text = "";
                btnAcademicYear.Text = "Save";
                btnDelete.Visible = false;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
            }
        }

        protected void gridAcademicYear_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
                e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gridAcademicYear, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void gridAcademicYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gridAcademicYear.Rows)
            {
                if (row.RowIndex == gridAcademicYear.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#F1F1F1");
                    row.ForeColor = Color.Black;
                    row.ToolTip = string.Empty;
                    string text = gridAcademicYear.SelectedRow.Cells[0].Text;
                    string value = gridAcademicYear.SelectedDataKey.Value.ToString();
                    txtAcademic.Text = text;
                    btnAcademicYear.Text = "Update";
                    btnAcademicYear.CommandArgument = value;
                    btnDelete.Visible = true;
                    divError.Attributes.Add("Style", "display:none");

                }
                else
                {
                    row.BackColor = Color.White;
                    row.ForeColor = Color.Black;
                    row.ToolTip = "Click to select this row.";
                }
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            dbLibrary.idUpdateTable("AcedemicYear",
               "AcademicYearId='" + gridAcademicYear.SelectedDataKey.Value + "'",
               "IsDeleted", "1");
            //string qur = "Delete from AcedemicYear where AcademicYearId=" + gridAcademicYear.SelectedDataKey.Value;
            //dbLibrary.idExecute(qur);
            loadGrid();
            btnDelete.Visible = false;
            btnNew_Click(sender, EventArgs.Empty);
            lblMsg.Text = "Academic Year Deleted Successfully";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }
    }
}