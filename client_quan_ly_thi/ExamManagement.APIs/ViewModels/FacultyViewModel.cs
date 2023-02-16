using System.Collections.Generic;

namespace ExamManagement.APIs.ViewModels
{
    public class FacultyViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public bool? Deleted { get; set; }
        public string Comment { get; set; }

        public ICollection<SubjectViewModel> Subjects { get; set; }
    }
}