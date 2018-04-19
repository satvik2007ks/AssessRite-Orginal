using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;

namespace AssessRite
{
    public class dbLibrary
    {
        public static string conStr = ConfigurationManager.ConnectionStrings["assessrite"].ToString();

        public static DataSet idGetCustomResult(string qry)
        {
            DataSet ds = new DataSet();
            SqlConnection conn1 = new SqlConnection(dbLibrary.conStr);
            SqlDataAdapter dataadapter1 = new SqlDataAdapter(qry, conn1);
            try
            {
                conn1.Open();
                dataadapter1.Fill(ds);
                return ds;

            }
            catch
            {
                ds = null;
                return ds;
            }
            finally
            {
                conn1.Close();
            }
        }

        public static void idInsertDataTable(string procedureName, string paramName, DataTable dt)
        {

            SqlConnection conn = new SqlConnection(dbLibrary.conStr);
            SqlCommand cmd = new SqlCommand(procedureName, conn);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter dtparam = cmd.Parameters.AddWithValue(paramName, dt);
            dtparam.SqlDbType = SqlDbType.Structured;
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            catch(Exception ex)
            {

            }
            finally
            {
                conn.Close();
            }
        }

        public static string idGetAFieldByQuery(string qur)
        {
            string retStr = "";
            try
            {
                DataSet ds = new DataSet();
                SqlConnection conn = new SqlConnection(dbLibrary.conStr);
                SqlDataAdapter dataadapter1 = new SqlDataAdapter(qur, conn);
                conn.Open();
                dataadapter1.Fill(ds);
                conn.Close();
                if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                {
                    retStr = ds.Tables[0].Rows[0][0].ToString();
                }
                //SqlConnection conn = new SqlConnection(iLib.conStr);
                //SqlCommand command = new SqlCommand(qur, conn);

                //SqlDataReader reader = null;
                //conn.Open();
                //reader = command.ExecuteReader();
                //if (reader.HasRows)
                //{
                //    reader.Read();
                //    retStr = reader[0].ToString();
                //}
                //conn.Close();
            }
            catch
            {

            }
            return retStr.Trim();
        }

        public static bool idHasRows(string qur)
        {
            bool retBool = false;
            try
            {
                SqlConnection conn = new SqlConnection(dbLibrary.conStr);
                SqlCommand command = new SqlCommand(qur, conn);
                conn.Open();
                SqlDataReader reader;
                reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    retBool = true;
                }
                conn.Close();
            }
            catch (Exception e)
            {
                throw e;
            }
            return retBool;

        }
        public static void idExecute(string qur)
        {
            try
            {
                SqlConnection conn = new SqlConnection(conStr);
                SqlCommand cmd = new SqlCommand();

                cmd.Connection = conn;
                conn.Open();
                cmd.CommandText = qur;
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch
            {
              
            }
        }

        public static void idInsertInto(string TableName, params string[] paramStr)
        {
            SqlConnection conn = new SqlConnection(dbLibrary.conStr);


            string qur = "insert into " + TableName + "(";
            for (int i = 0; i < paramStr.Length; i = i + 2)
            {
                if (paramStr[i] == ":nc:" || paramStr[i] == ":null:")
                    i++;
                qur += "" + paramStr[i] + ",";
            }
            qur = qur.Trim(',');
            qur += ") values (";
            for (int i = 0; i < paramStr.Length; i = i + 2)
            {
                if (paramStr[i] == ":nc:")
                {
                    i++;
                    qur += paramStr[i + 1] + ",";
                }
                else if (paramStr[i] == ":null:")
                {
                    i++;
                    qur += "null,";
                }
                else if (paramStr[i + 1] == ":null:")
                    qur += "NULL,";
                else
                {
                    qur += "'" + paramStr[i + 1].Replace('\'', '`') + "',";
                }
            }
            qur = qur.Trim(',');
            qur += ")";
            conn.Open();
            SqlCommand command = new SqlCommand(qur, conn);
            command.ExecuteNonQuery();
            conn.Close();

        }

        public static void idUpdateTable(string TableName, string Condition, params string[] paramStr)
        {

            SqlConnection conn = new SqlConnection(dbLibrary.conStr);

            string qur = "update " + TableName + " set ";
            for (int i = 0; i < paramStr.Length; i = i + 2)
            {
                if (paramStr[i] == ":nc:")
                {
                    i++;
                    qur += "" + paramStr[i] + "=" + paramStr[i + 1] + ",";
                }
                else if (paramStr[i] == ":null:")
                {
                    i++;
                    if (paramStr[i + 1] == null)
                        qur += "" + paramStr[i] + "=null,";
                    else
                        qur += "" + paramStr[i] + "='" + paramStr[i + 1] + "',";
                }
                else if (paramStr[i + 1] == ":null:")
                    qur += "" + paramStr[i] + "=NULL,";
                else
                    qur += "" + paramStr[i] + "='" + paramStr[i + 1].Replace('\'', '`') + "',";
            }
            qur = qur.Trim(',');
            qur += " Where " + Condition;
            conn.Open();

            SqlCommand command = new SqlCommand(qur, conn);
            command.ExecuteNonQuery();

            conn.Close();
        }

        public static bool idSendEmail(string SmtpClient, string FromId, string FromIdPassWord, string ToId, string subject, string DisplayName, string Body)
        {
            MailMessage mail = new MailMessage();
            NetworkCredential cred = new NetworkCredential(FromId, FromIdPassWord);
            mail.To.Add(ToId);
            mail.Subject = subject;
            mail.From = new MailAddress(FromId, DisplayName);
            mail.IsBodyHtml = true;
            mail.Body = Body;
            SmtpClient smtp = new SmtpClient(SmtpClient);
            smtp.UseDefaultCredentials = false;
            smtp.EnableSsl = true;
            smtp.Credentials = cred;
            try
            {
                smtp.Send(mail);
                return true;
            }
            catch { return false; }
        }

        public static SqlDataReader idReturnReader(string qur)
        {
            SqlConnection conn = new SqlConnection(dbLibrary.conStr);
            SqlCommand command = new SqlCommand(qur, conn);
            conn.Open();
            SqlDataReader reader;
            reader = command.ExecuteReader();
            return reader;
        }


        public static string idBuildQuery(string ProcedureName, params string[] paramStr)
        {
            StringBuilder qur = new StringBuilder();
            qur.Append("Exec ");
            qur.Append(ProcedureName);
            qur.Append(" ");
            for (int i = 0; i <= paramStr.Length - 1; i++)
            {
                string prmstr = paramStr[i];
                if (prmstr.Contains("'"))
                {
                    prmstr = prmstr.Replace("'", "''");
                }
                qur.Append("'");
                qur.Append(prmstr);
                qur.Append("'");
                if (i != paramStr.Length - 1)
                    qur.Append(",");
            }
            return qur.ToString();
        }


    }

}