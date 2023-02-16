using System;
using System.Collections.Generic;

namespace ExamManagement.APIs.ViewModels
{
    public class QuestionViewModel
    {
        public long Id { get; set; }
        public string Content { get; set; }
        public bool? Interchange { get; set; }
        public decimal? SubjectiveDifficulty { get; set; }
        public decimal? ObjectiveDifficulty { get; set; }
        public int? SelectedTimes { get; set; }
        public int? CorrectTimes { get; set; }
        public bool Deleted { get; set; }
        public int ChapterId { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }
        public decimal? Mark { get; set; }
        public int? Duration { get; set; }
        public long? ParentId { get; set; }
        public bool Audio { get; set; }
        public decimal? Discrimination { get; set; }
        public int? ManagementOrder { get; set; }
        public int? SubjectId { get; set; }
        public int? ListenedTimes { get; set; }

        public ChapterViewModel Chapter { get; set; }
        public ICollection<AnswerViewModel> Answers { get; set; }
        public ICollection<QuestionSheetDetailViewModel> QuestionSheetDetails { get; set; }
    }
}