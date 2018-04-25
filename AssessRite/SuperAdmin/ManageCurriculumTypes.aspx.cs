using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SuperAdmin
{
    public partial class ManageCurriculumTypes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
            if (!IsPostBack)
            {
                loadDropDown();
                // loadGrid();
            }
        }

        private void loadDropDown()
        {
            string qur = "Select * from InstitutionType where IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlInstitutionType.DataTextField = "InstitutionType";
                ddlInstitutionType.DataValueField = "InstitutionTypeId";
                ddlInstitutionType.DataSource = ds;
                ddlInstitutionType.DataBind();
                ddlInstitutionType.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlInstitutionType.SelectedIndex = 0;
            }
            else
            {
                ddlInstitutionType.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlInstitutionType.SelectedIndex = 0;
            }
        }

        [System.Web.Services.WebMethod]
        public static string SaveCurriculumType(int curriculumtypeid, int countryid, int stateid, string curriculumtype, int institutiontypeid, string buttontext)
        {
            //  return string.Format("subjectId: {0}{2}subject: {1}{2}classid: {3}{2}OtherLanguage: {4}", subjectid, subject, Environment.NewLine,classid,isotherlanguage);

            string qur = "Select CurriculumTypeId from CurriculumType where CurriculumType='" + curriculumtype + "' and CountryId='" + countryid + "' and StateId='" + stateid + "' and InstitutionTypeId='" + institutiontypeid + "' and IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int id = int.Parse(ds.Tables[0].Rows[0]["CurriculumTypeId"].ToString());
                if (buttontext == "Save")
                {
                    return "Curriculum Type Already Found";
                }
                else
                {
                    if (id == curriculumtypeid)
                    {

                        qur = "Update CurriculumType set CurriculumType='" + curriculumtype + "', CountryId='" + countryid + "', StateId='" + stateid + "', InstitutionTypeId='" + institutiontypeid + "' where  CurriculumTypeId='" + curriculumtypeid + "'";
                        dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                        return "Curriculum Type Updated Successfully";
                    }
                    else
                    {
                        return "Curriculum Type Already Found";
                    }
                }
            }
            else
            {
                if (buttontext == "Save")
                {
                    qur = "Insert Into CurriculumType(CountryId, StateId, InstitutionTypeId, CurriculumType) values('" + countryid + "','" + stateid + "','" + institutiontypeid + "','" + curriculumtype + "')";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "Curriculum Type Saved Successfully";
                }
                else
                {
                    qur = "Update CurriculumType set CurriculumType='" + curriculumtype + "', CountryId='" + countryid + "', StateId='" + stateid + "', InstitutionTypeId='" + institutiontypeid + "' where  CurriculumTypeId='" + curriculumtypeid + "'";

                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "Curriculum Type Updated Successfully";
                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteState(int curriculumtypeid)
        {
            string qur = "Update CurriculumType set IsDeleted='1' where CurriculumTypeId='" + curriculumtypeid + "'";
            dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
            return "Curriculum Type Deleted Successfully";
        }
    }
}