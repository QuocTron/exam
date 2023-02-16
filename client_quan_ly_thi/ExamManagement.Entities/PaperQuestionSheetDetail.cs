using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Entities
{
    public class PaperQuestionSheetDetail
    {
        [Key]
        [Column(Order = 0)]
        public long PaperQuestionSheetId { get; set; }

        [Key]
        [Column(Order = 1)]
        public long QuestionId { get; set; }

        public int? Order { get; set; }

        public virtual PaperQuestionSheet PaperQuestionSheet { get; set; }

    }
}
