using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            divError.Attributes.Add("Style", "display:none");
            string qur = "SELECT Login.UserName, Login.UserId, Login.UserTypeId, Login.SchoolId, SchoolInfo.SchoolName, Login.TeacherId, Login.StudentId, Login.AdminId, Login.DEId,Login.SMEId FROM Login INNER JOIN SchoolInfo ON Login.SchoolId = SchoolInfo.schoolId where Login.UserName='" + txtUserName.Text + "' and Login.Password='" + txtPassword.Text + "' and Login.IsDeleted='0'";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["UserId"] = ds.Tables[0].Rows[0]["UserId"].ToString();
                Session["UserType"] = ds.Tables[0].Rows[0]["UserTypeId"].ToString();
                Session["UserName"] = ds.Tables[0].Rows[0]["UserName"].ToString();
                Session["SchoolName"] = ds.Tables[0].Rows[0]["SchoolName"].ToString();
                Session["SchoolId"] = ds.Tables[0].Rows[0]["SchoolId"].ToString();
                if (Session["UserType"].ToString() == "6")
                {
                    Session["SMEId"] = ds.Tables[0].Rows[0]["SMEId"].ToString();
                    Response.Redirect("AssessRite/SME/Home.aspx");
                }
                if (Session["UserType"].ToString() == "5")
                {
                    Session["DEId"] = ds.Tables[0].Rows[0]["DEId"].ToString();
                    Response.Redirect("AssessRite/DE/Home.aspx");
                }
                if (Session["UserType"].ToString() == "4")
                {
                    Session["StudentId"] = ds.Tables[0].Rows[0]["StudentId"].ToString();
                    Response.Redirect("AssessRite/Student/Home.aspx");
                }
                if (Session["UserType"].ToString() == "3")
                {
                    Session["TeacherId"] = ds.Tables[0].Rows[0]["TeacherId"].ToString();
                    Response.Redirect("AssessRite/Teacher/Home.aspx");
                }
                if (Session["UserType"].ToString() == "2")
                {
                    Session["AdminId"] = ds.Tables[0].Rows[0]["AdminId"].ToString();
                    Response.Redirect("AssessRite/Admin/Home.aspx");
                }
                //if (Session["UserType"].ToString() == "1")
                //{
                //    // Session["SuperAdminId"] = ds.Tables[0].Rows[0]["SuperAdminId"].ToString();
                //    Response.Redirect("SuperAdmin/SchoolInfo.aspx");
                //}
                // Response.Redirect("Home.aspx");
            }
            else
            {
                qur = "SELECT Login.UserName, Login.UserId, Login.UserTypeId FROM Login where Login.UserName='" + txtUserName.Text + "' and Login.Password='" + txtPassword.Text + "' and Login.IsDeleted='0'";
                DataSet ds1 = dbLibrary.idGetCustomResult(qur);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    if (ds1.Tables[0].Rows[0]["UserTypeId"].ToString() == "1")
                    {
                        Session["UserId"] = ds1.Tables[0].Rows[0]["UserId"].ToString();
                        Session["UserType"] = ds1.Tables[0].Rows[0]["UserTypeId"].ToString();
                        Session["UserName"] = ds1.Tables[0].Rows[0]["UserName"].ToString();
                        Response.Redirect("SuperAdmin/SchoolInfo.aspx");
                    }
                }
                else
                {
                    divError.Attributes.Add("Style", "display:block;margin-bottom: 10px;");
                    lblError.Text = "Invalid UserName or Password";
                    return;
                }
            }
        }
    }
}