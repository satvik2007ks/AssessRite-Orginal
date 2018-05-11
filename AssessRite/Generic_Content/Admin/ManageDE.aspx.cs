using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.Generic_Content.Admin
{
    public partial class ManageDE : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SaveDE(int deid, string firstname, string lastname, string contactno, string emailid, string[] curriculumids, string username, string password, string buttontext)
        {
            if (HttpContext.Current.Session["ConnStr"] != null)
            {
                string qur = "SELECT DEId FROM DE where DEFirstName='" + firstname + "' and DELastName='" + lastname.Trim() + "' and DEContactNo='" + contactno.Trim() + "' and DEEmailId='" + emailid.Trim() + "'";
                DataSet ds = dbLibrary.idGetDataAsDataset(qur, HttpContext.Current.Session["ConnStr"].ToString());
                if (ds.Tables[0].Rows.Count > 0)
                {
                    int Id = int.Parse(ds.Tables[0].Rows[0]["DEId"].ToString());
                    if (buttontext == "Save")
                    {
                        return "DE Data Already Found";
                    }
                    else
                    {
                        if (Id == deid)
                        {
                            qur = "Select UserId from Login where UserName='" + username + "' and DEId<>'" + deid + "'";
                            DataSet ds1 = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
                            if (ds1.Tables[0].Rows.Count > 0)
                            {
                                return "UserName Already Exists";
                            }
                            else
                            {
                                qur = dbLibrary.idBuildQuery("[proc_AddDE]", deid.ToString(), firstname.Trim(), lastname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), HttpContext.Current.Session["AdminId"].ToString(), HttpContext.Current.Session["DefaultDB"].ToString(), "Update");
                                dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
                                DataTable dtDECurriculum = new DataTable();
                                dtDECurriculum.Columns.Add("DEId");
                                dtDECurriculum.Columns.Add("CurriculumTypeId");
                                foreach (string i in curriculumids)
                                {
                                    dtDECurriculum.Rows.Add(deid, i);
                                }
                                if (dtDECurriculum.Rows.Count > 0)
                                {
                                    dbLibrary.idInsertDataTableWithConnectionString("[proc_AssignDECurriculum]", "@List", dtDECurriculum, HttpContext.Current.Session["ConnStr"].ToString());
                                }
                                return "DE Details Updated Successfully";
                            }
                        }
                        else
                        {
                            return "DE Data Already Found";
                        }
                    }
                }
                else
                {
                    if (buttontext == "Save")
                    {
                        qur = "Select UserId from Login where UserName='" + username + "'";
                        DataSet ds1 = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
                        if (ds1.Tables[0].Rows.Count > 0)
                        {
                            return "UserName Already Exists";
                        }
                        else
                        {
                            string qurde = dbLibrary.idBuildQuery("[proc_AddDE]", "", firstname.Trim(), lastname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), HttpContext.Current.Session["AdminId"].ToString(), HttpContext.Current.Session["DefaultDB"].ToString(), "Insert");
                            DataSet dsDEId = dbLibrary.idGetDataAsDataset(qurde, HttpContext.Current.Session["ConnStr"].ToString());
                            if (dsDEId.Tables[0].Rows.Count > 0)
                            {
                                string newid = dsDEId.Tables[0].Rows[0]["id"].ToString();
                                DataTable dtDECurriculum = new DataTable();
                                dtDECurriculum.Columns.Add("DEId");
                                dtDECurriculum.Columns.Add("CurriculumTypeId");
                                foreach (string i in curriculumids)
                                {
                                    dtDECurriculum.Rows.Add(newid, i);
                                }
                                if (dtDECurriculum.Rows.Count > 0)
                                {
                                    dbLibrary.idInsertDataTableWithConnectionString("[proc_AssignDECurriculum]", "@List", dtDECurriculum, HttpContext.Current.Session["ConnStr"].ToString());
                                }
                            }
                            return "DE Added Successfully";
                        }
                    }
                    else
                    {
                        qur = "Select UserId from Login where UserName='" + username + "' and DEId<>'" + deid + "'";
                        DataSet ds1 = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
                        if (ds1.Tables[0].Rows.Count > 0)
                        {
                            return "UserName Already Exists";
                        }
                        else
                        {
                            qur = dbLibrary.idBuildQuery("[proc_AddDE]", deid.ToString(), firstname.Trim(), lastname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), HttpContext.Current.Session["AdminId"].ToString(), HttpContext.Current.Session["DefaultDB"].ToString(), "Update");
                            dbLibrary.idExecuteWithConnectionString(qur, HttpContext.Current.Session["ConnStr"].ToString());
                            DataTable dtDECurriculum = new DataTable();
                            dtDECurriculum.Columns.Add("DEId");
                            dtDECurriculum.Columns.Add("CurriculumTypeId");
                            foreach (string i in curriculumids)
                            {
                                dtDECurriculum.Rows.Add(deid, i);
                            }
                            if (dtDECurriculum.Rows.Count > 0)
                            {
                                dbLibrary.idInsertDataTableWithConnectionString("[proc_AssignDECurriculum]", "@List", dtDECurriculum, HttpContext.Current.Session["ConnStr"].ToString());
                            }
                            return "DE Details Updated Successfully";
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
        public static string DeleteDE(int DEid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_DeleteDE]", DEid.ToString());
            dbLibrary.idExecute(qur);
            return "DE Deleted Successfully";
        }
    }
}