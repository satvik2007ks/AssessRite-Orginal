using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite
{
    public partial class Subject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                loadDropDown();
               // loadGrid();
            }
        }

        //private void loadGrid()
        //{
        //    string qur = "SELECT Subject.SubjectId, Subject.ClassId, Subject.SubjectName,Subject.IsOtherLanguage, Class.ClassName FROM Class RIGHT OUTER JOIN Subject ON Class.ClassId = Subject.ClassId where Subject.IsDeleted='0' and Class.IsDeleted='0' ORDER BY Class.MasterClassId";
        //    if (dbLibrary.idHasRows(qur))
        //    {
        //        DataSet ds = dbLibrary.idGetCustomResult(qur);
        //        gridSubject.DataSource = ds;
        //        gridSubject.DataBind();
        //    }
        //}

        private void loadDropDown()
        {
            string qur = "Select * from Class where IsDeleted='0' and SchoolId='"+Session["InstitutionId"].ToString()+"' ORDER BY MasterClassId";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlClassName.DataTextField = "ClassName";
                ddlClassName.DataValueField = "ClassId";
                ddlClassName.DataSource = ds;
                ddlClassName.DataBind();
                ddlClassName.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlClassName.SelectedIndex = 0;
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            txtSubject.Text = "";
            ddlClassName.SelectedIndex = 0;
          //  gridSubject.SelectedIndex = -1;
            chkLanguage.Checked = false;
           // gridSubject_SelectedIndexChanged(sender, EventArgs.Empty);
            divError.Attributes.Add("Style", "display:none");
            btnSubjectSave.Text = "Save";
            btnDelete.Visible = false;
            chkLanguage.Checked = false;
        }

        //protected void gridSubject_RowDataBound(object sender, GridViewRowEventArgs e)
        //{
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
        //        e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
        //        e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gridSubject, "Select$" + e.Row.RowIndex);
        //        e.Row.ToolTip = "Click to select this row.";
        //    }
        //}

        //protected void gridSubject_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    foreach (GridViewRow row in gridSubject.Rows)
        //    {
        //        if (row.RowIndex == gridSubject.SelectedIndex)
        //        {
        //            row.BackColor = ColorTranslator.FromHtml("#F1F1F1");
        //            row.ForeColor = Color.Black;
        //            row.ToolTip = string.Empty;
        //            string text = gridSubject.SelectedRow.Cells[1].Text;
        //            string value = gridSubject.SelectedDataKey.Value.ToString();
        //            txtSubject.Text = text;
        //            ddlClassName.SelectedValue = gridSubject.SelectedRow.Cells[3].Text;
        //            if (gridSubject.SelectedRow.Cells[4].Text == "False")
        //            {
        //                chkLanguage.Checked = false;
        //            }
        //            else
        //            {
        //                chkLanguage.Checked = true;
        //            }
        //            btnSubjectSave.CommandArgument = value;
        //            btnSubjectSave.Text = "Update";
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
        //}

        protected void btnSubjectSave_Click(object sender, EventArgs e)
        {
            if (ddlClassName.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Select Class";
                return;
            }
            if (txtSubject.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Enter Subject";
                return;
            }
            else
            {
                divError.Attributes.Add("Style", "display:none");
            }

            string qur = "Select SubjectId from Subject where SubjectName='" + txtSubject.Text + "' and ClassId='" + ddlClassName.SelectedValue + "' and IsDeleted='0'";
            if (dbLibrary.idHasRows(qur))
            {
                int subjectId = int.Parse(dbLibrary.idGetAFieldByQuery(qur));
                if (btnSubjectSave.Text == "Save")
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "Subject Already Found*";
                    return;
                }
                else
                {
                    if (subjectId == int.Parse(btnSubjectSave.CommandArgument))
                    {
                        if (chkLanguage.Checked)
                        {
                            string SubjectName = Regex.Replace(txtSubject.Text, "<[^>]*>", string.Empty);
                            qur = "update Subject set SubjectName=N" + "'" + SubjectName + "', ClassId='" + ddlClassName.SelectedValue + "', IsOtherLanguage='" + chkLanguage.Checked.ToString() + "' where SubjectId='" + btnSubjectSave.CommandArgument + "'";
                            dbLibrary.idExecute(qur);
                        }
                        else
                        {
                            dbLibrary.idUpdateTable("Subject",
                        "SubjectId=" + btnSubjectSave.CommandArgument,
                        "ClassId", ddlClassName.SelectedValue,
                        "IsOtherLanguage", chkLanguage.Checked.ToString(),
                        "SubjectName", txtSubject.Text);
                        }

                        lblMsg.Text = "Subject Updated Successfully";
                    }
                    else
                    {
                        divError.Attributes.Add("Style", "display:block");
                        lblError.Text = "Subject Already Found*";
                        return;
                    }
                }
            }
            else
            {
                if (btnSubjectSave.Text == "Save")
                {
                    if (chkLanguage.Checked)
                    {
                        string SubjectName = Regex.Replace(txtSubject.Text, "<[^>]*>", string.Empty);
                        string qursub = "Insert Into Subject values('" + ddlClassName.SelectedValue + "',N" + "'" + SubjectName + "','" + chkLanguage.Checked.ToString() + "','0')";
                        dbLibrary.idExecute(qursub);
                    }
                    else
                    {
                        dbLibrary.idInsertInto("Subject",
                        "ClassId", ddlClassName.SelectedValue,
                        "SubjectName", txtSubject.Text,
                        "IsOtherLanguage", chkLanguage.Checked.ToString());
                    }

                    lblMsg.Text = "Subject Saved Successfully";

                }
                else
                {
                    if (chkLanguage.Checked)
                    {
                        string SubjectName = Regex.Replace(txtSubject.Text, "<[^>]*>", string.Empty);
                        qur = "update Subject set SubjectName=N" + "'" + SubjectName + "', ClassId='" + ddlClassName.SelectedValue + "', IsOtherLanguage='" + chkLanguage.Checked.ToString() + "' where SubjectId='" + btnSubjectSave.CommandArgument + "'";
                        dbLibrary.idExecute(qur);
                    }
                    else
                    {
                        dbLibrary.idUpdateTable("Subject",
                       "SubjectId=" + btnSubjectSave.CommandArgument,
                       "ClassId", ddlClassName.SelectedValue,
                        "IsOtherLanguage", chkLanguage.Checked.ToString(),
                       "SubjectName", txtSubject.Text);
                    }

                    lblMsg.Text = "Subject Updated Successfully";

                }
            }
          //  loadGrid();
            txtSubject.Text = "";
            btnSubjectSave.Text = "Save";
            ddlClassName.SelectedIndex = 0;
            chkLanguage.Checked = false;
            btnDelete.Visible = false;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }



        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);

        }

        //protected void btnYes_Click(object sender, EventArgs e)
        //{
        //    dbLibrary.idUpdateTable("Subject",
        //     "SubjectId='" + gridSubject.SelectedDataKey.Value + "'",
        //     "IsDeleted", "1");
        //    //string qur = "Delete from Subject where SubjectId=" + gridSubject.SelectedDataKey.Value;
        //    //dbLibrary.idExecute(qur);
        //    loadGrid();
        //    btnDelete.Visible = false;
        //    btnNew_Click(sender, EventArgs.Empty);
        //    lblMsg.Text = "Subject Deleted Successfully";
        //    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);

        //}

        [System.Web.Services.WebMethod]
        public static string SendParameters(int subjectid, string subject, int classid, string buttontext, string isotherlanguage)
        {
            //  return string.Format("subjectId: {0}{2}subject: {1}{2}classid: {3}{2}OtherLanguage: {4}", subjectid, subject, Environment.NewLine,classid,isotherlanguage);

            string qur = "Select SubjectId from Subject where SubjectName='" + subject + "' and ClassId='" + classid + "' and IsDeleted='0'";
            if (dbLibrary.idHasRows(qur))
            {
                int subjectId = int.Parse(dbLibrary.idGetAFieldByQuery(qur));
                if (buttontext == "Save")
                {
                    return "Subject Already Found";
                }
                else
                {
                    if (subjectId == subjectid)
                    {
                        if (isotherlanguage == "1")
                        {
                            string SubjectName = Regex.Replace(subject, "<[^>]*>", string.Empty);
                            qur = "update Subject set SubjectName=N" + "'" + SubjectName + "', ClassId='" + classid + "', IsOtherLanguage='" + isotherlanguage + "' where SubjectId='" + subjectid + "'";
                            dbLibrary.idExecute(qur);
                        }
                        else
                        {
                            dbLibrary.idUpdateTable("Subject",
                        "SubjectId=" + subjectid,
                        "ClassId", classid.ToString(),
                        "IsOtherLanguage", isotherlanguage,
                        "SubjectName", subject);
                        }

                        return "Subject Updated Successfully";
                    }
                    else
                    {

                        return "Subject Already Found";
                    }
                }
            }
            else
            {
                if (buttontext == "Save")
                {
                    if (isotherlanguage == "1")
                    {
                        string SubjectName = Regex.Replace(subject, "<[^>]*>", string.Empty);
                        string qursub = "Insert Into Subject values('" + classid + "',N" + "'" + SubjectName + "','" + isotherlanguage + "','0')";
                        dbLibrary.idExecute(qursub);
                    }
                    else
                    {
                        dbLibrary.idInsertInto("Subject",
                        "ClassId", classid.ToString(),
                        "SubjectName", subject,
                        "IsOtherLanguage", isotherlanguage);
                    }
                    return "Subject Saved Successfully";
                }
                else
                {
                    if (isotherlanguage == "1")
                    {
                        string SubjectName = Regex.Replace(subject, "<[^>]*>", string.Empty);
                        qur = "update Subject set SubjectName=N" + "'" + SubjectName + "', ClassId='" + classid + "', IsOtherLanguage='" + isotherlanguage + "' where SubjectId='" + subjectid + "'";
                        dbLibrary.idExecute(qur);
                    }
                    else
                    {
                        dbLibrary.idUpdateTable("Subject",
                       "SubjectId=" + subjectid,
                       "ClassId", classid.ToString(),
                        "IsOtherLanguage", isotherlanguage,
                       "SubjectName", subject);
                    }

                    return "Subject Updated Successfully";

                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteSubject(int subjectid)
        {
            dbLibrary.idUpdateTable("Subject",
           "SubjectId='" + subjectid + "'",
           "IsDeleted", "1");
            return "Subject Deleted Successfully";
        }
    }
}