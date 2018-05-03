using System;
using System.Collections.Generic;
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
        public static string SendParameters(int deid, string firstname, string lastname, string contactno, string emailid, string username, string password, string buttontext)
        {
            if (buttontext == "Save")
            {
                string qur = "SELECT DEId FROM DE where DEFirstName='" + firstname + "' and DELastName='" + lastname.Trim() + "' and DEContactNo='" + contactno.Trim() + "' and DEEmailId='" + emailid.Trim() + "' and IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    return "DE Data Already Exists";
                }
                qur = "Select UserId from Login where UserName='" + username + "' and UserTypeId='5' and IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    return "UserName Already Exists";
                }
                qur = dbLibrary.idBuildQuery("[proc_AddDE]", "", firstname.Trim(), lastname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), "Insert", HttpContext.Current.Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                return "DE Added Successfully";
            }
            else
            {
                string qur = dbLibrary.idBuildQuery("[proc_AddDE]", deid.ToString(), firstname.Trim(), lastname.Trim(), contactno.Trim(), emailid.Trim(), username.Trim(), password.Trim(), "Update", HttpContext.Current.Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                return "DE Details Updated Successfully";
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