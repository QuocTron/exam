using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExamManagement.APIs.ViewModels
{
    public class SearchStudentViewModel
    {
        public string StudentCode { get; set; }
        public long? ShiftId { get; set; }
        public long? ShiftSubjectId { get; set; }
        public long? ExamId { get; set; }
    }
}