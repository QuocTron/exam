using System;

namespace ExamManagement.APIs.ViewModels
{
    public class QuestionSheetDetailViewModel
    {
        public long QuestionSheetId { get; set; }
        public long QuestionId { get; set; }
        public int? Order { get; set; }
        public int? AnswerId { get; set; }
        public bool? Correct { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }
        public int ListenTimes { get; set; }

        public virtual QuestionSheetViewModel QuestionSheet { get; set; }
        public virtual QuestionViewModel Question { get; set; }
    }
}