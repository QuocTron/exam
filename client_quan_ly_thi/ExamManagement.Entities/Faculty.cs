using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ExamManagement.Entities
{
    public class Faculty
    {
        public int Id { get; set; }
        [StringLength(100)]
        public string Name { get; set; }
        [StringLength(100)]
        public string Comment { get; set; }
        public bool Deleted { get; set; }
	    public bool Validated { get; set; }

		public ICollection<Subject> Subjects { get; set; }

        public Faculty()
        {
            Subjects = new HashSet<Subject>();
        }
    }
}