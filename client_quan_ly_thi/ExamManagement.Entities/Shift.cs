using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ExamManagement.Entities
{
    public class Shift
    {
        public int Id { get; set; }
        [StringLength(50)]
        public string Name { get; set; }
        //public DateTime StartTime { get; set; }
        //public DateTime EndTime { get; set; }
        //public bool Activated { get; set; }
        //public DateTime? ActivateTime { get; set; }
        //public short? Duration { get; set; }
        //public bool Ended { get; set; }
        //public DateTime? EndDate { get; set; }
        public int? ExamId { get; set; }
        public bool QuestionSheetCreated { get; set; }
        public bool Desktop { get; set; }
        public bool Deleted { get; set; }

        public Exam Exam { get; set; }
        public ICollection<ShiftSubject> ShiftSubjects { get; set; }
        public ICollection<PaperShiftSubject> PaperShiftSubjects { get; set; }

        public Shift()
        {
            ShiftSubjects = new HashSet<ShiftSubject>();
            PaperShiftSubjects = new HashSet<PaperShiftSubject>();
        }
    }
}