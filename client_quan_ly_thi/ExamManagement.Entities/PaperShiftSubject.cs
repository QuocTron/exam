using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExamManagement.Entities
{
    public class PaperShiftSubject
    {
        public PaperShiftSubject()
        {
            PaperQuestionSheets = new HashSet<PaperQuestionSheet>();
        }

        public long Id { get; set; }

        public int? ShiftId { get; set; }

        public int? SubjectId { get; set; }

        public int? MatrixId { get; set; }

        public bool Deleted { get; set; }

        public virtual Matrix Matrix { get; set; }

        public virtual ICollection<PaperQuestionSheet> PaperQuestionSheets { get; set; }

        public virtual Shift Shift { get; set; }
    }
}
