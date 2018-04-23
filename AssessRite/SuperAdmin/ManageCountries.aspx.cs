using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SuperAdmin
{
    public partial class ManageCountries : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
        }

        [System.Web.Services.WebMethod]
        public static string SaveCountry(int countryid, string country, string buttontext)
        {

            string qur = "Select CountryId from Country where CountryName='" + country + "' and IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int id = int.Parse(ds.Tables[0].Rows[0]["CountryId"].ToString());
                if (buttontext == "Save")
                {
                    return "Country Name Already Found";
                }
                else
                {
                    if (id == countryid)
                    {
                        qur = "Update Country set CountryName='" + country + "' where CountryId='" + countryid + "'";
                        dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                        return "Country Name Updated Successfully";
                    }
                    else
                    {
                        return "Country Name Already Found";
                    }
                }
            }
            else
            {
                if (buttontext == "Save")
                {
                    //Insert
                    qur = "Insert Into Country(CountryName) values('" + country + "')";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "Country Name Saved Successfully";

                }
                else
                {
                    //Update
                    qur = "Update Country set CountryName='" + country + "' where CountryId='" + countryid + "'";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "Country Name Updated Successfully";

                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteCountry(int countryid)
        {

           string qur = "Update Country set IsDeleted='1' where CountryId='" + countryid + "'";
            dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
            return "Country Name Deleted Successfully";
        }
    }
}