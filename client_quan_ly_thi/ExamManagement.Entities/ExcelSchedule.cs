using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Entities
{
    public class ExcelSchedule
    {
        public List<ExcelExamSchedule> ExcelExamSchedules { get; set; }
        public List<ExcelMatrixLink> ExcelMatrixLinks { get; set; }
    }
}
