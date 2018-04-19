using AssessRite;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SuperAdmin
{
    public partial class ManageAdmins : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../Login.aspx");
            }
        }
        [System.Web.Services.WebMethod(EnableSession = true)]
        public static string SendParameters(int adminid, int schoolid, string adminname, string address, string contactno, string emailid, string username, string password, string buttontext)
        {
            if (buttontext == "Save")
            {
                string qur = "SELECT AdminId FROM Admin where SchoolId='" + schoolid + "' and AdminName='" + adminname + "' and  AdminContactNo='" + contactno.Trim() + "' and AdminEmailId='" + emailid.Trim() + "' and IsDeleted='0'";
                if (dbLibrary.idHasRows(qur))
                {
                    return "Admin Info Already Exists";
                }
                qur = "Select UserId from Login where UserName='" + username + "' and UserTypeId='2' and IsDeleted='0' and SchoolId='" + schoolid + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    return "UserName Already Exists";
                }
                qur = dbLibrary.idBuildQuery("[proc_AddAdmin]", "", schoolid.ToString(), adminname.Trim(), address.Trim(), contactno.Trim(), emailid.Trim(), username, password, "Insert");
                dbLibrary.idExecute(qur);
                return "Admin Added Successfully";
            }
            else
            {
                string qur = dbLibrary.idBuildQuery("[proc_AddAdmin]", adminid.ToString(), schoolid.ToString(), adminname.Trim(), address.Trim(), contactno.Trim(), emailid.Trim(), username, password, "Update");
                dbLibrary.idExecute(qur);
                return "Admin Info Updated Successfully";
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteAdmin(int adminid)
        {
            dbLibrary.idUpdateTable("Admin",
                "AdminId='" + adminid + "'",
                "IsDeleted", "1");
            return "Admin Deleted Successfully";
        }
    }
}