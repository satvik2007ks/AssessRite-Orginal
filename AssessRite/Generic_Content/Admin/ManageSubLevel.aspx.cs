using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.Generic_Content.Admin
{
    public partial class ManageSubLevel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("../../Login.aspx");
                }
                else
                {
                    hdnCountry.Value = Session["CountryId"].ToString();
                    hdnState.Value = Session["StateId"].ToString();
                }
            }
        }
        [WebMethod(EnableSession =true)]
        public static string SaveSubLevel(int sublevelid, int levelid, string institutiontype, string[] sublevelnames, string sublevel,string buttontext)
        {
            if(institutiontype=="School")
            {
                //If Institution Type is School sublevel will be 0, sublevelnames will have class array
                DataTable dtSubLevel = new DataTable();
                dtSubLevel.Columns.Add("LevelId");
                dtSubLevel.Columns.Add("SubLevel");
                dtSubLevel.Columns.Add("IsDeleted");
                foreach (string i in sublevelnames)
                {
                    dtSubLevel.Rows.Add(levelid, i,"0");
                }
                if (dtSubLevel.Rows.Count > 0)
                {
                    if(HttpContext.Current.Session["DefaultDB"]!=null)
                    {
                        string db = HttpContext.Current.Session["DefaultDB"].ToString();
                        string conn = dbLibrary.getConnectionString(db);
                        dbLibrary.idInsertDataTableWithConnectionString("[proc_SaveSchoolSublevel]", "@List", dtSubLevel, conn);
                    }
                }
                return "Sub-Level Added Successfully";
            }
            else
            {
                string qur = "Select SubLevelId from SubLevel where LevelId='" + levelid + "' and SubLevel='"+ sublevel + "' IsDeleted='0'";
                DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    int id = int.Parse(ds.Tables[0].Rows[0]["SubLevelId"].ToString());
                    if (buttontext == "Save")
                    {
                        return "SubLevel Already Found";
                    }
                    else
                    {
                        if (id == sublevelid)
                        {
                            qur = "Update SubLevel set SubLevel='" + sublevel + "' where LevelId='" + sublevelid + "'";
                            dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                            return "SubLevel Updated Successfully";
                        }
                        else
                        {
                            return "SubLevel Already Found";
                        }
                    }
                }
                else
                {
                    if (buttontext == "Save")
                    {
                        //Insert
                        qur = "Insert Into SubLevel(LevelId, SubLevel) values('" + levelid + "','"+sublevel+"')";
                        dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                        return "SubLevel Saved Successfully";

                    }
                    else
                    {
                        //Update
                        qur = "Update SubLevel set SubLevel='" + sublevel + "' where LevelId='" + sublevelid + "'";
                        dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                        return "Country Name Updated Successfully";

                    }
                }
            }
        }
    }
}