using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite
{
    public partial class MoveStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadAcademicYear();
                LoadClass();
            }
        }

        protected void btnMove_Click(object sender, EventArgs e)
        {
            if (ddlFromAcademicYear.SelectedIndex == 0)
            {
                divErr.Attributes.Add("style", "display:block");
                lblError.Text = "Select Academic Year*";
                return;
            }
            if (ddlClass.SelectedIndex == 0)
            {
                divErr.Attributes.Add("style", "display:block");
                lblError.Text = "Please Select Class";
                return;
            }
            if (!(chkStudents.Items.Cast<ListItem>().Any(item => item.Selected)))
            {
                divErr.Attributes.Add("style", "display:block");
                lblError.Text = "Please Select Students to Move";
                return;
            }
            if (ddlAcademicYear.SelectedIndex == 0)
            {
                divErr.Attributes.Add("style", "display:block");
                lblError.Text = "Please Select Academic Year to Move To";
                return;
            }
            if (ddlMoveTo.SelectedIndex == 0)
            {
                divErr.Attributes.Add("style", "display:block");
                lblError.Text = "Please elect Move To Class";
                return;
            }
            if (ddlAcademicYear.SelectedValue == ddlFromAcademicYear.SelectedValue)
            {
                divErr.Attributes.Add("style", "display:block");
                lblError.Text = "Move From and Move To Academic Year Cannot Be Same";
                return;
            }
            if (int.Parse(ddlAcademicYear.SelectedItem.Text.Split('-')[0].ToString()) < int.Parse(ddlFromAcademicYear.SelectedItem.Text.Split('-')[0].ToString()))
            {
                divErr.Attributes.Add("style", "display:block");
                lblError.Text = "Invalid!! Cannot Move Students to Older Academic Year";
                return;
            }
            if (int.Parse(ddlClass.SelectedItem.Text) < int.Parse(ddlMoveTo.SelectedItem.Text))
            {
                int movetoclass = int.Parse(ddlMoveTo.SelectedItem.Text);
                if ((int.Parse(ddlClass.SelectedItem.Text) + 1) != movetoclass)
                {
                    divErr.Attributes.Add("style", "display:block");
                    lblError.Text = "Invalid Move To Class!! Move To Class Has To Be " + (int.Parse(ddlClass.SelectedItem.Text) + 1);
                    return;
                }

            }
            else
            {
                divErr.Attributes.Add("style", "display:block");
                lblError.Text = "Move To Class Has To Be Greater Than Current Class";
                return;
            }
            DataTable dtMoveStudents = new DataTable();
            dtMoveStudents.Columns.Add("StudentId");
            dtMoveStudents.Columns.Add("AcademicYearId");
            dtMoveStudents.Columns.Add("ClassId");
            dtMoveStudents.Columns.Add("IsCurrent");
            foreach (ListItem li in chkStudents.Items)
            {
                if (li.Selected)
                {
                    dtMoveStudents.Rows.Add(li.Value.ToString(), ddlAcademicYear.SelectedValue, ddlMoveTo.SelectedValue, "1");
                    //dtMoveStudents.Rows.Add(li.Value.ToString(), ddlMoveToAcademicYear.SelectedValue, ddlMoveTo.SelectedValue, "1");
                }
            }
            if (dtMoveStudents.Rows.Count > 0)
            {
                dbLibrary.idInsertDataTable("[proc_MoveStudent]", "@List", dtMoveStudents);
            }
            clearAll();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
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
            chkStudents_SelectedIndexChanged(chkStudents, EventArgs.Empty);
        }

        protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            // string qur = "SELECT Student.FirstName+' '+ Student.LastName as Name, Student.StudentId FROM StudentClass RIGHT OUTER JOIN Student ON StudentClass.StudentId = Student.StudentId Where StudentClass.ClassId='" + ddlClass.SelectedValue + "' and StudentClass.AcademicYear='"+ddlMoveToAcademicYear.SelectedValue+"'";
            //string qur = "SELECT Student.FirstName+' '+ Student.LastName as Name, Student.StudentId FROM StudentClass RIGHT OUTER JOIN Student ON StudentClass.StudentId = Student.StudentId Where StudentClass.ClassId='" + ddlClass.SelectedValue + "' and StudentClass.IsCurrent='1' and Student.IsDeleted='0'";
            string qur = "SELECT Student.FirstName+' '+ Student.LastName as Name, Student.StudentId FROM StudentClass RIGHT OUTER JOIN Student ON StudentClass.StudentId = Student.StudentId Where StudentClass.ClassId='" + ddlClass.SelectedValue + "' and StudentClass.AcademicYearId='" + ddlFromAcademicYear.SelectedValue + "' and Student.IsDeleted='0' and StudentClass.IsCurrent='1'";
            DataSet ds1 = dbLibrary.idGetCustomResult(qur);
            if (dbLibrary.idHasRows(qur))
            {
                chkStudents.DataValueField = "StudentId";
                chkStudents.DataTextField = "Name";
                chkStudents.DataSource = ds1;
                chkStudents.DataBind();
                divStudents.Attributes.Add("style", "display:block;margin-top:10px");
                //btnAssign.Attributes.Add("style", "display:block;margin: 0 auto");
                divErr.Attributes.Add("style", "display:none");
            }
            else
            {
                //btnAssign.Attributes.Add("style", "display:none;");
                divStudents.Attributes.Add("style", "display:none");
                divErr.Attributes.Add("style", "display:block;margin-top:10px");
                lblError.Text = "No Sudents Found";
            }
        }

        private void LoadAcademicYear()
        {
            string qur = "Select * from AcedemicYear where IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "' order by  LEFT(AcademicYear, CHARINDEX('-',AcademicYear)-1) asc";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlAcademicYear.DataTextField = "AcademicYear";
                ddlAcademicYear.DataValueField = "AcademicYearId";
                ddlAcademicYear.DataSource = ds;
                ddlAcademicYear.DataBind();
                ddlAcademicYear.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlAcademicYear.SelectedIndex = 0;

                ddlFromAcademicYear.DataTextField = "AcademicYear";
                ddlFromAcademicYear.DataValueField = "AcademicYearId";
                ddlFromAcademicYear.DataSource = ds;
                ddlFromAcademicYear.DataBind();
                ddlFromAcademicYear.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlFromAcademicYear.SelectedIndex = 0;
            }
        }

        private void LoadClass()
        {
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

                ddlMoveTo.DataTextField = "ClassName";
                ddlMoveTo.DataValueField = "ClassId";
                ddlMoveTo.DataSource = ds;
                ddlMoveTo.DataBind();
                ddlMoveTo.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlMoveTo.SelectedIndex = 0;
            }
        }

        private void clearAll()
        {
            ddlAcademicYear.SelectedIndex = 0;
            ddlFromAcademicYear.SelectedIndex = 0;
            ddlClass.SelectedIndex = 0;
            ddlMoveTo.SelectedIndex = 0;
            chkStudentsAll.Checked = false;
            chkStudents.Items.Clear();
            divStudents.Attributes.Add("style", "display:none");

            //   divMoveTo.Attributes.Add("style", "display:none");
            //   divMoveToClass.Attributes.Add("style", "display:none");
            divHeading.Attributes.Add("style", "display:none");
            //foreach(ListItem li in chkStudents.Items)
            //{
            //    if(li.Selected)
            //    {
            //        li.Selected = false;
            //    }
            //}
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
            if (count > 0)
            {
                // divMoveTo.Attributes.Add("style", "display:block");
                //  divMoveToClass.Attributes.Add("style", "display:block");
                divHeading.Attributes.Add("style", "display:block");
                btnMove.Visible = true;
            }
            else
            {
                // divMoveTo.Attributes.Add("style", "display:none");
                // divMoveToClass.Attributes.Add("style", "display:none");
                divHeading.Attributes.Add("style", "display:none");
                btnMove.Visible = false;
            }
        }

        protected void ddlFromAcademicYear_SelectedIndexChanged(object sender, EventArgs e)
        {
            divErr.Attributes.Add("style", "display:none");
            chkStudentsAll.Checked = false;
            chkStudents.Items.Clear();
            divStudents.Attributes.Add("style", "display:none");
            LoadClass();
        }
    }
}