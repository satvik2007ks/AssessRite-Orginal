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
    public partial class Concept : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            //if (!IsPostBack)
            //{
            //    // loadDropDown();
            //    loadGrid();
            //    //   loadConcepts();
            //}
        }

        private void loadConcepts()
        {
            DataSet ds = (DataSet)ViewState["Data"];
            if (ds.Tables[0].Rows.Count > 0)
            {
                chkClass.DataTextField = "ClassName";
                chkClass.DataValueField = "ClassId";
                chkClass.DataSource = ds.Tables[0];
                chkClass.DataBind();
            }

            //string qur = "Select * from Class Where IsDeleted='0' ORDER BY CAST(ClassName AS Numeric(10,0)) ASC";
            //if (dbLibrary.idHasRows(qur))
            //{
            //    DataSet ds = dbLibrary.idGetCustomResult(qur);
            //    chkClass.DataTextField = "ClassName";
            //    chkClass.DataValueField = "ClassId";
            //    chkClass.DataSource = ds;
            //    chkClass.DataBind();
            //}
        }

        private void loadGrid()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getConcepts]");
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            //string qur = "SELECT Concept.ConceptId, Concept.ClassId, Concept.SubjectId, Concept.ConceptName, Class.ClassName, Subject.SubjectName FROM Subject RIGHT OUTER JOIN Concept ON Subject.SubjectId = Concept.SubjectId LEFT OUTER JOIN Class ON Concept.ClassId = Class.ClassId where Concept.isDeleted='0' and Subject.IsDeleted='0' and Class.IsDeleted='0' ORDER BY CAST(Class.ClassName AS Numeric(10,0)) ASC";
            //if (dbLibrary.idHasRows(qur))
            {
                //  DataSet ds = dbLibrary.idGetCustomResult(qur);
                gridConcept.DataSource = ds;
                gridConcept.DataBind();
            }
        }

        private void loadDropDown()
        {
            string qur1 = dbLibrary.idBuildQuery("[proc_getDataForConcept]");
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
            txtConcepts.Text = "";
            gridConcept.SelectedIndex = -1;
            btnConceptsSave.Text = "Save";
            gridConcept_SelectedIndexChanged(sender, EventArgs.Empty);
            ddlClassName.SelectedIndex = 0;
            ddlSubject.Items.Clear();
            divError.Attributes.Add("Style", "display:none");
            btnDelete.Visible = false;
            foreach (ListItem li in chkClass.Items)
            {
                if (li.Selected)
                {
                    li.Selected = false;
                }
            }
        }

        protected void btnConceptsSave_Click(object sender, EventArgs e)
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
            if (txtConcepts.Text == "")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Concept Required*";
                return;
            }
            else
            {
                divError.Attributes.Add("Style", "display:none");
            }

            string qur = "Select ConceptId from Concept where ConceptName='" + txtConcepts.Text + "' and ClassId='" + ddlClassName.SelectedValue + "' and SubjectId='" + ddlSubject.SelectedValue + "' and IsDeleted='0'";
            if (dbLibrary.idHasRows(qur))
            {
                int ConceptId = int.Parse(dbLibrary.idGetAFieldByQuery(qur));
                if (btnConceptsSave.Text == "Save")
                {
                    divError.Attributes.Add("Style", "display:block");
                    lblError.Text = "Concept Already Found*";
                    return;
                }
                else
                {
                    if (ConceptId == int.Parse(btnConceptsSave.CommandArgument))
                    {
                        if (IsOtherLanguage(ddlSubject.SelectedValue))
                        {
                            string concept = Regex.Replace(txtConcepts.Text, "<[^>]*>", string.Empty);
                            qur = "update Concept set ConceptName=N" + "'" + concept + "', SubjectId='" + ddlSubject.SelectedValue + "', ClassId='" + ddlClassName.SelectedValue + "' where ConceptId='" + btnConceptsSave.CommandArgument + "'";
                            dbLibrary.idExecute(qur);
                            //   string relatedClass = dbLibrary.idBuildQuery("[proc_ConceptRelatedClass]", "N" + "'" + concept + "'", btnConceptsSave.CommandArgument, ddlClassName.SelectedItem.Text);
                            //   dbLibrary.idExecute(relatedClass);
                        }
                        else
                        {
                            dbLibrary.idUpdateTable("Concept",
                       "ConceptId=" + btnConceptsSave.CommandArgument,
                       "ClassId", ddlClassName.SelectedValue,
                        "SubjectId", ddlSubject.SelectedValue,
                       "ConceptName", txtConcepts.Text);
                            //     string relatedClass = dbLibrary.idBuildQuery("[proc_ConceptRelatedClass]", txtConcepts.Text, btnConceptsSave.CommandArgument, ddlClassName.SelectedItem.Text);
                            //     dbLibrary.idExecute(relatedClass);
                        }

                        lblMsg.Text = "Concept Updated Successfully";
                    }
                    else
                    {
                        divError.Attributes.Add("Style", "display:block");
                        lblError.Text = "Concept Already Found*";
                        return;
                    }
                }
            }
            else
            {
                if (btnConceptsSave.Text == "Save")
                {
                    if (IsOtherLanguage(ddlSubject.SelectedValue))
                    {
                        //dbLibrary.idInsertInto("Concept",
                        //"ClassId", ddlClassName.SelectedValue,
                        // "SubjectId", ddlSubject.SelectedValue,
                        // "ConceptName", txtConcepts.Text);
                        string concept = Regex.Replace(txtConcepts.Text, "<[^>]*>", string.Empty);
                        string qurconc = "Insert Into Concept values('" + ddlClassName.SelectedValue + "','" + ddlSubject.SelectedValue + "',N" + "'" + concept + "','0')";
                        dbLibrary.idExecute(qurconc);
                        qur = "Select ConceptId from Concept where ClassId=" + ddlClassName.SelectedValue + " and SubjectId=" + ddlSubject.SelectedValue + " and ConceptName='" + txtConcepts.Text + "'";
                        Session["Concept"] = dbLibrary.idGetAFieldByQuery(qur);
                        // string relatedClass = dbLibrary.idBuildQuery("[proc_ConceptRelatedClass]", "N" + "'" + concept + "'", Session["Concept"].ToString(),ddlClassName.SelectedItem.Text);
                        //  dbLibrary.idExecute(relatedClass);
                    }
                    else
                    {
                        dbLibrary.idInsertInto("Concept",
                         "ClassId", ddlClassName.SelectedValue,
                         "SubjectId", ddlSubject.SelectedValue,
                         "ConceptName", txtConcepts.Text);
                        qur = "Select ConceptId from Concept where ClassId=" + ddlClassName.SelectedValue + " and SubjectId=" + ddlSubject.SelectedValue + " and ConceptName='" + txtConcepts.Text + "'";
                        Session["Concept"] = dbLibrary.idGetAFieldByQuery(qur);
                        //  string relatedClass = dbLibrary.idBuildQuery("[proc_ConceptRelatedClass]",txtConcepts.Text, Session["Concept"].ToString(), ddlClassName.SelectedItem.Text);
                        // dbLibrary.idExecute(relatedClass);
                    }
                    lblMsg.Text = "Concept Saved Successfully";
                }
                else
                {
                    if (IsOtherLanguage(ddlSubject.SelectedValue))
                    {
                        string concept = Regex.Replace(txtConcepts.Text, "<[^>]*>", string.Empty);
                        qur = "update Concept set ConceptName=N" + "'" + concept + "', SubjectId='" + ddlSubject.SelectedValue + "', ClassId='" + ddlClassName.SelectedValue + "' where ConceptId='" + btnConceptsSave.CommandArgument + "'";
                        dbLibrary.idExecute(qur);
                        //   string relatedClass = dbLibrary.idBuildQuery("[proc_ConceptRelatedClass]", "N" + "'" + concept + "'", btnConceptsSave.CommandArgument, ddlClassName.SelectedItem.Text);
                        //   dbLibrary.idExecute(relatedClass);
                    }
                    else
                    {
                        dbLibrary.idUpdateTable("Concept",
                      "ConceptId=" + btnConceptsSave.CommandArgument,
                      "ClassId", ddlClassName.SelectedValue,
                       "SubjectId", ddlSubject.SelectedValue,
                      "ConceptName", txtConcepts.Text);
                        // string relatedClass = dbLibrary.idBuildQuery("[proc_ConceptRelatedClass]", txtConcepts.Text, btnConceptsSave.CommandArgument, ddlClassName.SelectedItem.Text);
                        //  dbLibrary.idExecute(relatedClass);
                    }

                    lblMsg.Text = "Concept Updated Successfully";
                }
            }

            string qur1 = "Delete from ConceptsRelatedClass where ConceptId=" + Session["Concept"].ToString();
            dbLibrary.idExecute(qur1);

            foreach (ListItem li in chkClass.Items)
            {
                if (li.Selected)
                {
                    dbLibrary.idInsertInto("ConceptsRelatedClass",
                        "ConceptId", Session["Concept"].ToString(),
                        "ClassId", li.Value);
                }
            }
            loadGrid();
            txtConcepts.Text = "";
            btnConceptsSave.Text = "Save";
            ddlClassName.SelectedIndex = 0;
            ddlSubject.Items.Clear();
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

        protected void gridConcept_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
                e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gridConcept, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void gridConcept_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gridConcept.Rows)
            {
                if (row.RowIndex == gridConcept.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#6192d3");
                    row.ForeColor = Color.White;
                    row.ToolTip = string.Empty;
                    string text = gridConcept.SelectedRow.Cells[2].Text;
                    string value = gridConcept.SelectedDataKey.Value.ToString();
                    Session["Concept"] = value;
                    txtConcepts.Text = text;
                    ddlClassName.SelectedValue = gridConcept.SelectedRow.Cells[3].Text;
                    ddlClassName_SelectedIndexChanged(ddlClassName, EventArgs.Empty);
                    ddlSubject.SelectedValue = gridConcept.SelectedRow.Cells[4].Text;
                    btnConceptsSave.CommandArgument = value;
                    btnConceptsSave.Text = "Update";
                    btnDelete.Visible = true;
                    chkClass.Items.Clear();
                    loadConcepts();
                    string qur = "Select ClassId from ConceptsRelatedClass where ConceptId=" + value;
                    DataSet ds = dbLibrary.idGetCustomResult(qur);
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        foreach (ListItem li in chkClass.Items)
                        {
                            if (dr["ClassId"].ToString() == li.Value)
                            {
                                li.Selected = true;
                                break;
                            }
                        }
                    }
                }
                else
                {
                    row.BackColor = ColorTranslator.FromHtml("#F1F1F1");
                    row.ForeColor = ColorTranslator.FromHtml("#8f9b86");
                    row.ToolTip = "Click to select this row.";
                }
            }
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
            //string qur = "Select * from Subject where IsDeleted='0' and ClassId=" + ddlClassName.SelectedValue + " order by SubjectName";
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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            dbLibrary.idUpdateTable("Concept",
             "ConceptId='" + gridConcept.SelectedDataKey.Value + "'",
             "IsDeleted", "1");
            //string qur = "Delete from Concept where ConceptId=" + gridConcept.SelectedDataKey.Value;
            //dbLibrary.idExecute(qur);
            loadGrid();
            btnDelete.Visible = false;
            btnNew_Click(sender, EventArgs.Empty);
            lblMsg.Text = "Concept Deleted Successfully";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }

        [System.Web.Services.WebMethod]
        public static string SendParameters(string classname, int classid, int subjectid, string concept, string buttontext, string[] ids, string[] chktext, int conceptid)
        {
            string tempconceptid, qurdel, conc = "";
            var regexItem = new Regex("^[a-zA-Z0-9\' ]*$");
            //if (!regexItem.IsMatch(concept))
            //{
            //    return "Concept Cannot Have Special Characters";
            //}
            if (concept.Contains('\''))
            {
                conc = concept.Replace("'", "''''");
            }
            if (conc == "")
            {
                conc = concept;
            }
            foreach (string item in chktext)
            {
                if (int.Parse(item) >= int.Parse(classname))
                {
                    return "Invalid Lower Class";
                }
            }
            string qur = "Select ConceptId from Concept where ConceptName='" + conc + "' and ClassId='" + classid + "' and SubjectId='" + subjectid + "' and IsDeleted='0'";
            if (dbLibrary.idHasRows(qur))
            {
                int ConceptId = int.Parse(dbLibrary.idGetAFieldByQuery(qur));
                if (buttontext == "Save")
                {
                    return "Concept Already Found";
                }
                else
                {
                    if (ConceptId == conceptid)
                    {
                        string qur2 = "Select IsOtherLanguage from Subject where SubjectId='" + subjectid + "'";
                        bool IsOtherLanguage = bool.Parse(dbLibrary.idGetAFieldByQuery(qur2));
                        if (IsOtherLanguage)
                        {
                            string conceptname = Regex.Replace(concept, "<[^>]*>", string.Empty);
                            //qur = "update Concept set ConceptName=N" + "'" + conceptname + "', SubjectId='" + subjectid + "', ClassId='" + classid + "' where ConceptId='" + conceptid + "'";
                            //dbLibrary.idExecute(qur);

                            SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                            string query = "UPDATE Concept set ClassId=@ClassId, SubjectId=@SubjectId, ConceptName=@ConceptName where ConceptId=@ConceptId";
                            SqlCommand cmd = new SqlCommand(query, sqlConnection);
                            cmd.Parameters.AddWithValue("@ClassId", classid.ToString());
                            cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                            cmd.Parameters.AddWithValue("@ConceptName", conceptname);
                            cmd.Parameters.AddWithValue("@ConceptId", conceptid);
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



                            //   string relatedClass = dbLibrary.idBuildQuery("[proc_ConceptRelatedClass]", "N" + "'" + concept + "'", btnConceptsSave.CommandArgument, ddlClassName.SelectedItem.Text);
                            //   dbLibrary.idExecute(relatedClass);
                        }
                        else
                        {
                            //     dbLibrary.idUpdateTable("Concept",
                            //"ConceptId=" + conceptid,
                            //"ClassId", classid.ToString(),
                            // "SubjectId", subjectid.ToString(),
                            //"ConceptName", concept);
                            if (!regexItem.IsMatch(concept))
                            {
                                return "Concept Cannot Have Special Characters";
                            }
                            SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                            string query = "UPDATE Concept set ClassId=@ClassId, SubjectId=@SubjectId, ConceptName=@ConceptName where ConceptId=@ConceptId";
                            SqlCommand cmd = new SqlCommand(query, sqlConnection);
                            cmd.Parameters.AddWithValue("@ClassId", classid.ToString());
                            cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                            cmd.Parameters.AddWithValue("@ConceptName", concept);
                            cmd.Parameters.AddWithValue("@ConceptId", conceptid);
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
                        qurdel = "Delete from ConceptsRelatedClass where ConceptId=" + conceptid;
                        dbLibrary.idExecute(qurdel);
                        foreach (string item in ids)
                        {
                            //dbLibrary.idInsertInto("ConceptsRelatedClass",
                            //    "ConceptId", conceptid.ToString(),
                            //    "ClassId", item);
                            SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                            string query = "INSERT INTO ConceptsRelatedClass (ConceptId,ClassId) VALUES(@ConceptId,@ClassId)";
                            SqlCommand cmd = new SqlCommand(query, sqlConnection);
                            cmd.Parameters.AddWithValue("@ConceptId", conceptid.ToString());
                            cmd.Parameters.AddWithValue("@ClassId", item);
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
                        return "Concept Updated Successfully";
                    }
                    else
                    {
                        return "Concept Already Found";
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
                        //dbLibrary.idInsertInto("Concept",
                        //"ClassId", ddlClassName.SelectedValue,
                        // "SubjectId", ddlSubject.SelectedValue,
                        // "ConceptName", txtConcepts.Text);
                        string conceptname = Regex.Replace(concept, "<[^>]*>", string.Empty);
                        //string qurconc = "Insert Into Concept values('" + classid + "','" + subjectid + "',N" + "'" + conceptname + "','0')";
                        //dbLibrary.idExecute(qurconc);

                        SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                        string query = "INSERT INTO Concept (ClassId,SubjectId,ConceptName) VALUES(@ClassId,@SubjectId,@ConceptName)";
                        SqlCommand cmd = new SqlCommand(query, sqlConnection);
                        cmd.Parameters.AddWithValue("@ClassId", classid.ToString());
                        cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                        cmd.Parameters.AddWithValue("@ConceptName", conceptname);
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


                        qur = "Select ConceptId from Concept where ClassId=" + classid + " and SubjectId=" + subjectid + " and ConceptName='" + concept + "'";
                        tempconceptid = dbLibrary.idGetAFieldByQuery(qur);
                        // string relatedClass = dbLibrary.idBuildQuery("[proc_ConceptRelatedClass]", "N" + "'" + concept + "'", Session["Concept"].ToString(),ddlClassName.SelectedItem.Text);
                        //  dbLibrary.idExecute(relatedClass);
                    }
                    else
                    {
                        //dbLibrary.idInsertInto("Concept",
                        // "ClassId", classid.ToString(),
                        // "SubjectId", subjectid.ToString(),
                        // "ConceptName", concept);
                        if (!regexItem.IsMatch(concept))
                        {
                            return "Concept Cannot Have Special Characters";
                        }
                        SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                        string query = "INSERT INTO Concept (ClassId,SubjectId,ConceptName) VALUES(@ClassId,@SubjectId,@ConceptName)";
                        SqlCommand cmd = new SqlCommand(query, sqlConnection);
                        cmd.Parameters.AddWithValue("@ClassId", classid.ToString());
                        cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                        cmd.Parameters.AddWithValue("@ConceptName", concept);
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

                        qur = "Select ConceptId from Concept where ClassId=" + classid + " and SubjectId=" + subjectid + " and ConceptName='" + concept + "'";
                        tempconceptid = dbLibrary.idGetAFieldByQuery(qur);
                        //  string relatedClass = dbLibrary.idBuildQuery("[proc_ConceptRelatedClass]",txtConcepts.Text, Session["Concept"].ToString(), ddlClassName.SelectedItem.Text);
                        // dbLibrary.idExecute(relatedClass);
                    }
                    qurdel = "Delete from ConceptsRelatedClass where ConceptId=" + tempconceptid;
                    dbLibrary.idExecute(qurdel);
                    foreach (string item in ids)
                    {
                        //dbLibrary.idInsertInto("ConceptsRelatedClass",
                        //    "ConceptId", tempconceptid,
                        //    "ClassId", item);
                        SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                        string query = "INSERT INTO ConceptsRelatedClass (ConceptId,ClassId) VALUES(@ConceptId,@ClassId)";
                        SqlCommand cmd = new SqlCommand(query, sqlConnection);
                        cmd.Parameters.AddWithValue("@ConceptId", tempconceptid);
                        cmd.Parameters.AddWithValue("@ClassId", item);
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
                    return "Concept Saved Successfully";
                }
                else
                {
                    string qur2 = "Select IsOtherLanguage from Subject where SubjectId='" + subjectid + "'";
                    bool IsOtherLanguage = bool.Parse(dbLibrary.idGetAFieldByQuery(qur2));
                    if (IsOtherLanguage)
                    {
                        string conceptname = Regex.Replace(concept, "<[^>]*>", string.Empty);
                        //  qur = "update Concept set ConceptName=N" + "'" + conceptname + "', SubjectId='" + subjectid + "', ClassId='" + classid + "' where ConceptId='" + conceptid + "'";
                        //dbLibrary.idExecute(qur);
                        SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                        string query = "UPDATE Concept set ClassId=@ClassId, SubjectId=@SubjectId, ConceptName=@ConceptName where ConceptId=@ConceptId";
                        SqlCommand cmd = new SqlCommand(query, sqlConnection);
                        cmd.Parameters.AddWithValue("@ClassId", classid.ToString());
                        cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                        cmd.Parameters.AddWithValue("@ConceptName", conceptname);
                        cmd.Parameters.AddWithValue("@ConceptId", conceptid);
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
                        //  dbLibrary.idUpdateTable("Concept",
                        //"ConceptId=" + conceptid,
                        //"ClassId", classid.ToString(),
                        // "SubjectId", subjectid.ToString(),
                        //"ConceptName", concept);

                        SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                        string query = "UPDATE Concept set ClassId=@ClassId, SubjectId=@SubjectId, ConceptName=@ConceptName where ConceptId=@ConceptId";
                        SqlCommand cmd = new SqlCommand(query, sqlConnection);
                        cmd.Parameters.AddWithValue("@ClassId", classid.ToString());
                        cmd.Parameters.AddWithValue("@SubjectId", subjectid.ToString());
                        cmd.Parameters.AddWithValue("@ConceptName", concept);
                        cmd.Parameters.AddWithValue("@ConceptId", conceptid);
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
                    qurdel = "Delete from ConceptsRelatedClass where ConceptId=" + conceptid;
                    dbLibrary.idExecute(qurdel);
                    foreach (string item in ids)
                    {
                        //dbLibrary.idInsertInto("ConceptsRelatedClass",
                        //    "ConceptId", conceptid.ToString(),
                        //    "ClassId", item);

                        SqlConnection sqlConnection = new SqlConnection(dbLibrary.conStr);
                        string query = "INSERT INTO ConceptsRelatedClass (ConceptId,ClassId) VALUES(@ConceptId,@ClassId)";
                        SqlCommand cmd = new SqlCommand(query, sqlConnection);
                        cmd.Parameters.AddWithValue("@ConceptId", conceptid.ToString());
                        cmd.Parameters.AddWithValue("@ClassId", item);
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
                    return "Concept Updated Successfully";
                }
            }

            //qurdel = "Delete from ConceptsRelatedClass where ConceptId=" + tempconceptid;
            //dbLibrary.idExecute(qurdel);
            //foreach (string item in ids)
            //{
            //    dbLibrary.idInsertInto("ConceptsRelatedClass",
            //        "ConceptId", tempconceptid,
            //        "ClassId", item);
            //}
        }

        [System.Web.Services.WebMethod]
        public static string DeleteConcept(int conceptid)
        {
            dbLibrary.idUpdateTable("Concept",
             "ConceptId='" + conceptid + "'",
             "IsDeleted", "1");
            return "Concept Deleted Successfully";
        }
    }
}