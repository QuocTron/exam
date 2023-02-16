using System;
using System.Collections.Generic;

namespace ExamManagement.APIs.ViewModels
{
    public class ExamViewModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public DateTime? CreateDate { get; set; }
        public bool? Deleted { get; set; }

        public ICollection<ShiftViewModel> Shifts { get; set; }
    }
}