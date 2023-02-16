using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ExamManagement.Entities
{
    public class QuestionSheet
    {
        public long Id { get; set; }

        [StringLength(100)]
        public string Name { get; set; }
        public DateTime? CreateDate { get; set; }
        public bool Approved { get; set; }
        public bool Started { get; set; }
        public bool Completed { get; set; }
        public byte ExtraTime { get; set; }
        [StringLength(100)]
        public string ExtraTimeReason { get; set; }
        public decimal? Mark { get; set; }
        public short? NumberOfCorrect { get; set; }
        public short? Total { get; set; }
        public decimal? Difficulty { get; set; }
        public int? UserId { get; set; }
        public int StudentId { get; set; }
        public int? ShiftId { get; set; }
        public long ShiftSubjectId { get; set; }

        public ICollection<ShiftSubjectStudent> ShiftSubjectStudents { get; set; }
        public ICollection<QuestionSheetDetail> QuestionSheetDetails { get; set; }
        public ICollection<ExtraTimeLog> ExtraTimeLogs { get; set; }

        public QuestionSheet()
        {
            QuestionSheetDetails = new HashSet<QuestionSheetDetail>();
            ShiftSubjectStudents = new HashSet<ShiftSubjectStudent>();
            ExtraTimeLogs = new HashSet<ExtraTimeLog>();
        }
    }
}