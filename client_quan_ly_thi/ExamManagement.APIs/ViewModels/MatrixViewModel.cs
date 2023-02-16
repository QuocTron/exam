using System;
using System.Collections.Generic;

namespace ExamManagement.APIs.ViewModels
{
    public class MatrixViewModel
    {
        public int Id { get; set; }
        public int? ExamId { get; set; }
        public DateTime? CreateDate { get; set; }
        public string Name { get; set; }

        public ICollection<MatrixDetailViewModel> MatrixDetails { get; set; }
        public ICollection<ShiftSubjectViewModel> ShiftSubjects { get; set; }
    }
}