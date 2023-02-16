using System.Collections.Generic;

namespace ExamManagement.Entities.ExcelModel
{
    public class ShiftSheet
    {
        public List<ShiftRow> ShiftRows { get; set; }

        public ShiftSheet()
        {
            ShiftRows = new List<ShiftRow>();
        }
    }
}
