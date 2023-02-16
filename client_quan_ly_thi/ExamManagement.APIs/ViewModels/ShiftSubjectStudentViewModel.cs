namespace ExamManagement.APIs.ViewModels
{
    public class ShiftSubjectStudentViewModel
    {
        public long ShiftSubjectId { get; set; }
        public int StudentId { get; set; }
        public long? QuestionSheetId { get; set; }
        public bool? LogIn { get; set; }
        public bool? LastLogIn { get; set; }
        public bool? LastLogOut { get; set; }

        public StudentViewModel Student { get; set; }
        public ShiftSubjectViewModel ShiftSubject { get; set; }
        public QuestionSheetViewModel QuestionSheet { get; set; }
    }
}