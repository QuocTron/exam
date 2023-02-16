using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Entities
{
    public class ExtraTimeLog
    {
        [Key]
        public int Id { get; set; }
        [StringLength(100)]
        public string Reason { get; set; }
        [Required]
        public short ExtraTime { get; set; }

        public long? QuestionSheetId { get; set; }

        public QuestionSheet QuestionSheet { get; set; }
    }
}
