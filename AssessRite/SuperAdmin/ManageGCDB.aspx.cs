using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SuperAdmin
{
    public partial class ManageGCDB : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
        }
        [System.Web.Services.WebMethod]
        public static string SaveGCDB(int gcdbid, int countryid, int stateid, string dbname, string buttontext)
        {
            string qur = "Select GCDBId from GCDBDetails where GCDBName='" + dbname + "' and CountryId='" + countryid + "' and StateId='" + stateid + "' and IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int id = int.Parse(ds.Tables[0].Rows[0]["InstitutionTypeId"].ToString());
                if (buttontext == "Save")
                {
                    return "Database Name Already Found";
                }
                else
                {
                    if (id == gcdbid)
                    {
                        qur = "Update GCDBDetails set GCDBName='" + dbname + "' where GCDBId='" + gcdbid + "'";
                        dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                        return "Institution Type Updated Successfully";
                    }
                    else
                    {
                        return "Database Name Already Found";
                    }
                }
            }
            else
            {
                if (buttontext == "Save")
                {
                    //Insert
                    qur = "Insert Into GCDBDetails(CountryId, StateId, GCDBName) values('" + countryid + "', '" + stateid + "','" + dbname + "')";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "Database Name Saved Successfully";

                }
                else
                {
                    //Update
                    qur = "Update GCDBDetails set GCDBName='" + dbname + "' where GCDBId='" + gcdbid + "'";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "Database Name Updated Successfully";

                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteDatabase(int gcdbid)
        {
            string qur = "Update InstitutionType set IsDeleted='1' where GCDBId='" + gcdbid + "'";
            dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
            return "Database Deleted Successfully";
        }
    }
}