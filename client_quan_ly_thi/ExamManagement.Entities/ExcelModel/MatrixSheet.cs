using System.Collections.Generic;

namespace ExamManagement.Entities.ExcelModel
{
    public class MatrixSheet
    {
        public string Name { get; set; }
        public List<MatrixRow> MatrixRows { get; set; }

        public MatrixSheet()
        {
            MatrixRows = new List<MatrixRow>();
        }
    }
}
