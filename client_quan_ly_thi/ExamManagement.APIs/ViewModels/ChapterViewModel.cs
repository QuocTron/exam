using System.Collections.Generic;

namespace ExamManagement.APIs.ViewModels
{
    public class ChapterViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Content { get; set; }
        public int? Order { get; set; }
        public int? ParentId { get; set; }
        public bool? Deleted { get; set; }
        public int? SubjectId { get; set; }

        public SubjectViewModel SubjectViewModel { get; set; }
        public ICollection<QuestionViewModel> CauHois { get; set; }
    }
}