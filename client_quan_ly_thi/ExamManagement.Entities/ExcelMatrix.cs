using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Entities
{
    public class ExcelMatrix
    {
        public string MatrixName { get; set; }
        public List<ExcelMatrixDetail> ExcelMatrixDetails { get; set; }
    }
}
