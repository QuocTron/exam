using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExamManagement.APIs.ViewModels
{
    public class GetExtraStudentForm
    {
        public int StudentId { get; set; }
        public int ShiftId { get; set; }
        public int ExtraTime { get; set; }
        public string Reason { get; set; }
    }
}