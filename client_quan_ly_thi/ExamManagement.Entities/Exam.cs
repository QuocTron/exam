using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ExamManagement.Entities
{
    public class Exam
    {
        public int Id { get; set; }
        [StringLength(50)]
        public string Name { get; set; }
        public DateTime? CreateDate { get; set; }
        public int? UserId { get; set; }
        public bool Desktop { get; set; }
        public bool Deleted { get; set; }

        public ICollection<Shift> Shifts { get; set; }

        public Exam()
        {
            Shifts = new HashSet<Shift>();
        }
    }
}