using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExamManagement.APIs.ViewModels
{
    public class ExtraTimeLogViewModel
    {
        public int Id { get; set; }
        public string Reason { get; set; }
        public short ExtraTime { get; set; }
        public long QuestionSheetId { get; set; }
    }
}