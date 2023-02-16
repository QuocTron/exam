using System;

namespace ExamManagement.Entities.ExcelModel
{
    public class ShiftRow
    {
        public string Date { get; set; }
        public string StartTime { get; set; }
        public string Duration { get; set; }
        public string SubjectCode { get; set; }
        public string SubjectName { get; set; }
        public string MatrixSheetName { get; set; }
        public string StudentSheetName { get; set; }
    }
}
