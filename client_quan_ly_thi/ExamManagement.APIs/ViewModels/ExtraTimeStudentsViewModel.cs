using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExamManagement.APIs.ViewModels
{
    public class ExtraTimeStudentsViewModel
    {
        public IEnumerable<int> StudentIds { get; set; }
        public int SubjectId { get; set; }
        public int ShiftId { get; set; }
        public byte ExtraTime { get; set; }
        public string Reason { get; set; }
    }
}