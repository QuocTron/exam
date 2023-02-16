using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Entities
{
    public class ExcelMatrixLink
    {
        public string ExamDate { get; set; }
        public string StartTime { get; set; }
        public string Duration { get; set; }
        public string SubjectCode { get; set; }
        public string BankSubjectCode { get; set; }
        public string GroupCode { get; set; }
        public string SubGroupCode { get; set; }
        public string MatrixCode { get; set; }
    }
}
