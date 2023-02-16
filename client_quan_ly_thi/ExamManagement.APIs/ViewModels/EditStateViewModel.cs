using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExamManagement.APIs.ViewModels
{
    public class EditStateViewModel
    {
        public long[] ShiftIds { get; set; }
        public long[] shiftSubjectIds { get; set; }
    }
}