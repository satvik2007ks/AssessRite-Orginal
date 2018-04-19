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
    public partial class ManageTeacher : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                //  LoadGrid();
            }
        }

        private void LoadGrid()
        {
            string qur = "SELECT Teacher.TeacherId, Teacher.TeacherFirstName, Teacher.TeacherLastName, Teacher.ContactNo, Teacher.EmailId, Login.UserName,Login.Password FROM Teacher LEFT OUTER JOIN Login ON Teacher.TeacherId = Login.TeacherId where Teacher.IsDeleted='0' and Teacher.SchoolId='" + Session["SchoolId"].ToString() + "'";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            gridTeacher.DataSource = ds;
            gridTeacher.DataBind();
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtContactNo.Text = "";
            txtEmailID.Text = "";
            LoadGrid();
            btnTeacherSave.Text = "Save";
            divError.Attributes.Add("Style", "display:none");
            //txtSearch.Text = "";
            Session.Remove("TeacherId");
            txtUserName.Text = "";
            txtPassword.Text = "";
            btnDelete.Visible = false;
            //  UpdatePanel1.Update();
        }

        protected void btnTeacherSave_Click(object sender, EventArgs e)
        {
            divError.Attributes.Add("Style", "display:none");
            if (txtFirstName.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Enter FirstName";
                lblError.Focus();
                txtFirstName.Focus();
                return;
            }
            if (txtLastName.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Enter Lastname";
                lblError.Focus();
                txtLastName.Focus();
                return;
            }
            if (txtUserName.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Enter Username";
                lblError.Focus();
                txtUserName.Focus();
                return;
            }
            if (txtPassword.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Enter Password";
                lblError.Focus();
                txtPassword.Focus();
                return;
            }

            if (btnTeacherSave.Text == "Save")
            {
                string qur = "SELECT TeacherId FROM Teacher where TeacherFirstName='" + txtFirstName.Text.Trim() + "' and TeacherLastName='" + txtLastName.Text.Trim() + "' and ContactNo='" + txtContactNo.Text.Trim() + "' and EmailId='" + txtEmailID.Text.Trim() + "' and IsDeleted='0' and SchoolId='" + Session["SchoolId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "Teacher Data Already Exists";
                    lblError.Focus();
                    return;
                }
                qur = "Select UserId from Login where UserName='" + txtUserName.Text + "' and UserTypeId='3' and IsDeleted='0' and SchoolId='" + Session["SchoolId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "UserName Already Exists";
                    lblError.Focus();
                    txtUserName.Focus();
                    return;
                }
                qur = dbLibrary.idBuildQuery("[proc_AddTeacher]", "", txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtContactNo.Text.Trim(), txtEmailID.Text.Trim(), txtUserName.Text.Trim(), txtPassword.Text.Trim(), "Insert", Session["SchoolId"].ToString());
                dbLibrary.idExecute(qur);
                lblMsg.Text = "Teacher Added Successfully";
            }
            else
            {
                string qur = dbLibrary.idBuildQuery("[proc_AddTeacher]", Session["TeacherId"].ToString(), txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtContactNo.Text.Trim(), txtEmailID.Text.Trim(), txtUserName.Text.Trim(), txtPassword.Text.Trim(), "Update", Session["SchoolId"].ToString());
                dbLibrary.idExecute(qur);
                lblMsg.Text = "Teacher Details Updated Successfully";
            }
            LoadGrid();
            btnDelete.Visible = false;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);

        }

        protected void gridTeacher_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
                e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gridTeacher, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void gridTeacher_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gridTeacher.Rows)
            {
                if (row.RowIndex == gridTeacher.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#F1F1F1");
                    row.ForeColor = Color.Black;
                    row.ToolTip = string.Empty;
                    txtFirstName.Text = gridTeacher.SelectedRow.Cells[0].Text;
                    txtLastName.Text = gridTeacher.SelectedRow.Cells[1].Text;
                    txtContactNo.Text = gridTeacher.SelectedRow.Cells[2].Text;
                    txtEmailID.Text = gridTeacher.SelectedRow.Cells[3].Text;
                    txtUserName.Text = gridTeacher.SelectedRow.Cells[4].Text;
                    txtPassword.Text = gridTeacher.SelectedRow.Cells[5].Text;
                    Session["TeacherId"] = gridTeacher.SelectedDataKey.Value;
                    btnTeacherSave.Text = "Update";
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            string qur = dbLibrary.idBuildQuery("[proc_DeleteTeacher]", gridTeacher.SelectedDataKey.Value.ToString());
            dbLibrary.idExecute(qur);
            LoadGrid();
            btnDelete.Visible = false;
            btnNew_Click(sender, EventArgs.Empty);
            lblMsg.Text = "Teacher Deleted Successfully";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SendParameters(int teacherid, string firstname, string lastname, string contactno, string emailid, string username, string password, string buttontext)
        {
            if (buttontext == "Save")
            {
                string qur = "SELECT TeacherId FROM Teacher where TeacherFirstName='" + firstname.Trim() + "' and TeacherLastName='" + lastname.Trim() + "' and ContactNo='" + contactno.Trim() + "' and EmailId='" + emailid.Trim() + "' and IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["SchoolId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    return "Teacher Data Already Exists";
                    
                }
                qur = "Select UserId from Login where UserName='" + username + "' and UserTypeId='3' and IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["SchoolId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    
                    return "UserName Already Exists";
                }
                qur = dbLibrary.idBuildQuery("[proc_AddTeacher]", "", firstname.Trim(), lastname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), "Insert", HttpContext.Current.Session["SchoolId"].ToString());
                dbLibrary.idExecute(qur);
                return "Teacher Added Successfully";
            }
            else
            {
                string qur = dbLibrary.idBuildQuery("[proc_AddTeacher]", teacherid.ToString(), firstname.Trim(), lastname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), "Update", HttpContext.Current.Session["SchoolId"].ToString());
                dbLibrary.idExecute(qur);
                return "Teacher Details Updated Successfully";
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteTeacher(int teacherid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_DeleteTeacher]", teacherid.ToString());
            dbLibrary.idExecute(qur);
            return "Teacher Deleted Successfully";
        }
    }
}