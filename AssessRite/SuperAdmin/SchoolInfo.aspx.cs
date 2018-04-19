using AssessRite;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SuperAdmin
{
    public partial class SchoolInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SendParameters(int schoolid, string[] testtype, string schoolname, string schooladdress, int countryid, int stateid, string zipcode, string contactno, string emailid, int noofstudents, string principalname, string emergencycontact, string buttontext)
        {
            //
            if (buttontext == "Save")
            {
                string qur = "SELECT SchoolId FROM SchoolInfo where SchoolName='" + schoolname.Trim() + "' CountryId='"+countryid+"' and StateId='"+stateid+"' and ContactNo='" + contactno.Trim() + "' and EmailId='" + emailid.Trim() + "' and IsDeleted='0'";
                if (dbLibrary.idHasRows(qur))
                {
                    return "School Info Already Exists";
                }
                qur = dbLibrary.idBuildQuery("[proc_AddSchool]", "", schoolname.Trim(), schooladdress.Trim(), countryid.ToString(), stateid.ToString(), zipcode, contactno.Trim(), emailid.Trim(), noofstudents.ToString(), emergencycontact,principalname, "Insert");
                string id = dbLibrary.idGetAFieldByQuery(qur);
                DataTable dtTestType = new DataTable();
                dtTestType.Columns.Add("SchoolId");
                dtTestType.Columns.Add("TestType");
                foreach (string i in testtype)
                {
                    dtTestType.Rows.Add(id, i);
                }
                if (dtTestType.Rows.Count > 0)
                {
                    dbLibrary.idInsertDataTable("[proc_saveSchoolTestType]", "@List", dtTestType);
                }
                return "School Added Successfully";
            }
            else
            {
                string qur = dbLibrary.idBuildQuery("[proc_AddSchool]", schoolid.ToString(), schoolname.Trim(), schooladdress.Trim(), countryid.ToString(), stateid.ToString(), zipcode, contactno.Trim(), emailid.Trim(), noofstudents.ToString(), emergencycontact, principalname, "Update");
                dbLibrary.idExecute(qur);
                DataTable dtTestType = new DataTable();
                dtTestType.Columns.Add("SchoolId");
                dtTestType.Columns.Add("TestType");
                foreach (string i in testtype)
                {
                    dtTestType.Rows.Add(schoolid.ToString(), i);
                }
                if (dtTestType.Rows.Count > 0)
                {
                    dbLibrary.idInsertDataTable("[proc_saveSchoolTestType]", "@List", dtTestType);
                }
                return "School Info Updated Successfully";
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteSchool(int schoolid)
        {
            dbLibrary.idUpdateTable("SchoolInfo",
                "SchoolId='"+schoolid+"'",
                "IsDeleted","1");
            return "School Info Deleted Successfully";
        }
    }
}