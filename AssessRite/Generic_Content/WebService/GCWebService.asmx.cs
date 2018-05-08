using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace AssessRite.Generic_Content.WebService
{
    /// <summary>
    /// Summary description for GCWebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class GCWebService : System.Web.Services.WebService
    {
        [WebMethod(EnableSession = true)]
        public string GetInstitutionTypesForGCAdminDropDown()
        {
            string qur = "SELECT CurriculumType.InstitutionTypeId, InstitutionType.InstitutionType " +
                         " FROM CurriculumType INNER JOIN " +
                         " InstitutionType ON CurriculumType.InstitutionTypeId = InstitutionType.InstitutionTypeId RIGHT OUTER JOIN " +
                         " GCAdminAssignedCurriculum ON CurriculumType.CurriculumTypeId = GCAdminAssignedCurriculum.CurriculumTypeId " +
                         " Where CurriculumType.IsDeleted = '0' and InstitutionType.IsDeleted = '0' and AdminId = '" + HttpContext.Current.Session["AdminId"].ToString() + "'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string GetCurriculumTypesForGCAdminDropDown(int institutiontypeid)
        {
            string qur = "SELECT GCAdminAssignedCurriculum.CurriculumTypeId, CurriculumType.CurriculumType " +
                         " FROM CurriculumType RIGHT OUTER JOIN " +
                         " GCAdminAssignedCurriculum ON CurriculumType.CurriculumTypeId = GCAdminAssignedCurriculum.CurriculumTypeId" +
                         " Where CurriculumType.IsDeleted = '0' and AdminId = '" + HttpContext.Current.Session["AdminId"].ToString() + "' and CurriculumType.InstitutionTypeId='" + institutiontypeid + "'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string LoadDropDownSubLevels(int levelid)
        {
            string qur = "SELECT  SubLevel, SubLevelId from SubLevel where LevelId='" + levelid + "' and  IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, HttpContext.Current.Session["ConnStr"].ToString());
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod]
        public string LoadDropdownSubjects(int sublevelid)
        {
            string qur = "SELECT  SubjectId, SubjectName from Subject where SubLevelId='" + sublevelid + "' and  IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod]
        public string LoadDropdownConcepts(int subjectid)
        {
            string qur = "SELECT  ConceptId, ConceptName from Concept where SubjectId='" + subjectid + "' and  IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string GetSubLevel()
        {
            string qur = "SELECT  A.SubLevelId, A.LevelId, A.SubLevel, B.LevelName, B.CurriculumTypeId, C.CurriculumType, C.InstitutionTypeId, D.InstitutionType " +
                " FROM SubLevel A Inner JOIN AssessRiteMaster_Dev.dbo.Level B ON A.LevelId = B.LevelId " +
                " Inner Join AssessRiteMaster_Dev.dbo.CurriculumType C ON C.CurriculumTypeId = B.CurriculumTypeId " +
                " Inner Join AssessRiteMaster_Dev.dbo.GCAdminAssignedCurriculum AC ON AC.CurriculumTypeId = B.CurriculumTypeId " +
                " Inner join  AssessRiteMaster_Dev.dbo.InstitutionType D ON C.InstitutionTypeId = D.InstitutionTypeId " +
                " Where AC.AdminId = '" + HttpContext.Current.Session["AdminId"].ToString() + "' and A.IsDeleted = '0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, HttpContext.Current.Session["ConnStr"].ToString());
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string GetSubject()
        {
            string qur = "SELECT A.SubjectId, A.SubLevelId, A.SubjectName, A.IsOtherLanguage, B.SubLevel, C.LevelId, C.LevelName, D.CurriculumTypeId, D.CurriculumType,E.InstitutionTypeId,E.InstitutionType " +
" FROM Subject A INNER JOIN SubLevel B ON A.SubLevelId = B.SubLevelId " +
" INNER JOIN AssessRiteMaster_Dev.dbo.Level C ON B.LevelId = C.LevelId " +
" INNER JOIN AssessRiteMaster_Dev.dbo.CurriculumType D ON C.CurriculumTypeId = D.CurriculumTypeId " +
" Inner Join AssessRiteMaster_Dev.dbo.GCAdminAssignedCurriculum AC ON AC.CurriculumTypeId = C.CurriculumTypeId " +
" INNER JOIN AssessRiteMaster_Dev.dbo.InstitutionType E ON D.InstitutionTypeId = E.InstitutionTypeId " +
" Where AC.AdminId = '" + HttpContext.Current.Session["AdminId"].ToString() + "' and A.IsDeleted = '0' and B.IsDeleted = '0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, HttpContext.Current.Session["ConnStr"].ToString());
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string getDEData()
        {
            string qur = "SELECT DE.DEId, DE.DEFirstName, DE.DELastName, DE.DEContactNo, DE.DEEmailId, L.UserName,L.Password FROM DE LEFT OUTER JOIN AssessRiteMaster_Dev.dbo.Login L ON DE.DEId = L.DEId where DE.IsDeleted='0' and AddedByAdminId='" + HttpContext.Current.Session["AdminId"].ToString() + "'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, HttpContext.Current.Session["ConnStr"].ToString());
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string LoadCurriculumCheckboxlistForDE()
        {
            string qur = "SELECT A.CurriculumType, A.CurriculumTypeId, B.InstitutionType FROM AssessRiteMaster_Dev.dbo.CurriculumType A INNER JOIN AssessRiteMaster_Dev.dbo.InstitutionType B ON A.InstitutionTypeId = B.InstitutionTypeId RIGHT OUTER JOIN AssessRiteMaster_Dev.dbo.GCAdminAssignedCurriculum C ON A.CurriculumTypeId = C.CurriculumTypeId WHERE (A.IsDeleted = '0') AND (B.IsDeleted = '0') AND (C.AdminId='" + HttpContext.Current.Session["AdminId"].ToString() + "')";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                List<CheckBoxItem> chkListClass = new List<CheckBoxItem>();
                chkListClass = (from DataRow dr in ds.Tables[0].Rows
                                select new CheckBoxItem()
                                {
                                    CurriculumId = Convert.ToInt32(dr["CurriculumTypeId"].ToString()),
                                    Curriculum = dr["CurriculumType"].ToString() + "- (" + dr["InstitutionType"].ToString() + ")",
                                }).ToList();
                JavaScriptSerializer ser = new JavaScriptSerializer();
                return ser.Serialize(chkListClass);
            }
            else
                return null;
        }
        public class CheckBoxItem
        {
            public string Curriculum { get; set; }
            public int CurriculumId { get; set; }
        }

        [WebMethod(EnableSession = true)]
        public string getAllCurriculumForDE(int deid)
        {
            string qur = "Select CurriculumTypeId from DEAssignedCurriculum where DEId=" + deid;
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, HttpContext.Current.Session["ConnStr"].ToString());
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;

        }
    }
}
