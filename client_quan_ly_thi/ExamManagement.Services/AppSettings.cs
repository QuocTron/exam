using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Services
{
    public static class AppSettings
    {
        public static string StudentCodeHeader = ConfigurationManager.AppSettings["StudentCode"];
        public static string StudentLastNameHeader = ConfigurationManager.AppSettings["StudentLastName"];
        public static string StudentFirstNameHeader = ConfigurationManager.AppSettings["StudentFirstName"];
        public static string StudentClassNameHeader = ConfigurationManager.AppSettings["StudentClassName"];
        public static string ExamDateHeader = ConfigurationManager.AppSettings["ExamDate"];
        public static string StartTimeHeader = ConfigurationManager.AppSettings["StartTime"];
        public static string DurationHeader = ConfigurationManager.AppSettings["Duration"];
        public static string SubjectHeader = ConfigurationManager.AppSettings["SubjectCode"];
        public static string BankSubjectHeader = ConfigurationManager.AppSettings["BankSubjectCode"];
        public static string GroupCodeHeader = ConfigurationManager.AppSettings["GroupCode"];
        public static string SubGroupCodeHeader = ConfigurationManager.AppSettings["SubGroupCode"];
        public static string MatrixCodeHeader = ConfigurationManager.AppSettings["MatrixCode"];
        public static string ChapterIdHeader = ConfigurationManager.AppSettings["ChapterId"];
        public static string QuantityHeader = ConfigurationManager.AppSettings["Quantity"];
        public static string ExceptListHeader = ConfigurationManager.AppSettings["ExceptList"];
        public static string FactorHeader = ConfigurationManager.AppSettings["Factor"];
    }
}
