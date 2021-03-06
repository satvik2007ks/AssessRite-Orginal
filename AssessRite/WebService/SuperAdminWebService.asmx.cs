﻿using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace AssessRite.WebMethods
{
    /// <summary>
    /// Summary description for SuperAdminWebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class SuperAdminWebService : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetCountries()
        {
            string qur = "Select * from Country where IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
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

        [WebMethod]
        public string GetStates()
        {
            string qur = "SELECT State.StateId, State.CountryId, Country.CountryName, State.StateName FROM Country INNER JOIN State ON Country.CountryId = State.CountryId Where Country.IsDeleted = '0' and State.IsDeleted = '0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
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

        [WebMethod]
        public string LoadSchoolDropdownCountry()
        {
            string qur = "Select * from Country where IsDeleted='0'";
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
        public string GetInstitutionTypesForDropDown()
        {
            string qur = "Select * from InstitutionType where IsDeleted='0'";
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
        public string LoadSchoolDropdownState(int countryid)
        {
            string qur = "Select * from State where CountryId='" + countryid + "' and IsDeleted='0'";
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
        public string GetSchoolData()
        {
            string qur = "SELECT Country.CountryName, State.StateName, SchoolInfo.schoolId, SchoolInfo.SchoolName, SchoolInfo.URL, SchoolInfo.SchoolAddress, SchoolInfo.StateId, " +
                         " SchoolInfo.ZipCode, SchoolInfo.CountryId, SchoolInfo.ContactNo, SchoolInfo.Email, SchoolInfo.NoOfStudents, SchoolInfo.EmergencyContactNo, " +
                          " SchoolInfo.PrincipalName" +
                         " FROM Country INNER JOIN" +
                          " SchoolInfo ON Country.CountryId = SchoolInfo.CountryId INNER JOIN " +
                         " State ON SchoolInfo.StateId = State.StateId where SchoolInfo.IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod]
        public string LoadSchoolDropdownSchool()
        {
            string qur = "Select SchoolId, SchoolName from SchoolInfo";
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
        public string GetAdminDataForSuperAdmin()
        {
            string qur = "SELECT SchoolInfo.SchoolName, Admin.AdminId, Admin.SchoolId, Admin.AdminName, Admin.AdminAddress, Admin.AdminContactNo, Admin.AdminEmailId, Login.UserName,  " +
" Login.Password FROM  Admin INNER JOIN SchoolInfo ON Admin.SchoolId = SchoolInfo.schoolId INNER JOIN Login ON Admin.AdminId = Login.AdminId AND Admin.SchoolId = Login.SchoolId " +
" WHERE(Admin.IsDeleted = '0') AND(SchoolInfo.IsDeleted = '0')";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod]
        public string getAllTestTypesForSchool(int schoolid)
        {
            string qur = "Select TestType from SchoolTestType where SchoolId=" + schoolid;
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
        public string GetInstitutionTypes()
        {
            string qur = "Select * from InstitutionType where IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
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

        [WebMethod]
        public string GetCurriculumTypes()
        {
            string qur = "SELECT CurriculumType.CurriculumTypeId, CurriculumType.InstitutionTypeId, CurriculumType.CurriculumType, InstitutionType.InstitutionType, CurriculumType.CountryId, " +
                         " CurriculumType.StateId, Country.CountryName, State.StateName " +
                         " FROM CurriculumType INNER JOIN " +
                         " InstitutionType ON CurriculumType.InstitutionTypeId = InstitutionType.InstitutionTypeId INNER JOIN " +
                         " Country ON CurriculumType.CountryId = Country.CountryId INNER JOIN " +
                         " State ON CurriculumType.StateId = State.StateId " +
                         " WHERE(CurriculumType.IsDeleted = '0') AND(InstitutionType.IsDeleted = '0')";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
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

        [WebMethod]
        public string LoadDropDownCurriculumType(int countryid, int stateid, int institutionTypeId)
        {
            string qur = "SELECT  CurriculumTypeId, CurriculumType FROM  CurriculumType where CountryId='" + countryid + "' and StateId='" + stateid + "' and InstitutionTypeId='" + institutionTypeId + "' and  IsDeleted='0'";
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
        public string GetLevels()
        {
            string qur = "SELECT  [Level].LevelId, [Level].CurriculumTypeId, [Level].LevelName, CurriculumType.CountryId, CurriculumType.StateId, CurriculumType.InstitutionTypeId, CurriculumType.CurriculumType, Country.CountryName, State.StateName, " +
                         " InstitutionType.InstitutionType " +
                         " FROM  CurriculumType INNER JOIN " +
                         " Country ON CurriculumType.CountryId = Country.CountryId INNER JOIN " +
                         " InstitutionType ON CurriculumType.InstitutionTypeId = InstitutionType.InstitutionTypeId INNER JOIN " +
                         " [Level] ON CurriculumType.CurriculumTypeId = [Level].CurriculumTypeId INNER JOIN " +
                         " State ON CurriculumType.StateId = State.StateId " +
                         " Where Country.IsDeleted = '0' and State.IsDeleted = '0' and InstitutionType.IsDeleted = '0' and CurriculumType.IsDeleted = '0' and[Level].IsDeleted = '0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
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

        [WebMethod]
        public string GetGCAdmins()
        {
            string qur = "SELECT Admin.AdminId, Admin.AdminName, Admin.AdminAddress, Admin.AdminContactNo, Admin.AdminEmailId,Admin.IsStateAdmin, Login.UserName, Login.Password, Login.DefaultDB, Admin.CountryId, " +
                         " Admin.StateId, Country.CountryName, State.StateName " +
                         " FROM  Admin INNER JOIN " +
                         " Login ON Admin.AdminId = Login.AdminId INNER JOIN " +
                         " Country ON Admin.CountryId = Country.CountryId INNER JOIN " +
                         " State ON Admin.StateId = State.StateId " +
                         " WHERE(Admin.IsDeleted = '0')";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod]
        public string LoadDropDownLevels(int curriculumtypeId)
        {
            string qur = "SELECT  LevelName, LevelId from Level where CurriculumTypeId='" + curriculumtypeId + "' and  IsDeleted='0'";
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
        public string GetGCDB()
        {
            string qur = "SELECT  Country.CountryName, State.StateName,GCDBDetails.CountryId, GCDBDetails.StateId, GCDBDetails.GCDBId, GCDBDetails.GCDBName FROM  State RIGHT OUTER JOIN GCDBDetails ON State.StateId = GCDBDetails.StateId LEFT OUTER JOIN Country ON GCDBDetails.CountryId = Country.CountryId Where GCDBDetails.IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
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

        [WebMethod]
        public string loadDropDownDefaultDB(int countryid,int stateid)
        {
            string qur = "SELECT  GCDBName, GCDBId from GCDBDetails where CountryId='" + countryid + "' and StateId='"+stateid+"' and  IsDeleted='0'";
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
        public string LoadCurriculumCheckboxlist(int countryid, int stateid)
        {
            string qur = "SELECT CurriculumType.CurriculumType, CurriculumType.CurriculumTypeId, InstitutionType.InstitutionType FROM CurriculumType INNER JOIN InstitutionType ON CurriculumType.InstitutionTypeId = InstitutionType.InstitutionTypeId where CurriculumType.CountryId='" + countryid+ "' and CurriculumType.StateId='" + stateid+ "' and CurriculumType.IsDeleted='0' and InstitutionType.IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                List<CheckBoxItem> chkListClass = new List<CheckBoxItem>();
                chkListClass = (from DataRow dr in ds.Tables[0].Rows
                                select new CheckBoxItem()
                                {
                                    CurriculumId = Convert.ToInt32(dr["CurriculumTypeId"].ToString()),
                                    Curriculum = dr["CurriculumType"].ToString()+"- ("+dr["InstitutionType"].ToString()+")",
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

        [WebMethod]
        public string getAllCurriculumForAdmin(int adminid)
        {
            string qur = "Select CurriculumTypeId from GCAdminAssignedCurriculum where AdminId=" + adminid;
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
