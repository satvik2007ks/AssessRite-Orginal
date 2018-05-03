using AssessRite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite._3.Admin
{
    public partial class ManageDE : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
        }

        protected void btnDESave_Click(object sender, EventArgs e)
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

            if (btnDESave.Text == "Save")
            {
                string qur = "SELECT DEId FROM DE where DEFirstName='" + txtFirstName.Text.Trim() + "' and DELastName='" + txtLastName.Text.Trim() + "' and DEContactNo='" + txtContactNo.Text.Trim() + "' and DEEmailId='" + txtEmailID.Text.Trim() + "' and IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "DE Data Already Exists";
                    lblError.Focus();
                    return;
                }
                qur = "Select UserId from Login where UserName='" + txtUserName.Text + "' and UserTypeId='5' and IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "UserName Already Exists";
                    lblError.Focus();
                    txtUserName.Focus();
                    return;
                }
                qur = dbLibrary.idBuildQuery("[proc_AddDE]", "", txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtContactNo.Text.Trim(), txtEmailID.Text.Trim(), txtUserName.Text.Trim(), txtPassword.Text.Trim(), "Insert", Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                lblMsg.Text = "DE Added Successfully";
            }
            else
            {
                string qur = dbLibrary.idBuildQuery("[proc_AddDE]", Session["DEId"].ToString(), txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtContactNo.Text.Trim(), txtEmailID.Text.Trim(), txtUserName.Text.Trim(), txtPassword.Text.Trim(), "Update", Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                lblMsg.Text = "DE Details Updated Successfully";
            }
            btnDelete.Visible = false;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SendParameters(int deid, string firstname, string lastname, string contactno, string emailid, string username, string password, string buttontext)
        {
            if (buttontext == "Save")
            {
                string qur = "SELECT DEId FROM DE where DEFirstName='" + firstname + "' and DELastName='" + lastname.Trim() + "' and DEContactNo='" + contactno.Trim() + "' and DEEmailId='" + emailid.Trim() + "' and IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    return "DE Data Already Exists";
                }
                qur = "Select UserId from Login where UserName='" + username + "' and UserTypeId='5' and IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    return "UserName Already Exists";
                }
                qur = dbLibrary.idBuildQuery("[proc_AddDE]", "", firstname.Trim(), lastname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), "Insert", HttpContext.Current.Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                return "DE Added Successfully";
            }
            else
            {
                string qur = dbLibrary.idBuildQuery("[proc_AddDE]", deid.ToString(), firstname.Trim(), lastname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), "Update", HttpContext.Current.Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                return "DE Details Updated Successfully";
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteDE(int DEid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_DeleteDE]", DEid.ToString());
            dbLibrary.idExecute(qur);
            return "DE Deleted Successfully";
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtContactNo.Text = "";
            txtEmailID.Text = "";
            btnDESave.Text = "Save";
            divError.Attributes.Add("Style", "display:none");
            //txtSearch.Text = "";
            Session.Remove("DEId");
            txtUserName.Text = "";
            txtPassword.Text = "";
            btnDelete.Visible = false;
        }
    }
}