﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SuperAdmin
{
    public partial class ManageGCAdmins : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SaveGCAdmin(int adminid, int countryid, int stateid, string adminname, string address, string contactno, string emailid, string username, string password, string buttontext)
        {
            string qur = "SELECT AdminId FROM Admin where Countryid='" + countryid + "' and StateId='" + stateid + "' and AdminName='" + adminname + "' and  AdminContactNo='" + contactno.Trim() + "' and AdminEmailId='" + emailid.Trim() + "' and IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int id = int.Parse(ds.Tables[0].Rows[0]["AdminId"].ToString());
                if (buttontext == "Save")
                {
                    return "Admin Info Already Found";
                }
                else
                {
                    if (id == adminid)
                    {
                        qur = "Select UserId from Login where UserName='" + username + "' and AdminId<>'" + adminid + "'";
                        DataSet ds1 = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
                        if (ds1.Tables[0].Rows.Count > 0)
                        {
                            return "UserName Already Exists";
                        }
                        else
                        {
                            qur = dbLibrary.idBuildQuery("[proc_AddAdmin]", adminid.ToString(), "0", countryid.ToString(), stateid.ToString(), adminname.Trim(), address.Trim(), contactno.Trim(), emailid.Trim(), username, password, "Update");
                            dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                            return "Admin Info Updated Successfully";
                        }
                    }
                    else
                    {
                        return "Admin Info Already Found";
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
                        qur = dbLibrary.idBuildQuery("[proc_AddAdmin]", "", "0", countryid.ToString(), stateid.ToString(), adminname.Trim(), address.Trim(), contactno.Trim(), emailid.Trim(), username, password, "Insert");
                        dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                        return "Admin Added Successfully";
                    }
                }
                else
                {
                    qur = "Select UserId from Login where UserName='" + username + "' and AdminId<>'" + adminid + "'";
                    DataSet ds1 = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        return "UserName Already Exists";
                    }
                    else
                    {
                        qur = dbLibrary.idBuildQuery("[proc_AddAdmin]", adminid.ToString(), "0", countryid.ToString(), stateid.ToString(), adminname.Trim(), address.Trim(), contactno.Trim(), emailid.Trim(), username, password, "Update");
                        dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                        return "Admin Info Updated Successfully";
                    }
                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteGCAdmin(int adminid)
        {
            dbLibrary.idUpdateTable("Admin",
                "AdminId='" + adminid + "'",
                "IsDeleted", "1");
            return "Admin Deleted Successfully";
        }
    }
}