using System.Collections.Generic;

namespace ExamManagement.Entities.ExcelModel
{
    public class ExcelFile
    {
        public ShiftSheet ShiftSheet { get; set; }
        public List<MatrixSheet> MatrixSheets { get; set; }
        public List<StudentSheet> StudentSheets { get; set; }

        public ExcelFile()
        {
            ShiftSheet = new ShiftSheet();
            MatrixSheets = new List<MatrixSheet>();
            StudentSheets = new List<StudentSheet>();
        }
    }
}
