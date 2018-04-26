using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SuperAdmin
{
    public partial class ManageLevels : System.Web.UI.Page
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
        public static string SaveLevel(int levelid, int curriculumtypeid, string level, string buttontext)
        {
            //  return string.Format("subjectId: {0}{2}subject: {1}{2}classid: {3}{2}OtherLanguage: {4}", subjectid, subject, Environment.NewLine,classid,isotherlanguage);

            string qur = "Select LevelId from Level where CurriculumTypeId='"+curriculumtypeid+"' and LevelName='"+level+"' and IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int id = int.Parse(ds.Tables[0].Rows[0]["LevelId"].ToString());
                if (buttontext == "Save")
                {
                    return "Level Already Found";
                }
                else
                {
                    if (id == curriculumtypeid)
                    {

                        qur = "Update Level set LevelName='" + level + "' where  LevelId='" + levelid + "'";
                        dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                        return "Level Updated Successfully";
                    }
                    else
                    {
                        return "Level Already Found";
                    }
                }
            }
            else
            {
                if (buttontext == "Save")
                {
                    qur = "Insert Into Level(CurriculumTypeId, LevelName) values('" + curriculumtypeid + "','"+level+"')";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "Level Saved Successfully";
                }
                else
                {
                    qur = "Update Level set LevelName='" + level + "' where  LevelId='" + levelid + "'";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "Level Updated Successfully";
                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteState(int levelid)
        {
            string qur = "Update Level set IsDeleted='1' where LevelId='" + levelid + "'";
            dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
            return "Level Deleted Successfully";
        }
    }
}