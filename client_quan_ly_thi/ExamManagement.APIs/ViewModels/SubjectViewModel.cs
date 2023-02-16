using System.Collections.Generic;

namespace ExamManagement.APIs.ViewModels
{
    public class SubjectViewModel
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public int? FacultyId { get; set; }
        public short? ManagementOrder { get; set; }
        public bool Validated { get; set; }
        public bool Deleted { get; set; }
    }
}