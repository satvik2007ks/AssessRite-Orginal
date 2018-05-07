using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.Generic_Content.Admin
{
    public partial class Subject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("../../Login.aspx");
                }
                else
                {
                    hdnCountry.Value = Session["CountryId"].ToString();
                    hdnState.Value = Session["StateId"].ToString();
                }
            }
        }
        [WebMethod(EnableSession = true)]
        public static string SaveSubject(int subjectid, int sublevelid, string subject, string isotherlanguage, string buttontext)
        {
            if (HttpContext.Current.Session["ConnStr"] != null)
            {
                string qur = "Select SubjectId from Subject where SubjectName='" + subject + "' and SubLevelId='" + sublevelid + "' and IsDeleted='0'";
                DataSet ds = dbLibrary.idGetDataAsDataset(qur, HttpContext.Current.Session["ConnStr"].ToString());
                if (ds.Tables[0].Rows.Count > 0)
                {
                    int Id = int.Parse(ds.Tables[0].Rows[0]["SubjectId"].ToString());
                    if (buttontext == "Save")
                    {
                        return "Subject Already Found";
                    }
                    else
                    {
                        if (Id == subjectid)
                        {
                            if (isotherlanguage == "1")
                            {
                                string SubjectName = Regex.Replace(subject, "<[^>]*>", string.Empty);
                                qur = "Update Subject set SubjectName=N" + "'" + SubjectName + "', IsOtherLanguage='" + isotherlanguage + "' where SubjectId='" + subjectid + "'";
                                dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
                            }
                            else
                            {
                                qur = "Update Subject Set Subjectname='" + subject + "', IsOtherLanguage='" + isotherlanguage + "' where SubjectId='" + subjectid + "'";
                                dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
                            }
                            return "Subject Updated Successfully";
                        }
                        else
                        {
                            return "Subject Already Found";
                        }
                    }
                }
                else
                {
                    if (buttontext == "Save")
                    {
                        if (isotherlanguage == "1")
                        {
                            string SubjectName = Regex.Replace(subject, "<[^>]*>", string.Empty);
                            string qursub = "Insert Into Subject values('" + sublevelid + "',N" + "'" + SubjectName + "','" + isotherlanguage + "','0')";
                            dbLibrary.idExecuteWithConnectionString(qursub, HttpContext.Current.Session["ConnStr"].ToString());
                        }
                        else
                        {
                            string qursub = "Insert into subject values('" + sublevelid + "','" + subject + "', '" + isotherlanguage + "','" + isotherlanguage + "')";
                            dbLibrary.idExecuteWithConnectionString(qursub, HttpContext.Current.Session["ConnStr"].ToString());
                        }
                        return "Subject Saved Successfully";
                    }
                    else
                    {
                        if (isotherlanguage == "1")
                        {
                            string SubjectName = Regex.Replace(subject, "<[^>]*>", string.Empty);
                            qur = "Update Subject set SubjectName=N" + "'" + SubjectName + "', IsOtherLanguage='" + isotherlanguage + "' where SubjectId='" + subjectid + "'";
                            dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
                        }
                        else
                        {
                            qur = "Update Subject Set Subjectname='" + subject + "', IsOtherLanguage='" + isotherlanguage + "' where SubjectId='" + subjectid + "'";
                            dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
                        }
                        return "Subject Updated Successfully";
                    }
                }
            }
            else
            {
                return "Connection Lost";
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteSubject(int subjectid)
        {
            string qur = "Update Subject set IsDeleted='1' where SubjectId='" + subjectid + "'";
            dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
            return "Subject Deleted Successfully";
        }
    }
}