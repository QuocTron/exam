using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Entities
{
    public class PaperQuestionSheet
    {
        public PaperQuestionSheet()
        {
            PaperQuestionSheetDetails = new HashSet<PaperQuestionSheetDetail>();
        }

        public long Id { get; set; }

        [StringLength(200)]
        public string Name { get; set; }

        public DateTime? CreateDate { get; set; }

        public DateTime? ExportDate { get; set; }

        public DateTime? TestDate { get; set; }

        public int? Duration { get; set; }

        public bool? Exported { get; set; }

        public long? PaperShiftSubjectId { get; set; }

        public decimal? ObjectiveDifficulty { get; set; }

        public int? Total { get; set; }

        public virtual ICollection<PaperQuestionSheetDetail> PaperQuestionSheetDetails { get; set; }

        public virtual PaperShiftSubject PaperShiftSubject { get; set; }

    }
}
