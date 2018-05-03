using AssessRite;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite._3.Admin
{
    public partial class ManageSME : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadRptClassDetails();
                LoadGrid();
            }
        }

        private void LoadGrid()
        {
            string qur = "SELECT SME.SMEId, SME.SMEFirstName, SME.SMELastName, SME.SMEContactNo, SME.SMEEmailId, Login.UserName, Login.Password FROM Login INNER JOIN SME ON Login.SMEId = SME.SMEId where SME.IsDeleted='0' and SME.SchoolId=" + Session["InstitutionId"].ToString();
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            gridSME.DataSource = ds;
            gridSME.DataBind();
        }

        private void LoadRptClassDetails()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getSubjects]", Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            ViewState["Results"] = ds.Tables[0];
            //if (ds.Tables[0].Rows.Count > 0)
            //{
            //    rptSME.DataSource = ds;
            //    rptSME.DataBind();
            //}
            var distinctRows = (from DataRow dRow in ds.Tables[0].Rows
                                select new { col1 = dRow["ClassId"], col2 = dRow["ClassName"] }).Distinct();
            DataTable dt = new DataTable();

            dt.Columns.Add("ClassId");
            dt.Columns.Add("ClassName");
            foreach (var rows in distinctRows)
            {
                DataRow dr = dt.NewRow();
                dr["ClassId"] = rows.col1;
                dr["ClassName"] = rows.col2;
                dt.Rows.Add(dr);
            }
            if (dt.Rows.Count > 0)
            {
                rptSME.DataSource = dt;
                rptSME.DataBind();
                //rptSMEDetails.DataSource = dt;
                //rptSME.DataBind();
            }
        }

        protected void btnSMESave_Click(object sender, EventArgs e)
        {
            if (txtFirstName.Text == "")
            {
                lblError.Text = "Please Enter First Name";
                divError.Attributes.Add("style", "display:block");
                return;
            }
            if (txtLastName.Text == "")
            {
                lblError.Text = "Please Enter Last Name";
                divError.Attributes.Add("style", "display:block");
                return;
            }
            int countClass = 0;
            foreach (RepeaterItem i in rptSME.Items)
            {
                if (i.ItemType == ListItemType.Item || i.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkClass = i.FindControl("chkClass") as CheckBox;
                    CheckBoxList chkSubjects = i.FindControl("chkSubjects") as CheckBoxList;
                    if (chkClass.Checked == true)
                    {
                        int subjectcount = 0;
                        foreach (ListItem li in chkSubjects.Items)
                        {
                            if (li.Selected == true)
                            {
                                subjectcount++;
                            }
                        }
                        if (subjectcount == 0)
                        {
                            lblError.Text = "Please Select Subjects For Class " + chkClass.Text;
                            divError.Attributes.Add("style", "display:block");
                            return;
                        }
                        countClass++;
                    }
                }
            }
            if (countClass == 0)
            {
                lblError.Text = "Please Select Class For SME";
                divError.Attributes.Add("style", "display:block");
                return;
            }
            if (txtUserName.Text == "")
            {
                lblError.Text = "Please Enter UserName";
                divError.Attributes.Add("style", "display:block");
                return;
            }
            if (txtPassword.Text == "")
            {
                lblError.Text = "Please Enter Password";
                divError.Attributes.Add("style", "display:block");
                return;
            }
            if (btnSMESave.Text == "Save")
            {
                string qur = "SELECT SMEId FROM SME where SMEFirstName='" + txtFirstName.Text.Trim() + "' and SMELastName='" + txtLastName.Text.Trim() + "' and SMEContactNo='" + txtContactNo.Text.Trim() + "' and SMEEmailId='" + txtEmailID.Text.Trim() + "' and IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "SME Data Already Exists";
                    lblError.Focus();
                    return;
                }
                qur = "Select UserId from Login where UserName='" + txtUserName.Text + "' and UserTypeId='6' and IsDeleted='0' and SchoolId='" + Session["InstitutionId"].ToString() + "'";
                if (dbLibrary.idHasRows(qur))
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "UserName Already Exists";
                    lblError.Focus();
                    txtUserName.Focus();
                    return;
                }
                qur = dbLibrary.idBuildQuery("[proc_AddSME]", "", txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtContactNo.Text.Trim(), txtEmailID.Text.Trim(), txtUserName.Text.Trim(), txtPassword.Text.Trim(), "Insert", Session["InstitutionId"].ToString());
                string smeid = dbLibrary.idGetAFieldByQuery(qur);
                SaveSMEDetails(smeid);
                lblMsg.Text = "SME Added Successfully";
            }
            else
            {
                string qur = dbLibrary.idBuildQuery("[proc_AddSME]", Session["SMEId"].ToString(), txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtContactNo.Text.Trim(), txtEmailID.Text.Trim(), txtUserName.Text.Trim(), txtPassword.Text.Trim(), "Update", Session["InstitutionId"].ToString());
                dbLibrary.idExecute(qur);
                SaveSMEDetails(Session["SMEId"].ToString());
                lblMsg.Text = "SME Details Updated Successfully";
            }
            btnDelete.Visible = false;
            Clear();
            LoadGrid();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        private void SaveSMEDetails(string smeid)
        {
            foreach (RepeaterItem i in rptSME.Items)
            {
                if (i.ItemType == ListItemType.Item || i.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkClass = i.FindControl("chkClass") as CheckBox;
                    HiddenField hdnClassId = i.FindControl("hdnClassId") as HiddenField;
                    if (chkClass.Checked)
                    {
                        string qur = dbLibrary.idBuildQuery("proc_SaveSMEClassDetails", smeid, hdnClassId.Value);
                        string smeclassid = dbLibrary.idGetAFieldByQuery(qur);
                        CheckBoxList chkSubjects = i.FindControl("chkSubjects") as CheckBoxList;
                        DataTable dtSMESubjects = new DataTable();
                        dtSMESubjects.Columns.Add("SMEClassId");
                        dtSMESubjects.Columns.Add("SubjectId");
                        foreach (ListItem li in chkSubjects.Items)
                        {
                            if (li.Selected == true)
                            {
                                dtSMESubjects.Rows.Add(smeclassid, li.Value.ToString());
                            }
                        }
                        if (dtSMESubjects.Rows.Count > 0)
                        {
                            dbLibrary.idInsertDataTable("proc_SaveSMESubjectDetails", "@SubjectList", dtSMESubjects);
                        }
                    }
                }
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            Clear();
        }

        private void Clear()
        {
            txtFirstName.Text = "";
            txtLastName.Text = "";
            txtContactNo.Text = "";
            txtEmailID.Text = "";
            txtUserName.Text = "";
            txtPassword.Text = "";
            btnSMESave.Text = "Save";
            lblError.Text = "";
            divError.Attributes.Add("Style", "display:none");
            foreach (RepeaterItem items in rptSME.Items)
            {
                if (items.ItemType == ListItemType.Item || items.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkClass = items.FindControl("chkClass") as CheckBox;
                    CheckBoxList chkSubjects = items.FindControl("chkSubjects") as CheckBoxList;
                    chkClass.Checked = false;
                    foreach (ListItem li in chkSubjects.Items)
                    {
                        li.Selected = false;
                    }
                    chkSubjects.Enabled = false;
                }
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        protected void btnDeleteYes_Click(object sender, EventArgs e)
        {
            string qur = dbLibrary.idBuildQuery("[proc_DeleteSME]", btnDeleteYes.CommandArgument);
            dbLibrary.idExecute(qur);
            LoadGrid();
            Clear();
            lblMsg.Text = "SME Deleted Successfully";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallMyFunction1", "runEffect1()", true);

        }

        protected void gridSME_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
                e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gridSME, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void gridSME_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gridSME.Rows)
            {
                if (row.RowIndex == gridSME.SelectedIndex)
                {
                    Clear();
                    row.BackColor = ColorTranslator.FromHtml("#F1F1F1");
                    row.ForeColor = Color.Black;
                    row.ToolTip = string.Empty;
                    txtFirstName.Text = gridSME.SelectedRow.Cells[0].Text;
                    txtLastName.Text = gridSME.SelectedRow.Cells[1].Text;
                    txtContactNo.Text = gridSME.SelectedRow.Cells[2].Text;
                    txtEmailID.Text = gridSME.SelectedRow.Cells[3].Text;
                    txtUserName.Text = gridSME.SelectedRow.Cells[4].Text;
                    txtPassword.Text = gridSME.SelectedRow.Cells[5].Text;
                    Session["SMEId"] = gridSME.SelectedDataKey.Value;
                    btnDeleteYes.CommandArgument = gridSME.SelectedDataKey.Value.ToString();
                    string qurClass = dbLibrary.idBuildQuery("proc_getSMEDetails", gridSME.SelectedDataKey.Value.ToString());
                    DataSet ds = dbLibrary.idGetCustomResult(qurClass);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (RepeaterItem i in rptSME.Items)
                        {
                            if (i.ItemType == ListItemType.Item || i.ItemType == ListItemType.AlternatingItem)
                            {
                                CheckBox chkClass = i.FindControl("chkClass") as CheckBox;
                                CheckBoxList chkSubjects = i.FindControl("chkSubjects") as CheckBoxList;
                                HiddenField hdnClassId = i.FindControl("hdnClassId") as HiddenField;
                                foreach (DataRow dr in ds.Tables[0].Rows)
                                {
                                    if (dr["ClassId"].ToString() == hdnClassId.Value)
                                    {
                                        chkClass.Checked = true;
                                        chkClass_CheckedChanged(chkClass, EventArgs.Empty);
                                        if (ds.Tables[1].Rows.Count > 0)
                                        {

                                            foreach (DataRow drv in ds.Tables[1].Rows)
                                            {
                                                foreach (ListItem li in chkSubjects.Items)
                                                {
                                                    if (drv["SubjectId"].ToString() == li.Value)
                                                    {
                                                        li.Selected = true;
                                                    }
                                                    //else
                                                    //{
                                                    //    li.Selected = false;
                                                    //}
                                                }
                                            }
                                        }
                                    }
                                    //else
                                    //{
                                    //    chkClass.Checked = false;
                                    //}
                                }
                            }
                        }
                    }
                    btnSMESave.Text = "Update";
                    btnDelete.Visible = true;
                    divError.Attributes.Add("Style", "display:none");
                }
                else
                {
                    row.BackColor = Color.White;
                    row.ForeColor = Color.Black;
                    row.ToolTip = "Click to select this row.";
                }
            }
        }

        protected void rptSME_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                CheckBox chkClass = (CheckBox)e.Item.FindControl("chkClass");
                CheckBoxList chkSubjects = (CheckBoxList)e.Item.FindControl("chkSubjects");
                HiddenField hdnClassId = (HiddenField)e.Item.FindControl("hdnClassId");
                DataTable dtResults = (DataTable)ViewState["Results"];
                var subjects = from DataRow myRow in dtResults.Rows
                               where (int)myRow["ClassId"] == int.Parse(hdnClassId.Value)
                               select myRow;
                if (subjects.Any())
                {
                    DataTable dt = subjects.CopyToDataTable();
                    chkSubjects.DataTextField = "SubjectName";
                    chkSubjects.DataValueField = "SubjectId";
                    chkSubjects.DataSource = dt;
                    chkSubjects.DataBind();
                }
            }
        }

        protected void chkClass_CheckedChanged(object sender, EventArgs e)
        {
            foreach (RepeaterItem item in rptSME.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkClass = (CheckBox)sender;
                    if (chkClass.Checked)
                    {
                        CheckBoxList chkSubjects = (CheckBoxList)chkClass.Parent.FindControl("chkSubjects");
                        chkSubjects.Enabled = true;
                    }
                    else
                    {
                        CheckBoxList chkSubjects = (CheckBoxList)chkClass.Parent.FindControl("chkSubjects");
                        chkSubjects.Enabled = false;
                    }
                }
            }
        }

        //protected void btnViewDetails_Click(object sender, EventArgs e)
        //{
        //    foreach (RepeaterItem items in rptSMEDetails.Items)
        //    {
        //        if (items.ItemType == ListItemType.Item || items.ItemType == ListItemType.AlternatingItem)
        //        {
        //            CheckBox chkClass = items.FindControl("chkClass") as CheckBox;
        //            CheckBoxList chkSubjects = items.FindControl("chkSubjects") as CheckBoxList;
        //            chkClass.Checked = false;
        //            foreach (ListItem li in chkSubjects.Items)
        //            {
        //                li.Selected = false;
        //            }
        //            chkSubjects.Enabled = false;
        //        }
        //    }
        //    Button btnViewDetails = (Button)sender;
        //    string qurClass = dbLibrary.idBuildQuery("proc_getSMEDetails", btnViewDetails.CommandArgument);
        //    DataSet ds = dbLibrary.idGetCustomResult(qurClass);
        //    if (ds.Tables[0].Rows.Count > 0)
        //    {
        //        foreach (RepeaterItem i in rptSMEDetails.Items)
        //        {
        //            if (i.ItemType == ListItemType.Item || i.ItemType == ListItemType.AlternatingItem)
        //            {
        //                CheckBox chkClass = i.FindControl("chkClass") as CheckBox;
        //                CheckBoxList chkSubjects = i.FindControl("chkSubjects") as CheckBoxList;
        //                HiddenField hdnClassId = i.FindControl("hdnClassId") as HiddenField;
        //                foreach (DataRow dr in ds.Tables[0].Rows)
        //                {
        //                    if (dr["ClassId"].ToString() == hdnClassId.Value)
        //                    {
        //                        chkClass.Checked = true;
        //                        chkClass_CheckedChanged(chkClass, EventArgs.Empty);
        //                        if (ds.Tables[1].Rows.Count > 0)
        //                        {

        //                            foreach (DataRow drv in ds.Tables[1].Rows)
        //                            {
        //                                foreach (ListItem li in chkSubjects.Items)
        //                                {
        //                                    if (drv["SubjectId"].ToString() == li.Value)
        //                                    {
        //                                        li.Selected = true;
        //                                    }
        //                                    //else
        //                                    //{
        //                                    //    li.Selected = false;
        //                                    //}
        //                                }
        //                            }
        //                        }
        //                    }
        //                    //else
        //                    //{
        //                    //    chkClass.Checked = false;
        //                    //}
        //                }
        //            }
        //        }
        //    }
        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalDetails();", true);
        //}

        //protected void rptSMEDetails_ItemDataBound(object sender, RepeaterItemEventArgs e)
        //{
        //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        //    {
        //        DataRowView drv = e.Item.DataItem as DataRowView;
        //        CheckBox chkClass = (CheckBox)e.Item.FindControl("chkClass");
        //        CheckBoxList chkSubjects = (CheckBoxList)e.Item.FindControl("chkSubjects");
        //        HiddenField hdnClassId = (HiddenField)e.Item.FindControl("hdnClassId");
        //        DataTable dtResults = (DataTable)ViewState["Results"];
        //        var subjects = from DataRow myRow in dtResults.Rows
        //                       where (int)myRow["ClassId"] == int.Parse(hdnClassId.Value)
        //                       select myRow;
        //        if (subjects.Any())
        //        {
        //            DataTable dt = subjects.CopyToDataTable();
        //            chkSubjects.DataTextField = "SubjectName";
        //            chkSubjects.DataValueField = "SubjectId";
        //            chkSubjects.DataSource = dt;
        //            chkSubjects.DataBind();
        //        }
        //    }
        //}
    }
}