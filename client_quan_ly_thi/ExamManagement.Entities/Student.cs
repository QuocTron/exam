using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ExamManagement.Entities
{
    public class Student
    {
        public int Id { get; set; }
        [StringLength(100)]
        public string Code { get; set; }
        [StringLength(50)]
        public string Name { get; set; }

        [StringLength(50)]
        public string LastName { get; set; }

        [StringLength(50)]
        public string FirstName { get; set; }
        public string ClassName { get; set; }

        public ICollection<ShiftSubjectStudent> ShiftSubjectStudents { get; set; }

        public Student()
        {
            ShiftSubjectStudents = new HashSet<ShiftSubjectStudent>();
        }
    }
}