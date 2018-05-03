using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
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
        public string GetCurriculumTypesForGCAdminDropDown()
        {
            string qur = "SELECT GCAdminAssignedCurriculum.CurriculumTypeId, CurriculumType.CurriculumType "+
                         " FROM CurriculumType RIGHT OUTER JOIN "+
                         " GCAdminAssignedCurriculum ON CurriculumType.CurriculumTypeId = GCAdminAssignedCurriculum.CurriculumTypeId" +
                         " Where CurriculumType.IsDeleted = '0' and AdminId = '" + HttpContext.Current.Session["AdminId"].ToString() + "'";
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
        public string LoadDropDownSubLevels(int levelid)
        {
            string qur = "SELECT  SubLevel, SubLevelId from SubLevel where LevelId='" + levelid + "' and  IsDeleted='0'";
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
    }
}
