using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SuperAdmin
{
    public partial class ManageInstitutionTypes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
        }

        [System.Web.Services.WebMethod]
        public static string SaveInstitutionType(int institutiontypeid, string institutiontype, string buttontext)
        {
            string qur = "Select InstitutionTypeId from InstitutionType where InstitutionType='" + institutiontype + "' and IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int id = int.Parse(ds.Tables[0].Rows[0]["InstitutionTypeId"].ToString());
                if (buttontext == "Save")
                {
                    return "Institution Type Already Found";
                }
                else
                {
                    if (id == institutiontypeid)
                    {
                        qur = "Update InstitutionType set InstitutionType='" + institutiontype + "' where InstitutionTypeId='" + institutiontypeid + "'";
                        dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                        return "Institution Type Updated Successfully";
                    }
                    else
                    {
                        return "Institution Type Already Found";
                    }
                }
            }
            else
            {
                if (buttontext == "Save")
                {
                    //Insert
                    qur = "Insert Into InstitutionType(InstitutionType) values('" + institutiontype + "')";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "Institution Type Saved Successfully";

                }
                else
                {
                    //Update
                    qur = "Update InstitutionType set InstitutionType='" + institutiontype + "' where InstitutionTypeId='" + institutiontypeid + "'";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "Institution Type Updated Successfully";

                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteInstitutionType(int institutiontypeid)
        {
            string qur = "Update InstitutionType set IsDeleted='1' where InstitutionTypeId='" + institutiontypeid + "'";
            dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
            return "Institution Type Deleted Successfully";
        }
    }
}