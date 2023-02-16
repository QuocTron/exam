using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ExamManagement.Entities
{
    public class Matrix
    {
        public int Id { get; set; }
        public int? SubjectId { get; set; }
        public int? ExamId { get; set; }
        public DateTime? CreateDate { get; set; }

        [StringLength(100)]
        public string Name { get; set; }

        public ICollection<MatrixDetail> MatrixDetails { get; set; }
        public ICollection<ShiftSubject> ShiftSubjects { get; set; }

        public Matrix()
        {
            MatrixDetails = new HashSet<MatrixDetail>();
            ShiftSubjects = new HashSet<ShiftSubject>();
        }
    }
}