using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ExamManagement.Entities
{
    public class QuestionSheetDetail
    {
        [Key]
        [Column(Order = 1)]
        public long QuestionSheetId { get; set; }

        [Key]
        [Column(Order = 2)]
        public long QuestionId { get; set; }

        public short? Order { get; set; }
        public long? AnswerId { get; set; }
        public bool Correct { get; set; }
        public DateTime? CreateDate { get; set; }
        public DateTime? UpdateDate { get; set; }
        public byte? ListenTimes { get; set; }
        public bool Desktop { get; set; }

        [DefaultValue(false)]
        public bool Deleted { get; set; }

        public QuestionSheet QuestionSheet { get; set; }
        public Question Question { get; set; }
    }
}