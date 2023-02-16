namespace ExamManagement.APIs.ViewModels
{
    public class AnswerViewModel
    {
        public long Id { get; set; }
        public long? QuestionId { get; set; }
        public string Content { get; set; }
        public int? Order { get; set; }
        public bool? Correct { get; set; }
        public bool? Interchange { get; set; }
        public QuestionViewModel Question { get; set; }
    }
}
