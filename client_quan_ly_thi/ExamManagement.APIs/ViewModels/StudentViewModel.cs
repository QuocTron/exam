using System.Collections.Generic;

namespace ExamManagement.APIs.ViewModels
{
    public class StudentViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string GroupCode { get; set; }
        public string SubGroupCode { get; set; }
        public string ClassName { get; set; }
        public int BonusTime { get; set; }
        public bool LoggedIn { get; set; }
        public int ShiftSubjectId { get; set; }//for create new student manual
        public bool CreatedQuestionSheet { get; set; }
        public byte? StateExam { get; set; } // 1: Not done yet | 2: Taking the exam | 3: Finish
        public decimal? Score { get; set; }
        public long? QuestionSheetId { get; set; }
    }
}