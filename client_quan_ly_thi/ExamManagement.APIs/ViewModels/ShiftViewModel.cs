using System;
using System.Collections.Generic;

namespace ExamManagement.APIs.ViewModels
{
    public class ShiftViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        //public DateTime? StartTime { get; set; }
        //public DateTime? EndTime { get; set; }
        public bool Activated { get; set; }
        //public DateTime? ActivateTime { get; set; }
        //public short? Duration { get; set; }
        public bool Ended { get; set; }
        //public DateTime? EndDate { get; set; }
        public int? ExamId { get; set; }
        public bool QuestionSheetCreated { get; set; }
        public bool Deleted { get; set; }

        public int QuantitySubject { get; set; }
        public int QuantityActivedNotYet { get; set; }
        public int QuantityActived { get; set; }
        public int QuantityPaused { get; set; }
        public int QuantityEnded { get; set; }
    }
}