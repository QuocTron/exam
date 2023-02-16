using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ExamManagement.Entities
{
    public class ShiftSubjectStudent
    {
        [Key]
        [Column(Order = 1)]
        public long ShiftSubjectId { get; set; }

        [Key]
        [Column(Order = 2)]
        public int StudentId { get; set; }

        public long? QuestionSheetId { get; set; }
        public bool LogIn { get; set; }
        public byte? StateExam { get; set; } // 1: Not done yet | 2: Taking the exam | 3: Finish
        public DateTime? LastLogIn { get; set; }
        public DateTime? LastLogOut { get; set; }
        public DateTime InsertTime { get; set; }


        public Student Student { get; set; }
        public ShiftSubject ShiftSubject { get; set; }
        public QuestionSheet QuestionSheet { get; set; }
    }
}