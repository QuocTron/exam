using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ExamManagement.Entities
{
    public class Chapter
    {
        public int Id { get; set; }
        [StringLength(100)]
        public string Name { get; set; }
        [StringLength(1000)]
        public string Content { get; set; }
        public int? Order { get; set; }
        public int? ParentId { get; set; }
        public int? SubjectId { get; set; }
        public int? ManagementOrder { get; set; }
        public bool Validated { get; set; }
        public bool Deleted { get; set; }
        
        public Subject Subject { get; set; }
        public ICollection<Question> Questions { get; set; }

        public Chapter()
        {
            Questions = new HashSet<Question>();
        }
    }
}