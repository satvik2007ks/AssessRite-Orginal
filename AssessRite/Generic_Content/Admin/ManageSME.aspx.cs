using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace AssessRite.Generic_Content.Admin
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
                LoadSubjectsForAssigning("");
                //  LoadRptClassDetails();
                LoadGrid();
            }
        }

        private void LoadSubjectsForAssigning(string smeid)
        {
            string qur = "SELECT Subject.SubjectId, Subject.SubjectName, Subject.SubLevelId, SubLevel.SubLevel FROM Subject INNER JOIN SubLevel ON Subject.SubLevelId = SubLevel.SubLevelId where Subject.IsDeleted='0' and SubLevel.IsDeleted='0'";
            DataSet ds1 = dbLibrary.idGetDataAsDataset(qur, Session["Connstr"].ToString());
            ViewState["Results"] = ds1.Tables[0];
            qur = "SELECT  C.LevelName, D.CurriculumType, C.LevelId FROM SMESubLevelDetails A  " +
                         " INNER JOIN SubLevel B ON A.SubLevelId = B.SubLevelId " +
                         " INNER JOIN AssessRiteMaster_Dev.dbo.Level C ON C.LevelId = B.LevelId " +
                         " INNER JOIN AssessRiteMaster_Dev.dbo.CurriculumType D ON C.CurriculumTypeId = D.CurriculumTypeId " +
                         " INNER JOIN AssessRiteMaster_Dev.dbo.InstitutionType E ON D.InstitutionTypeId = E.InstitutionTypeId " +
                         " Where A.SMEId='" + smeid + "'" +
                         " Group by  C.LevelName, D.CurriculumType, C.LevelId";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, Session["Connstr"].ToString());
            rptAssignSME.DataSource = ds;
            rptAssignSME.DataBind();
        }

        private void LoadGrid()
        {
            string qur = "SELECT B.SMEId, B.SMEFirstName, B.SMELastName, B.SMEContactNo, B.SMEEmailId, A.UserName, A.Password FROM AssessRiteMaster_Dev.dbo.Login A INNER JOIN SME B ON A.SMEId = B.SMEId where B.IsDeleted='0' and B.AddedByAdminId='" + Session["AdminId"].ToString() + "'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, Session["ConnStr"].ToString());
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
                //  rptSME.DataSource = dt;
                // rptSME.DataBind();
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
                string qur = "SELECT SMEId FROM SME where SMEFirstName='" + txtFirstName.Text.Trim() + "' and SMELastName='" + txtLastName.Text.Trim() + "' and SMEContactNo='" + txtContactNo.Text.Trim() + "' and SMEEmailId='" + txtEmailID.Text.Trim() + "' and IsDeleted='0' and AddedByAdminId='" + Session["AdminId"].ToString() + "'";
                DataSet ds = dbLibrary.idGetDataAsDataset(qur, Session["ConnStr"].ToString());
                if (ds.Tables[0].Rows.Count > 0)
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "SME Data Already Exists";
                    lblError.Focus();
                    return;
                }
                qur = "Select UserId from Login where UserName='" + txtUserName.Text + "'";
                ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "UserName Already Exists";
                    lblError.Focus();
                    txtUserName.Focus();
                    return;
                }
                qur = dbLibrary.idBuildQuery("[proc_AddSME]", "", txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtContactNo.Text.Trim(), txtEmailID.Text.Trim(), txtUserName.Text.Trim(), txtPassword.Text.Trim(), Session["AdminId"].ToString(), Session["DefaultDB"].ToString(), "Insert");
                DataSet DSsmeid = dbLibrary.idGetDataAsDataset(qur, Session["ConnStr"].ToString());
                if (DSsmeid.Tables[0].Rows.Count > 0)
                {
                    Session["SMEID"] = DSsmeid.Tables[0].Rows[0]["id"].ToString();
                }
                // SaveSMEDetails(smeid);
                lblMsg.Text = "SME Added Successfully";
            }
            else
            {
                string qur = "Select UserId from Login where UserName='" + txtUserName.Text + "' and SMEId<>'" + Session["SMEID"].ToString() + "'";
                DataSet ds1 = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "UserName Already Exists";
                    lblError.Focus();
                    txtUserName.Focus();
                    return;
                }
                qur = dbLibrary.idBuildQuery("[proc_AddSME]", Session["SMEId"].ToString(), txtFirstName.Text.Trim(), txtLastName.Text.Trim(), txtContactNo.Text.Trim(), txtEmailID.Text.Trim(), txtUserName.Text.Trim(), txtPassword.Text.Trim(), Session["AdminId"].ToString(), Session["DefaultDB"].ToString(), "Update");
                dbLibrary.idExecuteWithConnectionString(qur, Session["ConnStr"].ToString());
                //  SaveSMEDetails(Session["SMEId"].ToString());
                lblMsg.Text = "SME Details Updated Successfully";
            }
            btnDelete.Visible = false;
            //  Clear();
            //  LoadGrid();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        private void SaveSMEDetails(string smeid)
        {
            //foreach (RepeaterItem i in rptSME.Items)
            //{
            //    if (i.ItemType == ListItemType.Item || i.ItemType == ListItemType.AlternatingItem)
            //    {
            //        CheckBox chkClass = i.FindControl("chkClass") as CheckBox;
            //        HiddenField hdnClassId = i.FindControl("hdnClassId") as HiddenField;
            //        if (chkClass.Checked)
            //        {
            //            string qur = dbLibrary.idBuildQuery("proc_SaveSMEClassDetails", smeid, hdnClassId.Value);
            //            string smeclassid = dbLibrary.idGetAFieldByQuery(qur);
            //            CheckBoxList chkSubjects = i.FindControl("chkSubjects") as CheckBoxList;
            //            DataTable dtSMESubjects = new DataTable();
            //            dtSMESubjects.Columns.Add("SMEClassId");
            //            dtSMESubjects.Columns.Add("SubjectId");
            //            foreach (ListItem li in chkSubjects.Items)
            //            {
            //                if (li.Selected == true)
            //                {
            //                    dtSMESubjects.Rows.Add(smeclassid, li.Value.ToString());
            //                }
            //            }
            //            if (dtSMESubjects.Rows.Count > 0)
            //            {
            //                dbLibrary.idInsertDataTable("proc_SaveSMESubjectDetails", "@SubjectList", dtSMESubjects);
            //            }
            //        }
            //    }
            //}
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
            gridSME.SelectedIndex = -1;
            Session.Remove("SMEID");
            LoadSubjectsForAssigning("");
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
            //Clear();
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
                    //Clear();
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
                    btnSMESave.Text = "Update";
                    btnDelete.Visible = true;
                    divError.Attributes.Add("Style", "display:none");
                    LoadSubjectsForAssigning(gridSME.SelectedDataKey.Value.ToString());
                    CheckAssignedDetails();
                }
                else
                {
                    row.BackColor = Color.White;
                    row.ForeColor = Color.Black;
                    row.ToolTip = "Click to select this row.";
                }
            }

            //            string qurClass = dbLibrary.idBuildQuery("proc_getSMEDetails", gridSME.SelectedDataKey.Value.ToString());
            //            DataSet ds = dbLibrary.idGetCustomResult(qurClass);
            //            if (ds.Tables[0].Rows.Count > 0)
            //            {
            //                foreach (RepeaterItem i in rptSME.Items)
            //                {
            //                    if (i.ItemType == ListItemType.Item || i.ItemType == ListItemType.AlternatingItem)
            //                    {
            //                        CheckBox chkClass = i.FindControl("chkClass") as CheckBox;
            //                        CheckBoxList chkSubjects = i.FindControl("chkSubjects") as CheckBoxList;
            //                        HiddenField hdnClassId = i.FindControl("hdnClassId") as HiddenField;
            //                        foreach (DataRow dr in ds.Tables[0].Rows)
            //                        {
            //                            if (dr["ClassId"].ToString() == hdnClassId.Value)
            //                            {
            //                                chkClass.Checked = true;
            //                                chkClass_CheckedChanged(chkClass, EventArgs.Empty);
            //                                if (ds.Tables[1].Rows.Count > 0)
            //                                {
            //                                    foreach (DataRow drv in ds.Tables[1].Rows)
            //                                    {
            //                                        foreach (ListItem li in chkSubjects.Items)
            //                                        {
            //                                            if (drv["SubjectId"].ToString() == li.Value)
            //                                            {
            //                                                li.Selected = true;
            //                                            }
            //                                            //else
            //                                            //{
            //                                            //    li.Selected = false;
            //                                            //}
            //                                        }
            //                                    }
            //                                }
            //                            }
            //                            //else
            //                            //{
            //                            //    chkClass.Checked = false;
            //                            //}
            //                        }
            //                    }
            //                }
            //            }
            //            btnSMESave.Text = "Update";
            //            btnDelete.Visible = true;
            //            divError.Attributes.Add("Style", "display:none");
            //        }
            //        else
            //        {
            //            row.BackColor = Color.White;
            //            row.ForeColor = Color.Black;
            //            row.ToolTip = "Click to select this row.";
            //        }
            //    }
        }

        protected void rptSME_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                CheckBox chkSubLevel = (CheckBox)e.Item.FindControl("chkSubLevel");
                CheckBoxList chkSubjects = (CheckBoxList)e.Item.FindControl("chkSubjects");
                HiddenField hdnSublevelId = (HiddenField)e.Item.FindControl("hdnSublevelId");
                Button btnUpdateAssign = e.Item.NamingContainer.NamingContainer.FindControl("btnUpdateAssign") as Button;
                DataTable dtResults = (DataTable)ViewState["Results"];
                var subjects = from DataRow myRow in dtResults.Rows
                               where (int)myRow["SubLevelId"] == int.Parse(hdnSublevelId.Value)
                               select myRow;
                if (subjects.Any())
                {
                    DataTable dt = subjects.CopyToDataTable();
                    chkSubjects.DataTextField = "SubjectName";
                    chkSubjects.DataValueField = "SubjectId";
                    chkSubjects.DataSource = dt;
                    chkSubjects.DataBind();
                    btnUpdateAssign.Visible = true;
                }
                else
                {
                    btnUpdateAssign.Visible = false;
                }

            }
        }

        protected void rptAssignSME_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                Repeater rptSME = (Repeater)e.Item.FindControl("rptSME");
                // Button btnUpdateAssign = (Button)e.Item.FindControl("btnUpdateAssign");

                string qur = "SELECT SubLevel.SubLevel, SubLevel.SubLevelId FROM SubLevel Where SubLevelId in (Select SubLevelId from Subject where IsDeleted='0') and SubLevel.LevelId='" + drv["LevelId"].ToString() + "' and  SubLevel.IsDeleted='0'";
                DataSet ds = dbLibrary.idGetDataAsDataset(qur, Session["ConnStr"].ToString());
                if (ds.Tables[0].Rows.Count > 0)
                {
                    //if (Session["SMEID"] != null)
                    //{
                    //    btnUpdateAssign.Visible = true;
                    //}
                    //else
                    //{
                    //    btnUpdateAssign.Visible = false;
                    //}
                    rptSME.DataSource = ds;
                    rptSME.DataBind();

                }
                //else
                //{
                //    btnUpdateAssign.Visible = false;
                //}
            }
            if (e.Item.ItemType == ListItemType.Footer)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                DropDownList ddlCurriculumType = (DropDownList)e.Item.FindControl("ddlCurriculumType");
                string qur = "SELECT A.CurriculumType+' - ('+ B.InstitutionType+ ')' as CurriculumType, A.CurriculumTypeId FROM AssessRiteMaster_Dev.dbo.CurriculumType A INNER JOIN AssessRiteMaster_Dev.dbo.InstitutionType B ON A.InstitutionTypeId = B.InstitutionTypeId RIGHT OUTER JOIN AssessRiteMaster_Dev.dbo.GCAdminAssignedCurriculum C ON A.CurriculumTypeId = C.CurriculumTypeId WHERE (A.IsDeleted = '0') AND (B.IsDeleted = '0') AND (C.AdminId='" + HttpContext.Current.Session["AdminId"].ToString() + "')";
                DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ddlCurriculumType.DataTextField = "CurriculumType";
                    ddlCurriculumType.DataValueField = "CurriculumTypeId";
                    ddlCurriculumType.DataSource = ds;
                    ddlCurriculumType.DataBind();
                    ddlCurriculumType.Items.Insert(0, new ListItem("--Select--", "-1"));
                    ddlCurriculumType.SelectedIndex = 0;
                }
            }
        }

        public void CheckAssignedDetails()
        {
            string qur = "Select SubLevelId, SMESubLevelId from SMESubLevelDetails where SMEId='" + gridSME.SelectedDataKey.Value.ToString() + "'";
            //string qur = "SELECT A.SMESubLevelId, A.SubLevelId " +
            //                " FROM SMESubLevelDetails A INNER JOIN " +
            //                " SubLevel B ON A.SubLevelId = B.SubLevelId INNER JOIN " +
            //                " AssessRiteMaster_Dev.dbo.Level C ON B.LevelId = C.LevelId " +
            //                " Where A.SubLevelId = " + drv["SubLevelId"].ToString() + "";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, Session["ConnStr"].ToString());
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    foreach (RepeaterItem i in rptAssignSME.Items)
                    {
                        if (i.ItemType == ListItemType.AlternatingItem || i.ItemType == ListItemType.Item)
                        {
                            Repeater rptSME = (Repeater)i.FindControl("rptSME");
                            foreach (RepeaterItem item in rptSME.Items)
                            {
                                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                                {
                                    CheckBox chkSubLevel = (CheckBox)item.FindControl("chkSubLevel");
                                    HiddenField hdnSubLevelId = (HiddenField)item.FindControl("hdnSubLevelId");
                                    CheckBoxList chkSubjects = (CheckBoxList)item.FindControl("chkSubjects");
                                    if (hdnSubLevelId.Value == dr["SubLevelId"].ToString())
                                    {
                                        chkSubLevel.Checked = true;
                                        chkSubjects.Enabled = true;
                                        qur = "Select SubjectId from SMESubjectDetails where SMESubLevelId='" + dr["SMESubLevelId"].ToString() + "'";
                                        DataSet ds1 = dbLibrary.idGetDataAsDataset(qur, Session["ConnStr"].ToString());
                                        if (ds1.Tables[0].Rows.Count > 0)
                                        {
                                            foreach (DataRow d in ds1.Tables[0].Rows)
                                            {
                                                foreach (ListItem li in chkSubjects.Items)
                                                {
                                                    if (li.Value == d["SubjectId"].ToString())
                                                    {
                                                        li.Selected = true;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }

                //if (drv["SubLevelId"].ToString() == dr["SubLevelId"].ToString())
                //{
                //    chkSubLevel.Checked = true;
                //    chkSubLevel_CheckedChanged1(chkSubLevel, EventArgs.Empty);

                //}
            }
        }

        protected void ddlCurriculumType_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList curriculumtype = (DropDownList)sender;
            DropDownList ddlLevel = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("ddlLevel") as DropDownList;
            string qur = "SELECT  LevelName, LevelId from Level where CurriculumTypeId='" + curriculumtype.SelectedValue + "' and  IsDeleted='0'";
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, dbLibrary.MasterconStr);
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlLevel.DataTextField = "LevelName";
                ddlLevel.DataValueField = "LevelId";
                ddlLevel.DataSource = ds;
                ddlLevel.DataBind();
                ddlLevel.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlLevel.SelectedIndex = 0;
            }
            else
            {
                ddlLevel.Items.Clear();
            }
            ddlLevel_SelectedIndexChanged(ddlLevel, EventArgs.Empty);
        }

        protected void ddlLevel_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddlLevel = (DropDownList)sender;
            Repeater rptFooter = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("rptFooter") as Repeater;
            Button btnAssign = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("btnAssign") as Button;
            HtmlGenericControl divSelectHeader = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("divSelectHeader") as HtmlGenericControl;
            HtmlGenericControl divAssignError = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("divAssignError") as HtmlGenericControl;
            Label lblErr = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("lblErr") as Label;
            string qur = "";
            if (gridSME.SelectedDataKey != null)
            {
                qur = "SELECT SubLevel.SubLevel, SubLevel.SubLevelId FROM SubLevel Where SubLevelId in (Select SubLevelId from Subject where IsDeleted='0') and SubLevel.LevelId='" + ddlLevel.SelectedValue + "' and  SubLevel.IsDeleted='0' and SubLevelId not in (Select SubLevelId from SMESubLevelDetails where SMEID='" + gridSME.SelectedDataKey.Value.ToString() + "')";
            }
            else
            {
                qur = "SELECT SubLevel.SubLevel, SubLevel.SubLevelId FROM SubLevel Where SubLevelId in (Select SubLevelId from Subject where IsDeleted='0') and SubLevel.LevelId='" + ddlLevel.SelectedValue + "' and  SubLevel.IsDeleted='0'";
            }
            DataSet ds = dbLibrary.idGetDataAsDataset(qur, Session["ConnStr"].ToString());
            if (ds.Tables[0].Rows.Count > 0)
            {
                divAssignError.Attributes.Add("style", "display:none");
                divSelectHeader.Attributes.Add("style", "display:flex");
                //if (Session["SMEID"] != null)
                //{
                btnAssign.Visible = true;
                //}
                //else
                //{
                //    btnAssign.Visible = false;
                //}
                rptFooter.DataSource = ds;
                rptFooter.DataBind();
            }
            else
            {
                rptFooter.DataSource = ds;
                rptFooter.DataBind();
                lblErr.Text = "No Sub-Level Found";
                divAssignError.Attributes.Add("style", "display:block");
                divSelectHeader.Attributes.Add("style", "display:none");
                btnAssign.Visible = false;
                return;
            }
        }

        protected void rptFooter_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataRowView drv = e.Item.DataItem as DataRowView;
                CheckBox chkSubLevel = (CheckBox)e.Item.FindControl("chkSubLevel");
                CheckBoxList chkSubjects = (CheckBoxList)e.Item.FindControl("chkSubjects");
                HiddenField hdnSublevelId = (HiddenField)e.Item.FindControl("hdnSublevelId");
                DataTable dtResults = (DataTable)ViewState["Results"];
                var subjects = from DataRow myRow in dtResults.Rows
                               where (int)myRow["SubLevelId"] == int.Parse(hdnSublevelId.Value)
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

        protected void chkSubLevel_CheckedChanged(object sender, EventArgs e)
        {
            Repeater rptFooter = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("rptFooter") as Repeater;
            foreach (RepeaterItem item in rptFooter.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkSubLevel = (CheckBox)sender;
                    if (chkSubLevel.Checked)
                    {
                        CheckBoxList chkSubjects = (CheckBoxList)chkSubLevel.Parent.FindControl("chkSubjects");
                        chkSubjects.Enabled = true;
                    }
                    else
                    {
                        CheckBoxList chkSubjects = (CheckBoxList)chkSubLevel.Parent.FindControl("chkSubjects");
                        foreach (ListItem li in chkSubjects.Items)
                        {
                            li.Selected = false;
                        }
                        chkSubjects.Enabled = false;
                    }
                }
            }
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            HtmlGenericControl divAssignError = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("divAssignError") as HtmlGenericControl;
            Label lblErr = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("lblErr") as Label;
            if (Session["SMEID"] == null || gridSME.SelectedDataKey == null)
            {
                lblErr.Text = "Please Add SME Before Assigning";
                divAssignError.Attributes.Add("style", "display:block");
                return;
            }
            else
            {
                divAssignError.Attributes.Add("style", "display:none");
            }
            if (gridSME.SelectedDataKey != null)
            {
                Session["SMEID"] = gridSME.SelectedDataKey.Value.ToString();
            }
            bool insert = false;
            Repeater rptFooter = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("rptFooter") as Repeater;
            int countClass = 0;
            foreach (RepeaterItem i in rptFooter.Items)
            {
                if (i.ItemType == ListItemType.Item || i.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkSubLevel = i.FindControl("chkSubLevel") as CheckBox;
                    CheckBoxList chkSubjects = i.FindControl("chkSubjects") as CheckBoxList;
                    if (chkSubLevel.Checked == true)
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
                            lblError.Text = "Please Select Subjects For Class " + chkSubLevel.Text;
                            divError.Attributes.Add("style", "display:block");
                            return;
                        }
                        countClass++;
                    }
                }
            }
            if (countClass == 0)
            {
                lblError.Text = "Please Select Sub-Level For SME";
                divError.Attributes.Add("style", "display:block");
                return;
            }

            foreach (RepeaterItem i in rptFooter.Items)
            {
                if (i.ItemType == ListItemType.Item || i.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkSubLevel = i.FindControl("chkSubLevel") as CheckBox;
                    HiddenField hdnSubLevelId = i.FindControl("hdnSublevelId") as HiddenField;
                    if (chkSubLevel.Checked)
                    {
                        string qur = dbLibrary.idBuildQuery("proc_SaveSMESubLevelDetails", Session["SMEID"].ToString(), hdnSubLevelId.Value);
                        DataSet ds = dbLibrary.idGetDataAsDataset(qur, Session["ConnStr"].ToString());
                        insert = true;
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            string smesublevelid = ds.Tables[0].Rows[0]["id"].ToString();
                            CheckBoxList chkSubjects = i.FindControl("chkSubjects") as CheckBoxList;
                            DataTable dtSMESubjects = new DataTable();
                            dtSMESubjects.Columns.Add("SMESubLevelId");
                            dtSMESubjects.Columns.Add("SubjectId");
                            foreach (ListItem li in chkSubjects.Items)
                            {
                                if (li.Selected == true)
                                {
                                    dtSMESubjects.Rows.Add(smesublevelid, li.Value.ToString());
                                }
                            }
                            if (dtSMESubjects.Rows.Count > 0)
                            {
                                insert = true;
                                dbLibrary.idInsertDataTableWithConnectionString("proc_SaveSMESubjectDetails", "@SubjectList", dtSMESubjects, Session["ConnStr"].ToString());
                            }
                        }
                    }
                }
            }
            if (insert)
            {
                LoadSubjectsForAssigning(Session["SMEID"].ToString());
                CheckAssignedDetails();
            }
        }

        public void ClearExpertise()
        {
            divError.Attributes.Add("Style", "display:none");
            Repeater rptFooter = rptAssignSME.Controls[rptAssignSME.Controls.Count - 1].Controls[0].FindControl("rptFooter") as Repeater;
            foreach (RepeaterItem items in rptFooter.Items)
            {
                if (items.ItemType == ListItemType.Item || items.ItemType == ListItemType.AlternatingItem)
                {
                    CheckBox chkSubLevel = items.FindControl("chkSubLevel") as CheckBox;
                    CheckBoxList chkSubjects = items.FindControl("chkSubjects") as CheckBoxList;
                    chkSubLevel.Checked = false;
                    foreach (ListItem li in chkSubjects.Items)
                    {
                        li.Selected = false;
                    }
                    chkSubjects.Enabled = false;
                }
            }
        }

        protected void btnUpdateAssign_Click(object sender, EventArgs e)
        {
            int countClass = 0;
            foreach (RepeaterItem item in rptAssignSME.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    Repeater rptSME = (Repeater)item.FindControl("rptSME");
                    if (rptSME != null)
                    {
                        foreach (RepeaterItem i in rptSME.Items)
                        {
                            if (i.ItemType == ListItemType.Item || i.ItemType == ListItemType.AlternatingItem)
                            {
                                CheckBox chkSubLevel = i.FindControl("chkSubLevel") as CheckBox;
                                CheckBoxList chkSubjects = i.FindControl("chkSubjects") as CheckBoxList;
                                if (chkSubLevel.Checked == true)
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
                                        lblError.Text = "Please Select Subjects For Class " + chkSubLevel.Text;
                                        divError.Attributes.Add("style", "display:block");
                                        return;
                                    }
                                    countClass++;
                                }
                            }
                        }
                    }
                }
            }
            if (countClass == 0)
            {
                lblError.Text = "Please Select Sub-Level For SME";
                divError.Attributes.Add("style", "display:block");
                return;
            }
            string qry = dbLibrary.idBuildQuery("[proc_DeleteSMEAssignedDetails]", gridSME.SelectedDataKey.Value.ToString());
            dbLibrary.idExecuteWithConnectionString(qry, Session["ConnStr"].ToString());
            foreach (RepeaterItem item in rptAssignSME.Items)
            {
                if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                {
                    Repeater rptSME = (Repeater)item.FindControl("rptSME");
                    if (rptSME != null)
                    {
                        foreach (RepeaterItem i in rptSME.Items)
                        {
                            if (i.ItemType == ListItemType.Item || i.ItemType == ListItemType.AlternatingItem)
                            {
                                CheckBox chkSubLevel = i.FindControl("chkSubLevel") as CheckBox;
                                HiddenField hdnSubLevelId = i.FindControl("hdnSublevelId") as HiddenField;
                                if (chkSubLevel.Checked)
                                {
                                    string qur = dbLibrary.idBuildQuery("proc_SaveSMESubLevelDetails", gridSME.SelectedDataKey.Value.ToString(), hdnSubLevelId.Value);
                                    DataSet ds = dbLibrary.idGetDataAsDataset(qur, Session["ConnStr"].ToString());
                                    if (ds.Tables[0].Rows.Count > 0)
                                    {
                                        string smesublevelid = ds.Tables[0].Rows[0]["id"].ToString();
                                        CheckBoxList chkSubjects = i.FindControl("chkSubjects") as CheckBoxList;
                                        DataTable dtSMESubjects = new DataTable();
                                        dtSMESubjects.Columns.Add("SMESubLevelId");
                                        dtSMESubjects.Columns.Add("SubjectId");
                                        foreach (ListItem li in chkSubjects.Items)
                                        {
                                            if (li.Selected == true)
                                            {
                                                dtSMESubjects.Rows.Add(smesublevelid, li.Value.ToString());
                                            }
                                        }
                                        if (dtSMESubjects.Rows.Count > 0)
                                        {
                                            dbLibrary.idInsertDataTableWithConnectionString("proc_SaveSMESubjectDetails", "@SubjectList", dtSMESubjects, Session["ConnStr"].ToString());
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        protected void chkSubLevel_CheckedChanged1(object sender, EventArgs e)
        {
            foreach (RepeaterItem i in rptAssignSME.Items)
            {
                if (i.ItemType == ListItemType.AlternatingItem || i.ItemType == ListItemType.Item)
                {
                    Repeater rptSME = (Repeater)i.FindControl("rptSME");
                    foreach (RepeaterItem item in rptSME.Items)
                    {
                        if (item.ItemType == ListItemType.Item || item.ItemType == ListItemType.AlternatingItem)
                        {
                            CheckBox chkSubLevel = (CheckBox)sender;
                            if (chkSubLevel.Checked)
                            {
                                CheckBoxList chkSubjects = (CheckBoxList)chkSubLevel.Parent.FindControl("chkSubjects");
                                chkSubjects.Enabled = true;
                            }
                            else
                            {
                                CheckBoxList chkSubjects = (CheckBoxList)chkSubLevel.Parent.FindControl("chkSubjects");
                                foreach (ListItem li in chkSubjects.Items)
                                {
                                    li.Selected = false;
                                }
                                chkSubjects.Enabled = false;

                            }
                        }
                    }
                }
            }
        }
    }
}