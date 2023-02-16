using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ExamManagement.APIs.ViewModels
{
    public class StudentInfoViewModel
    {
        public int Id { get; set; }
        public int ShiftId { get; set; }
        public long ShiftSubjectId { get; set; }
        public string Code { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string ClassName { get; set; }
        public bool LoggedIn { get; set; }
        public byte? StateExam { get; set; }
        public short ExtraTime { get; set; }
        public bool CreatedQuestionSheet { get; set; }
        public string SubjectName { get; set; }
        public decimal? Score { get; set; }
        public long? QuestionSheetId { get; set; }
    }
}