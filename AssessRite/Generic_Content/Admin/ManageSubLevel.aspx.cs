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
        [WebMethod(EnableSession = true)]
        public static string SaveSubLevel(int sublevelid, int levelid, string levelname, string[] sublevelnames, string sublevel, string buttontext)
        {
            if (HttpContext.Current.Session["ConnStr"] != null)
            {
                if (levelname == "Class")
                {
                    //If Institution Type is School sublevel will be 0, sublevelnames will have class array
                    DataTable dtSubLevel = new DataTable();
                    dtSubLevel.Columns.Add("LevelId");
                    dtSubLevel.Columns.Add("SubLevel");
                    dtSubLevel.Columns.Add("IsDeleted");
                    foreach (string i in sublevelnames)
                    {
                        dtSubLevel.Rows.Add(levelid, i, "0");
                    }
                    string qur = "select SubLevel from SubLevel where LevelId='" + levelid + "' and IsDeleted='0'";
                    DataSet ds = dbLibrary.idGetDataAsDataset(qur, HttpContext.Current.Session["ConnStr"].ToString());
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        var rowsToDelete = from r1 in dtSubLevel.AsEnumerable()
                                           join r2 in ds.Tables[0].AsEnumerable()
                                                on r1.Field<string>("SubLevel") equals r2.Field<string>("SubLevel")
                                           select r1;

                        foreach (DataRow row in rowsToDelete.ToArray())
                            row.Delete(); // marks row as deleted;
                        dtSubLevel.AcceptChanges();
                    }
                    if (dtSubLevel.Rows.Count > 0)
                    {
                        dbLibrary.idInsertDataTableWithConnectionString("[proc_SaveSublevel]", "@List", dtSubLevel, HttpContext.Current.Session["ConnStr"].ToString());
                    }
                    return "Sub-Level Added Successfully";
                }
                else
                {
                    string qur = "Select SubLevelId from SubLevel where LevelId='" + levelid + "' and SubLevel='" + sublevel + "' and IsDeleted='0'";
                    DataSet ds = dbLibrary.idGetDataAsDataset(qur, HttpContext.Current.Session["ConnStr"].ToString());
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        int id = int.Parse(ds.Tables[0].Rows[0]["SubLevelId"].ToString());
                        if (buttontext == "Save")
                        {
                            return "Sub-Level Already Found";
                        }
                        else
                        {
                            if (id == sublevelid)
                            {
                                qur = "Update SubLevel set SubLevel='" + sublevel + "' where LevelId='" + sublevelid + "'";
                                dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
                                return "Sub-Level Updated Successfully";
                            }
                            else
                            {
                                return "Sub-Level Already Found";
                            }
                        }
                    }
                    else
                    {
                        if (buttontext == "Save")
                        {
                            //Insert
                            qur = "Insert Into SubLevel(LevelId, SubLevel) values('" + levelid + "','" + sublevel + "')";
                            dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
                            return "Sub-Level Saved Successfully";

                        }
                        else
                        {
                            //Update
                            qur = "Update SubLevel set SubLevel='" + sublevel + "' where LevelId='" + sublevelid + "'";
                            dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
                            return "Sub-Level Updated Successfully";

                        }
                    }
                }
            }
            else
            {
                return "Connection Lost";
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteSubLevel(int sublevelid)
        {
            string qur = "Update SubLevel set IsDeleted='1' where SubLevelId='" + sublevelid + "'";
            if (HttpContext.Current.Session["ConnStr"] != null)
            {
                dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
                return "Sub-Level Deleted Successfully";
            }
            else
            {
                return "Connection Lost";
            }

        }
    }
}