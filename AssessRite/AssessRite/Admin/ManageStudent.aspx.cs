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
    public partial class ManageStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadClass();
                LoadAcademicYear();
                //   LoadGrid();
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
            }
        }

        private void LoadGrid()
        {
            string qur = "SELECT Student.StudentId, Student.FirstName, Student.LastName, Student.ParentName, Student.ParentContactNo, Student.ParentEmailId, Class.ClassName, AcedemicYear.AcademicYear, StudentClass.ClassId, StudentClass.AcademicYearId, Login.UserName,Login.Password FROM Login RIGHT OUTER JOIN Student ON Login.StudentId = Student.StudentId LEFT OUTER JOIN Class RIGHT OUTER JOIN StudentClass ON Class.ClassId = StudentClass.ClassId LEFT OUTER JOIN AcedemicYear ON StudentClass.AcademicYearId = AcedemicYear.AcademicYearId ON Student.StudentId = StudentClass.StudentId where StudentClass.IsCurrent='1' and Student.IsDeleted='0' and Student.SchoolId='" + Session["InstitutionId"].ToString() + "' and Class.IsDeleted='0'";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            gridStudent.DataSource = ds;
            gridStudent.DataBind();
        }

        private void LoadClass()
        {
            string qur = "Select * from Class where IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'  ORDER BY MasterClassId";
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
        }

        protected void gridStudent_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
                e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gridStudent, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void gridStudent_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gridStudent.Rows)
            {
                if (row.RowIndex == gridStudent.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#F1F1F1");
                    row.ForeColor = Color.Black;
                    row.ToolTip = string.Empty;
                    txtFirstName.Text = gridStudent.SelectedRow.Cells[0].Text;
                    txtLastName.Text = gridStudent.SelectedRow.Cells[1].Text;
                    ddlClassName.SelectedValue = gridStudent.SelectedRow.Cells[7].Text;
                    ddlAcademicYear.SelectedValue = gridStudent.SelectedRow.Cells[8].Text;
                    txtParentName.Text = gridStudent.SelectedRow.Cells[4].Text;
                    txtContactNo.Text = gridStudent.SelectedRow.Cells[5].Text;
                    txtEmailID.Text = gridStudent.SelectedRow.Cells[6].Text;
                    txtUserName.Text = gridStudent.SelectedRow.Cells[10].Text;
                    txtPassword.Text = gridStudent.SelectedRow.Cells[11].Text;
                    Session["StudentId"] = gridStudent.SelectedDataKey.Value;
                    btnStudentSave.Text = "Update";
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

        protected void btnNew_Click(object sender, EventArgs e)
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtParentName.Text = "";
            txtContactNo.Text = "";
            txtEmailID.Text = "";
            LoadGrid();
            btnStudentSave.Text = "Save";
            ddlClassName.SelectedIndex = 0;
            ddlAcademicYear.SelectedIndex = 0;
            divError.Attributes.Add("Style", "display:none");
            //  txtSearch.Text = "";
            txtUserName.Text = "";
            txtPassword.Text = "";
            btnDelete.Visible = false;
            Session.Remove("StudentId");
            // UpdatePanel1.Update();
        }

        protected void btnStudentSave_Click(object sender, EventArgs e)
        {
            divError.Attributes.Add("Style", "display:none");
            if (txtFirstName.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Enter Firstname";
                return;
            }
            if (txtLastName.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Enter Lastname";
                return;
            }
            if (ddlClassName.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Select Class";
                return;
            }
            if (ddlAcademicYear.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Select Academic Year*";
                return;
            }
            if (txtUserName.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Enter UserName";
                txtUserName.Focus();
                return;
            }
            if (txtPassword.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Enter Password";
                txtPassword.Focus();
                return;
            }
            if (btnStudentSave.Text == "Save")
            {
                string qur = "";
                if (txtParentName.Text != "")
                {
                    qur = "SELECT Student.StudentId FROM  Student LEFT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where Student.FirstName='" + txtFirstName.Text + "' and Student.LastName='" + txtLastName.Text + "' and Student.ParentName='" + txtParentName.Text + "' and StudentClass.ClassId='" + ddlClassName.SelectedValue + "' and StudentClass.AcademicYearId='" + ddlAcademicYear.SelectedValue + "' and Student.IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                }
                else if (txtParentName.Text != "" && txtEmailID.Text != "")
                {
                    qur = "SELECT Student.StudentId FROM  Student LEFT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where Student.FirstName='" + txtFirstName.Text + "' and Student.LastName='" + txtLastName.Text + "' and Student.ParentName='" + txtParentName.Text + "' and Student.ParentEmailId='" + txtEmailID.Text + "' and StudentClass.ClassId='" + ddlClassName.SelectedValue + "' and StudentClass.AcademicYearId='" + ddlAcademicYear.SelectedValue + "' and Student.IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                }
                else if (txtParentName.Text != "" && txtContactNo.Text != "")
                {
                    qur = "SELECT Student.StudentId FROM  Student LEFT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where Student.FirstName='" + txtFirstName.Text + "' and Student.LastName='" + txtLastName.Text + "' and Student.ParentName='" + txtParentName.Text + "' and Student.ParentContactNo='" + txtContactNo.Text + "' and StudentClass.ClassId='" + ddlClassName.SelectedValue + "' and StudentClass.AcademicYearId='" + ddlAcademicYear.SelectedValue + "' and Student.IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                }
                else if (txtContactNo.Text != "" && txtEmailID.Text != "" && txtParentName.Text != "")
                {
                    qur = "SELECT Student.StudentId FROM  Student LEFT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where Student.FirstName='" + txtFirstName.Text + "' and Student.LastName='" + txtLastName.Text + "' and Student.ParentName='" + txtParentName.Text + "' and Student.ParentEmailId='" + txtEmailID.Text + "' and Student.ParentContactNo='" + txtContactNo.Text + "' and StudentClass.ClassId='" + ddlClassName.SelectedValue + "' and StudentClass.AcademicYearId='" + ddlAcademicYear.SelectedValue + "' and Student.IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                }
                else
                {
                    qur = "SELECT Student.StudentId FROM  Student LEFT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where Student.FirstName='" + txtFirstName.Text + "' and Student.LastName='" + txtLastName.Text + "' and StudentClass.ClassId='" + ddlClassName.SelectedValue + "' and StudentClass.AcademicYearId='" + ddlAcademicYear.SelectedValue + "' and Student.IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                }
                if (dbLibrary.idHasRows(qur))
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "Student Data Already Exists";
                    return;
                }
                qur = "Select UserId from Login where UserName='" + txtUserName.Text + "' and UserTypeId='4' and IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "UserName Already Exists";
                    txtUserName.Focus();
                    return;
                }
                qur = dbLibrary.idBuildQuery("[proc_AddStudent]", "", txtFirstName.Text.Trim(), txtLastName.Text.Trim(), ddlClassName.SelectedValue, ddlAcademicYear.SelectedValue, txtParentName.Text.Trim(), txtContactNo.Text.Trim(), txtEmailID.Text.Trim(), txtUserName.Text.Trim(), txtPassword.Text.Trim(), "Insert", Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                lblMsg.Text = "Student Added Successfully";
            }
            else
            {
                string qur = dbLibrary.idBuildQuery("[proc_AddStudent]", Session["StudentId"].ToString(), txtFirstName.Text.Trim(), txtLastName.Text.Trim(), ddlClassName.SelectedValue, ddlAcademicYear.SelectedValue, txtParentName.Text.Trim(), txtContactNo.Text.Trim(), txtEmailID.Text.Trim(), txtUserName.Text.Trim(), txtPassword.Text.Trim(), "Update", Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                lblMsg.Text = "Student Details Updated Successfully";
            }
            LoadGrid();
            btnDelete.Visible = false;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            string qur = dbLibrary.idBuildQuery("[proc_DeleteStudent]", gridStudent.SelectedDataKey.Value.ToString());
            dbLibrary.idExecute(qur);
            LoadGrid();
            btnDelete.Visible = false;
            btnNew_Click(sender, EventArgs.Empty);
            lblMsg.Text = "Student Deleted Successfully";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SendParameters(int studentid, string firstname, string lastname, int classid, int academicyearid, string parentname, string contactno, string emailid, string username, string password, string buttontext)
        {
            if (buttontext == "Save")
            {
                string qur = "";
                if (parentname != "")
                {
                    qur = "SELECT Student.StudentId FROM  Student LEFT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where Student.FirstName='" + firstname + "' and Student.LastName='" + lastname + "' and Student.ParentName='" + parentname + "' and StudentClass.ClassId='" + classid + "' and StudentClass.AcademicYearId='" + academicyearid + "' and Student.IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
                }
                else if (parentname != "" && emailid != "")
                {
                    qur = "SELECT Student.StudentId FROM  Student LEFT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where Student.FirstName='" + firstname + "' and Student.LastName='" + lastname + "' and Student.ParentName='" + parentname + "' and Student.ParentEmailId='" + emailid + "' and StudentClass.ClassId='" + classid + "' and StudentClass.AcademicYearId='" + academicyearid + "' and Student.IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
                }
                else if (parentname != "" && contactno != "")
                {
                    qur = "SELECT Student.StudentId FROM  Student LEFT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where Student.FirstName='" + firstname + "' and Student.LastName='" + lastname + "' and Student.ParentName='" + parentname + "' and Student.ParentContactNo='" + contactno + "' and StudentClass.ClassId='" + classid + "' and StudentClass.AcademicYearId='" + academicyearid + "' and Student.IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
                }
                else if (contactno != "" && emailid != "" && parentname != "")
                {
                    qur = "SELECT Student.StudentId FROM  Student LEFT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where Student.FirstName='" + firstname + "' and Student.LastName='" + lastname + "' and Student.ParentName='" + parentname + "' and Student.ParentEmailId='" + emailid + "' and Student.ParentContactNo='" + contactno + "' and StudentClass.ClassId='" + classid + "' and StudentClass.AcademicYearId='" + academicyearid + "' and Student.IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
                }
                else
                {
                    qur = "SELECT Student.StudentId FROM  Student LEFT OUTER JOIN StudentClass ON Student.StudentId = StudentClass.StudentId where Student.FirstName='" + firstname + "' and Student.LastName='" + lastname + "' and StudentClass.ClassId='" + classid + "' and StudentClass.AcademicYearId='" + academicyearid + "' and Student.IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
                }
                if (dbLibrary.idHasRows(qur))
                {

                    return "Student Data Already Exists";
                }
                qur = "Select UserId from Login where UserName='" + username + "' and UserTypeId='4' and IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    return "UserName Already Exists";
                }
                qur = dbLibrary.idBuildQuery("[proc_AddStudent]", "", firstname.Trim(), lastname.Trim(), classid.ToString(), academicyearid.ToString(), parentname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), "Insert", HttpContext.Current.Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                return "Student Added Successfully";
            }
            else
            {
                string qur = dbLibrary.idBuildQuery("[proc_AddStudent]", studentid.ToString(), firstname.Trim(), lastname.Trim(), classid.ToString(), academicyearid.ToString(), parentname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), "Update", HttpContext.Current.Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                return "Student Details Updated Successfully";
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteStudent(int studentid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_DeleteStudent]", studentid.ToString());
            dbLibrary.idExecute(qur);
            return "Student Deleted Successfully";
        }
    }
}