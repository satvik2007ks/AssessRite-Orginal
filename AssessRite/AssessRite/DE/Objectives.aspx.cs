using AssessRite;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite.DE
{
    public partial class Objectives : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
            {
                // loadDropDown();
                // loadGrid();
            }
        }

        private void loadGrid()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getObjectives]");
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            //            string qur = "SELECT  Objectives.ObjectiveId, Objectives.SubjectId, Objectives.ConceptId, Objectives.ObjectiveName, Class.ClassName, Subject.SubjectName, Concept.ConceptName, Class.ClassId " +
            //" FROM Class RIGHT OUTER JOIN Subject ON Class.ClassId = Subject.ClassId RIGHT OUTER JOIN Objectives ON Subject.SubjectId = Objectives.SubjectId LEFT OUTER JOIN Concept ON Objectives.ConceptId = Concept.ConceptId where Objectives.IsDeleted='0' and Class.IsDeleted='0' and Subject.IsDeleted='0' and Concept.IsDeleted='0' ORDER BY CAST(Class.ClassName AS Numeric(10,0)) ASC";
            //            if (dbLibrary.idHasRows(qur))
            {
                // DataSet ds = dbLibrary.idGetCustomResult(qur);
                gridObjective.DataSource = ds;
                gridObjective.DataBind();
            }
        }

        private void loadDropDown()
        {
            string qur1 = dbLibrary.idBuildQuery("[proc_getDataForObjective]");
            DataSet ds = dbLibrary.idGetCustomResult(qur1);
            ViewState["Data"] = ds;
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlClassName.DataTextField = "ClassName";
                ddlClassName.DataValueField = "ClassId";
                ddlClassName.DataSource = ds.Tables[0];
                ddlClassName.DataBind();
                ddlClassName.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlClassName.SelectedIndex = 0;
            }
            //string qur = "Select * from Class where IsDeleted='0' ORDER BY CAST(ClassName AS Numeric(10,0)) ASC";
            //if (dbLibrary.idHasRows(qur))
            //{
            //    DataSet ds = dbLibrary.idGetCustomResult(qur);
            //    ddlClassName.DataTextField = "ClassName";
            //    ddlClassName.DataValueField = "ClassId";
            //    ddlClassName.DataSource = ds;
            //    ddlClassName.DataBind();
            //    ddlClassName.Items.Insert(0, new ListItem("--Select--", "-1"));
            //    ddlClassName.SelectedIndex = 0;
            //}
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            ddlClassName.SelectedIndex = 0;
            ddlSubject.Items.Clear();
            ddlConcepts.Items.Clear();
            txtObjectives.Text = "";
            gridObjective.SelectedIndex = -1;
            btnObjectivesSave.Text = "Save";
            gridObjective_SelectedIndexChanged(sender, EventArgs.Empty);
            divError.Attributes.Add("Style", "display:none");
            btnDelete.Visible = false;
        }

        protected void ddlClassName_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataSet ds = (DataSet)ViewState["Data"];
            DataTable dt = ds.Tables[1];
            if (dt.Rows.Count > 0)
            {
                var results = (from myRow in dt.AsEnumerable()
                               where (int)myRow["ClassId"] == int.Parse(ddlClassName.SelectedValue)
                               select myRow).CopyToDataTable();
                DataTable dtTemp = (DataTable)results;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectId";
                ddlSubject.DataSource = dtTemp;
                ddlSubject.DataBind();
                ddlSubject.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlSubject.SelectedIndex = 0;
            }
            else
            {
                ddlSubject.Items.Clear();
            }

            //string qur = "Select * from Subject where IsDeleted='0' and ClassId=" + ddlClassName.SelectedValue;
            //if (dbLibrary.idHasRows(qur))
            //{
            //    DataSet ds = dbLibrary.idGetCustomResult(qur);
            //    ddlSubject.DataTextField = "SubjectName";
            //    ddlSubject.DataValueField = "SubjectId";
            //    ddlSubject.DataSource = ds;
            //    ddlSubject.DataBind();
            //    ddlSubject.Items.Insert(0, new ListItem("--Select--", "-1"));
            //    ddlSubject.SelectedIndex = 0;
            //}
            //else
            //{
            //    ddlSubject.Items.Clear();
            //}
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataSet ds = (DataSet)ViewState["Data"];
            DataTable dt = ds.Tables[2];
            if (dt.Rows.Count > 0)
            {
                var results = (from myRow in dt.AsEnumerable()
                               where (int)myRow["ClassId"] == int.Parse(ddlClassName.SelectedValue) && (int)myRow["SubjectId"] == int.Parse(ddlSubject.SelectedValue)
                               select myRow).CopyToDataTable();
                DataTable dtTemp = (DataTable)results;
                ddlConcepts.DataTextField = "ConceptName";
                ddlConcepts.DataValueField = "ConceptId";
                ddlConcepts.DataSource = dtTemp;
                ddlConcepts.DataBind();
                ddlConcepts.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlConcepts.SelectedIndex = 0;
            }
            else
            {
                ddlConcepts.Items.Clear();
            }
            //string qur = "Select * from Concept where IsDeleted='0' and ClassId=" + ddlClassName.SelectedValue + " and SubjectId=" + ddlSubject.SelectedValue;
            //if (dbLibrary.idHasRows(qur))
            //{
            //    DataSet ds = dbLibrary.idGetCustomResult(qur);
            //    ddlConcepts.DataTextField = "ConceptName";
            //    ddlConcepts.DataValueField = "ConceptId";
            //    ddlConcepts.DataSource = ds;
            //    ddlConcepts.DataBind();
            //    ddlConcepts.Items.Insert(0, new ListItem("--Select--", "-1"));
            //    ddlConcepts.SelectedIndex = 0;
            //}

        }

        protected void gridObjective_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
                e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gridObjective, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void gridObjective_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gridObjective.Rows)
            {
                if (row.RowIndex == gridObjective.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#6192d3");
                    row.ForeColor = Color.White;
                    row.ToolTip = string.Empty;
                    string text = gridObjective.SelectedRow.Cells[3].Text;
                    string value = gridObjective.SelectedDataKey.Value.ToString();
                    txtObjectives.Text = text;
                    ddlClassName.SelectedValue = gridObjective.SelectedRow.Cells[4].Text;
                    ddlClassName_SelectedIndexChanged(ddlClassName, EventArgs.Empty);
                    ddlSubject.SelectedValue = gridObjective.SelectedRow.Cells[5].Text;
                    ddlSubject_SelectedIndexChanged(ddlClassName, EventArgs.Empty);
                    ddlConcepts.SelectedValue = gridObjective.SelectedRow.Cells[6].Text;
                    btnObjectivesSave.CommandArgument = value;
                    btnObjectivesSave.Text = "Update";
                    btnDelete.Visible = true;
                }
                else
                {
                    row.BackColor = ColorTranslator.FromHtml("#F1F1F1");
                    row.ForeColor = ColorTranslator.FromHtml("#8f9b86");
                    row.ToolTip = "Click to select this row.";
                }
            }
        }

        protected void btnObjectivesSave_Click(object sender, EventArgs e)
        {
            if (ddlClassName.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Select Class*";
                return;
            }
            if (ddlSubject.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Select Subject*";
                return;
            }
            if (ddlConcepts.SelectedIndex == 0)
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Select Concept*";
                return;
            }
            if (txtObjectives.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Objective Required*";
                return;
            }
            else
            {
                divError.Attributes.Add("Style", "display:none");
            }

            string qur = "Select ObjectiveId from Objectives where ObjectiveName='" + txtObjectives.Text + "' and SubjectId='" + ddlSubject.SelectedValue + "' and ConceptId='" + ddlConcepts.SelectedValue + "' and IsDeleted='0'";
            if (dbLibrary.idHasRows(qur))
            {
                int ObjectiveId = int.Parse(dbLibrary.idGetAFieldByQuery(qur));
                if (btnObjectivesSave.Text == "Save")
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "Objective Already Found*";
                    return;
                }
                else
                {
                    if (ObjectiveId == int.Parse(btnObjectivesSave.CommandArgument))
                    {
                        if (IsOtherLanguage(ddlSubject.SelectedValue))
                        {
                            string objective = Regex.Replace(txtObjectives.Text, "<[^>]*>", string.Empty);
                            qur = "update Objectives set ObjectiveName=N" + "'" + objective + "', SubjectId='" + ddlSubject.SelectedValue + "', ConceptId='" + ddlConcepts.SelectedValue + "' where ObjectiveId='" + btnObjectivesSave.CommandArgument + "'";
                            dbLibrary.idExecute(qur);
                        }
                        else
                        {
                            dbLibrary.idUpdateTable("Objectives",
                        "ObjectiveId=" + btnObjectivesSave.CommandArgument,
                        "SubjectId", ddlSubject.SelectedValue,
                         "ConceptId", ddlConcepts.SelectedValue,
                        "ObjectiveName", txtObjectives.Text);
                            lblMsg.Text = "Objective Updated Successfully";
                        }
                    }
                    else
                    {
                        divError.Attributes.Add("Style", "display:block");
                        lblError.Text = "Objective Already Found*";
                        return;
                    }
                }
            }
            else
            {
                if (btnObjectivesSave.Text == "Save")
                {
                    if (IsOtherLanguage(ddlSubject.SelectedValue))
                    {
                        string objective = Regex.Replace(txtObjectives.Text, "<[^>]*>", string.Empty);
                        string qurconc = "Insert Into Objectives values('" + ddlSubject.SelectedValue + "','" + ddlConcepts.SelectedValue + "',N" + "'" + objective + "','0')";
                        dbLibrary.idExecute(qurconc);
                    }
                    else
                    {
                        dbLibrary.idInsertInto("Objectives",
                  "SubjectId", ddlSubject.SelectedValue,
                  "ConceptId", ddlConcepts.SelectedValue,
                  "ObjectiveName", txtObjectives.Text);
                    }
                    lblMsg.Text = "Objective Saved Successfully";
                }
                else
                {
                    if (IsOtherLanguage(ddlSubject.SelectedValue))
                    {
                        string objective = Regex.Replace(txtObjectives.Text, "<[^>]*>", string.Empty);
                        qur = "update Objectives set ObjectiveName=N" + "'" + objective + "', SubjectId='" + ddlSubject.SelectedValue + "', ConceptId='" + ddlConcepts.SelectedValue + "' where ObjectiveId='" + btnObjectivesSave.CommandArgument + "'";
                        dbLibrary.idExecute(qur);
                    }
                    else
                    {
                        dbLibrary.idUpdateTable("Objectives",
                      "ObjectiveId=" + btnObjectivesSave.CommandArgument,
                      "SubjectId", ddlSubject.SelectedValue,
                       "ConceptId", ddlConcepts.SelectedValue,
                      "ObjectiveName", txtObjectives.Text);
                    }

                    lblMsg.Text = "Objective Updated Successfully";

                }
            }

            loadGrid();
            txtObjectives.Text = "";
            btnObjectivesSave.Text = "Save";
            ddlClassName.SelectedIndex = 0;
            ddlSubject.Items.Clear();
            ddlConcepts.Items.Clear();
            btnDelete.Visible = false;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        private bool IsOtherLanguage(string subjectId)
        {
            string qur = "Select IsOtherLanguage from Subject where SubjectId='" + subjectId + "'";
            bool IsOtherLanguage = bool.Parse(dbLibrary.idGetAFieldByQuery(qur));
            if (IsOtherLanguage)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            dbLibrary.idUpdateTable("Objectives",
            "ObjectiveId='" + gridObjective.SelectedDataKey.Value + "'",
            "IsDeleted", "1");
            //string qur = "Delete from Objectives where ObjectiveId=" + gridObjective.SelectedDataKey.Value;
            //dbLibrary.idExecute(qur);
            loadGrid();
            btnDelete.Visible = false;
            btnNew_Click(sender, EventArgs.Empty);
            lblMsg.Text = "Objective Deleted Successfully";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        [System.Web.Services.WebMethod]
        public static string SendParameters(int classid, int subjectid, int conceptid, string objective, string buttontext, int objectiveid)
        {
            string objec = "";
            if (objective.Contains('\''))
            {
                objec = objective.Replace("'", "''''");
            }
            if (objec == "")
            {
                objec = objective;
            }
            string qur = "Select ObjectiveId from Objectives where ObjectiveName='" + objec + "' and SubjectId='" + subjectid + "' and ConceptId='" + conceptid + "' and IsDeleted='0'";
            if (dbLibrary.idHasRows(qur))
            {
                int ObjectiveId = int.Parse(dbLibrary.idGetAFieldByQuery(qur));
                if (buttontext == "Save")
                {
                    return "Objective Already Found";
                }
                else
                {
                    if (ObjectiveId == objectiveid)
                    {
                        string qur2 = "Select IsOtherLanguage from Subject where SubjectId='" + subjectid + "'";
                        bool IsOtherLanguage = bool.Parse(dbLibrary.idGetAFieldByQuery(qur2));
                        if (IsOtherLanguage)
                        {
                            string objectivename = Regex.Replace(objective, "<[^>]*>", string.Empty);
                            //qur = "update Objectives set ObjectiveName=N" + "'" + objectivename + "', SubjectId='" + subjectid + "', ConceptId='" + conceptid + "' where ObjectiveId='" + objectiveid + "'";
                            //dbLibrary.idExecute(qur);
                            SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                            string query = "UPDATE Objectives set SubjectId=@SubjectId, ObjectiveName=@ObjectiveName, ConceptId=@ConceptId where ObjectiveId=@ObjectiveId";
                            SqlCommand cmd = new SqlCommand(query, sqlConnection);
                            cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                            cmd.Parameters.AddWithValue("@ObjectiveName", objectivename);
                            cmd.Parameters.AddWithValue("@ConceptId", conceptid.ToString());
                            cmd.Parameters.AddWithValue("@ObjectiveId", objectiveid);
                            try
                            {
                                sqlConnection.Open();
                                cmd.ExecuteNonQuery();

                            }
                            catch (SqlException e)
                            {

                            }
                            finally
                            {
                                sqlConnection.Close();
                            }
                        }
                        else
                        {
                            //    dbLibrary.idUpdateTable("Objectives",
                            //"ObjectiveId=" + objectiveid,
                            //"SubjectId", subjectid.ToString(),
                            // "ConceptId", conceptid.ToString(),
                            //"ObjectiveName", objective);

                            SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                            string query = "UPDATE Objectives set SubjectId=@SubjectId, ObjectiveName=@ObjectiveName, ConceptId=@ConceptId where ObjectiveId=@ObjectiveId";
                            SqlCommand cmd = new SqlCommand(query, sqlConnection);
                            cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                            cmd.Parameters.AddWithValue("@ObjectiveName", objective);
                            cmd.Parameters.AddWithValue("@ConceptId", conceptid.ToString());
                            cmd.Parameters.AddWithValue("@ObjectiveId", objectiveid);
                            try
                            {
                                sqlConnection.Open();
                                cmd.ExecuteNonQuery();

                            }
                            catch (SqlException e)
                            {

                            }
                            finally
                            {
                                sqlConnection.Close();
                            }

                        }
                        return "Objective Updated Successfully";
                    }
                    else
                    {
                        return "Objective Already Found*";
                    }
                }
            }
            else
            {
                if (buttontext == "Save")
                {
                    string qur2 = "Select IsOtherLanguage from Subject where SubjectId='" + subjectid + "'";
                    bool IsOtherLanguage = bool.Parse(dbLibrary.idGetAFieldByQuery(qur2));
                    if (IsOtherLanguage)
                    {
                        string objectivename = Regex.Replace(objective, "<[^>]*>", string.Empty);
                        string qurconc = "Insert Into Objectives values('" + subjectid + "','" + conceptid + "',N" + "'" + objectivename + "','0')";
                        dbLibrary.idExecute(qurconc);
                    }
                    else
                    {
                        //      dbLibrary.idInsertInto("Objectives",
                        //"SubjectId", subjectid.ToString(),
                        //"ConceptId", conceptid.ToString(),
                        //"ObjectiveName", objective);

                        SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                        string query = "INSERT INTO Objectives (SubjectId,ConceptId,ObjectiveName) VALUES(@SubjectId,@ConceptId,@ObjectiveName)";
                        SqlCommand cmd = new SqlCommand(query, sqlConnection);
                        cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                        cmd.Parameters.AddWithValue("@ConceptId", conceptid.ToString());
                        cmd.Parameters.AddWithValue("@ObjectiveName", objective);

                        try
                        {
                            sqlConnection.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {

                        }
                        finally
                        {
                            sqlConnection.Close();
                        }
                    }
                    return "Objective Saved Successfully";
                }
                else
                {
                    string qur2 = "Select IsOtherLanguage from Subject where SubjectId='" + subjectid + "'";
                    bool IsOtherLanguage = bool.Parse(dbLibrary.idGetAFieldByQuery(qur2));
                    if (IsOtherLanguage)
                    {
                        string objectivename = Regex.Replace(objective, "<[^>]*>", string.Empty);
                        //qur = "update Objectives set ObjectiveName=N" + "'" + objectivename + "', SubjectId='" + subjectid + "', ConceptId='" + conceptid + "' where ObjectiveId='" + objectiveid + "'";
                        //dbLibrary.idExecute(qur);

                        SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                        string query = "UPDATE Objectives set SubjectId=@SubjectId, ObjectiveName=@ObjectiveName, ConceptId=@ConceptId where ObjectiveId=@ObjectiveId";
                        SqlCommand cmd = new SqlCommand(query, sqlConnection);
                        cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                        cmd.Parameters.AddWithValue("@ObjectiveName", objectivename);
                        cmd.Parameters.AddWithValue("@ConceptId", conceptid.ToString());
                        cmd.Parameters.AddWithValue("@ObjectiveId", objectiveid);
                        try
                        {
                            sqlConnection.Open();
                            cmd.ExecuteNonQuery();

                        }
                        catch (SqlException e)
                        {

                        }
                        finally
                        {
                            sqlConnection.Close();
                        }

                    }
                    else
                    {
                        //  dbLibrary.idUpdateTable("Objectives",
                        //"ObjectiveId=" + objectiveid,
                        //"SubjectId", subjectid.ToString(),
                        // "ConceptId", conceptid.ToString(),
                        //"ObjectiveName", objective);

                        SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                        string query = "UPDATE Objectives set SubjectId=@SubjectId, ObjectiveName=@ObjectiveName, ConceptId=@ConceptId where ObjectiveId=@ObjectiveId";
                        SqlCommand cmd = new SqlCommand(query, sqlConnection);
                        cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                        cmd.Parameters.AddWithValue("@ObjectiveName", objective);
                        cmd.Parameters.AddWithValue("@ConceptId", conceptid.ToString());
                        cmd.Parameters.AddWithValue("@ObjectiveId", objectiveid);
                        try
                        {
                            sqlConnection.Open();
                            cmd.ExecuteNonQuery();

                        }
                        catch (SqlException e)
                        {

                        }
                        finally
                        {
                            sqlConnection.Close();
                        }


                    }
                    return "Objective Updated Successfully";
                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteObjective(int objectiveid)
        {
            dbLibrary.idUpdateTable("Objectives",
           "ObjectiveId='" + objectiveid + "'",
           "IsDeleted", "1");
            return "Objective Deleted Successfully";
        }
    }
}