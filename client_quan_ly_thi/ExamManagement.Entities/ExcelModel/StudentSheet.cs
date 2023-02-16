using System.Collections.Generic;

namespace ExamManagement.Entities.ExcelModel
{
    public class StudentSheet
    {
        public string Name { get; set; }
        public List<StudentRow> StudentRows { get; set; }

        public StudentSheet()
        {
            StudentRows = new List<StudentRow>();
        }
    }
}
