using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.SuperAdmin
{
    public partial class ManageStates : System.Web.UI.Page
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
            string qur = "Select * from Country where IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlCountry.DataTextField = "CountryName";
                ddlCountry.DataValueField = "CountryId";
                ddlCountry.DataSource = ds;
                ddlCountry.DataBind();
                ddlCountry.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlCountry.SelectedIndex = 0;
            }
            else
            {
                ddlCountry.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlCountry.SelectedIndex = 0;
            }
        }

        [System.Web.Services.WebMethod]
        public static string SaveState(int stateid, string state, int countryid, string buttontext)
        {
            //  return string.Format("subjectId: {0}{2}subject: {1}{2}classid: {3}{2}OtherLanguage: {4}", subjectid, subject, Environment.NewLine,classid,isotherlanguage);

            string qur = "Select StateId from State where StateName='" + state + "' and CountryId='" + countryid + "' and IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                int id = int.Parse(ds.Tables[0].Rows[0]["StateId"].ToString());
                if (buttontext == "Save")
                {
                    return "State Already Found";
                }
                else
                {
                    if (id == stateid)
                    {

                        qur = "Update State set StateName='" + state + "' where CountryId='" + countryid + "' and StateId='" + stateid + "'";
                        dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                        return "State Updated Successfully";
                    }
                    else
                    {
                        return "State Already Found";
                    }
                }
            }
            else
            {
                if (buttontext == "Save")
                {
                    qur = "Insert Into State(StateName, CountryId) values('" + state + "','" + countryid + "')";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "State Saved Successfully";
                }
                else
                {
                    qur = "Update State set StateName='" + state + "' where CountryId='" + countryid + "' and StateId='" + stateid + "'";
                    dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
                    return "State Updated Successfully";

                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteState(int stateid)
        {
            string qur = "Update State set IsDeleted='1' where StateId='" + stateid + "'";
            dbLibrary.idExecuteWithConnectionString(qur, dbLibrary.MasterconStr);
            return "State Deleted Successfully";
        }
    }
}