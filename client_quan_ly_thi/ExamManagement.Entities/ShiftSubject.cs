using System;
using System.Collections.Generic;

namespace ExamManagement.Entities
{
    public class ShiftSubject
    {
        public long Id { get; set; }
        public int? ShiftId { get; set; }
        public int? SubjectId { get; set; }
        public int? MatrixId { get; set; }
        public string SubjectCode { get; set; }
        public string SubjectName { get; set; }
        public string GroupCode { get; set; }
        public string SubGroupCode { get; set; }
        public short? Duration { get; set; }
        public byte? StateActivate { get; set; } // 1: is not active | 2: Activing | 3: Pause | 4: Finish
        public bool CreatedQuestionSheet { get; set; }

        public DateTime? EndDate { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public DateTime? ActivateTime { get; set; }
        public bool? Ended { get; set; }
        public Shift Shift { get; set; }
        public Subject Subject { get; set; }
        public Matrix Matrix { get; set; }
        public ICollection<ShiftSubjectStudent> ShiftSubjectStudents { get; set; }

        public ShiftSubject()
        {
            ShiftSubjectStudents = new HashSet<ShiftSubjectStudent>();
        }
    }
}