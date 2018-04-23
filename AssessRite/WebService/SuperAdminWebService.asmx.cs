using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
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
        public string LoadSchoolDropdownState(int countryid)
        {
            string qur = "Select * from State where CountryId='" + countryid +"' and IsDeleted='0'" ;
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
    }
}
