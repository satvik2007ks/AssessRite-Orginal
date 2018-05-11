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
            string qur = "SELECT Login.UserName, Login.UserId, Login.UserTypeId,Login.InstitutionId,Login.DefaultDB, Login.TeacherId, Login.StudentId, Login.AdminId, Login.DEId, Login.SMEId, Admin.IsGCAdmin, Admin.IsStateAdmin, Admin.CountryId, Admin.StateId, InstitutionInfo.InstitutionName FROM  Login LEFT OUTER JOIN InstitutionInfo ON Login.InstitutionId = InstitutionInfo.InstitutionId LEFT OUTER JOIN Admin ON Login.AdminId = Admin.AdminId where Login.UserName='" + txtUserName.Text + "' and Login.Password='" + txtPassword.Text + "' and Login.IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Session["UserId"] = ds.Tables[0].Rows[0]["UserId"].ToString();
                Session["UserType"] = ds.Tables[0].Rows[0]["UserTypeId"].ToString();
                Session["UserName"] = ds.Tables[0].Rows[0]["UserName"].ToString();
                Session["SchoolName"] = ds.Tables[0].Rows[0]["InstitutionName"].ToString();
                Session["InstitutionId"] = ds.Tables[0].Rows[0]["InstitutionId"].ToString();
                Session["DefaultDB"] = ds.Tables[0].Rows[0]["DefaultDB"].ToString();
                string defaultdb = ds.Tables[0].Rows[0]["DefaultDB"].ToString();
                Session["ConnStr"] = dbLibrary.getConnectionString(defaultdb);
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
                    if (bool.Parse(ds.Tables[0].Rows[0]["IsGCAdmin"].ToString()))
                    {
                        Session["IsStateAdmin"] = ds.Tables[0].Rows[0]["IsStateAdmin"].ToString();
                        Session["IsGCAdmin"] = ds.Tables[0].Rows[0]["IsGCAdmin"].ToString();
                        Session["CountryId"] = ds.Tables[0].Rows[0]["CountryId"].ToString();
                        Session["StateId"] = ds.Tables[0].Rows[0]["StateId"].ToString();
                        Response.Redirect("Generic_Content/Admin/Home.aspx");
                    }
                    else
                    {
                        Response.Redirect("AssessRite/Admin/Home.aspx");
                    }
                }
                if (Session["UserType"].ToString() == "1")
                {
                    // Session["SuperAdminId"] = ds.Tables[0].Rows[0]["SuperAdminId"].ToString();
                    Response.Redirect("SuperAdmin/Home.aspx");
                }
                Response.Redirect("Home.aspx");
            }
            else
            {
                qur = "SELECT Login.UserName, Login.UserId, Login.UserTypeId FROM Login where Login.UserName='" + txtUserName.Text + "' and Login.Password='" + txtPassword.Text + "' and Login.IsDeleted='0'";
                DataSet ds1 = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    if (ds1.Tables[0].Rows[0]["UserTypeId"].ToString() == "1")
                    {
                        Session["UserId"] = ds1.Tables[0].Rows[0]["UserId"].ToString();
                        Session["UserType"] = ds1.Tables[0].Rows[0]["UserTypeId"].ToString();
                        Session["UserName"] = ds1.Tables[0].Rows[0]["UserName"].ToString();
                        Response.Redirect("SuperAdmin/Home.aspx");
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