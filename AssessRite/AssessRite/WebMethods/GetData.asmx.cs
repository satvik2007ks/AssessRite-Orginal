using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace AssessRite.AssessRite.WebMethods
{
    /// <summary>
    /// Summary description for GetData
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class GetData : System.Web.Services.WebService
    {

        //Add/View Subject Page
        [WebMethod(EnableSession = true)]
        public string GetSubjectData()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getSubjects]", HttpContext.Current.Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                // DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        //Add/View Class Page
        [WebMethod(EnableSession = true)]
        public string GetClassData()
        {
            string qur = "Select * from Class where IsDeleted='0' and SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "' ORDER BY MasterClassId";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                // DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        //Add/View Concept Page
        [WebMethod]
        public string GetConceptData()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getConcepts]");
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string LoadConceptDropdownsClass()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForConcept]", HttpContext.Current.Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string LoadConceptDropdownsSubject(int classid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForConcept]", HttpContext.Current.Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[1].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[1];
                var results = (from myRow in dt.AsEnumerable()
                               where (int)myRow["ClassId"] == classid
                               select myRow).CopyToDataTable();
                DataTable dtTemp = (DataTable)results;
                dtTemp.TableName = "Table2";
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dtTemp.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string LoadConceptCheckboxlist()

        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForConcept]", HttpContext.Current.Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                List<CheckBoxItem> chkListClass = new List<CheckBoxItem>();
                chkListClass = (from DataRow dr in ds.Tables[0].Rows
                                select new CheckBoxItem()
                                {
                                    ClassId = Convert.ToInt32(dr["ClassId"].ToString()),
                                    ClassName = dr["ClassName"].ToString(),
                                }).ToList();
                JavaScriptSerializer ser = new JavaScriptSerializer();
                return ser.Serialize(chkListClass);
            }
            else
                return null;
        }
        public class CheckBoxItem
        {
            public string ClassName { get; set; }
            public int ClassId { get; set; }
        }

        [WebMethod]
        public string getAllConceptAppearedinLowerClasses(int conceptid)
        {
            string qur = "Select ClassId from ConceptsRelatedClass where ConceptId=" + conceptid;
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;

        }

        //Add/View Objective Page

        [WebMethod]
        public string GetObjectiveData()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getObjectives]");
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string LoadObjectiveDropdownsClass()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForObjective]", HttpContext.Current.Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string LoadObjectiveDropdownsSubject(int classid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForObjective]", HttpContext.Current.Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[1].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[1];
                var results = (from myRow in dt.AsEnumerable()
                               where (int)myRow["ClassId"] == classid
                               select myRow).CopyToDataTable();
                DataTable dtTemp = (DataTable)results;
                dtTemp.TableName = "Table2";
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dtTemp.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string LoadObjectiveDropdownsConcept(int subjectid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForObjective]", HttpContext.Current.Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[2].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[2];
                var results = (from myRow in dt.AsEnumerable()
                               where (int)myRow["SubjectId"] == subjectid
                               select myRow).CopyToDataTable();
                DataTable dtTemp = (DataTable)results;
                dtTemp.TableName = "Table3";
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dtTemp.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        //Add/View Questions
        [WebMethod]
        public string LoadQuestionDropdownsAnswerType()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForQuestion]");
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[4].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[4];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod]
        public string LoadQuestionDropdownsClass()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForQuestion]");
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dt.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod]
        public string LoadQuestionDropdownsSubject(int classid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForQuestion]");
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[1].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[1];
                var results = (from myRow in dt.AsEnumerable()
                               where (int)myRow["ClassId"] == classid
                               select myRow).CopyToDataTable();
                DataTable dtTemp = (DataTable)results;
                dtTemp.TableName = "Table2";
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dtTemp.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod]
        public string LoadQuestionDropdownsConcept(int subjectid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForQuestion]");
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[2].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[2];
                var results = (from myRow in dt.AsEnumerable()
                               where (int)myRow["SubjectId"] == subjectid
                               select myRow).CopyToDataTable();
                DataTable dtTemp = (DataTable)results;
                dtTemp.TableName = "Table3";
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dtTemp.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }

        [WebMethod]
        public string LoadQuestionDropdownsObjective(int conceptid)
        {
            string qur = dbLibrary.idBuildQuery("[proc_getDataForQuestion]");
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[3].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[3];
                var results = (from myRow in dt.AsEnumerable()
                               where (int)myRow["ConceptId"] == conceptid
                               select myRow).CopyToDataTable();
                DataTable dtTemp = (DataTable)results;
                dtTemp.TableName = "Table4";
                string result;
                using (StringWriter sw = new StringWriter())
                {
                    dtTemp.WriteXml(sw);
                    result = sw.ToString();
                }
                return result;
            }
            else
                return null;
        }


        [WebMethod(EnableSession = true)]
        public string getQuestionsData()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getQuestions]", HttpContext.Current.Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod]
        public string getQuestionAnswerData(int questionid)
        {
            string qur = "SELECT AnswerId, Answer, IsRightAnswer, QuestionId FROM Answers where QuestionId='" + questionid + "'";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string getStudentData()
        {
            string qur = "SELECT Student.StudentId, Student.FirstName, Student.LastName, Student.ParentName, Student.ParentContactNo, Student.ParentEmailId, Class.ClassName, AcedemicYear.AcademicYear, StudentClass.ClassId, StudentClass.AcademicYearId, Login.UserName,Login.Password FROM Login RIGHT OUTER JOIN Student ON Login.StudentId = Student.StudentId LEFT OUTER JOIN Class RIGHT OUTER JOIN StudentClass ON Class.ClassId = StudentClass.ClassId LEFT OUTER JOIN AcedemicYear ON StudentClass.AcademicYearId = AcedemicYear.AcademicYearId ON Student.StudentId = StudentClass.StudentId where StudentClass.IsCurrent='1' and Student.IsDeleted='0' and Student.SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "' and Class.IsDeleted='0'";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string getTeacherData()
        {
            string qur = "SELECT Teacher.TeacherId, Teacher.TeacherFirstName, Teacher.TeacherLastName, Teacher.ContactNo, Teacher.EmailId, Login.UserName,Login.Password FROM Teacher LEFT OUTER JOIN Login ON Teacher.TeacherId = Login.TeacherId where Teacher.IsDeleted='0' and Teacher.SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string getDEData()
        {
            string qur = "SELECT DE.DEId, DE.DEFirstName, DE.DELastName, DE.DEContactNo, DE.DEEmailId, Login.UserName,Login.Password FROM DE LEFT OUTER JOIN Login ON DE.DEId = Login.DEId where DE.IsDeleted='0' and DE.SchoolId='" + HttpContext.Current.Session["InstitutionId"].ToString() + "'";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string getScheduledTests()
        {
            string qur = "SELECT TS.TestScheduleId, Class_1.ClassName, Subject.SubjectName, Test.TestId, Test.TestCreationDate, Test.TestType, Test.TestKey, Test.NoOfQuestions, Test.TotalQuestions,CONVERT(VARCHAR(10),TS.TestDate,110) as TestDate, CONVERT(VARCHAR(15), TS.TestActiveFrom, 100) AS TestActiveFrom, CONVERT(VARCHAR(15),TS.TestActiveTo, 100) AS TestActiveTo, Class.ClassName AS AssignedTo, (select Count(*) from TestAssigned where TestScheduleId=TS.TestScheduleId and Status='Taken')  as TakenCount FROM Class INNER JOIN TestSchedule TS ON Class.ClassId = TS.AssignedClassId LEFT OUTER JOIN Test ON TS.TestId = Test.TestId LEFT OUTER JOIN Class AS Class_1 ON Test.ClassId = Class_1.ClassId LEFT OUTER JOIN Subject ON Test.SubjectId = Subject.SubjectId where Test.CreatedBy='" + HttpContext.Current.Session["UserId"].ToString() + "' and Test.TestType='Online' order by TS.TestScheduleId DESC";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod]
        public string getAssignedStudents(int testScheduleId)
        {
            string qur = "SELECT  TestAssigned.TestAssignedId, Student.FirstName+' '+Student.LastName as StudentName, TestAssigned.Status FROM TestAssigned INNER JOIN Student ON TestAssigned.StudentId = Student.StudentId where TestAssigned.TestScheduleId='" + testScheduleId + "'";
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod]
        public string getConceptsForTests(int testid)
        {
            string qur = "SELECT Concept.ConceptName, TestConcepts.TestKey FROM Concept RIGHT OUTER JOIN TestConcepts ON Concept.ConceptId = TestConcepts.ConceptId where TestConcepts.TestId=" + testid;
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string getQuestionsStatus()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getQuestionsStatusForDE]", HttpContext.Current.Session["DEId"].ToString(), HttpContext.Current.Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string getQuestionsUnderReview()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getQuestionsUnderReview]", HttpContext.Current.Session["InstitutionId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

        [WebMethod(EnableSession = true)]
        public string getQuestionsUnderReviewForSME()
        {
            string qur = dbLibrary.idBuildQuery("[proc_getQuestionsUnderReviewForSME]", HttpContext.Current.Session["InstitutionId"].ToString(), HttpContext.Current.Session["SMEId"].ToString());
            DataSet ds = dbLibrary.idGetCustomResult(qur);
            if (ds.Tables[0].Rows.Count > 0)
            {
                //DataSet ds = dbLibrary.idGetCustomResult(qur);
                DataTable dt = ds.Tables[0];
                string JSONresult;
                JSONresult = JsonConvert.SerializeObject(dt);
                return JSONresult;
            }
            else
                return null;
        }

      

        [WebMethod]
        public string SendEmail(string name, string emailid, string subject, string message)
        {
            //try
            //{
            //    MailMessage msgObj = new MailMessage();
            //    msgObj.To = "satvik2007@gmail.com";
            //    msgObj.From = "Mike";
            //    msgObj.Subject = "Test Message";
            //    msgObj.Body = "Hello World!";
            //    SmtpMail.SmtpServer = "Your Server";
            //    SmtpMail.Send("donotreply@assessrite.com", msgObj.To, msgObj.Subject, msgObj.Body);
            //    SmtpMail.Send(msgObj);
            //}
            //catch (Exception ex)
            //{
            //  //  MessageBox.Show(ex.ToString());
            //}
            return "Email sent successfully";
        }
    }
}
