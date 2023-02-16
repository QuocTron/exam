using System;
using System.Collections.Generic;

namespace ExamManagement.APIs.ViewModels
{
    public class QuestionSheetViewModel
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public DateTime? CreateDate { get; set; }
        public bool? Approved { get; set; }
        public bool? Started { get; set; }
        public bool? Completed { get; set; }
        public int? ExtraTime { get; set; }
        public string ExtraTimeReason { get; set; }
        public decimal? Mark { get; set; }
        public int? NumberOfCorrect { get; set; }
        public int? Total { get; set; }
        public decimal? Difficulty { get; set; }

        public ICollection<ShiftSubjectStudentViewModel> ShiftSubjectStudents { get; set; }
        public ICollection<QuestionSheetDetailViewModel> QuestionSheetDetails { get; set; }
        public ICollection<ExtraTimeLogViewModel> ExtraTimeLogs { get; set; }
    }
}