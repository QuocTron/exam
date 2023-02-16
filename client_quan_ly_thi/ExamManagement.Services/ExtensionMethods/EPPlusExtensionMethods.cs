using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Services.ExtensionMethods
{
    public static class EPPlusExtensionMethods
    {
        public static int GetColumnByName(this ExcelWorksheet worksheet, string columnName)
        {
            return worksheet.Cells["1:1"].First(c => c.Text.Equals(columnName)).Start.Column;
        }

        /// <summary>
        /// Get one cell by row index and column name.
        /// </summary>
        public static ExcelRange Cell(this ExcelWorksheet worksheet, int rowIndex, string columnName)
        {
            int columnIndex = worksheet.GetColumnByName(columnName);

            return worksheet.Cells[rowIndex, columnIndex];
        }
    }
}
