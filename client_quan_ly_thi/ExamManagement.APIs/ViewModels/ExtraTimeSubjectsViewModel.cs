using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExamManagement.APIs.ViewModels
{
    public class ExtraTimeSubjectsViewModel
    {
        public IEnumerable<int> ShiftSubjectIds { get; set; }
        public byte ExtraTime { get; set; }
        public string Reason { get; set; }
    }
}