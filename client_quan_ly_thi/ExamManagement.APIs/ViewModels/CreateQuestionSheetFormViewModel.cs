using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExamManagement.APIs.ViewModels
{
    public class CreateQuestionSheetFormViewModel
    {
        public int? ExamId { get; set; }
        public IEnumerable<int?> ShiftIds { get; set; }
        public IEnumerable<int?> ShiftSubjectIds { get; set; }
    }
}