using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ExamManagement.Entities
{
    public class Subject
    {
        public int Id { get; set; }
        [StringLength(12)]
        public string Code { get; set; }
        [StringLength(100)]
        public string Name { get; set; }
        public int? FacultyId { get; set; }
        public short? ManagementOrder { get; set; }
        public bool Validated { get; set; }
        public bool Deleted { get; set; }

        public Faculty Faculty { get; set; }
        public ICollection<Chapter> Chapters { get; set; }
        public ICollection<ShiftSubject> ShiftSubjects { get; set; }

        public Subject()
        {
            Chapters = new HashSet<Chapter>();
            ShiftSubjects = new HashSet<ShiftSubject>();
        }
    }
}