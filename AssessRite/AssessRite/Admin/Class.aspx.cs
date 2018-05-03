using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AssessRite
{
    public partial class Class : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("../../Login.aspx");
            }
            if (!IsPostBack)
                loadDropDown();
                loadGrid();
        }

        private void loadDropDown()
        {
            string qur = "Select * from MasterClass";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                ddlClass.DataTextField = "MasterCLassName";
                ddlClass.DataValueField = "MasterClassId";
                ddlClass.DataSource = ds;
                ddlClass.DataBind();
                ddlClass.Items.Insert(0, new ListItem("--Select--", "-1"));
                ddlClass.SelectedIndex = 0;
            }
        }

        private void loadGrid()
        {
            string qur = "Select * from Class where IsDeleted='0' ORDER BY MasterClassId";
            if (dbLibrary.idHasRows(qur))
            {
                DataSet ds = dbLibrary.idGetCustomResult(qur);
                gridClass.DataSource = ds;
                gridClass.DataBind();
            }
        }

        protected void btnClassSave_Click(object sender, EventArgs e)
        {
            if (ddlClass.SelectedValue == "-1")
            {
                divError.Attributes.Add("Style", "display:block");
                lblError.Text = "Please Enter Class";
                return;
            }
            //else if (txtClass.Text == "0")
            //{
            //    divError.Attributes.Add("Style", "display:block");
            //    lblError.Text = "Class Cannot Be 0";
            //    return;
            //}
            //else if (txtClass.Text.Contains("-"))
            //{
            //    divError.Attributes.Add("Style", "display:block");
            //    lblError.Text = "Invalid Characters in Class";
            //    return;
            //}
            //else if (int.Parse(txtClass.Text) > 12)
            //{
            //    divError.Attributes.Add("Style", "display:block");
            //    lblError.Text = "Class Cannot Be Greater Than 12";
            //    return;
            //}
            else
            {
                divError.Attributes.Add("Style", "display:none");

                string qur = "Select ClassId from Class where ClassName='" + ddlClass.SelectedValue + "' and IsDeleted='0'";
                if (dbLibrary.idHasRows(qur))
                {
                    int classId = int.Parse(dbLibrary.idGetAFieldByQuery(qur));
                    if (btnClassSave.Text == "Save")
                    {
                        divError.Attributes.Add("Style", "display:block");
                        lblError.Text = "Class Already Exists";
                        return;
                    }
                    else
                    {
                        if (classId == int.Parse(btnClassSave.CommandArgument))
                        {
                           // dbLibrary.idUpdateTable("Class",
                           //"ClassId=" + btnClassSave.CommandArgument,
                           //"ClassName", txtClass.Text);
                            lblMsg.Text = "Class Updated Successfully";
                        }
                        else
                        {
                            divError.Attributes.Add("Style", "display:block");
                            lblError.Text = "Class Already Exists";
                            return;
                        }
                    }
                }
                else
                {
                    if (btnClassSave.Text == "Save")
                    {
                        //dbLibrary.idInsertInto("Class",
                        //"ClassName", txtClass.Text);
                        lblMsg.Text = "Class Saved Successfully";
                    }
                    else
                    {
                        //dbLibrary.idUpdateTable("Class",
                        //    "ClassId=" + btnClassSave.CommandArgument,
                        //    "ClassName", txtClass.Text);
                        lblMsg.Text = "Class Updated Successfully";
                    }
                }

                loadGrid();
               // txtClass.Text = "";
                btnClassSave.Text = "Save";
                btnDelete.Visible = false;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
            }

        }

        protected void gridClass_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onmouseover"] = "this.style.cursor='pointer';this.style.textDecoration='underline';";
                e.Row.Attributes["onmouseout"] = "this.style.textDecoration='none';";
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gridClass, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
            }
        }

        protected void gridClass_SelectedIndexChanged(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gridClass.Rows)
            {
                if (row.RowIndex == gridClass.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#F1F1F1");
                    row.ForeColor = Color.Black;
                    // row.ForeColor = Color.White;
                    row.ToolTip = string.Empty;
                    string text = gridClass.SelectedRow.Cells[0].Text;
                    string value = gridClass.SelectedDataKey.Value.ToString();
                   // txtClass.Text = text;
                    btnClassSave.Text = "Update";
                    btnClassSave.CommandArgument = value;
                    btnDelete.Visible = true;
                    divError.Attributes.Add("Style", "display:none");
                    //  gridClass.HeaderRow.TableSection = TableRowSection.TableHeader;
                    // UpdatePanel1.Update();
                }
                else
                {
                    row.BackColor = Color.White;
                    row.ForeColor = Color.Black;
                    row.ToolTip = "Click to select this row.";
                }
            }
        }

        protected void btnNew_Click(object sender, EventArgs e)
        {
            //txtClass.Text = "";
            btnClassSave.Text = "Save";
            gridClass.SelectedIndex = -1;
            gridClass_SelectedIndexChanged(sender, EventArgs.Empty);
            btnDelete.Visible = false;
            divError.Attributes.Add("Style", "display:none");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            dbLibrary.idUpdateTable("Class",
               "ClassId='" + gridClass.SelectedDataKey.Value + "'",
               "IsDeleted", "1");

            loadGrid();
            btnDelete.Visible = false;
            btnNew_Click(sender, EventArgs.Empty);
            lblMsg.Text = "Class Deleted Successfully";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction1", "runEffect1()", true);
        }


        //protected void gridClass_PreRender(object sender, EventArgs e)
        //{
        //    if (gridClass.Rows.Count > 0)
        //    {
        //        gridClass.UseAccessibleHeader = true;
        //        gridClass.HeaderRow.TableSection = TableRowSection.TableHeader;
        //    }
        //}

        [System.Web.Services.WebMethod]
        public static string SendParameters(int classid, string classname, string buttontext)
        {
            string qur = "Select ClassId from Class where ClassName='" + classname + "' and IsDeleted='0' and schoolId='"+ HttpContext.Current.Session["InstitutionId"].ToString()+ "'";
            if (dbLibrary.idHasRows(qur))
            {
                int classId = int.Parse(dbLibrary.idGetAFieldByQuery(qur));
                if (buttontext == "Add")
                {
                   // divError.Attributes.Add("Style", "display:block");
                  //  lblError.Text = "Class Already Exists";
                    return "Class Already Exists";
                }
                else
                {
                    if (classId == classid)
                    {
                        dbLibrary.idUpdateTable("Class",
                       "ClassId=" + classid,
                       "ClassName", classname);
                        return "Class Updated Successfully";
                    }
                    else
                    {
                        return "Class Already Exists";
                    }
                }
            }
            else
            {
                if (buttontext == "Add")
                {
                    dbLibrary.idInsertInto("Class",
                    "ClassName", classname,
                    "SchoolId", HttpContext.Current.Session["InstitutionId"].ToString(),
                    "MasterClassId",classid.ToString());
                    return "Class Saved Successfully";
                }
                else
                {
                    dbLibrary.idUpdateTable("Class",
                        "ClassId=" + classid,
                        "ClassName", classname);
                    return "Class Updated Successfully";
                }
            }
        }

        [System.Web.Services.WebMethod]
        public static string DeleteClass(int classid)
        {
            dbLibrary.idUpdateTable("Class",
               "ClassId='" + classid + "'",
               "IsDeleted", "1");
            return "Class Deleted Successfully";
        }
    }
}
