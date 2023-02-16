namespace ExamManagement.Entities
{
    public class Answer
    {
        public long Id { get; set; }
        public long? QuestionId { get; set; }
        public string Content { get; set; }
        public int? Order { get; set; }
        public bool Correct { get; set; }
        public bool Interchange { get; set; }
        public int? SelectedTimes { get; set; }
        public Question Question { get; set; }
    }
}