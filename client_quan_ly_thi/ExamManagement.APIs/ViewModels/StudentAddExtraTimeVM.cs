using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExamManagement.APIs.ViewModels
{
    public class StudentAddExtraTimeVM
    {
        public IEnumerable<int> ShiftIds { get; set; }
        public IEnumerable<int> ShiftSubjectIds { get; set; } //only use when add shiftsubject time
        public IEnumerable<int> StudentIds { get; set; }
        public byte Time { get; set; }
        public string Reason { get; set; }
    }
}